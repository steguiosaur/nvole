return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "nvim-tree/nvim-tree.lua",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "p00f/clangd_extensions.nvim",
        "mfussenegger/nvim-jdtls",
        "simrat39/rust-tools.nvim",
    },
    config = function()
        local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
        if not lspconfig_ok then
            return
        end
        local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not cmp_ok then
            return
        end

        local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                active = signs,
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "single",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- vim.fn.execute("au CursorHold * lua vim.diagnostic.open_float(0, { scope = 'cursor' })", true)

        -- LSP HANDLERS
        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = "single" })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
        vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            },
        }
        capabilities.offsetEncoding = { "utf-8" }
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap.set

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- NVIM LSP KEYMAPS
            keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            -- keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
            keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
            keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
            keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
            keymap("n", "gb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
            keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        end

        for _, server in ipairs({
            "asm_lsp",
            "bashls",
            "cmake",
            "cssls",
            "diagnosticls",
            "html",
            "eslint",
            "groovyls",
            "kotlin_language_server",
            "pyright",
            "tailwindcss",
            "texlab",
            "tsserver",
            "volar",
            "zls",
        }) do
            lspconfig[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        lspconfig.ltex.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ltex = {
                    language = "en-US",
                    enabled = { "latex" },
                },
            },
        })

        lspconfig.phpactor.setup({
            cmd = { "phpactor", "language-server", "-vv" },
            filetypes = { "php", "blade" },
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function(_)
                return vim.loop.cwd()
            end,
            init_options = {
                ["language_server_phpstan.enabled"] = false,
                ["language_server_psalm.enabled"] = false,
                ["language_server_completion.trim_leading_dollar"] = true,
                ["language_server_worse_reflection.inlay_hints.enable"] = true,
                ["language_server_worse_reflection.inlay_hints.params"] = true,
                ["language_server_worse_reflection.inlay_hints.types"] = true,
                ["language_server_configuration.auto_config"] = true,
                ["code_transform.import_globals"] = true,
            },
        })

        lspconfig.clangd.setup({
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
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })

        local rt_ok, rust_tools = pcall(require, "rust-tools")
        if rt_ok then
            rust_tools.setup({
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                },
            })
        end

        lspconfig.lua_ls.setup({
            ft = { "lua" },
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        lspconfig.cssls.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                client.server_capabilities.documentRangeFormattingProvider = true
            end,
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

        lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
