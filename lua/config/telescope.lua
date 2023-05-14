local actions = require("telescope.actions")
require("telescope").setup{
    defaults = {
        mappings = {
            i = {["<esc>"] = actions.close}
        },
--        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        color_devicons = true,
    }
}
