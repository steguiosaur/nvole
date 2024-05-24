return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        local mason_nvim_dap = require("mason-nvim-dap")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            max_concurrent_installers = 10,
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "bashls",
                "cmake",
                "cssls",
                "diagnosticls",
                "html",
                "jdtls",
                "jsonls",
                "pyright",
                "tsserver",
                "zls",
                "kotlin_language_server",
                "groovyls",
                "ltex",
                "phpactor",
                "itelephense",
            },
            automatic_installation = {
                exclude = {
                    "clangd",
                    "lua_ls",
                    "rust_analyzer",
                    "texlab",
                    "typst_lsp",
                },
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",     -- prettier formatter
                -- "stylua",       -- lua formatter
                "isort",        -- python formatter
                "black",        -- python formatter
                "bibtex-tidy",  -- bibtex formatter
                "php-cs-fixer", -- php formatter

                "pylint",       -- python linter
                "eslint_d",     -- js linter
                "markdownlint", -- md linter
                "cpplint",      -- c/cpp linter
                "cmakelang",    -- cmake linter
                "cmakelint",    -- cmake linter
                "phpcs",        -- php linter
            },
        })


        mason_nvim_dap.setup({
            ensure_installed = {
                "debugpy",
                "java-debug-adapter",
                "java-test",
            },
        })

    end,
}
