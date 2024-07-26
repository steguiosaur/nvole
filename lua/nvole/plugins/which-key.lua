return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 2000
    end,
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "which-key local keymaps",
        },
    },
    opts = {
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 10,
            },
            presets = {
                operators = false,
                motions = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
        },
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        win = {
            border = "single",
        },
        layout = {
            height = { min = 4, max = 25 },
            width = { min = 20, max = 50 },
            spacing = 4,
            align = "left",
        },
        show_help = true,
    },
}
