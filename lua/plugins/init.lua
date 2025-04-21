-- ############################################################
-- # Lazy.nvim bootstrap (laddar in plugin managern)
-- ############################################################

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  error("Lazy.nvim saknas – se till att du klonat det.")
end
vim.opt.rtp:prepend(lazypath)


-- ############################################################
-- # Ladda plugins via Lazy
-- ############################################################

require("lazy").setup({

  -- Färgtema
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  -- Gruvbox-tema (modern Lua-version med fler kontrastlägen)
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- Fuzzy finder (filnavigering och sökfunktioner)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Ikoner (används av bl.a. nvim-tree, lualine m.m.)
  { "nvim-tree/nvim-web-devicons" },

  -- Filträd (utforskare)
  { "nvim-tree/nvim-tree.lua" },

  -- Statusrad (information längst ner i fönstret)
  { "nvim-lualine/lualine.nvim" },

  -- Syntax highlighting och strukturell kodförståelse
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Git-indikatorer i vänster marginal
  { "lewis6991/gitsigns.nvim" },

  -- Kommenteringsfunktion (toggla kommentarer med snabbkommando)
  { "numToStr/Comment.nvim", opts = {} },

  -- Autocompletion-system (nvim-cmp med källor)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- LSP-källa för cmp
      "hrsh7th/cmp-nvim-lsp",

      -- Komplettering från aktuell buffert
      "hrsh7th/cmp-buffer",

      -- Komplettering för filsystemssökvägar
      "hrsh7th/cmp-path",

      -- Komplettering i kommandorad (ex :help, :e etc)
      "hrsh7th/cmp-cmdline",

      -- Snippet-motor (krävs för vissa förslag)
      "L3MON4D3/LuaSnip",

      -- Koppling mellan cmp och LuaSnip
      "saadparwaiz1/cmp_luasnip"
    }
  },

  -- LSP-konfiguration (integrerar språkserver för t.ex. Go, Lua, Python, JS m.m.)
  { "neovim/nvim-lspconfig" },
})

