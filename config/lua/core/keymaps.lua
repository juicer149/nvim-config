-- lua/core/keymaps.lua
--
-- Keyboard policy for this Neovim configuration.
--
-- This file defines WHAT keys mean.
-- It does NOT implement behavior.
--
-- All non-trivial behavior is delegated to `lua/tools/*`.
--
-- Philosophy:
--   - Explicit > implicit
--   - No magic registers
--   - No hidden side effects
--   - Deterministic behavior
--
-- Logical structure (not filesystem):
--
-- keymaps/
-- ├── ergonomics
-- ├── yank
-- ├── leader
-- ├── tabs
-- ├── theme
-- ├── safety
-- ├── curate
-- ├── view
-- └── filesystem (oil)
--

local map = vim.keymap.set

-- ============================================================================
-- ERGONOMICS
-- Insert & Visual mode comfort
-- ============================================================================

map("i", "jk", "<Esc>", { desc = "Escape insert mode" })
map("v", "jk", "<Esc>", { desc = "Escape visual mode" })

-- ============================================================================
-- YANK / CLIPBOARD SEMANTICS
-- Yank = system clipboard via OSC52
-- ============================================================================

local yank = require("tools.yank")

map("v", "y", yank.visual_to_clipboard, {
  desc = "Yank selection to system clipboard",
  silent = true,
})

-- ============================================================================
-- LEADER BASICS
-- Session / window lifecycle
-- ============================================================================

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

-- ============================================================================
-- TAB NAVIGATION
-- Coarse-grained workspaces
-- ============================================================================

map("n", "<leader>gt", "gt", { desc = "Next tab" })
map("n", "<leader>gT", "gT", { desc = "Previous tab" })

-- ============================================================================
-- THEME CONTROL
-- Runtime editor state
-- ============================================================================

-- THEME CONTROL
-- Global editor state

map("n", "<leader>t", function()
  require("tools.theme").toggle()
end, {
  desc = "Toggle dark / light theme",
})

-- ============================================================================
-- NAVIGATION SAFETY LAYER
-- Prevent accidental mutation
-- ============================================================================

map("n", "H", "h", { silent = true })
map("n", "J", "j", { silent = true })
map("n", "K", "k", { silent = true })
map("n", "L", "l", { silent = true })

-- ============================================================================
-- STRUCTURAL MANIPULATION (CURATE)
-- Explicit structure control
-- ============================================================================
local curate = require("tools.curate")
map("n", "<leader>f", curate.fold_next, { desc = "Curate: fold deeper" })
map("n", "<leader>F", curate.fold_max,  { desc = "Curate: fold max" })
map("n", "<leader>u", curate.unfold_next, { desc = "Curate: unfold one level" })
map("n", "<leader>U", curate.unfold_all,  { desc = "Curate: unfold all" })


-- ============================================================================
-- VIEW / CAMERA MANAGEMENT
-- Cursor and viewport are orthogonal
-- ============================================================================

local view = require("tools.view")

map("n", "<leader><leader>", function()
  view.set(2)
end, { desc = "View: upper-mid (reset)" })

map("n", "<leader>v", function()
  view.set(1)
end, { desc = "View: cursor at top" })

map("n", "<leader>V", function()
  view.set(5)
end, { desc = "View: cursor at bottom" })

for i = 1, 5 do
  map("n", "<leader>" .. i .. "v", function()
    view.set(i)
  end, {
    desc = "View: position " .. i,
  })
end

-- ============================================================================
-- FILESYSTEM (OIL)
-- Directories as buffers
-- ============================================================================

local oil = require("tools.oil")

map("n", "-", oil.open_parent, {
  desc = "Oil: open parent directory",
})

map("n", "<leader>e", oil.open_cwd, {
  desc = "Oil: open project root",
})
