return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            -- javascript = { "eslint_d" },
            -- typescript = { "eslint_d" },
            -- javascriptreact = { "eslint_d" },
            -- typescriptreact = { "eslint_d" },
            -- svelte = { "eslint_d" },
            -- python = { "pylint" },
            -- c = { "cpplint" },
            -- cpp = { "cpplint" },
            markdown = { "markdownlint" },
            cmake = { "cmakelint" },
            php = { "phpcs" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>lw", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
