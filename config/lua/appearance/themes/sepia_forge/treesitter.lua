-- lua/appearance/themes/sepia_forge/treesitter.lua
--
-- Treesitter highlight groups.

local M = {}

function M.apply(a, _c, r)
  a.role(r.comment, {
    "@comment",
  })

  a.role(r.string, {
    "@string",
    "@string.documentation",
    "@character",
  })

  a.role(r.number, {
    "@number",
    "@number.float",
  })

  a.role(r.builtin, {
    "@boolean",
    "@constant.builtin",
    "@function.builtin",
    "@attribute",
    "@attribute.python",
    "@punctuation.special",
  })

  a.role(r.constant, {
    "@constant",
    "@constant.macro",
  })

  a.role(r.text, {
    "@variable",
    "@variable.builtin",
    "@variable.member",
    "@property",
    "@operator",
    "@punctuation",
    "@punctuation.delimiter",
    "@punctuation.bracket",
    "@module",
    "@namespace",
    "@tag.delimiter",
  })

  a.role(r.function_, {
    "@function",
    "@function.call",
    "@function.method",
    "@function.method.call",
    "@tag.attribute",
  })

  a.role(r.type, {
    "@type",
    "@type.builtin",
    "@type.definition",
    "@class",
    "@constructor",
    "@tag",
  })

  a.role(r.keyword, {
    "@keyword",
    "@keyword.function",
    "@keyword.return",
    "@keyword.conditional",
    "@keyword.repeat",
    "@keyword.exception",
    "@keyword.operator",
  })

  a.role(r.keyword_subtle, {
    "@keyword.import",
  })
end

return M
