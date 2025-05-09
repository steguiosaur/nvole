local M = {}

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
    vim.notify("cmp-nvim-lsp not found. LSP capabilities might be basic.", vim.log.levels.WARN)
    cmp_nvim_lsp = { default_capabilities = function(caps) return caps end }
end


M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    },
}
M.capabilities.offsetEncoding = { "utf-8" }


vim.diagnostic.config({
    virtual_text = true,
    signs = {
        active = true,
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
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


vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
        silent = true,
        border = "single",
    })

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
    })

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
    })


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("nvole.lsp", { clear = true }),
    callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.client_id)
        local opts = {
            noremap = true,
            -- silent = true,
            buffer = bufnr,
        }

        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, { desc = "goto declaration" })
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, { desc = "goto definition" })
        vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover({ border = \"single\" })<CR>", opts,
            { desc = "show hover" })
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, { desc = "goto implementation" })
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, { desc = "show references" })
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, { desc = "show diagnostic" })
        -- vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts, { desc = "format buffer" })
        vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts, { desc = "show LSP info" })
        vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts, { desc = "show code actions" })
        vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts, { desc = "next diagnostic" })
        vim.keymap.set("n", "gb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts, { desc = "prev diagnostic" })
        vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts, { desc = "rename" })
        vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help({ border = \"single\"} )<CR>", opts,
            { desc = "show signature" })
        vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts, { desc = "set loclist" })
    end,
})

return M
