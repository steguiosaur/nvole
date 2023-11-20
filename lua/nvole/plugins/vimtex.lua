return {
    "lervag/vimtex", -- LaTeX
    config = function()
        -- VimTex LaTeX
        vim.g.tex_flavor = "latex"
        --vim.g.vimtex_syntax_conceal_disable = true
        vim.g.vimtex_quickfix_mode = 2
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk = {
            executable = "latexmk",
            out_dir = "output",
            options = {
                "--pdflatex",
                "--shell-escape",
                "--file-line-error",
                "--synctex=1",
                "--interaction=nonstopmode",
            },
        }
    end,
}
