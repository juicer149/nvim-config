-- lua/appearance/init.lua
--
-- Public API for editor appearance.
--
-- Model:
--   - WezTerm may own the background.
--   - Neovim owns text, syntax, diagnostics, and editor UI.
--   - If TERMINAL_THEME_KIND is exposed, Neovim may use transparent background.
--   - If not, Neovim uses the full colorscheme background.
--
-- Adjustment priority:
--   1. exact terminal theme name
--   2. terminal theme kind
--   3. no adjustment

local M = {}

local background  = require("appearance.background")
local environment = require("appearance.environment")
local groups      = require("appearance.groups")
local persistence = require("appearance.persistence")
local schemes     = require("appearance.schemes")

function M.apply(mode)
  local apply = schemes.apply[mode]
  if not apply then
    vim.notify(
      "[appearance] unknown theme: " .. tostring(mode),
      vim.log.levels.WARN
    )
    return
  end

  apply()
  persistence.save(mode)
end

function M.toggle()
  local group = groups.current()
  local current = persistence.load()

  if not current or not groups.contains(group, current) then
    M.apply(group[1])
    return
  end

  for index, theme in ipairs(group) do
    if theme == current then
      local next_theme = group[index + 1] or group[1]
      M.apply(next_theme)
      return
    end
  end
end

function M.toggle_background()
  if not environment.terminal_managed_background() then
    vim.notify(
      "[appearance] terminal background unavailable",
      vim.log.levels.WARN
    )
    return
  end

  local mode = background.toggle()

  -- Re-resolve after background mode changed.
  -- This matters because:
  --   terminal background -> light/dark group
  --   theme background    -> full group
  M.autoload()

  vim.notify("[appearance] background: " .. mode, vim.log.levels.INFO)
end

function M.autoload()
  local group_name = groups.current_name()
  local group = groups.current()
  local saved = persistence.load()

  if saved and groups.contains(group, saved) then
    M.apply(saved)
    return
  end

  M.apply(groups.default_for(group_name))
end

return M
