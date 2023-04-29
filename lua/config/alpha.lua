local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
"             ▄▄▄▄                     ",
"            █  ▄ █                    ",
"          ▄▄█▄▄▄▄█▄▄ ▄▄▄▄▄▄▄          ",
"          ▄ ▀   ▀▀      ▀▀▀███▄       ",
" ▄▀▄   ▄▄██    ▄▄▀           ▀██▄     ",
"  ▀▄▀▄█▀▀▄▄▄                     ▀█▄  ",
"    █▀   █▄█           ▄▄▄▄▄      ██  ",
"   █▀                ▄██▀▀▀▀██▄   ██  ",
"  █▀  ▄▄█▄▄         ██▀       ▀   ██▄ ",
"   ▀▀▀▀█▀▄▀▀▀▀▀██▄█▄██         ▄▄████ ",
"        ▀▄▀ ▀█▀██▀▀ ▀█▄▄▄██   ▄███▀██ ",
"              ▀▀      █▀▀   ▄██▀▀  ██ ",
"                   ▄█▀█████▀▀▀    ▄██ ",
"                    ▀▀█          ▄██  ",
"                              ▄▄██▀   ",
"                 ▄█████████████▀▀     ",
"                                      ",
"         █▄░█ █░█ █▀█ █░░ █▀▀         ",
"         █░▀█ ▀▄▀ █▄█ █▄▄ ██▄         ",
"                                      ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("e", "  New File" , ":ene <BAR> startinsert <CR>"),
    dashboard.button("ff", "  Find File", ":Telescope find_files<CR>"),
    dashboard.button("fg", "  Find Text", ":Telescope live_grep<CR>"),
    dashboard.button("fr", "  Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button("m", "  Mason"    , ":Mason<CR>"),
    dashboard.button("s", "  Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
