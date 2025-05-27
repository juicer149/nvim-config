# Min Neovim-konfiguration

## Struktur
- `init.lua` → laddar alla moduler
- `lua/core/`
  - `options.lua` → UI-inställningar (radnummer, färgkolumn, etc.)
  - `keymaps.lua` → Egna keymaps
  - `autocmds.lua` → Autokommandon (t.ex. relativenumber växling)
  - `commands.lua` → Egna kommandon (ex: `:CopyOSC`, `:Theme`, `:ThemeNext`)
  - `theme.lua` → Laddar aktivt färgtema (rose-pine eller gruvbox)
  - `lsp.lua` → Konfiguration av LSP för Python, Go och C
- `lua/plugins/init.lua` → Lazy.nvim + alla plugins
- `scripts/`
  - `setup.sh` → Installerar Node.js, pyright, gopls och clangd
  - `install_nvim_latest.sh` → Uppgraderar till senaste stabila NeoVim

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
- `gd` → gå till definition (via LSP)
- `K` → hover-dokumentation (via LSP)
- `<leader>rn` → byt namn (via LSP)
- `<leader>ca` → code actions (via LSP)

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
- `lualine` – statuslinje (med Copilot-status)
- `nvim-treesitter` – syntax highlighting
- `gitsigns.nvim` – git-indikatorer
- `Comment.nvim` – kommentera rader/block
- `nvim-cmp` – autocompletion
- `LuaSnip` – snippetsystem
- `nvim-lspconfig` – LSP-konfiguration (via `core/lsp.lua`)
- `copilot.vim` – GitHub Copilot AI-autocomplete

## UI
- Relativa radnummer i normal mode
- Absoluta radnummer i insert mode (växlar automatiskt)
- Vertikal färgkolumn vid 80 tecken (`colorcolumn`)
- Ruler aktiverad (rad/kolumn visas i statuslinjen)
- Copilot-status visas i `lualine`

## Kommandon
- `:CopyOSC` → kopierar hela bufferten via OSC52 (för t.ex. SSH-terminal)
- `:Theme <tema>` → byter aktivt tema (ex: `:Theme gruvbox`)
- `:ThemeNext` → växlar till nästa variant inom det aktiva temat

## Scripts
- `scripts/setup.sh` → installerar beroenden för LSP (Node.js, pyright, gopls, clangd)
- `scripts/install_nvim_latest.sh` → laddar och installerar senaste NeoVim v0.10+

## TODO / framtida förbättringar
- Automatisk formattering med t.ex. Prettier, Black
- Fler snippets för vanliga språk
- Projektväxling via Telescope
- Lägg till stöd för fler LSP-servrar (t.ex. Rust, TypeScript)
- Förbättra LSP-konfiguration (t.ex. diagnostics, hover)
- Utöka keymaps för mer effektiv navigering
- Lägg till fler plugins för produktivitet (t.ex. Todo-comments, Git integration)
 
