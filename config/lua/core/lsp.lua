-- ############################################################
-- # LSP configuration – Neovim ≥ 0.11
-- # Uses native vim.lsp.config API
-- ############################################################

local util = require("lspconfig.util")

-- ============================================================
-- on_attach: keymaps when an LSP server attaches
-- ============================================================

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- ============================================================
-- Python interpreter discovery (virtualenv aware)
-- ============================================================

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

-- ============================================================
-- Global defaults (applied to all servers)
-- ============================================================

vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- ============================================================
-- Pyright (Python)
-- ============================================================

vim.lsp.config("pyright", {
  root_dir = function(fname)
    return util.root_pattern(
      ".venv",
      "venv",
      "pyproject.toml",
      "setup.py",
      "requirements.txt",
      ".git"
    )(fname) or vim.fn.fnamemodify(fname, ":p:h")
  end,

  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    config.settings.python.pythonPath =
      get_python_path(config.root_dir)
  end,

  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- ============================================================
-- Nim
-- ============================================================

vim.lsp.config("nim_langserver", {})

-- ============================================================
-- Go
-- ============================================================

vim.lsp.config("gopls", {})

-- ============================================================
-- C / C++
-- ============================================================

vim.lsp.config("clangd", {})

-- ============================================================
-- HTML (+ Jinja trick)
-- ============================================================

vim.lsp.config("html", {
  filetypes = { "html", "jinja", "jinja2" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = { css = true, javascript = true },
  },
})

-- ============================================================
-- Enable servers
-- ============================================================

vim.lsp.enable({
  "pyright",
  "nim_langserver",
  "gopls",
  "clangd",
  "html",
})

-- ============================================================
-- Command: show Pyright Python path
-- ============================================================

vim.api.nvim_create_user_command("LspPyPath", function()
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == "pyright" then
      print(
        "Pyright Python path: "
          .. (client.config.settings.python.pythonPath or "nil")
      )
    end
  end
end, {})
