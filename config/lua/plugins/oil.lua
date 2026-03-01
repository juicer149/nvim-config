-- lua/plugins/oil.lua
--
-- Filesystem as a buffer.
-- Replaces netrw and tree views.

return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  },
}
