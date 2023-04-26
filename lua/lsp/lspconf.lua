local status_lsp_ok, lspconfig = pcall(require, "lspconfig")
if not status_lsp_ok then
	return
end

-- Clangd
lspconfig.clangd.setup{
    cmd = {"clangd"};
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" };
    root_pattern = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    };
}

-- Cmake
lspconfig.cmake.setup{
    cmd = {"cmake-language-server"};
    filetypes = {"cmake"};
    init_options = {
        build_directory = "build"
    };
    root_pattern = {
        'CMakePresets.json',
        'CTestConfig.cmake',
        '.git',
        'build',
        'cmake'
    };
}

-- Lua
lspconfig.lua_ls.setup{}

-- Python
lspconfig.pyright.setup{
    cmd = { "pyright-langserver", "--stdio" };
    filetypes = { "python" };
}

-- Rust
lspconfig.rust_analyzer.setup{
    cmd = {"rust-analyzer"};
    filetypes = {"rust", "rs"};
}

-- LaTeX
lspconfig.texlab.setup{
    cmd = {"texlab"};
    filetypes = { "tex", "plaintex", "bib" };
}

vim.g.tex_flavor = "latex"
vim.g.vimtex_syntax_conceal_disable = true
vim.g.vimtex_quickfix_mode = true
vim.g.vimtex_view_method = "zathura"

-- Zig Language Server
lspconfig.zls.setup{
    cmd = {"zls"};
    filetypes = { "zig", "zir" };
}

lspconfig.bashls.setup{}
lspconfig.cssls.setup{}
lspconfig.jsonls.setup{}
lspconfig.zk.setup{}
lspconfig.marksman.setup{}

-- MarkdownPreview
vim.g.mkdp_theme = "dark"

lspconfig.tsserver.setup{}
lspconfig.html.setup{}
