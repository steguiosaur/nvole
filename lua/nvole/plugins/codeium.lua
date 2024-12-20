return {
    "Exafunction/codeium.vim",
    enabled = false,
    -- enabled = function()
    --     return vim.fn.has("Android") == 0
    -- end,
    event = { "BufWritePre" },
    config = function()
        vim.g.codeium_disable_bindings = 1

        vim.keymap.set("i", "<C-g>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, desc = "accept codeium suggestion" })
        vim.keymap.set("i", "<C-e>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, desc = "cycle next codeium completions" })
        vim.keymap.set("i", "<C-b>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, desc = "cycle prev codeium completions" })
        vim.keymap.set("i", "<C-x>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true, desc = "clear codeium suggestion" })
    end,
}
