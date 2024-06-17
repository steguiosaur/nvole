return {
    "akinsho/toggleterm.nvim",
    event = 'VeryLazy',
    version = "*",
    config = function()
        require("toggleterm").setup {
            direction = "float",
            float_opts = {
                border = "single"
            }
        }

        local opts = { noremap = true, silent = true }
        local silent = { silent = true }
        local keymap = vim.keymap.set

        keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)

        keymap("t", "<esc>", [[<C-\><C-n>]], silent)
        keymap("t", "jj", [[<C-\><C-n>]], silent)
        keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], silent)
        keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], silent)
        keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], silent)
        keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], silent)
        keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], silent)
    end,
}
