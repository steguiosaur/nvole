local null_ls_ok, null_ls = pcall(require, "null-ls")

if not null_ls_ok then return end

local fmt = null_ls.builtins.formatting
--local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        fmt.prettier.with({
            extra_args = {
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote"
            }
        }),
        fmt.stylua,
        fmt.latexindent,
    },
})
