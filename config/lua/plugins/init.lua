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
  -- Import all plugin specs from lua/plugins/*
  { import = "plugins.treesitter" },

  -- ======================================================================
  -- COLORSCHEMES
  -- ======================================================================
  { "EdenEast/nightfox.nvim", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- ======================================================================
  -- FILE NAVIGATION
  -- ======================================================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { "nvim-tree/nvim-web-devicons" },

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

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- ======================================================================
  -- LSP
  -- ======================================================================
  { "neovim/nvim-lspconfig" },

  -- ======================================================================
  -- AI
  -- ======================================================================
  {
    "github/copilot.vim",
    lazy = false,
  },
})
