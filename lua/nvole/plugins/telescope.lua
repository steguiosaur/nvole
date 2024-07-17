return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = { ["<esc>"] = actions.close },
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				prompt_prefix = "   ",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				color_devicons = true,
				path_display = { "truncate" },
				layout_config = {
					prompt_position = "top",
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					oldfiles = {
						prompt_title = "Recent Files",
					},
				},
			},
		})

		telescope.load_extension("fzf")

		local opts = { noremap = true, silent = true }
		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
		keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
		keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
		keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
		keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
		keymap("n", "<leader>fc", ":Telescope git_commits<CR>", opts)
		keymap("n", "<leader>fs", ":Telescope git_status<CR>", opts)
	end,
}
