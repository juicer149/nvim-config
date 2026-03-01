-- lua/tools/osc52.lua
--
-- OSC52 clipboard helper.
-- Responsible only for transporting text to the terminal.
-- Selection policy is handled elsewhere.

local M = {}

function M.copy(text)
  if not text or text == "" then
    return
  end

  local encoded = vim.fn.system("base64 | tr -d '\n'", text)
  local osc = "\x1b]52;c;" .. encoded .. "\x07"
  vim.api.nvim_chan_send(vim.v.stderr, osc)
end

return M
