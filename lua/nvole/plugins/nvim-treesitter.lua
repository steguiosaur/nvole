return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    branch = "main",
    init = function()
        vim.api.nvim_create_autocmd('FileType', { 
            callback = function() 
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start) 
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
            end, 
          }) 

        local ensureInstalled = {
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
            "lua",
            "zig",
            "bash",
            "kotlin",
            "groovy",
            "json",
        }
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
        require('nvim-treesitter').install(parsersToInstall)

        -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        -- parser_config.blade = {
        --     install_info = {
        --         url = "https://github.com/EmranMR/tree-sitter-blade",
        --         files = { "src/parser.c" },
        --         branch = "main",
        --     },
        --     filetype = "blade",
        -- }
        -- vim.filetype.add({
        --     pattern = {
        --         [".*%.blade%.php"] = "blade",
        --     },
        -- })

    end,
    -- config = function()
    --     require("nvim-treesitter").setup({
    --         ensure_installed = {
    --             "asm",
    --             "c",
    --             "cmake",
    --             "cpp",
    --             "lua",
    --             "markdown_inline",
    --             "java",
    --             "rust",
    --             "javascript",
    --             "typescript",
    --             "python",
    --             "php",
    --             "latex",
    --             "lua",
    --             "zig",
    --             "bash",
    --             "kotlin",
    --             "groovy",
    --             "json",
    --         },
    --         textobjects = {
    --             select = {
    --                 enable = true,
    --                 lookahead = true,
    --                 keymaps = {},
    --             },
    --         },
    --         matchup = {
    --             enable = true,
    --             disable = { "" },
    --         },
    --         indent = { enable = true },
    --         highlight = {
    --             enable = true,
    --             disable = { "latex" },
    --             use_languagetree = true,
    --         },
    --     })
    --
    --     local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --     parser_config.blade = {
    --         install_info = {
    --             url = "https://github.com/EmranMR/tree-sitter-blade",
    --             files = { "src/parser.c" },
    --             branch = "main",
    --         },
    --         filetype = "blade",
    --     }
    --     vim.filetype.add({
    --         pattern = {
    --             [".*%.blade%.php"] = "blade",
    --         },
    --     })
    -- end,
}
