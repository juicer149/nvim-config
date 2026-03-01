-- Leader key
vim.g.mapleader = " "

-- Curate adapter
vim.opt.rtp:append(
  vim.fn.expand("~/dev/project/packages/curate/adapters/nvim")
)

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")
require("plugins")

-- Theme autoload loader
require("tools.theme").autoload()

require("core.lsp")
