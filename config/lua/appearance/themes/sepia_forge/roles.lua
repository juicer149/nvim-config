-- lua/appearance/themes/sepia_forge/roles.lua
--
-- Semantic roles.
--
-- This is the theme grammar:
--   red    = syntax structure
--   blue   = type / data / form
--   teal   = function / action
--   orange = language tools / builtins
--   sepia  = text / values / reading
--   gray   = comments / marginalia

local M = {}

function M.build(c)
  return {
    -- Text hierarchy
    text = { fg = c.fg },
    comment = { fg = c.comment, italic = false },
    string = { fg = c.string, italic = false },
    number = { fg = c.number },
    constant = { fg = c.constant, bold = true },

    -- Syntax semantics
    keyword = { fg = c.keyword, bold = false },
    keyword_subtle = { fg = c.keyword_subtle, bold = false },
    type = { fg = c.type },
    function_ = { fg = c.function_, bold = false },
    builtin = { fg = c.builtin },

    -- UI helpers
    muted = { fg = c.muted },
    line_nr = { fg = c.line_nr, bg = c.bg },
    cursor_line_nr = { fg = c.cursor_line_nr, bg = c.surface, bold = false },

    -- Diagnostics
    error = { fg = c.error },
    warn = { fg = c.warn },
    info = { fg = c.info },
    hint = { fg = c.hint },
  }
end

return M
