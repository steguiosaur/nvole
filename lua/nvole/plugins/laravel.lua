return {
	"adalessa/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"nvimtools/none-ls.nvim",
	},
	cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
	keys = {
		{ "<leader>lva", "<cmd>Laravel artisan<cr>" },
		{ "<leader>lvr", "<cmd>Laravel routes<cr>" },
		{ "<leader>lvm", "<cmd>Laravel related<cr>" },
	},
	event = { "VeryLazy" },
	config = true,
}
