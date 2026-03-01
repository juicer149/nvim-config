-- lua/core/commands.lua
--
-- User-facing commands.
--
-- Commands are explicit entry points into behavior.
-- No command performs hidden state mutation.
--

-- ============================================================================
-- CLIPBOARD / OSC52
-- ============================================================================

local osc52 = require("tools.osc52")

vim.api.nvim_create_user_command("CopyOSC", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if not lines or #lines == 0 then
    return
  end

  local content = table.concat(lines, "\n")
  osc52.copy(content)

  vim.notify("Copied buffer via OSC52", vim.log.levels.INFO)
end, {
  desc = "Copy entire buffer to system clipboard via OSC52",
})
