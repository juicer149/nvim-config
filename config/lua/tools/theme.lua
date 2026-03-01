-- lua/tools/theme.lua
--
-- Single source of truth for editor theming.
-- Exactly two modes exist: dark and light.
--
-- Philosophy:
--   - Terminal-first (background comes from terminal)
--   - No bold text
--   - Minimal italics
--   - High-signal, calm syntax colors
--   - Zero runtime side effects outside this file

local M = {}

-- ---------------------------------------------------------------------------
-- Theme definitions
-- ---------------------------------------------------------------------------

M.dark = {
  name = "carbonfox",
  apply = function()
    vim.o.background = "dark"

    -- Carbonfox is part of nightfox.nvim
    local ok = pcall(vim.cmd.colorscheme, "carbonfox")
    if not ok then
      vim.notify(
        "[theme] carbonfox not available, falling back to default",
        vim.log.levels.WARN
      )
      return
    end

    -- Transparent / terminal-first
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

    -- Typography control
    vim.api.nvim_set_hl(0, "Comment", { italic = false })
    vim.api.nvim_set_hl(0, "Keyword", { bold = false })
    vim.api.nvim_set_hl(0, "Function", { bold = false })
    vim.api.nvim_set_hl(0, "Identifier", { bold = false })
  end,
}

M.light = {
  name = "dayfox",
  apply = function()
    vim.o.background = "light"

    local ok = pcall(vim.cmd.colorscheme, "dayfox")
    if not ok then
      vim.notify(
        "[theme] dayfox not available, falling back to default",
        vim.log.levels.WARN
      )
      return
    end

    -- Keep terminal background visible if supported
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  end,
}

-- ---------------------------------------------------------------------------
-- Persistent state
-- ---------------------------------------------------------------------------

local theme_file = vim.fn.stdpath("config") .. "/theme.txt"

local function save(mode)
  local f = io.open(theme_file, "w")
  if f then
    f:write(mode)
    f:close()
  end
end

local function load()
  local f = io.open(theme_file, "r")
  if not f then
    return "dark"
  end

  local mode = f:read("*l")
  f:close()

  return mode == "light" and "light" or "dark"
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

function M.apply(mode)
  if mode == "light" then
    M.light.apply()
    save("light")
  else
    M.dark.apply()
    save("dark")
  end
end

function M.toggle()
  local current = load()
  if current == "dark" then
    M.apply("light")
  else
    M.apply("dark")
  end
end

function M.autoload()
  M.apply(load())
end

return M
