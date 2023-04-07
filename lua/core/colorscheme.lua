require('nvim-tundra').setup({
    transparent_background = false,
    dim_inactive_windows = {
        enabled = false,
        color = nil,
    },
    sidebars = {
        enabled = true,
        color = nil,
    },
    editor = {
        search = {},
        substitute = {},
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
    diagnostics = {
        errors = {},
        warnings = {},
        information = {},
        hints = {},
    },
    plugins = {
        treesitter = true,
        telescope = true,
        nvimtree = true,
        gitsigns = true,
    },
})

vim.opt.background = 'dark'
vim.cmd('colorscheme tundra')
