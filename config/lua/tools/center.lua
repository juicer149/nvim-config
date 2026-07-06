-- lua/tools/center.lua
--
-- Horizontal view / centered editor control.
-- Keeps normal Vim layout available, but allows a centered reading/code area
-- on wide screens.

local M = {}

local MIN_COLUMNS = 150

local function normal_window_count()
  local count = 0

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
    if ok then
      local buftype = vim.bo[buf].buftype
      local filetype = vim.bo[buf].filetype

      if buftype == "" and filetype ~= "no-neck-pain" then
        count = count + 1
      end
    end
  end

  return count
end

local function no_neck_pain()
  local ok, nnp = pcall(require, "no-neck-pain")
  if not ok then
    vim.notify("no-neck-pain.nvim is not available", vim.log.levels.WARN)
    return nil
  end

  return nnp
end

function M.toggle()
  vim.cmd("NoNeckPain")
end

function M.should_enable()
  return vim.o.columns >= MIN_COLUMNS and normal_window_count() == 1
end

function M.auto()
  local nnp = no_neck_pain()
  if not nnp then
    return
  end

  if M.should_enable() then
    nnp.enable()
  else
    nnp.disable()
  end
end

return M
