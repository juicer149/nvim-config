-- lua/appearance/persistence.lua
--
-- Persists the selected editor text theme.

local M = {}

local theme_file = vim.fn.stdpath("config") .. "/theme.txt"

function M.save(mode)
  local f = io.open(theme_file, "w")
  if f then
    f:write(mode)
    f:close()
  end
end

function M.load()
  local f = io.open(theme_file, "r")
  if not f then
    return nil
  end

  local mode = f:read("*l")
  f:close()

  return mode
end

return M
