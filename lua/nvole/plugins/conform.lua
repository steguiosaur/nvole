return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
        {
            "<leader>lf",
            function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true,
                })
            end,
            mode = { "n", "v" },
            desc = "Format file or range (in visual mode)",
        },
    },
    config = function()
        vim.b.disable_autoformat = true
        vim.g.disable_autoformat = true

        require("conform").setup({
            formatters_by_ft = {
                -- javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                -- lua = { "stylua" },
                python = { "black" },
                latex = { "latexindent" },
                bibtex = { "bibtex-tidy" },
                -- c = { "clang_format" },
                -- cpp = { "clang_format" },
                -- java = { "clang_format" },
                php = { "php" },
                blade = { "blade-formatter" },
            },
            formatters = {
                php = {
                    command = "php-cs-fixer",
                    args = {
                        "--rules=@PER-CS",
                        "--using-cache=no",
                        "fix",
                        "$FILENAME",
                    },
                    stdin = false,
                },
                notify_on_error = true,
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 2500, lsp_format = "fallback" }
            end,
        })

        vim.api.nvim_create_user_command("ConformDisable", function(args)
            if args.bang then
                -- command ConformDisable!
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("ConformEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
}
