-- lua/appearance/themes/sepia_forge/lsp.lua
--
-- LSP semantic token highlight groups.

local M = {}

function M.apply(a, _c, r)
  a.role(r.type, {
    "@lsp.type.class",
    "@lsp.type.enum",
    "@lsp.type.interface",
    "@lsp.type.struct",
    "@lsp.type.type",
    "@lsp.type.typeParameter",

    -- Pyright / basedpyright default-library type-like symbols.
    "@lsp.typemod.class.defaultLibrary",
    "@lsp.typemod.type.defaultLibrary",
  })

  a.role(r.function_, {
    "@lsp.type.function",
    "@lsp.type.method",
  })

  a.role(r.builtin, {
    "@lsp.type.decorator",
    "@lsp.type.boolean",
    "@lsp.typemod.function.defaultLibrary",
  })

  a.role(r.text, {
    "@lsp.type.variable",
    "@lsp.typemod.variable.defaultLibrary",
    "@lsp.type.parameter",
    "@lsp.type.property",
  })

  a.role(r.keyword, {
    "@lsp.type.keyword",
  })

  a.role(r.string, {
    "@lsp.type.string",
  })

  a.role(r.number, {
    "@lsp.type.number",
  })
end

return M
