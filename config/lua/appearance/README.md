# appearance

Editor appearance subsystem for Neovim.

WezTerm may own the terminal background. Neovim owns editor text, syntax, diagnostics and UI highlights.

## Model

```text
WezTerm
  exposes:
    TERMINAL_THEME      exact theme name, e.g. sepia_dim
    TERMINAL_THEME_KIND light | dark

Neovim
  uses TERMINAL_THEME_KIND to choose a theme group
  uses TERMINAL_THEME for exact theme adjustments
```

## Files

```text
appearance/
├── init.lua          public API: apply, toggle, autoload
├── environment.lua   reads TERMINAL_THEME / TERMINAL_THEME_KIND
├── background.lua    toggles background owner: terminal | theme
├── groups.lua        theme cycles for light / dark / full
├── schemes.lua       loads actual colorschemes
├── adjustments.lua   local patches for terminal backgrounds
├── policy.lua        transparency + typography policy
└── persistence.lua   saves selected theme/background mode
```

## Keymaps

```text
<leader>t  Toggle editor theme
<leader>T  Toggle background owner
```

Background owner:

```text
terminal  Neovim is transparent, WezTerm owns background
theme     Neovim colorscheme owns background
```

If no terminal theme variables exist, Neovim uses full colorscheme backgrounds.

## Adding a new Neovim theme

1. Add the plugin in:

```text
config/lua/plugins/colors.lua
```

Example:

```lua
{ "author/theme.nvim", priority = 1000 },
```

2. Add it to the correct group in:

```text
appearance/groups.lua
```

Example:

```lua
light = {
  "dayfox",
  "scholar",
  "new-light-theme",
}
```

or:

```lua
dark = {
  "carbonfox",
  "scholar-dark",
  "new-dark-theme",
}
```

3. Add an apply function in:

```text
appearance/schemes.lua
```

Example:

```lua
function M.new_light_theme()
  vim.o.background = "light"

  local ok = pcall(vim.cmd.colorscheme, "new-theme")
  if not ok then
    vim.notify("[appearance] new-theme not available", vim.log.levels.WARN)
    return
  end

  finalize("new-light-theme")
end
```

4. Register it in `M.apply`:

```lua
M.apply = {
  ["new-light-theme"] = M.new_light_theme,
}
```

## Adjusting a theme for a WezTerm background

If a theme looks wrong only on one exact WezTerm background, edit:

```text
appearance/adjustments.lua
```

Use `by_theme`:

```lua
M.by_theme = {
  sepia_dim = {
    ["gruvbox-light"] = function()
      vim.api.nvim_set_hl(0, "String", { fg = "#4F6F2F" })
    end,
  },
}
```

If the adjustment should apply to all light or dark terminal backgrounds, use `by_kind`:

```lua
M.by_kind = {
  light = {
    dayfox = function()
      vim.api.nvim_set_hl(0, "String", { fg = "#4F6F2F" })
    end,
  },
}
```

Priority:

```text
1. by_theme[TERMINAL_THEME][nvim_theme]
2. by_kind[TERMINAL_THEME_KIND][nvim_theme]
3. no adjustment
```

## Changing WezTerm background

Change the active WezTerm theme in the WezTerm config.

WezTerm should expose:

```text
TERMINAL_THEME      exact theme name
TERMINAL_THEME_KIND light | dark
```

Example:

```text
TERMINAL_THEME=sepia_dim
TERMINAL_THEME_KIND=light
```

Neovim then knows:

```text
use light theme group
apply exact sepia_dim adjustments if they exist
```

If the new WezTerm background makes a Neovim theme too weak or too strong, add or change an adjustment in:

```text
appearance/adjustments.lua
```

Do not edit the external colorscheme directly.

## Useful commands

```vim
:colorscheme
:set background?
:echo $TERMINAL_THEME
:echo $TERMINAL_THEME_KIND
:lua require("appearance").toggle()
:lua require("appearance").toggle_background()
```

To inspect the highlight group under the cursor:

```vim
:Inspect
```
