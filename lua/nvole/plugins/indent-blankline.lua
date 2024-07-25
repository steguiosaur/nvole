return {
	"lukas-reineke/indent-blankline.nvim",
	priority = 500,
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = "▎",
			},
			scope = {
				enabled = true, -- 'true': Highlight only the intended indentation and the current scope by an underline.
				show_start = false, -- Shows an underline on the first line of the scope.
				show_end = false, -- Shows an underline on the last line of the scope.
				show_exact_scope = false,
				injected_languages = true,
			},
			exclude = {
				filetypes = {
					"help",
					"packer",
					"NvimTree",
					"Trouble",
					"dashboard",
					"TelescopePrompt",
					"TelescopeResults",
					"TelescopePreviewer",
					"lspinfo",
					"startify",
					"fugitive",
					"fugitiveblame",
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
		})
	end,
}
