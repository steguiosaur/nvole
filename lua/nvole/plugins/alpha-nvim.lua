return {
    "goolord/alpha-nvim",
    event = { "VimEnter" },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "BlakeJC94/alpha-nvim-fortune",
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local fortune = require("alpha.fortune")

        -- Set header
        dashboard.section.header.val = {
            "                                ",
            "      █▄░█ █░█ █▀█ █░░ █▀▀      ",
            "      █░▀█ ▀▄▀ █▄█ █▄▄ ██▄      ",
            "                                ",
            " - nvim config by steguiosaur - ",
            "                                ",
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("ff", "󰈞  Find File", ":FzfLua files<CR>"),
            dashboard.button("fg", "󰊄  Find Text", ":FzfLua live_grep<CR>"),
            dashboard.button("fr", "  Recent", ":FzfLua oldfiles<CR>"),
            dashboard.button("m", "  Mason", ":Mason<CR>"),
            dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h<CR>"),
            dashboard.button("q", "󰅙  Quit NVIM", ":qa<CR>"),
        }

        dashboard.section.footer.val = fortune()

        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd("autocmd FileType alpha setlocal nofoldenable")
    end,
}
