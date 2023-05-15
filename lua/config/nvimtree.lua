require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	hijack_directories = { enable = true },
	sync_root_with_cwd = true,
	view = {
		adaptive_size = false,
		side = "left",
		width = 25,
		preserve_window_proportions = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	filters = {
		exclude = { ".git", "node_modules", ".cache" },
	},
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	git = {
		enable = true,
		ignore = false,
	},
	filesystem_watchers = {
		enable = true,
	},
	renderer = {
		root_folder_label = false,
		highlight_git = false,
		highlight_opened_files = "none",
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "󰉋",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = true,
			},
		},
	},
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
