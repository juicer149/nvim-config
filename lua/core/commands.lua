-- ############################################################
-- # Egna kommandon
-- ############################################################

-- Kopiera hela bufferten via OSC52 (t.ex. via SSH)
vim.api.nvim_create_user_command("CopyOSC", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")
  local encoded = vim.fn.system("base64 | tr -d '\n'", content)
  local osc = "\x1b]52;c;" .. encoded .. "\x07"
  vim.api.nvim_chan_send(vim.v.stderr, osc)
  print("✔️ Kopierat till urklipp via OSC52")
end, {})

-- ############################################################
-- # Temaväxling: rose-pine + gruvbox med variantstöd
-- ############################################################

local current_theme = "rose-pine"  -- Standardtema
local current_variant_index = 1

local variants = {
  ["rose-pine"] = { "main", "moon", "dawn" },
  ["gruvbox"]   = { "soft", "medium", "hard" },
}

-- Hjälpfunktion för att sätta temat med variant
local function apply_theme(theme, variant)
  current_theme = theme
  current_variant_index = 1

  if theme == "rose-pine" then
    require("rose-pine").setup({
      variant = variant,
    })
  elseif theme == "gruvbox" then
    require("gruvbox").setup({
      contrast = variant,
      transparent_mode = false,
    })
  end

  vim.cmd.colorscheme(theme)
  print("Tema: " .. theme .. " (" .. variant .. ")")
end

-- Kommando: :Theme <rose-pine|gruvbox>
vim.api.nvim_create_user_command("Theme", function(opts)
  local theme = opts.args
  if variants[theme] then
    current_theme = theme
    current_variant_index = 1
    apply_theme(theme, variants[theme][current_variant_index])
  else
    print("Okänt tema: " .. theme)
  end
end, {
  nargs = 1,
  complete = function()
    return { "rose-pine", "gruvbox" }
  end,
})

-- Kommando: :ThemeNext – växla till nästa variant inom aktivt tema
vim.api.nvim_create_user_command("ThemeNext", function()
  current_variant_index = (current_variant_index % #variants[current_theme]) + 1
  local variant = variants[current_theme][current_variant_index]
  apply_theme(current_theme, variant)
end, {})

