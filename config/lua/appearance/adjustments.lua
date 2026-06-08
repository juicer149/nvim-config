-- lua/appearance/adjustments.lua
--
-- Local theme adjustments.
--
-- These are small patches applied after external colorschemes load.
-- They adapt existing themes to WezTerm-managed backgrounds without
-- forking or rewriting the original colorschemes.
--
-- Priority:
--   1. by_theme[TERMINAL_THEME][nvim_theme]
--   2. by_kind[TERMINAL_THEME_KIND][nvim_theme]
--   3. no adjustment

local environment = require("appearance.environment")

local M = {}

-- ---------------------------------------------------------------------------
-- Shared adjustment helpers
-- ---------------------------------------------------------------------------

local function lift_dayfox_strings()
  vim.api.nvim_set_hl(0, "String", { fg = "#4F6F2F" })
  vim.api.nvim_set_hl(0, "@string", { fg = "#4F6F2F" })
end

local function lift_scholar_for_light_terminal()
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#7A6244" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#8F5A2A" })

  vim.api.nvim_set_hl(0, "Comment", { fg = "#6B5640", italic = false })
  vim.api.nvim_set_hl(0, "@comment", { fg = "#6B5640", italic = false })

  vim.api.nvim_set_hl(0, "String", { fg = "#4F6F2F" })
  vim.api.nvim_set_hl(0, "@string", { fg = "#4F6F2F" })

  vim.api.nvim_set_hl(0, "Function", { fg = "#2F5F6E", bold = false })
  vim.api.nvim_set_hl(0, "@function", { fg = "#2F5F6E" })
  vim.api.nvim_set_hl(0, "@function.call", { fg = "#2F5F6E" })
end

local function lift_scholar_for_dark_terminal()
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#7A6650" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D69A5E" })

  vim.api.nvim_set_hl(0, "Comment", { fg = "#8B765E", italic = false })
  vim.api.nvim_set_hl(0, "@comment", { fg = "#8B765E", italic = false })

  vim.api.nvim_set_hl(0, "String", { fg = "#AFC982" })
  vim.api.nvim_set_hl(0, "@string", { fg = "#AFC982" })

  vim.api.nvim_set_hl(0, "Function", { fg = "#90B7C8", bold = false })
  vim.api.nvim_set_hl(0, "@function", { fg = "#90B7C8" })
  vim.api.nvim_set_hl(0, "@function.call", { fg = "#90B7C8" })
end

local function lift_gruvbox_for_light_terminal()
  -- Gruvbox has a good feel, but some groups are too soft
  -- against the Sepia Forge Dim background.

  local sepia_text = "#3F3022"
  local sepia_string = "#605952"
  local sepia_line = "#9A7A52"
  local sepia_accent = "#8F5A2A"

  local teal_function = "#285766"
  local teal_type = "#4A7168"

  local orange_builtin = "#B05F28"

  -- Function names / method names
  vim.api.nvim_set_hl(0, "Function", { fg = teal_function, bold = false })
  vim.api.nvim_set_hl(0, "pythonFunction", { fg = teal_function, bold = false })
  vim.api.nvim_set_hl(0, "@function", { fg = teal_function })
  vim.api.nvim_set_hl(0, "@function.call", { fg = teal_function })
  vim.api.nvim_set_hl(0, "@function.method", { fg = teal_function })
  vim.api.nvim_set_hl(0, "@method", { fg = teal_function })
  vim.api.nvim_set_hl(0, "@constructor", { fg = teal_function })

  -- Class names / types
  vim.api.nvim_set_hl(0, "Type", { fg = teal_type })
  vim.api.nvim_set_hl(0, "pythonClass", { fg = teal_type })
  vim.api.nvim_set_hl(0, "@type", { fg = teal_type })
  vim.api.nvim_set_hl(0, "@type.python", { fg = teal_type })
  vim.api.nvim_set_hl(0, "@class", { fg = teal_type })

  -- Variables / properties
  vim.api.nvim_set_hl(0, "Identifier", { fg = sepia_text, bold = false })
  vim.api.nvim_set_hl(0, "@variable", { fg = sepia_text })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = sepia_text })
  vim.api.nvim_set_hl(0, "@property", { fg = sepia_text })

  -- Builtins
  -- Warmer and more saturated than strings, so builtins remain distinct.
  vim.api.nvim_set_hl(0, "pythonBuiltin", { fg = orange_builtin })
  vim.api.nvim_set_hl(0, "@constant.builtin", { fg = orange_builtin })
  vim.api.nvim_set_hl(0, "@function.builtin", { fg = orange_builtin })
  vim.api.nvim_set_hl(0, "@variable.builtin", { fg = orange_builtin })

  -- Strings / docstrings
  vim.api.nvim_set_hl(0, "String", { fg = sepia_string })
  vim.api.nvim_set_hl(0, "pythonString", { fg = sepia_string })
  vim.api.nvim_set_hl(0, "@string", { fg = sepia_string })
  vim.api.nvim_set_hl(0, "@string.documentation", { fg = sepia_string })

  -- Line numbers
  vim.api.nvim_set_hl(0, "LineNr", { fg = sepia_line })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = sepia_accent })
end

-- ---------------------------------------------------------------------------
-- Exact terminal theme adjustments
-- ---------------------------------------------------------------------------
-- Use this when a specific WezTerm theme needs a specific Neovim patch.

M.by_theme = {
  sepia_dim = {
    dayfox = lift_dayfox_strings,
    scholar = lift_scholar_for_light_terminal,
    ["gruvbox-light"] = lift_gruvbox_for_light_terminal,
  },

  sepia = {
    dayfox = lift_dayfox_strings,
    scholar = lift_scholar_for_light_terminal,
    ["gruvbox-light"] = lift_gruvbox_for_light_terminal,
  },

  sepia_dark = {
    ["scholar-dark"] = lift_scholar_for_dark_terminal,
    ["gruvbox-dark"] = lift_gruvbox_for_dark_terminal,
  },
}

-- ---------------------------------------------------------------------------
-- Background kind fallback adjustments
-- ---------------------------------------------------------------------------
-- Use this when no exact terminal theme adjustment exists.

M.by_kind = {
  light = {
    dayfox = lift_dayfox_strings,
    scholar = lift_scholar_for_light_terminal,
    ["gruvbox-light"] = lift_gruvbox_for_light_terminal,
  },

  dark = {
    ["scholar-dark"] = lift_scholar_for_dark_terminal,
    ["gruvbox-dark"] = lift_gruvbox_for_dark_terminal,
  },
}

-- ---------------------------------------------------------------------------
-- Apply
-- ---------------------------------------------------------------------------

function M.apply(nvim_theme)
  local terminal_theme = environment.terminal_theme()
  local terminal_kind = environment.terminal_theme_kind()

  local exact =
    terminal_theme
    and M.by_theme[terminal_theme]
    and M.by_theme[terminal_theme][nvim_theme]

  if exact then
    exact()
    return
  end

  local fallback =
    terminal_kind
    and M.by_kind[terminal_kind]
    and M.by_kind[terminal_kind][nvim_theme]

  if fallback then
    fallback()
  end
end

return M
