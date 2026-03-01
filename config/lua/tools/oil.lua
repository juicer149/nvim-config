-- lua/tools/oil.lua
--
-- Semantic wrapper for Oil.
-- No plugin loading. No side effects.

local M = {}

function M.open_parent()
  require("oil").open()
end

function M.open_cwd()
  require("oil").open(vim.fn.getcwd())
end

return M
