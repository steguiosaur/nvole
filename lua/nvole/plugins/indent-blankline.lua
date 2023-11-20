return {
    "lukas-reineke/indent-blankline.nvim",
    priority = 500,
    main = "ibl",
    config = function()
        require("ibl").setup({
            indent = { char = "▎" },
            scope = { enabled = false },
        })
    end,
}
