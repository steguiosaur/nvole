
-- Lualine
require('lualine').setup{
    options = { theme = 'nightfly' },
    sections = {
        lualine_c = {'lsp_progress'},
        lualine_x = {'encoding' , 'filetype'},
    },
}
