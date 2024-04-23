return {
    "lervag/vimtex",
    ft = { "tex", "latex", "bib" },
    config = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_syntax_conceal_disable = true
        vim.g.vimtex_quickfix_mode = 2
        vim.g.vimtex_view_method = "zathura"

        vim.g.vimtex_compiler_latexmk = {
            executable = "latexmk",
            out_dir = "output",
            options = {
                "-pdflatex",
                "-shell-escape",
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
            },
        }

        vim.g.vimtex_quickfix_ignore_filters = {
            "Command terminated with space",
            "LaTeX Font Warning: Font shape",
            "Package caption Warning: The option",
            [[Underfull \\hbox (badness [0-9]*) in]],
            "Package enumitem Warning: Negative labelwidth",
            [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
            [[Package caption Warning: Unused \\captionsetup]],
            "Package typearea Warning: Bad type area settings!",
            [[Package fancyhdr Warning: \\headheight is too small]],
            [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
            "Package hyperref Warning: Token not allowed in a PDF string",
            [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
        }
    end,
}
