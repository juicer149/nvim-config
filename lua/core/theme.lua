local variants = {
  ["rose-pine"] = { "main", "moon", "dawn" },
  ["gruvbox"]   = { "soft", "medium", "hard" },
  ["catppuccin"] = { "latte", "frappe", "macchiato", "mocha" },
}

local current_theme = "rose-pine"
local current_variant_index = 1

local function apply_theme(theme, variant)
  current_theme = theme
  current_variant_index = 1

  if theme == "rose-pine" then
    require("rose-pine").setup({ variant = variant })
  elseif theme == "gruvbox" then
    require("gruvbox").setup({ contrast = variant, transparent_mode = false })
  elseif theme == "catppuccin" then
    require("catppuccin").setup({ flavour = variant, transparent_background = false })
  end

  vim.cmd.colorscheme(theme)
  print("Tema: " .. theme .. " (" .. variant .. ")")
end


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
    return vim.tbl_keys(variants)
  end,
})

vim.api.nvim_create_user_command("ThemeNext", function()
  current_variant_index = (current_variant_index % #variants[current_theme]) + 1
  local variant = variants[current_theme][current_variant_index]
  apply_theme(current_theme, variant)
end, {})

