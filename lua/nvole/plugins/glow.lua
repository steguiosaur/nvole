return {
    "ellisonleao/glow.nvim",
    ft = { "markdown" },
    cmd = "Glow",
    config = function()
        require("glow").setup({
            border = "single",
            pager = false,
            width_ratio = 0.9,
            height_ratio = 0.85,
        })

        vim.keymap.set("n", "<leader>lg", "<cmd>Glow<CR>", { noremap = true })
    end,
}
