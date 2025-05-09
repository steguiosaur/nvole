return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "asm",
                "c",
                "cmake",
                "cpp",
                "lua",
                "markdown_inline",
                "java",
                "rust",
                "javascript",
                "typescript",
                "python",
                "php",
                "latex",
                "lua",
                "zig",
                "bash",
                "kotlin",
                "groovy",
                "json",
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {},
                },
            },
            matchup = {
                enable = true,
                disable = { "" },
            },
            indent = { enable = true },
            highlight = {
                enable = true,
                disable = { "latex" },
                use_languagetree = true,
            },
        })

        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }
        vim.filetype.add({
            pattern = {
                [".*%.blade%.php"] = "blade",
            },
        })
    end,
}
