# Sepia Forge

Sepia Forge is a warm mid-tone Neovim theme.

It is not meant to be a bright light theme or a dark theme. The goal is closer to a technical handbook: paper-like background, low-saturation syntax, and readable long-form coding sessions.

Theme principle:

```text
The background carries the room.
Syntax whispers.
Diagnostics may speak louder.
```

## Color grammar

```text
black / brown  = main content
red            = syntax structure
blue-gray      = type / data / classification
ochre          = functions / actions
burnt orange   = builtins / language tools
gray-brown     = comments / marginalia
sepia          = strings, values, reading hierarchy
```

## Files

```text
sepia_forge/
├── init.lua          theme entrypoint
├── palette.lua       raw hex values only
├── roles.lua         semantic meaning for palette colors
├── apply.lua         helpers for applying highlight groups
├── ui.lua            editor UI: Normal, CursorLine, LineNr, Visual, menus
├── syntax.lua        legacy Vim syntax + Python legacy groups
├── treesitter.lua    Treesitter @groups
├── lsp.lua           LSP semantic token groups
├── diagnostics.lua   errors, warnings, info, hints
├── plugins.lua       Telescope, completion, GitSigns, diff
└── markdown.lua      Markdown-specific highlights
```

## Mental model

The theme is built in layers:

```text
palette.lua
  raw colors

roles.lua
  semantic roles

*.lua modules
  map Neovim highlight groups to roles
```

Example:

```text
#75543A
  -> function_ role
  -> Function, @function, @lsp.type.function
```

This means colors should usually be changed in `palette.lua`, not directly in syntax modules.

## Adding or changing colors

To change the theme’s visual character, edit:

```text
palette.lua
```

To change what a color means, edit:

```text
roles.lua
```

To change which Neovim highlight group receives a role, edit the relevant module:

```text
syntax.lua      legacy syntax groups
treesitter.lua  Treesitter groups
lsp.lua         LSP semantic tokens
ui.lua          editor interface
plugins.lua     plugin integrations
```

## Adding a new highlight group

Use the role helper when the group belongs to an existing semantic role:

```lua
a.role(r.function_, {
  "@function",
  "@function.call",
})
```

Use direct highlights for UI or special cases:

```lua
a.hl("Visual", { fg = c.fg, bg = c.selection })
```

Prefer roles for syntax. Prefer direct highlights for UI surfaces, borders, selection, diagnostics, and plugin-specific layout.

## Working with new languages

For now, language-specific exceptions can live in:

```text
syntax.lua
treesitter.lua
lsp.lua
```

If language support grows large, create a new folder:

```text
languages/
├── python.lua
├── lua.lua
├── html.lua
└── django.lua
```

Do this only when a language needs enough custom handling that the general modules become hard to read.

## Debugging highlights

Use Neovim’s inspect tool:

```vim
:Inspect
```

Place the cursor on the token that looks wrong, run `:Inspect`, and add the highlight group to the correct module.

Recommended workflow:

```text
1. Notice visual friction while working.
2. Run :Inspect on the token.
3. Decide which semantic role it belongs to.
4. Add the group to the relevant module.
5. Reload the theme.
```

## Reload

After editing theme files:

```vim
:lua package.loaded["appearance.themes.sepia_forge.palette"] = nil
:lua package.loaded["appearance.themes.sepia_forge.roles"] = nil
:lua package.loaded["appearance.themes.sepia_forge"] = nil
:lua package.loaded["appearance.schemes"] = nil
:lua require("appearance").apply("sepia-forge")
```

Restarting Neovim also works.

## Terminal background mode

Sepia Forge can run in two modes:

```text
theme background
  Neovim owns the background.

terminal background
  WezTerm owns the background.
  Neovim uses transparent Normal background.
```

Use:

```vim
:lua require("appearance").toggle_background()
```

When using terminal background mode, WezTerm’s `sepia_dim` background should match the theme palette.
