# Neovim Keymaps
Snabbreferens för mina viktigaste Neovim-kommandon.

`<leader>` = `Space`

---

## Grundläggande

| Keymap | Mode | Funktion |
|---|---|---|
| `jk` | Insert / Visual | Lämna insert/visual mode |
| `<leader>w` | Normal | Spara fil |
| `<leader>q` | Normal | Stäng fönster |

---

## Navigation

| Keymap | Mode | Funktion |
|---|---|---|
| `H` | Normal | Flytta vänster |
| `J` | Normal | Flytta nedåt |
| `K` | Normal | Flytta uppåt |
| `L` | Normal | Flytta höger |

---

## Tabbar

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader>gt` | Normal | Nästa tab |
| `<leader>gT` | Normal | Föregående tab |

---

## Tema

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader>t` | Normal | Växla dark/light theme |

---

## LSP

| Keymap | Mode | Funktion |
|---|---|---|
| `gd` | Normal | Gå till definition |
| `K` | Normal | Hover-dokumentation |
| `gr` | Normal | References |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code action |

---

## Completion / nvim-cmp

`nvim-cmp` används manuellt som LSP-/referenslista.

| Keymap | Mode | Funktion |
|---|---|---|
| `<C-Space>` | Insert | Öppna completion-lista |
| `<C-n>` | Insert | Nästa förslag |
| `<C-p>` | Insert | Föregående förslag |
| `<CR>` | Insert | Acceptera markerat förslag |
| `<C-d>` | Insert | Visa/dölj docs |
| `<C-f>` | Insert | Scrolla docs nedåt |
| `<C-b>` | Insert | Scrolla docs uppåt |
| `<C-e>` | Insert | Stäng completion-lista |

---

## GitHub Copilot

Copilot är primär inline-skrivhjälp.

| Keymap | Mode | Funktion |
|---|---|---|
| `<Tab>` | Insert | Acceptera hela förslaget |
| `<S-Tab>` | Insert | Acceptera nästa ord |
| `<C-g>l` | Insert | Acceptera nästa rad |
| `<C-g>n` | Insert | Nästa Copilot-förslag |
| `<C-g>p` | Insert | Föregående Copilot-förslag |
| `<C-g>g` | Insert | Generera nytt förslag |
| `<C-g>d` | Insert | Avvisa förslag |
| `<leader>cp` | Normal | Öppna Copilot panel |
| `<leader>cs` | Normal | Copilot status |
| `<leader>ce` | Normal | Aktivera Copilot |
| `<leader>cd` | Normal | Stäng av Copilot |

---

## Curate

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader>f` | Normal | Fold deeper |
| `<leader>F` | Normal | Fold max |
| `<leader>u` | Normal | Unfold one level |
| `<leader>U` | Normal | Unfold all |

---

## View / kamera

| Keymap | Mode | Funktion |
|---|---|---|
| `<leader><leader>` | Normal | Reset view |
| `<leader>v` | Normal | Cursor nära toppen |
| `<leader>V` | Normal | Cursor nära botten |
| `<leader>1v` | Normal | View position 1 |
| `<leader>2v` | Normal | View position 2 |
| `<leader>3v` | Normal | View position 3 |
| `<leader>4v` | Normal | View position 4 |
| `<leader>5v` | Normal | View position 5 |

---

## Filesystem / Oil

| Keymap | Mode | Funktion |
|---|---|---|
| `-` | Normal | Öppna parent directory |
| `<leader>e` | Normal | Öppna projektrot / cwd |

---

## Praktisk modell

| System | Roll |
|---|---|
| Copilot | Skriver i flödet |
| LSP / cmp | Referenslista och exakt språkstöd |
| Oil | Filnavigering |
| Curate | Strukturell manipulation |
| View | Visuell positionering |
