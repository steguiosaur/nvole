return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("Comment").setup({
            mappings = false,
        })

        vim.keymap.set("n", "gc", "<Plug>(comment_toggle_linewise)", { desc = "toggle comment" })
        vim.keymap.set("x", "gc", "<Plug>(comment_toggle_linewise_visual)", { desc = "toggle comment" })
    end,
}
