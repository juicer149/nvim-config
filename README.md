# Min Neovim-konfiguration

## Struktur
- `init.lua` → laddar alla moduler
- `lua/core/`
  - `options.lua` → UI-inställningar (radnummer, färgkolumn, etc.)
  - `keymaps.lua` → Egna keymaps
  - `autocmds.lua` → Autokommandon (t.ex. relativenumber växling)
  - `commands.lua` → Egna kommandon (ex: `:CopyOSC`, `:Theme`, `:ThemeNext`)
  - `theme.lua` → Laddar aktivt färgtema (rose-pine eller gruvbox)
- `lua/plugins/init.lua` → Lazy.nvim + alla plugins

## Plugin manager
- Använder [Lazy.nvim](https://github.com/folke/lazy.nvim)
- Plugins definieras i `lua/plugins/init.lua`
- Plugins installeras med `:Lazy sync`
- Oanvända plugins tas bort med `:Lazy clean`

## Keymaps
- `<leader>w` → spara (`:w`)
- `<leader>q` → stäng buffert (`:q`)
- `jk` → Esc i insert/visual mode
- `Alt + j/k` → flytta rader upp/ner (i både normal och visual mode)
- `<leader>tt` → växla till nästa temavariant (`:ThemeNext`)

## Tema
- Stöd för två teman:
  - **`rose-pine`** – varianter: `main`, `moon`, `dawn`
  - **`gruvbox`** – kontraster: `soft`, `medium`, `hard`
- Temat laddas dynamiskt via `:Theme` och `:ThemeNext`
- Byt tema med:
  - `:Theme rose-pine` eller `:Theme gruvbox`
- Byt variant inom aktivt tema med:
  - `:ThemeNext` → växlar till nästa variant inom `rose-pine` eller `gruvbox`

## Plugins (urval)
- `telescope.nvim` – fuzzy file finder
- `nvim-tree` – filträd
- `lualine` – statuslinje
- `nvim-treesitter` – syntax highlighting
- `gitsigns.nvim` – git-indikatorer
- `Comment.nvim` – kommentera rader/block
- `nvim-cmp` – autocompletion
- `LuaSnip` – snippetsystem
- `nvim-lspconfig` – LSP-konfiguration

## UI
- Relativa radnummer i normal mode
- Absoluta radnummer i insert mode (växlar automatiskt)
- Vertikal färgkolumn vid 80 tecken (`colorcolumn`)
- Ruler aktiverad (rad/kolumn visas i statuslinjen)

## Kommandon
- `:CopyOSC` → kopierar hela bufferten via OSC52 (för t.ex. SSH-terminal)
- `:Theme <tema>` → byter aktivt tema (ex: `:Theme gruvbox`)
- `:ThemeNext` → växlar till nästa variant inom det aktiva temat

## TODO / framtida förbättringar
- Lägg till LSP-konfiguration för fler språk
- Automatisk formattering med t.ex. Prettier, Black
- Fler snippets för vanliga språk
- Projektväxling via Telescope
- Snabbstartsskript (`bootstrap.sh`) för ny maskin

