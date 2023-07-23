local null_ls_ok, null_ls = pcall(require, "null-ls")

if not null_ls_ok then return end

require("mason-null-ls").setup({
	ensure_installed = {
		"cpplint",
		"markdownlint",
		"mypy",
		"prettier",
		--"latexindent"
		--"ruff",
		--"stylua",
	},
})

local fmt = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.cpplint,
		diagnostics.markdownlint,
		fmt.prettier.with({
			extra_args = {
				"--no-semi",
				"--single-quote",
				"--jsx-single-quote",
			},
		}),
		fmt.stylua,
		fmt.latexindent,
		--diagnostics.mypy,
		--diagnostics.ruff,
	},
})

