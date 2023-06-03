local M = {}
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not cmp_ok then return end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = { Error = "✘", Warn = " ", Hint = "", Info = "" }

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

    vim.cmd([[au CursorHold * lua vim.diagnostic.open_float(0,{scope = "cursor"})]])
end

return M
