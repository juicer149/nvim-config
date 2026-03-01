-- lua/tools/view.lua
--
-- View / camera control for Neovim.
-- Uses winsaveview / winrestview (the only stable API).
--
-- View positions:
--   1 = top
--   2 = upper-mid
--   3 = center
--   4 = lower-mid
--   5 = bottom
--
-- No buffer mutation. No global state. Deterministic.

local M = {}

local function clamp(value, min, max)
  if value < min then
    return min
  elseif value > max then
    return max
  end
  return value
end

function M.set(position)
  position = clamp(position, 1, 5)

  local view = vim.fn.winsaveview()

  local cursor_line = view.lnum
  local win_height = vim.api.nvim_win_get_height(0)

  -- Map 1..5 -> 0.0 .. 1.0
  local ratio = (position - 1) / 4

  local topline = cursor_line - math.floor(win_height * ratio)
  if topline < 1 then
    topline = 1
  end

  view.topline = topline
  vim.fn.winrestview(view)
end

return M
