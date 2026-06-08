-- lua/plugins/ai.lua
--
-- Optional AI assistance.
-- Never required for core workflow.
--
-- GitHub Copilot owns inline ghost-text completion.
--
-- Design:
-- - <Tab> accepts full Copilot suggestion.
-- - <S-Tab> accepts next word of suggestion.
-- - <C-g>n cycles to next suggestion.
-- - <C-g>p cycles to previous suggestion.
-- - <C-g>g requests/generates a new suggestion.
-- - <C-g>l accepts next line of suggestion.
-- - <C-g>d dismisses current suggestion.
-- - <leader>cp opens Copilot panel.

return {
  "github/copilot.vim",
  lazy = false,

  config = function()
    -- ============================================================
    -- Copilot behavior
    -- ============================================================
    --
    -- Do NOT set:
    -- vim.g.copilot_no_tab_map = true
    --
    -- This keeps Copilot's default <Tab> behavior:
    -- <Tab> accepts the full inline suggestion.

    -- ============================================================
    -- Insert-mode Copilot keymaps
    -- ============================================================

    -- Accept next word of the current suggestion.
    --
    -- Useful when Copilot suggests too much, but the beginning is right.
    vim.keymap.set("i", "<S-Tab>", "<Plug>(copilot-accept-word)", {
      silent = true,
      desc = "Copilot: accept next word",
    })

    -- Accept next line of the current suggestion.
    vim.keymap.set("i", "<C-g>l", "<Plug>(copilot-accept-line)", {
      silent = true,
      desc = "Copilot: accept next line",
    })

    -- Cycle between alternative suggestions.
    vim.keymap.set("i", "<C-g>n", "<Plug>(copilot-next)", {
      silent = true,
      desc = "Copilot: next suggestion",
    })

    vim.keymap.set("i", "<C-g>p", "<Plug>(copilot-previous)", {
      silent = true,
      desc = "Copilot: previous suggestion",
    })

    -- Request/generate a new suggestion explicitly.
    vim.keymap.set("i", "<C-g>g", "<Plug>(copilot-suggest)", {
      silent = true,
      desc = "Copilot: generate suggestion",
    })

    -- Dismiss current suggestion.
    vim.keymap.set("i", "<C-g>d", "<Plug>(copilot-dismiss)", {
      silent = true,
      desc = "Copilot: dismiss suggestion",
    })

    -- ============================================================
    -- Normal-mode Copilot commands
    -- ============================================================

    vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", {
      silent = true,
      desc = "Copilot: status",
    })

    vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<CR>", {
      silent = true,
      desc = "Copilot: enable",
    })

    vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<CR>", {
      silent = true,
      desc = "Copilot: disable",
    })

    vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", {
      silent = true,
      desc = "Copilot: open panel",
    })
  end,
}
