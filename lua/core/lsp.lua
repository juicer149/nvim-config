local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- Tangentbindningar när språkservern är aktiv
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Dynamiskt val av python-tolk
local function get_python_path(root_dir)
  if not root_dir then
    return vim.fn.exepath("python3") or "python3"
  end

  local candidates = { ".venv", "venv", "ll_env" }
  for _, dir in ipairs(candidates) do
    local python = root_dir .. "/" .. dir .. "/bin/python"
    if vim.fn.executable(python) == 1 then
      return python
    end
  end

  return vim.fn.exepath("python3") or "python3"
end

-- Pyright (Python)
lspconfig.pyright.setup({
  on_attach = on_attach,
  root_dir = function(fname)
    return util.root_pattern(".venv", "pyproject.toml", "setup.py", "requirements.txt", ".git")(fname)
      or vim.fn.fnamemodify(fname, ":p:h") -- fallback till filens katalog
  end,
  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
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

-- Debug: visa vilken python-tolk som används av pyright
vim.api.nvim_create_user_command("LspPyPath", function()
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == "pyright" then
      print("Pyright Python path: " .. (client.config.settings.python.pythonPath or "nil"))
    end
  end
end, {})

