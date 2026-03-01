-- lua/plugins/treesitter.lua
--
-- Tree-sitter configuration.
-- Responsible ONLY for syntax structure, not colors.

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      -- Core
      "lua",
      "vim",
      "vimdoc",

      -- Shell & config
      "bash",
      "json",
      "yaml",
      "toml",

      -- Docs / text
      "markdown",
      "markdown_inline",

      -- VCS
      "gitignore",
      "gitcommit",

      -- Languages you actually use
      "python",
      "c",
      "cpp",
      "go",
      "nim",

      -- Internal helpers
      "regex",
      "query",
      "comment",
    },

    highlight = {
      enable = true,

      -- Keep regex highlighting for python
      -- (docstrings, decorators still come from Vim syntax)
      additional_vim_regex_highlighting = {
        "python",
      },
    },

    indent = {
      enable = true,
      disable = { "python" },
    },
  },
}
