-- TreeSitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
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
    },
}

