-- lua/tools/yank.lua
--
-- Yank semantics for Neovim.
--
-- This module defines what "yank" means in this configuration:
--   - In visual mode, `y` copies the selected text
--   - The destination is the *system clipboard* via OSC52
--
-- Design goals:
--   - No use of Vim's yank operator (too slow, too much side effect)
--   - No registers
--   - No redraw-heavy editor machinery
--   - Correct visual semantics
--   - Works over SSH / WSL
--
-- This is intentionally more explicit than Vim's built-in yank,
-- because we want control, determinism, and zero latency.

local osc52 = require("tools.osc52")

local M = {}

-- ---------------------------------------------------------------------------
-- Leave visual mode explicitly
--
-- Why this exists:
--   Visual selection marks ('< and '>) are NOT finalized until
--   visual mode is exited.
--
-- Why not `vim.cmd("normal! <Esc>")`:
--   - `<Esc>` is not interpreted correctly in Ex strings
--   - Can result in literal garbage being inserted into the buffer
--
-- `nvim_feedkeys` + `replace_termcodes` is the *only* correct way
-- to synthesize a real <Esc> keypress from Lua.
-- ---------------------------------------------------------------------------
local function exit_visual_mode()
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "n", false)
end

-- ---------------------------------------------------------------------------
-- Read the current visual selection directly from the buffer
--
-- Why not use `"vy`:
--   - Yank is an operator → expensive
--   - Updates registers, jumplist, marks
--   - Triggers redraw and editor hooks
--   - Causes noticeable latency for large selections
--
-- Instead:
--   - Read the committed visual marks ('< and '>)
--   - Read buffer lines directly
--   - Trim columns manually
--
-- This is equivalent to a direct memory read instead of a high-level API.
-- ---------------------------------------------------------------------------
local function get_visual_selection()
  local start = vim.fn.getpos("'<")
  local finish = vim.fn.getpos("'>")

  -- If marks are not set, there is no valid selection
  if start[2] == 0 or finish[2] == 0 then
    return nil
  end

  local start_line, start_col = start[2], start[3]
  local end_line, end_col     = finish[2], finish[3]

  -- Read the selected lines directly from the buffer
  local lines = vim.fn.getline(start_line, end_line)
  if #lines == 0 then
    return nil
  end

  -- Trim the first and last line to the selected columns
  lines[1] = lines[1]:sub(start_col)

  if #lines == 1 then
    -- Single-line selection
    lines[1] = lines[1]:sub(1, end_col - start_col + 1)
  else
    -- Multi-line selection
    lines[#lines] = lines[#lines]:sub(1, end_col)
  end

  return table.concat(lines, "\n")
end

-- ---------------------------------------------------------------------------
-- Public API
--
-- This is what keymaps call.
-- It is intentionally small and explicit.
-- ---------------------------------------------------------------------------
function M.visual_to_clipboard()
  -- Finalize visual marks
  exit_visual_mode()

  -- Extract selected text
  local text = get_visual_selection()
  if not text then
    return
  end

  -- Transport text to system clipboard via OSC52
  osc52.copy(text)
end

return M
