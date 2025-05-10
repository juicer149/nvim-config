local map = vim.keymap.set

-- Flytta rader
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Flytta raden nedåt" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Flytta raden uppåt" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Flytta markerad rad nedåt" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Flytta markerad rad uppåt" })

-- jk som Escape
map("i", "jk", "<Esc>", { desc = "jk som Escape i insert-läge" })
map("v", "jk", "<Esc>", { desc = "jk som Escape i visual-läge" })

-- Leader-tangenter
map("n", "<leader>w", ":w<CR>", { desc = "Spara fil" })
map("n", "<leader>q", ":q<CR>", { desc = "Stäng fil" })

-- Tab-navigering med Space+g och Space+f
map("n", "<leader>g", "gt", { desc = "Nästa tab" })
map("n", "<leader>f", "gT", { desc = "Föregående tab" })
