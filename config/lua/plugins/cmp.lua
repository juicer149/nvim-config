-- lua/plugins/cmp.lua
--
-- Autocompletion engine.
--
-- Design:
-- - GitHub Copilot owns <Tab>.
-- - nvim-cmp is used as a manual LSP/reference completion menu.
-- - Completion menu opens with <C-Space>.
-- - Documentation opens manually with <C-d>.

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      -- ============================================================
      -- Snippets
      -- ============================================================

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- ============================================================
      -- Completion behavior
      -- ============================================================
      --
      -- autocomplete = false means cmp does NOT open automatically.
      -- Use <C-Space> to open the LSP/cmp completion menu manually.
      --
      -- This keeps GitHub Copilot as the main inline completion system.

      completion = {
        autocomplete = false,
      },

      -- ============================================================
      -- Window behavior
      -- ============================================================
      --
      -- Documentation does NOT appear automatically.
      -- Use <C-d> to toggle documentation manually.

      view = {
        docs = {
          auto_open = false,
        },
      },

      window = {
        completion = cmp.config.window.bordered({
          max_height = 5,
          max_width = 40,
        }),

        documentation = cmp.config.window.bordered({
          max_width = 60,
          max_height = 12,
        }),
      },

      -- ============================================================
      -- Keymaps
      -- ============================================================

      mapping = cmp.mapping.preset.insert({
        -- Manually trigger completion.
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Toggle documentation for selected completion item.
        ["<C-d>"] = cmp.mapping(function()
          if cmp.visible_docs() then
            cmp.close_docs()
          else
            cmp.open_docs()
          end
        end, { "i", "s" }),

        -- Scroll documentation if it is open.
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),

        -- Navigate completion menu.
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        -- Close completion menu.
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm selected LSP/cmp item.
        --
        -- <Tab> is deliberately NOT mapped here,
        -- because <Tab> belongs to GitHub Copilot.
        ["<CR>"] = cmp.mapping.confirm({
          select = false,
        }),
      }),

      -- ============================================================
      -- Sources
      -- ============================================================

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })

    -- ============================================================
    -- Command-line completion
    -- ============================================================

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
