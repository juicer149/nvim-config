local lspconfig = require("lspconfig")

-- Tangentbindningar när språkservern är aktiv
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Python
lspconfig.pyright.setup({
  on_attach = on_attach,
})

-- Nim 
lspconfig.nim_langserver.setup({
  on_attach = on_attach,
})


-- Go
lspconfig.gopls.setup({
  on_attach = on_attach,
})

-- C / C++
lspconfig.clangd.setup({
  on_attach = on_attach,
})


