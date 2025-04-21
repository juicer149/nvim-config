require("rose-pine").setup({
  variant = "moon",  -- Du kan också välja "main" eller "dawn"
})

vim.cmd.colorscheme("rose-pine")

-- Gruvbox-konfiguration (via ellisonleao/gruvbox.nvim)
require("gruvbox").setup({
  contrast = "hard",        -- Välj mellan: "soft", "medium", "hard"
  transparent_mode = false, -- Sätt till true om du vill ha transparent bakgrund
})

vim.cmd.colorscheme("gruvbox")

