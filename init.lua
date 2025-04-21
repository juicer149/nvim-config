-- Sätt leader till mellanslag
vim.g.mapleader = " "

-- Ladda konfiguration
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")
require("plugins")

require("core.theme")
