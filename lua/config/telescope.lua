local actions = require("telescope.actions")
require("telescope").setup{
    defaults = {
        mappings = {
            i = {["<esc>"] = actions.close}
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt_prefix = "   ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        color_devicons = true,
        path_display = { "truncate" },
        layout_config = {
            prompt_position = "top",
        },
    }
}
