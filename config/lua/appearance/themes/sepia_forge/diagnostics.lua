-- lua/appearance/themes/sepia_forge/diagnostics.lua
--
-- Diagnostics and diagnostic virtual text.

local M = {}

function M.apply(a, c, r)
  a.hl("DiagnosticError", r.error)
  a.hl("DiagnosticWarn", r.warn)
  a.hl("DiagnosticInfo", r.info)
  a.hl("DiagnosticHint", r.hint)

  a.hl("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
  a.hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.warn })
  a.hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.info })
  a.hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.hint })

  a.hl("DiagnosticVirtualTextError", { fg = c.error, bg = c.surface })
  a.hl("DiagnosticVirtualTextWarn", { fg = c.warn, bg = c.surface })
  a.hl("DiagnosticVirtualTextInfo", { fg = c.info, bg = c.surface })
  a.hl("DiagnosticVirtualTextHint", { fg = c.hint, bg = c.surface })
end

return M
