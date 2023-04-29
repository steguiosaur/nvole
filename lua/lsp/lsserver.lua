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

-- Zig Language Server
lspconfig.zls.setup{
    cmd = {"zls"};
    filetypes = { "zig", "zir" };
}

lspconfig.lua_ls.setup{}
lspconfig.bashls.setup{}
lspconfig.cssls.setup{}
lspconfig.jsonls.setup{}
lspconfig.tsserver.setup{}
lspconfig.html.setup{}
lspconfig.zk.setup{}
lspconfig.marksman.setup{}
