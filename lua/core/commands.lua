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

