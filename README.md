## KeymapsDenna konfiguration använder `<leader>` som mellanslag (`Space`).

Keymaps är uppdelade efter funktion: grundläggande Vim-flöde, navigation, vyhantering, LSP, completion, Copilot och projektverktyg.

### Grundläggande

| Keymap | Mode | Funktion |
|---|---|---|
| `jk` | Insert / Visual | Lämna insert/visual mode |
| `<leader>w` | Normal | Spara fil (`:w`) |
| `<leader>q` | Normal | Stäng fönster (`:q`) |

### Tabbar och fönster

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader>gt` | Normal | Gå till nästa tab |
| `<leader>gT` | Normal | Gå till föregående tab |

### Tema

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader>t` | Normal | Växla mellan dark/light theme |

### Navigation safety layer

För att undvika oavsiktliga mutationer är `H`, `J`, `K`, `L` i normal mode mappade till ren navigation.

| Keymap | Mode | Funktion |
|---|---|---|
| `H` | Normal | Flytta vänster |
| `J` | Normal | Flytta nedåt |
| `K` | Normal | Flytta uppåt |
| `L` | Normal | Flytta höger |

> Obs: Eftersom `K` används som navigation i `core/keymaps.lua` kan standard-LSP-hover på `K` behöva flyttas eller prioriteras beroende på laddordning.

### LSP

LSP-keymaps aktiveras när en språkserver är kopplad till bufferten.

| Keymap | Mode | Funktion |
|---|---|---|
| `gd` | Normal | Gå till definition |
| `K` | Normal | Visa hover-dokumentation |
| `gr` | Normal | Visa references |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |

### Completion / nvim-cmp

`nvim-cmp` används som manuell LSP-/referenslista. Den öppnas inte automatiskt, utan används när exakt språkstöd behövs.

| Keymap | Mode | Funktion |
|---|---|---|
| `<C-Space>` | Insert | Öppna completion-lista manuellt |
| `<C-n>` | Insert | Nästa completion-förslag |
| `<C-p>` | Insert | Föregående completion-förslag |
| `<CR>` | Insert | Acceptera markerat completion-förslag |
| `<C-d>` | Insert | Visa/dölj dokumentation för markerat förslag |
| `<C-f>` | Insert | Scrolla dokumentation nedåt |
| `<C-b>` | Insert | Scrolla dokumentation uppåt |
| `<C-e>` | Insert | Stäng completion-listan |

Designprincipen är att LSP/cmp fungerar som ett uppslagsverk: exakt, lokalt och manuellt.

### GitHub Copilot

Copilot används som primär inline-skrivhjälp. `Tab` tillhör Copilot, inte `nvim-cmp`.

| Keymap | Mode | Funktion |
|---|---|---|
| `<Tab>` | Insert | Acceptera hela Copilot-förslaget |
| `<S-Tab>` | Insert | Acceptera nästa ord av Copilot-förslaget |
| `<C-g>l` | Insert | Acceptera nästa rad av Copilot-förslaget |
| `<C-g>n` | Insert | Nästa Copilot-förslag |
| `<C-g>p` | Insert | Föregående Copilot-förslag |
| `<C-g>g` | Insert | Generera / be om nytt Copilot-förslag |
| `<C-g>d` | Insert | Avvisa aktuellt Copilot-förslag |
| `<leader>cp` | Normal | Öppna Copilot panel |
| `<leader>cs` | Normal | Visa Copilot status |
| `<leader>ce` | Normal | Aktivera Copilot |
| `<leader>cd` | Normal | Stäng av Copilot |

Designprincipen är att Copilot sköter skrivflödet, medan LSP/cmp används som referenssystem.

### Curate

Egna keymaps för strukturell manipulation via Curate-adaptern.

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader>f` | Normal | Curate: fold deeper |
| `<leader>F` | Normal | Curate: fold max |
| `<leader>u` | Normal | Curate: unfold one level |
| `<leader>U` | Normal | Curate: unfold all |

### View / kamera

Dessa keymaps separerar markörposition från viewport-position. De används för att styra var i fönstret markören placeras visuellt.

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader><leader>` | Normal | Reset view till upper-mid |
| `<leader>v` | Normal | Placera markören nära toppen |
| `<leader>V` | Normal | Placera markören nära botten |
| `<leader>1v` | Normal | View position 1 |
| `<leader>2v` | Normal | View position 2 |
| `<leader>3v` | Normal | View position 3 |
| `<leader>4v` | Normal | View position 4 |
| `<leader>5v` | Normal | View position 5 |

### Filesystem / Oil

| Keymap | Mode | Funktion |
|---|---|---|
| `-` | Normal | Öppna parent directory i Oil |
| `<leader>e` | Normal | Öppna projektrot/current working directory i Oil |
