local M = {}

M.settings = {
	java = {
		codeGeneration = {
			hashCodeEquals = {
				useInstanceof = true,
				useJava7Objects = true,
			},
			toString = {
				codeStyle = "STRING_BUILDER_CHAINED",
			},
			useBlocks = true,
		},
		contentProvider = { preferred = "fernflower" },
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		signatureHelp = { enabled = true },
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		format = {
			settings = {
				profile = "GoogleStyle",
			},
		},
	},
}

return M
