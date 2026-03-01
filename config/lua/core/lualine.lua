local function copilot_status()
  local ok, status = pcall(vim.fn["copilot#Enabled"])
  if ok and status == 1 then
    return "Copilot: ON"
  else
    return "Copilot: OFF"
  end
end

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = {
      copilot_status,
      "encoding", "fileformat", "filetype"
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
-- This code sets up the lualine status line plugin for Neovim.
