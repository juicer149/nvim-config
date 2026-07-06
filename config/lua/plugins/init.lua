-- lua/plugins/init.lua
--
-- Lazy.nvim bootstrap & plugin specification.
-- This file defines WHAT plugins exist.
-- Behavior/config lives elsewhere.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  error("Lazy.nvim is missing – install it before loading plugins.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Import plugin specs from lua/plugins/*
  { import = "plugins.colors" },
  { import = "plugins.treesitter" },
  { import = "plugins.cmp" },
  { import = "plugins.lsp" },
  { import = "plugins.ai" },

  -- ======================================================================
  -- FILE NAVIGATION
  -- ======================================================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
    },
  },

  -- ======================================================================
  -- UI
  -- ======================================================================
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 104,
      autocmds = {
        enableOnVimEnter = false,
        enableOnTabEnter = false,
        reloadOnColorSchemeChange = false,
        skipEnteringNoNeckPainBuffer = true,
      },
    },
  },
  -- ======================================================================
  -- SYNTAX / LEGACY
  -- ======================================================================
  { "zah/nim.vim" },

  -- ======================================================================
  -- GIT
  -- ======================================================================
  { "lewis6991/gitsigns.nvim" },

  -- ======================================================================
  -- EDITING
  -- ======================================================================
  { "numToStr/Comment.nvim", opts = {} },
})
