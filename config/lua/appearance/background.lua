-- lua/appearance/background.lua
--
-- Background ownership.
--
-- terminal = terminal emulator owns background; Neovim is transparent.
-- theme    = Neovim colorscheme owns background.

local M = {}

M.MODE = {
  TERMINAL = "terminal",
  THEME = "theme",
}

local background_file = vim.fn.stdpath("config") .. "/background.txt"

function M.load()
  local f = io.open(background_file, "r")
  if not f then
    return M.MODE.TERMINAL
  end

  local mode = f:read("*l")
  f:close()

  if mode == M.MODE.THEME then
    return M.MODE.THEME
  end

  return M.MODE.TERMINAL
end

function M.save(mode)
  local f = io.open(background_file, "w")
  if f then
    f:write(mode)
    f:close()
  end
end

function M.uses_terminal()
  return M.load() == M.MODE.TERMINAL
end

function M.uses_theme()
  return M.load() == M.MODE.THEME
end

function M.toggle()
  local current = M.load()

  if current == M.MODE.TERMINAL then
    M.save(M.MODE.THEME)
    return M.MODE.THEME
  end

  M.save(M.MODE.TERMINAL)
  return M.MODE.TERMINAL
end

return M
