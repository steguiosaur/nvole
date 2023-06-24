-- TreeSitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "c",
        "cmake",
        "cpp",
        "lua",
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
        use_languagetree = true,
    },
    indent = { enable = true },
}

