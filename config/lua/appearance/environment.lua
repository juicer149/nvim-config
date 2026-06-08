-- lua/appearance/environment.lua
--
-- Terminal environment detection.
--
-- Owns the contract between the terminal layer and Neovim.
--
-- WezTerm may expose:
--   TERMINAL_THEME      = exact theme alias, e.g. sepia_dim
--   TERMINAL_THEME_KIND = light | dark

local M = {}

M.ENV = {
  THEME = "TERMINAL_THEME",
  THEME_KIND = "TERMINAL_THEME_KIND",
}

M.KIND = {
  LIGHT = "light",
  DARK = "dark",
}

function M.terminal_theme()
  local theme = vim.env[M.ENV.THEME]

  if theme == nil or theme == "" then
    return nil
  end

  return theme
end

function M.terminal_theme_kind()
  local kind = vim.env[M.ENV.THEME_KIND]

  if kind == M.KIND.LIGHT or kind == M.KIND.DARK then
    return kind
  end

  return nil
end

function M.terminal_managed_background()
  return M.terminal_theme_kind() ~= nil
end

return M
