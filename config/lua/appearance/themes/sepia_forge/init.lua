-- lua/appearance/themes/sepia_forge/init.lua
--
-- Sepia Forge
--
-- Theme entrypoint.
--
-- Model:
--   palette -> semantic roles -> highlight groups

local M = {}

local palette = require("appearance.themes.sepia_forge.palette")
local roles = require("appearance.themes.sepia_forge.roles").build(palette)
local apply = require("appearance.themes.sepia_forge.apply")

function M.apply()
  vim.o.background = "light"
  vim.g.colors_name = "sepia-forge"

  require("appearance.themes.sepia_forge.ui").apply(apply, palette, roles)
  require("appearance.themes.sepia_forge.syntax").apply(apply, palette, roles)
  require("appearance.themes.sepia_forge.treesitter").apply(apply, palette, roles)
  require("appearance.themes.sepia_forge.lsp").apply(apply, palette, roles)
  require("appearance.themes.sepia_forge.diagnostics").apply(apply, palette, roles)
  require("appearance.themes.sepia_forge.plugins").apply(apply, palette, roles)
  require("appearance.themes.sepia_forge.markdown").apply(apply, palette, roles)
end

return M
