return {
    "adalessa/laravel.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "tpope/vim-dotenv",
        "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
        { "<leader>la", ":Laravel artisan<cr>" },
        { "<leader>lr", ":Laravel routes<cr>" },
        { "<leader>lm", ":Laravel related<cr>" },
    },
    event = { "VeryLazy" },
    config = true,
}
