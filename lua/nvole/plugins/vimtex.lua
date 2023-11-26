return {
    "lervag/vimtex", -- LaTeX
    ft = { "latex", "tex" },
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

        if vim.fn.has("Android") == 1 then
            function OpenPdf()
                local pdf_path = './output/' .. vim.fn.expand('%:t:r') .. '.pdf'
                vim.fn.system('termux-open ' .. vim.fn.shellescape(pdf_path))
            end
            vim.keymap.set({ 'n', 'v'}, '<leader>lv', "<cmd>lua OpenPdf()<CR>", { noremap = true })
        end

    end,
}
