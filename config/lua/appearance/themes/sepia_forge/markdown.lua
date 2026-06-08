-- lua/appearance/themes/sepia_forge/markdown.lua
--
-- Markdown highlights.

local M = {}

function M.apply(a, _c, r)
  a.role(r.keyword, {
    "markdownHeadingDelimiter",
    "markdownH1",
  })

  a.role(r.type, {
    "markdownH2",
  })

  a.role(r.string, {
    "markdownCode",
    "markdownCodeBlock",
  })

  a.role(r.function_, {
    "markdownLinkText",
  })
end

return M
