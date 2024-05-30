return {
    "stevearc/conform.nvim",
    --event = { "BufWritePre" }, -- to disable, comment this out
    keys = {
        {
            "<leader>lc",
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
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "prettier" },
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
                lua = { "stylua" },
                python = { "isort", "black" },
                latex = { "latexindent" },
                bibtex = { "bibtex-tidy" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                java = { "clang_format" },
                php = { "php-cs-fixer" },
            },

            format_on_save = {
                lsp_fallback = true,
                async = true,
                timeout_ms = 1000,
            },
        })
    end,
}
