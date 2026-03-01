-- lua/plugins/colors.lua
--
-- Colorschemes only.
-- No selection logic, no configuration side effects.

return {
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "Mofiqul/dracula.nvim", priority = 1000, lazy = false },

  -- Keep commented themes here for easy testing
  -- { "rebelot/kanagawa.nvim", priority = 1000 },
  -- { "datsfilipe/vesper.nvim", priority = 1000 },
}
