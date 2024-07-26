return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        focus = true,
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "trouble diagnostics",
        },
        {
            "<leader>xw",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "trouble buffer diagnostics",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "trouble symbols",
        },
        {
            "<leader>xls",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "trouble LSP def / ref / ...",
        },
        {
            "<leader>xll",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "trouble location list",
        },
        {
            "<leader>xq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "trouble quickfix list",
        },
    },
}
