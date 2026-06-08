-- lua/appearance/groups.lua
--
-- Theme cycles grouped by background ownership and terminal background kind.
--
-- Selection model:
--   terminal background -> use light/dark group from TERMINAL_THEME_KIND
--   theme background    -> use full group
--
-- Defaults:
--   exact TERMINAL_THEME default wins first
--   then group/kind default
--   then sepia-forge fallback

local background = require("appearance.background")
local environment = require("appearance.environment")

local M = {}

M.items = {
  light = {
    "sepia-forge",
    "dayfox",
    "scholar",
    "gruvbox-light",
  },

  dark = {
    "carbonfox",
    "scholar-dark",
    "dracula",
    "gruvbox-dark",
  },

  full = {
    "sepia-forge",
    "dayfox",
    "scholar",
    "gruvbox-light",
    "carbonfox",
    "scholar-dark",
    "dracula",
    "gruvbox-dark",
  },

  standalone = {
    "sepia-forge",
    "carbonfox",
    "dayfox",
    "scholar",
    "scholar-dark",
  },
}

M.defaults_by_terminal_theme = {
  sepia = "sepia-forge",
  sepia_dim = "sepia-forge",

  -- Keep dark sepia in a dark editor theme by default.
  sepia_dark = "scholar-dark",
}

M.defaults_by_group = {
  light = "sepia-forge",
  dark = "carbonfox",
  full = "sepia-forge",
  standalone = "sepia-forge",
}

function M.current_name()
  if background.uses_theme() then
    return "full"
  end

  return environment.terminal_theme_kind() or "standalone"
end

function M.current()
  return M.items[M.current_name()] or M.items.standalone
end

function M.contains(items, value)
  for _, item in ipairs(items) do
    if item == value then
      return true
    end
  end

  return false
end

function M.default_for(group_name)
  local group = M.items[group_name] or M.items.standalone
  local terminal_theme = environment.terminal_theme()

  local exact_default =
    terminal_theme
    and M.defaults_by_terminal_theme[terminal_theme]

  if exact_default and M.contains(group, exact_default) then
    return exact_default
  end

  local group_default = M.defaults_by_group[group_name]

  if group_default and M.contains(group, group_default) then
    return group_default
  end

  return group[1] or "sepia-forge"
end

return M
