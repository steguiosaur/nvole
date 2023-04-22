require('lspconfig').pyright.setup{
    cmd = { "pyright-langserver", "--stdio" };
    filetypes = { "python" };
}
