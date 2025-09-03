local M = {}

function M.setup()
    local mason_status_ok, mason = pcall(require, "mason")
    if not mason_status_ok then
        vim.notify("Mason not found!", vim.log.levels.ERROR)
        return
    end

    local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_status_ok then
        vim.notify("Mason-lspconfig not found!", vim.log.levels.ERROR)
        return
    end

    local mason_tool_installer = require("mason-tool-installer")
    local mason_nvim_dap = require("mason-nvim-dap")

    local lsp_shared = require("nvole.core.lsp-settings")

    mason.setup({
        ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
        max_concurrent_installers = 10,
    })

    mason_lspconfig.setup({
        ensure_installed = {
            "bashls",
            "cmake",
            "cssls",
            -- "diagnosticls",
            "eslint",
            -- "groovyls",
            "html",
            "intelephense",
            "jdtls",
            "jsonls",
            -- "kotlin_language_server",
            "ltex",
            "pyright",
            -- "phpactor",
            -- "sqlls",
            "ts_ls",
            -- "vue_ls",
            -- "zls",
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
        automatic_enable = {
            exclude = {
                "jdtls",
                "lua_ls",
                "texlab",
                "clangd",
                "ltex",
            },
        },
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = lsp_shared.capabilities,
                })
            end,

            ["lua_ls"] = function()
            end,

            ["vue_ls"] = function()
                require("lspconfig").vue_ls.setup({
                    capabilities = lsp_shared.capabilities,
                    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
                    init_options = {
                        languageFeatures = {
                            references = true,
                            definition = true,
                            typeDefinition = true,
                            callHierarchy = true,
                            hover = true,
                            rename = true,
                            signatureHelp = true,
                            codeAction = true,
                            completion = {
                                defaultTagNameCase = "both",
                                defaultAttrNameCase = "kebabCase",
                            },
                            schemaRequestService = true,
                            documentHighlight = true,
                            codeLens = true,
                            semanticTokens = true,
                            diagnostics = true,
                        },
                        documentFeatures = {
                            selectionRange = true,
                            foldingRange = true,
                            linkedEditingRange = true,
                            documentSymbol = true,
                            documentColor = true,
                        },
                    },
                    settings = {
                        volar = {
                            codeLens = {
                                references = true,
                                pugTools = true,
                                scriptSetupTools = true,
                            },
                        },
                    },
                    root_markers = { "package.json", "vue.config.js" }
                })
            end,

            ["sqlls"] = function()
                require("lspconfig").sqlls.setup {
                    capabilities = lsp_shared.capabilities,
                    filetypes = { 'sql', 'mysql', 'sqlite' },
                    root_dir = function(_)
                        return vim.loop.cwd()
                    end,
                }
            end,

            ["rust_analyzer"] = function()
            end,

            ["jdtls"] = function()
            end,

            ["cssls"] = function()
                require("lspconfig").cssls.setup({
                    capabilities = lsp_shared.capabilities,
                    settings = {
                        css = {
                            lint = {
                                unknownAtRules = "ignore",
                            },
                        },
                        scss = {
                            lint = {
                                unknownAtRules = "ignore",
                            },
                        },
                    },
                })
            end,

            ["ltex"] = function()
            end,

            ["jsonls"] = function()
                require("lspconfig").jsonls.setup({
                    capabilities = lsp_shared.capabilities,
                    settings = {
                        json = {
                            schemas = {
                                {
                                    fileMatch = { "package.json" },
                                    url = "https://json.schemastore.org/package.json",
                                },
                                {
                                    fileMatch = { "tsconfig*.json" },
                                    url = "https://json.schemastore.org/tsconfig.json",
                                },
                                {
                                    fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                                    url = "https://json.schemastore.org/prettierrc.json",
                                },
                                {
                                    fileMatch = { ".eslintrc", ".eslintrc.json" },
                                    url = "https://json.schemastore.org/eslintrc.json",
                                },
                                {
                                    fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                                    url = "https://json.schemastore.org/babelrc.json",
                                },
                                {
                                    fileMatch = { "lerna.json" },
                                    url = "https://json.schemastore.org/lerna.json",
                                },
                                {
                                    fileMatch = { "now.json", "vercel.json" },
                                    url = "https://json.schemastore.org/now.json",
                                },
                                {
                                    fileMatch = { "ecosystem.json" },
                                    url = "https://json.schemastore.org/pm2-ecosystem.json",
                                },
                            },
                        },
                    },
                })
            end,
        }
    })

    require("lspconfig").clangd.setup({
        capabilities = lsp_shared.capabilities,
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
            "--background-index",
            "--compile-commands-dir=build",
            "--clang-tidy",
            "--cross-file-rename",
            "--all-scopes-completion",
            "--completion-style=detailed",
            "--header-insertion-decorators",
            "--header-insertion=iwyu",
            "--pch-storage=memory",
            "--print-options",
            "-j=4",
            "--log=verbose"
        },
    })

    require("lspconfig").lua_ls.setup({
        capabilities = lsp_shared.capabilities,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    })

    local rt_ok, rust_tools = pcall(require, "rust-tools")
    if rt_ok then
        rust_tools.setup({ server = { capabilities = lsp_shared.capabilities } })
    else
        require("lspconfig").rust_analyzer.setup({ capabilities = lsp_shared.capabilities })
    end

    require("lspconfig").ltex.setup({
        capabilities = lsp_shared.capabilities,
        settings = {
            ltex = {
                language = "en-US",
                enabled = { "latex" },
            },
        },
    })


    if mason_tool_installer then
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier",     -- prettier formatter
                -- "stylua", -- lua formatter
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
    end

    if mason_nvim_dap then
        mason_nvim_dap.setup({
            automatic_installation = false,
            ensure_installed = {
                "debugpy",
                "java-debug-adapter",
                "java-test",
            },
        })
    end
end

return M
