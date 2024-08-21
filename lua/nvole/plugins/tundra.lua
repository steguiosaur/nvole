return {
    "sam4llis/nvim-tundra", -- colorscheme
    priority = 1000,
    config = function()
        require("nvim-tundra").setup({
            transparent_background = false,
            dim_inactive_windows = {
                enabled = false,
                color = nil,
            },
            sidebars = {
                enabled = true,
                color = nil,
            },
            syntax = {
                booleans = { bold = true, italic = false },
                comments = { bold = true, italic = false },
                conditionals = {},
                constants = { bold = true },
                fields = {},
                functions = {},
                keywords = {},
                loops = {},
                numbers = { bold = true },
                operators = { bold = true },
                punctuation = {},
                strings = {},
                types = { italic = false },
            },
        })

        vim.g.tundra_biome = "arctic"
        vim.opt.background = "dark"
        -- vim.cmd("colorscheme tundra")
    end,
}
