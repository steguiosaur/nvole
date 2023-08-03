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
        "bash"
    },
    highlight = {
        enable = true,
        disable = {"tex"},
        use_languagetree = true,
    },
    indent = { enable = true },
}

