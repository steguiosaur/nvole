-- TreeSitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "c",
        "cmake",
        "cpp",
        "lua",
        "markdown",
        "java",
        "rust",
        "javascript",
        "typescript",
        "python",
        "latex",
        "lua",
        "zig",
        "bash",
        "kotlin",
        "groovy"
    },
    highlight = {
        enable = true,
        disable = {"latex"},
        use_languagetree = true,
    },
    indent = { enable = true },
}

