-- lua/appearance/themes/sepia_forge/syntax.lua
--
-- Legacy Vim syntax groups and Python legacy groups.

local M = {}

function M.apply(a, _c, r)
  -- -------------------------------------------------------------------------
  -- Core syntax
  -- -------------------------------------------------------------------------

  a.role(r.comment, {
    "Comment",
    "SpecialComment",
  })

  a.role(r.constant, {
    "Constant",
  })

  a.role(r.string, {
    "String",
    "Character",
  })

  a.role(r.number, {
    "Number",
    "Float",
  })

  a.role(r.builtin, {
    "Boolean",
    "Special",
    "SpecialChar",
    "Debug",
  })

  a.role(r.text, {
    "Identifier",
    "Operator",
    "Delimiter",
  })

  a.role(r.function_, {
    "Function",
  })

  a.role(r.keyword, {
    "Statement",
    "Conditional",
    "Repeat",
    "Label",
    "Keyword",
    "Exception",
    "StorageClass",
  })

  a.role(r.keyword_subtle, {
    "PreProc",
    "Include",
    "Define",
    "Macro",
    "PreCondit",
  })

  a.role(r.type, {
    "Type",
    "Structure",
    "Typedef",
    "Tag",
  })

  -- -------------------------------------------------------------------------
  -- Python legacy syntax groups
  -- -------------------------------------------------------------------------

  a.role(r.keyword, {
    "pythonStatement",
    "pythonConditional",
    "pythonRepeat",
    "pythonException",
    "pythonOperator",
  })

  a.role(r.keyword_subtle, {
    "pythonInclude",
    "pythonImport",
  })

  a.role(r.function_, {
    "pythonFunction",
  })

  a.role(r.type, {
    "pythonClass",

    -- In Python, names like str/int/bool often behave visually as type hints.
    -- Therefore the broad legacy pythonBuiltin group is type-colored.
    "pythonBuiltin",
    "pythonBuiltinType",
  })

  a.role(r.builtin, {
    "pythonBuiltinObj",
    "pythonBoolean",
  })

  a.role(r.string, {
    "pythonString",
  })

  a.role(r.number, {
    "pythonNumber",
  })
end

return M
