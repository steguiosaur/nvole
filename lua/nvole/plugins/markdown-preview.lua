return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    config = function()
        vim.g.mkdp_theme = "dark"

        local keymap = vim.keymap.set
        -- MarkdownPreview
        keymap("n", "<leader>lm", ":MarkdownPreview<CR>", opts)
        keymap("n", "<leader>ls", ":MarkdownPreviewStop<CR>", opts)
        keymap("n", "<leader>lt", ":MarkdownPreviewToggle<CR>", opts)
        keymap("n", "<leader>lg", ":Glow<CR>", opts)
    end,
}
