-- lua/appearance/themes/sepia_forge/plugins.lua
--
-- Plugin and integration highlights:
--   - GitSigns
--   - Diff
--   - Telescope
--   - nvim-cmp

local M = {}

function M.apply(a, c, _r)
  -- -------------------------------------------------------------------------
  -- Git / diff
  -- -------------------------------------------------------------------------

  a.hl("DiffAdd", { fg = c.hint, bg = c.surface })
  a.hl("DiffChange", { fg = c.info, bg = c.surface })
  a.hl("DiffDelete", { fg = c.error, bg = c.surface })
  a.hl("DiffText", { fg = c.fg, bg = c.selection })

  a.hl("GitSignsAdd", { fg = c.hint, bg = c.bg })
  a.hl("GitSignsChange", { fg = c.info, bg = c.bg })
  a.hl("GitSignsDelete", { fg = c.error, bg = c.bg })

  -- -------------------------------------------------------------------------
  -- Telescope
  -- -------------------------------------------------------------------------

  a.hl("TelescopeNormal", { fg = c.fg, bg = c.surface })
  a.hl("TelescopeBorder", { fg = c.surface_stronger, bg = c.surface })
  a.hl("TelescopeSelection", { fg = c.fg, bg = c.selection })
  a.hl("TelescopeMatching", { fg = c.function_ })

  -- -------------------------------------------------------------------------
  -- Completion
  -- -------------------------------------------------------------------------

  a.hl("CmpItemAbbr", { fg = c.fg })
  a.hl("CmpItemAbbrMatch", { fg = c.function_ })
  a.hl("CmpItemAbbrMatchFuzzy", { fg = c.function_ })
  a.hl("CmpItemKind", { fg = c.type })
  a.hl("CmpItemMenu", { fg = c.comment })
end

return M
