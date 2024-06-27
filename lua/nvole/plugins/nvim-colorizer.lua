return {
	"norcalli/nvim-colorizer.lua", -- color highlighter
	event = "VeryLazy",
	config = function()
		-- Run colorizer on every buffer:
		vim.cmd([[
            augroup Colorizer
                autocmd!
                autocmd BufEnter * ColorizerAttachToBuffer
            augroup END
        ]])

		require("colorizer").setup({
			"*",
		})
	end,
}
