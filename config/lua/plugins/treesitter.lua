local parsers = {
  "python",
  "lua",
  "vim",
  "vimdoc",
  "bash",
  "json",
  "yaml",
  "toml",
  "html",
  "css",
  "markdown",
  "markdown_inline",
  "c",
  "cpp",
  "go",
  "nim",
  "regex",
  "query",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
