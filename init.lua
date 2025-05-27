-- Sätt leader till mellanslag
vim.g.mapleader = " "

-- Ladda konfiguration
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")
require("plugins")

-- Ladda teman och färgscheman
require("core.theme")

-- Ladda plugins
require("core.lsp")

