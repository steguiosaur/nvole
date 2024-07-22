return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local opts = { noremap = true, silent = true }
		local keymap = vim.keymap.set

		keymap("n", "<leader>mm", ':lua require("harpoon.mark").add_file()<CR>', opts)
		keymap("n", "<leader>mf", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
		keymap("n", "<leader>mn", ':lua require("harpoon.ui").nav_next()<CR>', opts)
		keymap("n", "<leader>mp", ':lua require("harpoon.ui").nav_prev()<CR>', opts)
		keymap("n", "<leader>mt", ':lua require("harpoon.tmux").gotoTerminal(1)<CR>', opts)
	end,
}
