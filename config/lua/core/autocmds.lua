-- ############################################################
-- # Autokommandon – smarta automatiska beteenden i Neovim
-- ############################################################

-- ==================================================
-- Växla mellan absolut och relativ radnummer
-- ================================================

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
    vim.opt_local.expandtab = true
  end,
})

-- HTML / Jinja2: 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.html", "*.jinja", "*.jinja2", "*.j2" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

