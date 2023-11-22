return {
    "Civitasv/cmake-tools.nvim",
    config = function()
        require("cmake-tools").setup({
            cmake_command = "cmake", -- this is used to specify cmake command path
            cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
            cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
            cmake_build_directory = "build", -- this is used to specify generate directory for cmake
            cmake_build_directory_prefix = "build", -- when cmake_build_directory is set to "", this option will be activated
            cmake_soft_link_compile_commands = false, -- this will automatically make a soft link from compile commands file to project root dir
            cmake_compile_commands_from_lsp = true, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
            cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
            cmake_variants_message = {
                short = { show = true }, -- whether to show short message
                long = { show = true, max_length = 40 }, -- whether to show long message
            },
            cmake_dap_configuration = {
                -- debug settings for cmake
                name = "lldb",
                type = "lldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_always_use_terminal = true, -- if true, use terminal for generate, build, clean, install, run, etc, except for debug, else only use terminal for run, use quickfix for others
            cmake_quickfix_opts = {
                -- quickfix settings for cmake, quickfix will be used when `cmake_always_use_terminal` is false
                show = "only_on_error", -- "always", "only_on_error"
                position = "belowright", -- "bottom", "top"
                size = 9,
            },
            cmake_terminal_opts = {
                -- terminal settings for cmake, terminal will be used for run when `cmake_always_use_terminal` is false or true, will be used for all tasks except for debug when `cmake_always_use_terminal` is true
                name = "Main Terminal",
                prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                split_direction = "horizontal", -- "horizontal", "vertical"
                split_size = 11,

                -- Window handling
                single_terminal_per_instance = false, -- Single viewport, multiple windows
                single_terminal_per_tab = false, -- Single viewport per tab
                keep_terminal_static_location = false, -- Static location of the viewport if avialable

                -- Running Tasks
                start_insert_in_launch_task = true, -- if you want to enter terminal with :startinsert upon using :CMakeRun
                start_insert_in_other_tasks = true, -- If you want to enter terminal with :startinsert upon launching all other cmake tasks in the terminal. Generally set as false
                focus_on_main_terminal = true, -- focus on cmake terminal when cmake task is launched. Only used if cmake_always_use_terminal is true.
                focus_on_launch_terminal = true, -- Focus on cmake launch terminal when executable target in launched.
            },
        })

        vim.keymap.set("n", "<Leader>cg", "<cmd>CMakeGenerate<CR>")
        vim.keymap.set("n", "<Leader>cb", "<cmd>CMakeBuild<CR>")
        vim.keymap.set("n", "<Leader>cc", "<cmd>CMakeClean<CR>")
        vim.keymap.set("n", "<Leader>cq", "<cmd>CMakeClose<CR>")
    end,
}
