-- lua/tools/curate.lua
---- Thin Neovim adapter over curate_next (Python) + fold_engine.
--
-- Philosophy:
-- - Lua owns UX/state (step progression, fold ownership)
-- - Python owns structure/semantics (scopes + cursor-centric fold_plan)
-- - No CLI entrypoints, no __main__
-- - Deterministic, explicit data flow:
--     buffer text + cursor + step + language
--       -> python fold_plan
--       -> fold ranges
--       -> manual folds in Neovim
--
-- Contracts:
-- - Returned folds are 1-based inclusive line ranges (a,b) with a < b.
-- - Curate owns folds: we always clear and re-apply.

local M = {}

-- ============================================================================
-- Per-buffer state
-- ============================================================================

local STATE = {}

local function buf_state(buf)
  STATE[buf] = STATE[buf] or { step = 0 }
  return STATE[buf]
end

-- Cleanup on buffer destruction (buffer numbers are reused!)
vim.api.nvim_create_autocmd("BufWipeout", {
  callback = function(args)
    STATE[args.buf] = nil
  end,
})

-- ============================================================================
-- Fold ownership / policy
-- ============================================================================

local function ensure_manual_folds()
  vim.opt_local.foldmethod = "manual"
  vim.opt_local.foldenable = true
  vim.opt_local.foldlevel = 99
  vim.opt_local.foldopen = ""
end

local function clear_folds()
  vim.cmd("normal! zE")
end

local function apply_folds(folds)
  ensure_manual_folds()
  clear_folds()

  for _, r in ipairs(folds or {}) do
    local a, b = tonumber(r[1]), tonumber(r[2])
    if a and b and a < b then
      vim.cmd(string.format("%d,%dfold", a, b))
    end
  end
end

-- ============================================================================
-- Helpers: language mapping (Neovim filetype -> Curate language key)
-- ============================================================================

-- Adjust if you want different mapping rules.
local function ft_to_language(ft)
  if ft == nil or ft == "" then
    return "default"
  end
  -- curate_next already uses keys like "python", "lua", etc.
  return ft
end

-- ============================================================================
-- Python bridge
-- ============================================================================

local function run_fold_engine(step)
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)[1]

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local source = table.concat(lines, "\n")

  local ft = vim.bo[buf].filetype
  local language = ft_to_language(ft)

  ensure_manual_folds()

  -- Python program:
  -- - reads JSON payload from stdin
  -- - compiles scopes with treesitter if possible, else noop
  -- - computes fold_plan
  -- - converts folded addresses -> fold ranges (start,end)
  --
  -- Important: fold_engine returns addresses, but Neovim needs line ranges.
  local py = [[
import sys, json
from curate_next.compile import compile_scope_set
from curate_next.folding.fold_engine import fold_plan

payload = json.load(sys.stdin)

source   = payload.get("source", "")
language = payload.get("language", "default")
cursor   = int(payload.get("cursor", 1))
step     = int(payload.get("step", 0))

def compute_scopes():
    # Prefer treesitter, but never fail: fallback to noop.
    try:
        return compile_scope_set(source=source, language=language, producer="treesitter")
    except Exception:
        return compile_scope_set(source=source, language=language, producer="noop")

scopes = compute_scopes()
plan = fold_plan(scopes, cursor_line=cursor, step=step)

# Build lookup address -> (start,end)
addr_to_span = {tuple(s.address): (int(s.start), int(s.end)) for s in scopes}

folds = []
for addr in plan.folded:
    a = tuple(addr)
    if a in addr_to_span:
        start, end = addr_to_span[a]
        if start < end:
            folds.append([start, end])

print(json.dumps({"folds": folds}))
]]

  local payload = vim.json.encode({
    source = source,
    language = language,
    cursor = cursor,
    step = step,
  })

  vim.system(
    { "python3", "-c", py },
    { text = true, stdin = payload },
    function(res)
      if res.code ~= 0 then
        vim.schedule(function()
          vim.notify(res.stderr or "Curate error", vim.log.levels.ERROR)
        end)
        return
      end

      local ok, decoded = pcall(vim.json.decode, res.stdout or "")
      if not ok or type(decoded) ~= "table" then
        vim.schedule(function()
          vim.notify("Curate returned invalid JSON", vim.log.levels.ERROR)
        end)
        return
      end

      vim.schedule(function()
        apply_folds(decoded.folds or {})
      end)
    end
  )
end

-- ============================================================================
-- Public API
-- ============================================================================

function M.fold_next()
  local buf = vim.api.nvim_get_current_buf()
  local state = buf_state(buf)
  state.step = state.step + 1
  run_fold_engine(state.step)
end

function M.fold_max()
  local buf = vim.api.nvim_get_current_buf()
  local state = buf_state(buf)
  state.step = 999
  run_fold_engine(state.step)
end

function M.unfold_next()
  local buf = vim.api.nvim_get_current_buf()
  local state = buf_state(buf)
  state.step = math.max(0, state.step - 1)

  if state.step == 0 then
    clear_folds()
  else
    run_fold_engine(state.step)
  end
end

function M.unfold_all()
  local buf = vim.api.nvim_get_current_buf()
  buf_state(buf).step = 0
  clear_folds()
end

return M
