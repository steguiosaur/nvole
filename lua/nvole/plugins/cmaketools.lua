return {
	"Civitasv/cmake-tools.nvim",
	event = "VeryLazy",
	config = function()
		require("cmake-tools").setup({
			cmake_command = "cmake",
			cmake_regenerate_on_save = true,
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_build_options = {},
			cmake_build_directory = "build",
			cmake_build_directory_prefix = "build",
			cmake_soft_link_compile_commands = false,
			cmake_compile_commands_from_lsp = true,
			cmake_kits_path = nil,
			cmake_variants_message = {
				short = { show = true },
				long = { show = true, max_length = 40 },
			},
			cmake_dap_configuration = {
				name = "gdb",
				type = "gdb",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = false,
				console = "integratedTerminal",
			},
			cmake_always_use_terminal = false,
			cmake_quickfix_opts = {
				show = "only_on_error",
				position = "belowright",
				size = 9,
				encoding = "utf-8",
				auto_close_when_success = true,
			},
			cmake_terminal_opts = {
				name = "Main Terminal",
				prefix_name = "[CMakeTools]: ",
				split_direction = "horizontal",
				split_size = 11,

				-- Window handling
				single_terminal_per_instance = false,
				single_terminal_per_tab = false,
				keep_terminal_static_location = false,

				-- Running Tasks
				start_insert_in_launch_task = false,
				start_insert_in_other_tasks = false,
				focus_on_main_terminal = true,
				focus_on_launch_terminal = true,
			},
		})

		vim.keymap.set("n", "<Leader>cg", "<cmd>CMakeGenerate<CR>")
		vim.keymap.set("n", "<Leader>ct", "<cmd>CMakeSelectBuildType<CR>")
		vim.keymap.set("n", "<Leader>cb", "<cmd>CMakeBuild<CR>")
		vim.keymap.set("n", "<Leader>cc", "<cmd>CMakeClean<CR>")
		vim.keymap.set("n", "<Leader>cq", "<cmd>CMakeClose<CR>")
	end,
}
