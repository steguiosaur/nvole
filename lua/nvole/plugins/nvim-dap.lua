return {
    "mfussenegger/nvim-dap",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap_ok, dap = pcall(require, "dap")
        local dapui_ok, dapui = pcall(require, "dapui")
        local dapvt_ok, dapvt = pcall(require, "nvim-dap-virtual-text")

        if not dap_ok and dapui_ok and dapvt_ok then
            return
        end

        local opts = { noremap = true }

        -- Dap
        vim.keymap.set("n", "<Leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
        vim.keymap.set("n", "<Leader>dd", "<CMD>lua require('dap').continue()<CR>", opts)
        vim.keymap.set("n", "<Leader>di", "<CMD>lua require('dap').restart()<CR>", opts)
        vim.keymap.set("n", "<Leader>dj", "<CMD>lua require('dap').step_into()<CR>", opts)
        vim.keymap.set("n", "<Leader>dk", "<CMD>lua require('dap').step_over()<CR>", opts)
        vim.keymap.set("n", "<Leader>dl", "<CMD>lua require('dap').step_out()<CR>", opts)
        vim.keymap.set("n", "<F1>", "<CMD>lua require('dap').step_into()<CR>", opts)
        vim.keymap.set("n", "<F2>", "<CMD>lua require('dap').step_over()<CR>", opts)
        vim.keymap.set("n", "<F3>", "<CMD>lua require('dap').step_out()<CR>", opts)
        vim.keymap.set("n", "<Leader>dq", function()
            require("dap").terminate()
            require("dapui").close()
        end, { noremap = true, desc = "terminate debugger" })
        vim.keymap.set("n", "<Leader>d<space>", "<CMD>lua require('dapui').open()<CR>", opts)
        vim.keymap.set("n", "<Leader>dQ", "<CMD>lua require('dapui').close()<CR>", opts)
        vim.keymap.set("n", "<Leader>dh", "<CMD>lua require('dapui').eval()<CR>", opts)
        vim.keymap.set(
            "n",
            "<Leader>dw",
            "<CMD>lua require('dapui').float_element('watches', { enter = true, position = center })<CR>",
            opts
        )
        vim.keymap.set(
            "n",
            "<Leader>ds",
            "<CMD>lua require('dapui').float_element('scopes', { enter = true, position = center })<CR>",
            opts
        )
        vim.keymap.set(
            "n",
            "<Leader>dr",
            "<CMD>lua require('dapui').float_element('repl', { enter = true, position = center })<CR>",
            opts
        )

        dapvt.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            clear_on_continue = false,
            virt_text_pos = "eol",
            -- Experimental Features:
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            expand_lines = vim.fn.has("nvim-0.7"),
            layouts = {
                {
                    elements = {
                        { id = "repl", size = 0.25 },
                        { id = "stacks", size = 0.25 },
                        { id = "scopes", size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                    },
                    size = 60, -- 40 columns
                    position = "right",
                },
                -- {
                --     elements = {
                --         -- { id = "console", size = 0.25 },
                --     },
                --     size = 0.25, -- 25% of total lines
                --     position = "bottom",
                -- },
            },
            floating = {
                max_height = nil,  -- These can be integers or a float between 0 and 1.
                max_width = nil,   -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil,
            },
        })

        -- DAP Setup
        dap.set_log_level("TRACE")

        -- Enable virtual text
        vim.g.dap_virtual_text = true

        vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "S", texthl = "", linehl = "", numhl = "" })

        -- Adapters
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "-i", "dap" },
        }

        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                })
            else
                cb({
                    type = 'executable',
                    command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                    },
                })
            end
        end

        -- Config
        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch',
                name = "Launch file",

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}", -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return '/usr/bin/python'
                    end
                end,
            },
        }

        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                args = function()
                    local args_in = vim.fn.input("Arguments: ")
                    local args = {}
                    for arg in string.gmatch(args_in, "%S+") do
                        table.insert(args, arg)
                    end
                    return args
                end,
                stopOnEntry = false,
                runInTerminal = false,
            },
        }
        dap.configurations.cpp = dap.configurations.c
        dap.configurations.rust = dap.configurations.c
    end,
}
