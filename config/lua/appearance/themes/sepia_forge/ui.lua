-- lua/appearance/themes/sepia_forge/ui.lua
--
-- Core editor UI highlights.

local M = {}

function M.apply(a, c, r)
  a.hl("Normal", { fg = c.fg, bg = c.bg })
  a.hl("NormalNC", { fg = c.fg, bg = c.bg })
  a.hl("NormalFloat", { fg = c.fg, bg = c.surface })
  a.hl("FloatBorder", { fg = c.muted, bg = c.surface })

  a.hl("EndOfBuffer", { fg = c.bg, bg = c.bg })
  a.hl("SignColumn", { fg = c.fg, bg = c.bg })

  a.hl("CursorLine", { bg = c.surface })
  a.hl("CursorColumn", { bg = c.surface })
  a.hl("ColorColumn", { bg = c.surface })

  a.hl("LineNr", r.line_nr)
  a.hl("CursorLineNr", r.cursor_line_nr)

  a.hl("Visual", { fg = c.fg, bg = c.selection })
  a.hl("Search", { fg = c.fg, bg = c.selection })
  a.hl("IncSearch", { fg = c.bg, bg = c.keyword })

  a.hl("Pmenu", { fg = c.fg, bg = c.surface })
  a.hl("PmenuSel", { fg = c.fg, bg = c.selection })
  a.hl("PmenuSbar", { bg = c.surface_stronger })
  a.hl("PmenuThumb", { bg = c.line_nr })

  a.hl("StatusLine", { fg = c.fg, bg = c.surface_stronger })
  a.hl("StatusLineNC", { fg = c.comment, bg = c.surface })
  a.hl("WinSeparator", { fg = c.surface_stronger, bg = c.bg })
end

return M
