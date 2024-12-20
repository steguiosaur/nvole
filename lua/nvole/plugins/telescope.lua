return {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = { ["<esc>"] = actions.close },
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
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    oldfiles = {
                        prompt_title = "Recent Files",
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>")
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
        vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<CR>")
        vim.keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<CR>")
        vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>")
    end,
}
