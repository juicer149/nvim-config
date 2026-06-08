-- lua/appearance/themes/sepia_forge/palette.lua
--
-- Raw color palette.
--
-- This file should contain hex values only.
-- Meaning belongs in roles.lua.
--
-- Sepia Forge is not a bright theme and not a dark theme.
-- It is a mid-tone reading theme:
--   - warm paper background
--   - low-saturation syntax
--   - diagnostics may speak louder than normal syntax
--
-- Philosophy:
--   The background carries the room.
--   Syntax whispers.
--   Diagnostics may speak louder.

return {
  -- Base
  bg = "#E7D1B3",
  fg = "#231910",

  -- Sepia / neutral hierarchy
  comment = "#60625B",
  string = "#5A4B2B",
  muted = "#8A735B",
  line_nr = "#9A8064",
  cursor_line_nr = "#704214",

  -- Surfaces
  surface = "#DEC8AD",
  surface_stronger = "#D3B99B",
  selection = "#C9A783",

  -- Syntax accents
  keyword = "#8A2A22",
  keyword_subtle = "#6F241D",

  type = "#4A5A67",
  function_ = "#5A3B22",
  builtin = "#A45C2A",

  number = "#6F241D",
  constant = "#704214",

  -- Diagnostics
  error = "#9A2A22",
  warn = "#B8662D",
  info = "#4A5A67",
  hint = "#75543A",
}
