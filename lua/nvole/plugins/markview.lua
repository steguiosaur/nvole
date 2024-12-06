return {
    "OXY2DEV/markview.nvim",
    enabled = false,
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("markview").setup({
            hybrid_modes = { "n" }
        });

		vim.keymap.set("n", "<Leader>mv", "<cmd>Markview toggle<CR>")
		vim.keymap.set("n", "<Leader>ms", "<cmd>Markview splitToggle<CR>")
		vim.keymap.set("n", "<Leader>mh", ":Markview hybridToggle<CR>")
    end
}
