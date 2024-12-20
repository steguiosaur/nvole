return {
    "adalessa/laravel.nvim",
    enabled = true,
    dependencies = {
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
        "nvimtools/none-ls.nvim",
        "kevinhwang91/promise-async",
    },
    tag = "v3.1.0",
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
        { "<leader>lva", "<cmd>Laravel artisan<cr>" },
        { "<leader>lvr", "<cmd>Laravel routes<cr>" },
        { "<leader>lvm", "<cmd>Laravel related<cr>" },
    },
    event = { "VeryLazy" },
    opts = {},
    config = true,
}
