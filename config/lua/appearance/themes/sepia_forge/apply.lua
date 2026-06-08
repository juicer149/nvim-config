-- lua/appearance/themes/sepia_forge/apply.lua
--
-- Highlight application helpers.

local M = {}

function M.hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.role(role, groups)
  for _, group in ipairs(groups) do
    M.hl(group, role)
  end
end

return M
