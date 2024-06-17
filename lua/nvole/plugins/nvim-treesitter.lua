return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup {
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
                "php",
                "latex",
                "lua",
                "zig",
                "bash",
                "kotlin",
                "groovy",
            },
            indent = { enable = true },
            highlight = {
                enable = true,
                disable = { "latex" },
                use_languagetree = true,
            },
        }
        -- https://github.com/EmranMR/tree-sitter-blade/discussions/19#discussion-5400675
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade"
        }
        vim.filetype.add({
            pattern = {
                ['.*%.blade%.php'] = 'blade',
            }
        })
    end,
}
