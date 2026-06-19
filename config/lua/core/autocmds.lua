-- ############################################################
-- # Autokommandon – smarta automatiska beteenden i Neovim
-- ############################################################

-- ============================================================
-- Växla mellan absolut och relativ radnummer
-- ============================================================

-- I insertmode -> visa absolut radnummer.
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

-- I normalmode -> visa relativt radnummer.
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- ============================================================
-- Dynamisk indentering beroende på filtyp
-- ============================================================

-- Python: 4 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Web files: 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "css",
    "scss",
    "less",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Jinja / template files: 2 spaces
--
-- Kept separate from pure HTML because template filetypes can vary
-- depending on how Neovim detects them.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jinja", "*.jinja2", "*.j2" },
  callback = function()
    vim.opt_local.filetype = "jinja"
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Makefile: real tabs
--
-- Make recipes require literal tab characters.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = false
  end,
})
