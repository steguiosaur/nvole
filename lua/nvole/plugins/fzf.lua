return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
    config = function()
        require("fzf-lua").setup({
            oldfiles = {
                include_current_session = true,
            },
            previewers = {
                builtin = {
                    syntax_limit_b = 1024 * 100, -- 100KB
                },
            },
            grep = {
                rg_glob = true,            -- enable glob parsing
                glob_flag = "--iglob",     -- case insensitive globs
                glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
            },
            winopts = {
                border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            },
            file_ignore_patterns = { "node_modules/.*", ".*%.jpg", ".*%.png", ".*%.gif", ".*%.jpeg" },
            keymap = {
                fzf = {
                    ['tab']        = 'down',
                    ['shift-tab']  = 'up',
                    ["ctrl-q"]     = "abort",
                    ["ctrl-u"]     = "unix-line-discard",
                    ["ctrl-f"]     = "half-page-down",
                    ["ctrl-b"]     = "half-page-up",
                    ["ctrl-a"]     = "beginning-of-line",
                    ["ctrl-e"]     = "end-of-line",
                    ["alt-a"]      = "toggle-all",
                    ["f3"]         = "toggle-preview-wrap",
                    ["f4"]         = "toggle-preview",
                    ["shift-down"] = "preview-page-down",
                    ["shift-up"]   = "preview-page-up",
                },
            },
        })

        vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
        vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
        vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>")
        vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>")
        vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>")
        vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua git_commits<CR>")
        vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua git_status<CR>")
        vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>")
        vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua<CR>")
    end
}
