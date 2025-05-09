return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"linrongbin16/lsp-progress.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspconfig.ui.windows").default_options.border = "single"

		require("lsp-progress").setup({
			spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
			client_format = function(client_name, spinner, series_messages)
				return #series_messages > 0
						and (table.concat(series_messages, ", ") .. " " .. spinner .. " " .. "[" .. client_name .. "]")
					or nil
			end,
			format = function(client_messages)
				local sign = " LSP" -- nf-fa-gear \uf013
				return #client_messages > 0 and (" " .. table.concat(client_messages, " " .. sign)) or sign
			end,
		})

		local line_x = vim.fn.has("Android") == 1 and {} or { "fileformat", "encoding" }

		-- Lualine
		require("lualine").setup({
			options = {
				theme = "fullerene",
				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						on_click = function()
							vim.cmd("Trouble diagnostics toggle filter.buf=0")
						end,
					},
					"filename",
				},
				lualine_c = {},
				lualine_x = {
					{
						require("lsp-progress").progress,
						on_click = function()
							vim.cmd("LspInfo")
						end,
					},
					line_x,
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
