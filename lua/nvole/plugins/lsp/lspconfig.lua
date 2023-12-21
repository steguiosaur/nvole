return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "nvim-tree/nvim-tree.lua",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "simrat39/rust-tools.nvim",
    },
    config = function()
        local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
        local rt_ok, rust_tools = pcall(require, "rust-tools")
        if not lspconfig_ok then return end
        local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if not cmp_ok then return end

        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap.set

        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.offsetEncoding = { "utf-8" }

        local signs = {
            Error = "✘",
            Warn = "",
            Hint = "",
            Info = ""
        }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.diagnostic.config {
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
        }

        vim.fn.execute("au CursorHold * lua vim.diagnostic.open_float(0, { scope = 'cursor' })", true)

        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                silent = true,
                border = "single",
            }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "single",
            }),
        }

        ---@diagnostic disable-next-line: unused-local
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- NVIM LSP KEYMAPS
            keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            --keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
            keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
            keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
            keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
            keymap("n", "gb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
            keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        end

        -- SYSTEMS / LOW LEVEL
        lspconfig.asm_lsp.setup({
            cmd = { "asm-lsp" },
            filetypes = { "s", "S", "asm" },
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
        })

        if vim.fn.executable("clangd") == 1 then
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
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
                handlers = handlers,
            })
        end

        lspconfig.cmake.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.cmake").settings,
        })

        if vim.fn.executable("rust-analyzer") == 1 then
            if rt_ok then
                rust_tools.setup({
                    server = {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        handlers = handlers,
                    },
                })
            end
        end

        if vim.fn.executable("zls") == 1 then
            lspconfig.zls.setup({
                cmd = { "zls" },
                on_attach = on_attach,
                capabilities = capabilities,
                handlers = handlers,
            })
        end

        -- SCRIPTING
        lspconfig.pyright.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.pyright").settings,
        })

        if vim.fn.executable("lua-language-server") == 1 then
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                handlers = handlers,
                on_attach = on_attach,
                settings = require("nvole.plugins.lsp.servers.lua_ls").settings,
            })
        end

        lspconfig.bashls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.bashls").settings,
        })

        -- JVM LANGUAGES
        lspconfig.jdtls.setup({
            filetypes = { "java" },
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.jdtls").settings,
        })

        lspconfig.kotlin_language_server.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
        })

        lspconfig.groovyls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
        })

        -- WEB DEVELOPMENT
        lspconfig.cssls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.cssls").settings,
        })

        lspconfig.html.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.html").settings,
        })

        lspconfig.tsserver.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.tsserver").settings,
        })

        lspconfig.jsonls.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
            settings = require("nvole.plugins.lsp.servers.jsonls").settings,
        })

        -- TYPESETTING
        lspconfig.ltex.setup({
            filetypes = { "tex", "markdown" },
            capabilities = capabilities,
            handlers = handlers,
            on_attach = on_attach,
        })

        if vim.fn.executable("texlab") == 1 then
            lspconfig.texlab.setup({
                cmd = { "texlab" },
                filetypes = { "tex", "plaintex", "bib" },
                on_attach = on_attach,
                capabilities = capabilities,
                handlers = handlers,
            })
        end
    end,
}
