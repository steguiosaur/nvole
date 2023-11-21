return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local dap_ok, dap = pcall(require, "dap")
        local dapui_ok, dapui = pcall(require, "dapui")
        local dapvt_ok, dapvt = pcall(require, "nvim-dap-virtual-text")

        if not dap_ok and dapui_ok and dapvt_ok then
            return
        end

        require("mason-nvim-dap").setup({
            ensure_installed = { "codelldb" },
        })

        local opts = { noremap = true, silent = true }

        -- Dap
        vim.keymap.set("n", "<Leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
        vim.keymap.set("n", "<Leader>dc", "<CMD>lua require('dap').continue()<CR>", opts)
        vim.keymap.set("n", "<Leader>dd", "<CMD>lua require('dap').continue()<CR>", opts)
        vim.keymap.set("n", "<Leader>dh", "<CMD>lua require('dapui').eval()<CR>", opts)
        vim.keymap.set("n", "<Leader>di", "<CMD>lua require('dap').step_into()<CR>", opts)
        vim.keymap.set("n", "<Leader>do", "<CMD>lua require('dap').step_out()<CR>", opts)
        vim.keymap.set("n", "<Leader>dO", "<CMD>lua require('dap').step_over()<CR>", opts)
        vim.keymap.set("n", "<Leader>dt", "<CMD>lua require('dap').terminate()<CR>", opts)
        vim.keymap.set("n", "<Leader>dC", "<CMD>lua require('dapui').close()<CR>", opts)

        vim.keymap.set("n", "<Leader>dw", "<CMD>lua require('dapui').float_element('watches', { enter = true })<CR>",
            opts)
        vim.keymap.set("n", "<Leader>ds", "<CMD>lua require('dapui').float_element('scopes', { enter = true })<CR>", opts)
        vim.keymap.set("n", "<Leader>dr", "<CMD>lua require('dapui').float_element('repl', { enter = true })<CR>", opts)


        dapvt.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            only_first_definition = true,
            all_references = false,
            filter_references_pattern = "<module",
            -- Experimental Features:
            virt_text_pos = "eol",   -- position of virtual text, see `:h nvim_buf_set_extmark()`
            all_frames = false,      -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false,      -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        })

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7"),
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
                {
                    elements = {
                        -- Elements can be strings or table with id and size keys.
                        { id = "scopes", size = 0.25 },
                        "breakpoints",
                        "stacks",
                        "watches",
                    },
                    size = 40, -- 40 columns
                    position = "left",
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 0.25, -- 25% of total lines
                    position = "bottom",
                },
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

        -- Automatically open UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
            -- shade.toggle()
        end
        dap.listeners.after.event_terminated["dapui_config"] = function()
            dapui.close()
            -- shade.toggle()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
            -- shade.toggle()
        end

        -- Enable virtual text
        vim.g.dap_virtual_text = true

        vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "S", texthl = "", linehl = "", numhl = "" })

        -- Adapters
        dap.adapters.lldb = {
            type = 'executable',
            command = 'lldb-vscode',
            name = 'lldb'
        }

        -- Config
        dap.configurations.cpp = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input(vim.fn.getcwd() .. '/', 'buildDebug')
                end,
                cwd = '${workspaceFolder}',
                -- program = "${file}",
                -- cwd = "${fileDirname}/buildDebug",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

    end,
}
