# Min Neovim-konfiguration

En minimal men kraftfull Neovim-setup, byggd på **Lua** och **Lazy.nvim**, med fokus på enkelhet, robusthet och tydlighet.  
Stöd för Python, Go, C/C++, Nim och HTML/Jinja2 – med dynamisk indentering och färgteman.  

---

## Struktur

- `init.lua` → laddar alla moduler
- `lua/core/`
  - `options.lua` → UI-inställningar (radnummer, färgkolumn, etc.)
  - `keymaps.lua` → Egna keymaps
  - `autocmds.lua` → Autokommandon (radnummer, indentering beroende på filtyp)
  - `commands.lua` → Egna kommandon (ex: `:CopyOSC`)
  - `theme.lua` → Dynamisk färgtema-hantering
  - `lsp.lua` → LSP-konfiguration för Python, Nim, Go, C/C++, HTML/Jinja2
- `lua/plugins/init.lua` → Lazy.nvim + plugin-lista
- `scripts/`
  - `setup.sh` → Installerar LSP-servrar och beroenden
  - `install_nvim_latest.sh` → Installerar senaste stabila NeoVim
- `Makefile` → snabbkommandon (`make setup`, `make push`, `make pull`)
- `sync.sh` → Git-sync för konfiguration
- `.gitignore` → ignorerar `theme.txt` (lokal preferens)

---

## Plugin manager
- [Lazy.nvim](https://github.com/folke/lazy.nvim) används för plugin-hantering
- Plugins definieras i `lua/plugins/init.lua`
- `:Lazy sync` → installera
- `:Lazy clean` → ta bort oanvända plugins

---

## Keymaps

- `<leader>w` → spara (`:w`)
- `<leader>q` → stäng buffert (`:q`)
- `jk` → Esc i insert/visual mode
- `Alt + j/k` → flytta rader upp/ner
- `<leader>t` → växla mellan Dark/Light mode
- `gd` → gå till definition (LSP)
- `K` → hover-dokumentation (LSP)
- `<leader>rn` → byt namn (LSP)
- `<leader>ca` → code actions (LSP)

---

## Tema

- **Dark mode**: `rose-pine (moon)`  
- **Light mode**: `dayfox`  
- Växla mellan dem med `<leader>t`  
- Valet sparas lokalt i `theme.txt` (exkluderad från Git)  

---

## Plugins (urval)

- `telescope.nvim` – fuzzy finder
- `nvim-tree` – filträd
- `lualine.nvim` – statuslinje (med Copilot-status)
- `nvim-treesitter` – syntax highlighting
- `gitsigns.nvim` – git-indikatorer
- `Comment.nvim` – snabbkommentering
- `nvim-cmp` – autocompletion
- `LuaSnip` – snippets
- `nvim-lspconfig` – språkserver-integration
- `copilot.vim` – GitHub Copilot AI

---

## LSP-servrar

Konfigurerade i `core/lsp.lua`:

- **Python** → `pyright` (automatisk upptäckt av virtuell miljö)  
- **Nim** → `nim_langserver`  
- **Go** → `gopls`  
- **C/C++** → `clangd`  
- **HTML/Jinja2** → `vscode-html-language-server` (hanterar HTML, ignorerar Jinja-block)  

Kommando:  
```vim
:LspPyPath

---

## Scripts

- `scripts/setup.sh` → installerar Node.js, Pyright, gopls, clangd, HTML LSP  
- `scripts/install_nvim_latest.sh` → installerar senaste Neovim  
- `sync.sh` → förenklad Git-sync (push/pull)  

---

## Makefile

För att slippa långa kommandon finns en enkel `Makefile` med färdiga genvägar:

- `make setup` → installerar alla LSP-servrar och beroenden (idempotent, hoppar över det som redan finns)  
- `make nvim` → installerar senaste stabila versionen av Neovim  
- `make push` → pushar din config till GitHub (via `sync.sh`)  
- `make pull` → hämtar senaste ändringar från GitHub  

Standardmålet är `help`, så om du kör bara `make` listas alla tillgängliga kommandon.

```bash
make        # visar hjälp
make setup  # installerar miljön
make push   # synkar config till GitHub
