return {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
        -- Lua initialization file
        local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "moonfly",
            callback = function()
                vim.api.nvim_set_hl(0, "Function", { bg = "#101010", bold = true })
            end,
            group = custom_highlight,
        })

        -- vim.cmd('colorscheme moonfly')
    end
}
