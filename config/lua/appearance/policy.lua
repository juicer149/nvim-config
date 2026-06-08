-- lua/appearance/policy.lua
--
-- General editor appearance policy.
--
-- These functions are not tied to a specific colorscheme.
-- They express how Neovim should behave when the terminal owns
-- the background and Neovim owns text/syntax/UI highlights.

local M = {}

function M.make_transparent()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

return M
