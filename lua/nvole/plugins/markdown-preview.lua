return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    config = function()
        vim.g.mkdp_theme = "dark"

        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap.set
        -- MarkdownPreview
        keymap("n", "<leader>lm", ":MarkdownPreview<CR>", opts)
        keymap("n", "<leader>ls", ":MarkdownPreviewStop<CR>", opts)
        keymap("n", "<leader>lt", ":MarkdownPreviewToggle<CR>", opts)
    end,
}
