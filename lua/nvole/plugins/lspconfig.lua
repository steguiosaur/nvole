return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
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
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
            { border = "single" })
        vim.lsp.handlers["textDocument/publishDiagnostics"] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
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

        local on_attach = function(client, bufnr)
            local opts = { noremap = true, buffer = bufnr }

            -- NVIM LSP KEYMAPS
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, { desc = "goto declaration" })
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, { desc = "goto definition" })
            vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts, { desc = "show hover" })
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, { desc = "goto implementation" })
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, { desc = "show references" })
            vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, { desc = "show diagnostic" })
            -- vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts, { desc = "format buffer" })
            vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts, { desc = "show LSP info" })
            vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts,
                { desc = "show code actions" })
            vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts,
                { desc = "next diagnostic" })
            vim.keymap.set("n", "gb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts,
                { desc = "prev diagnostic" })
            vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts, { desc = "rename" })
            vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts,
                { desc = "show signature" })
            vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts, { desc = "set loclist" })
        end

        for _, server in ipairs({
            "asm_lsp",
            "bashls",
            "clangd",
            "cmake",
            "cssls",
            "eslint",
            "groovyls",
            "html",
            "jsonls",
            "kotlin_language_server",
            "ltex",
            "lua_ls",
            "phpactor",
            "pyright",
            "sqlls",
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

        lspconfig.sqlls.setup {
            filetypes = { 'sql', 'mysql', 'sqlite' },
            root_dir = function(_)
                return vim.loop.cwd()
            end,
        }

        lspconfig.ltex.setup({
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
