-- lua/appearance/schemes.lua
--
-- Concrete colorscheme application.
--
-- Each function loads one colorscheme and then applies:
--   1. background ownership policy
--   2. local integration adjustments when terminal background is used

local adjustments = require("appearance.adjustments")
local background  = require("appearance.background")
local environment = require("appearance.environment")
local policy      = require("appearance.policy")

local sepia_forge = require("appearance.themes.sepia_forge")

local M = {}

local function terminal_background_active()
  return environment.terminal_managed_background()
      and background.uses_terminal()
end

local function apply_background_policy()
  if terminal_background_active() then
    policy.make_transparent()
  end
end

local function setup_scholar()
  local ok_setup, scholar = pcall(require, "scholar")
  if ok_setup then
    scholar.setup({
      contrast = "soft",
      transparent_mode = false,
    })
  end
end

local function finalize(nvim_theme)
  apply_background_policy()

  if terminal_background_active() then
    adjustments.apply(nvim_theme)
  end
end

function M.sepia_forge()
  sepia_forge.apply()
  finalize("sepia-forge")
end

function M.scholar()
  vim.o.background = "light"

  setup_scholar()

  local ok = pcall(vim.cmd.colorscheme, "scholar")
  if not ok then
    vim.notify(
      "[appearance] scholar not available, falling back to dayfox",
      vim.log.levels.WARN
    )
    M.dayfox()
    return
  end

  finalize("scholar")
end

function M.scholar_dark()
  vim.o.background = "dark"

  setup_scholar()

  local ok = pcall(vim.cmd.colorscheme, "scholar")
  if not ok then
    vim.notify(
      "[appearance] scholar not available, falling back to carbonfox",
      vim.log.levels.WARN
    )
    M.carbonfox()
    return
  end

  finalize("scholar-dark")
end

function M.dayfox()
  vim.o.background = "light"

  local ok = pcall(vim.cmd.colorscheme, "dayfox")
  if not ok then
    vim.notify("[appearance] dayfox not available", vim.log.levels.WARN)
    return
  end

  finalize("dayfox")
end

function M.gruvbox_light()
  vim.o.background = "light"

  local ok = pcall(vim.cmd.colorscheme, "gruvbox")
  if not ok then
    vim.notify("[appearance] gruvbox not available", vim.log.levels.WARN)
    return
  end

  finalize("gruvbox-light")
end

function M.carbonfox()
  vim.o.background = "dark"

  local ok = pcall(vim.cmd.colorscheme, "carbonfox")
  if not ok then
    vim.notify("[appearance] carbonfox not available", vim.log.levels.WARN)
    return
  end

  finalize("carbonfox")
end

function M.dracula()
  vim.o.background = "dark"

  local ok = pcall(vim.cmd.colorscheme, "dracula")
  if not ok then
    vim.notify("[appearance] dracula not available", vim.log.levels.WARN)
    return
  end

  finalize("dracula")
end

function M.gruvbox_dark()
  vim.o.background = "dark"

  local ok = pcall(vim.cmd.colorscheme, "gruvbox")
  if not ok then
    vim.notify("[appearance] gruvbox not available", vim.log.levels.WARN)
    return
  end

  finalize("gruvbox-dark")
end

M.apply = {
  ["sepia-forge"] = M.sepia_forge,

  scholar = M.scholar,
  ["scholar-dark"] = M.scholar_dark,

  dayfox = M.dayfox,
  ["gruvbox-light"] = M.gruvbox_light,

  carbonfox = M.carbonfox,
  dracula = M.dracula,
  ["gruvbox-dark"] = M.gruvbox_dark,
}

return M
