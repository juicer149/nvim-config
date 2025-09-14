-- Sätt leader till mellanslag
vim.g.mapleader = " "

-- ############################################################
-- # Tema-konfiguration (ändra här för att byta dark/light tema)
-- ############################################################
local dark_theme = {
  name = "rose-pine",
  setup = function()
    require("rose-pine").setup({ variant = "moon" })
  end,
}
local light_theme = {
  name = "dayfox",
  setup = function()
    -- dayfox (Nightfox-tema) kräver ingen extra setup
  end,
}

-- ############################################################
-- # Ladda konfiguration
-- ############################################################
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")
require("plugins")

-- ############################################################
-- # Tema-hantering: autoload + kommandon
-- ############################################################
local theme_file = vim.fn.stdpath("config") .. "/theme.txt"

local function save_theme(mode)
  local f = io.open(theme_file, "w")
  if f then
    f:write(mode)
    f:close()
  end
end

vim.api.nvim_create_user_command("Darkmode", function()
  dark_theme.setup()
  vim.cmd.colorscheme(dark_theme.name)
  save_theme("dark")
  print("🌙 Dark mode aktiverat (" .. dark_theme.name .. ")")
end, {})

vim.api.nvim_create_user_command("Lightmode", function()
  light_theme.setup()
  vim.cmd.colorscheme(light_theme.name)
  save_theme("light")
  print("☀️ Light mode aktiverat (" .. light_theme.name .. ")")
end, {})

vim.api.nvim_create_user_command("ToggleTheme", function()
  local mode = "light"
  local f = io.open(theme_file, "r")
  if f then
    mode = f:read("*l") or "light"
    f:close()
  end
  if mode == "dark" then
    vim.cmd("Lightmode")
  else
    vim.cmd("Darkmode")
  end
end, {})

-- Autoload senaste använda tema
do
  local f = io.open(theme_file, "r")
  if f then
    local mode = f:read("*l")
    f:close()
    if mode == "dark" then
      dark_theme.setup()
      vim.cmd.colorscheme(dark_theme.name)
    elseif mode == "light" then
      light_theme.setup()
      vim.cmd.colorscheme(light_theme.name)
    end
  else
    -- fallback: ljus som standard
    light_theme.setup()
    vim.cmd.colorscheme(light_theme.name)
  end
end

-- ############################################################
-- # LSP
-- ############################################################
require("core.lsp")

