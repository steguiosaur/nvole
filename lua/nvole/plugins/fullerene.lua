return {
    "steguiosaur/fullerene.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("fullerene").setup({
            terminal_colors = true,         -- enable terminal colors
            styles = {                      -- You can pass the style using the format: style = true
                comments = { bold = true }, -- style for comments
                keywords = {},              -- style for keywords
                identifiers = {},           -- style for identifiers
                functions = {},             -- style for functions
                variables = {},             -- style for variables
                booleans = { bold = true },
            },
            integrations = {
                alpha = true,
                cmp = true,
                flash = false,
                gitsigns = true,
                hop = false,
                indent_blankline = true,
                lazy = true,
                lsp = true,
                markdown = true,
                mason = true,
                navic = false,
                neo_tree = false,
                neorg = false,
                noice = true,
                notify = true,
                rainbow_delimiters = false,
                telescope = true,
                treesitter = true,
            },
            highlight_overrides = {}
        })
        vim.cmd("colorscheme fullerene")
    end
}
