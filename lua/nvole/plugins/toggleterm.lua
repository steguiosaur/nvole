return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "single",
            },
        })

        vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, desc = "toggleterm" })

        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
        vim.keymap.set("t", "jj", [[<C-\><C-n>]])
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
    end,
}
