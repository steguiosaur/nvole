-- VimTex LaTeX
vim.g.tex_flavor = "latex"
vim.g.vimtex_syntax_conceal_disable = true
vim.g.vimtex_quickfix_mode = true
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
	executable = "latexmk",
	build_dir = "output",
	options = {
		"-lualatex",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
	},
}

-- Markdown Preview
vim.g.mkdp_theme = "dark"
