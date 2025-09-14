local map = vim.keymap.set

-- jk som Escape
map("i", "jk", "<Esc>", { desc = "jk som Escape i insert-läge" })
map("v", "jk", "<Esc>", { desc = "jk som Escape i visual-läge" })

-- Leader-tangenter
map("n", "<leader>w", ":w<CR>", { desc = "Spara fil" })
map("n", "<leader>q", ":q<CR>", { desc = "Stäng fil" })

-- Tab-navigering
map("n", "<leader>g", "gt", { desc = "Nästa tab" })
map("n", "<leader>f", "gT", { desc = "Föregående tab" })

-- Tema-växling
map("n", "<leader>t", ":ToggleTheme<CR>", { desc = "Växla mellan Darkmode/Lightmode" })

