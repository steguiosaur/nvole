return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("Comment").setup{
            mappings = false,
        }

    local keymap = vim.keymap.set

    -- Comment
    keymap("n", "gc", "<Plug>(comment_toggle_linewise)")
    keymap("x", "gc", "<Plug>(comment_toggle_linewise_visual)")

    end,
}
