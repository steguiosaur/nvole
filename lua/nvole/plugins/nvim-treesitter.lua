return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup {
            indent = { enable = true },
            ensure_installed = {
                "c",
                "cmake",
                "cpp",
                "lua",
                --"markdown",
                "markdown_inline",
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
        }
    end,
}
