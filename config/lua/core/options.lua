-- ############################################################
-- # Core options – global editor defaults
-- ############################################################

-- ============================================================
-- Line numbers
-- ============================================================

vim.opt.number = true
vim.opt.relativenumber = true

-- ============================================================
-- Layout / UI
-- ============================================================

-- should implement a tool for allowing <leader> + some key that adds or
-- subtracts from vim.opt.colorcolumn
vim.opt.colorcolumn = "81"
vim.opt.ruler = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- ============================================================
-- Indentation defaults
-- ============================================================
--
-- These are global defaults.
-- Filetype-specific overrides live in core/autocmds.lua.

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ============================================================
-- Completion behavior
-- ============================================================

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- ============================================================
-- Search
-- ============================================================

vim.opt.ignorecase = true
vim.opt.smartcase = true
