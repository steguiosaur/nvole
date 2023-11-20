return {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = function()
        require("glow").setup({
            border = "single",
            pager = false,
            width_ratio = 0.7,
            height_ratio = 0.7,
        })
    end,
}
