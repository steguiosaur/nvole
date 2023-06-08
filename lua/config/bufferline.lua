require("bufferline").setup{
    options = {
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        show_close_icon = true,
        left_trunc_marker = '',
        right_trunc_marker = '',
        color_icons = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer" ,
                text_align = "center",
                separator = false
            },
        },
    },
    highlights = {
    	buffer_selected = { italic = false },
    	diagnostic_selected = { italic = false },
    	hint_selected = { italic = false },
    	pick_selected = { italic = false },
    	pick_visible = { italic = false },
    	pick = { italic = false },
    },
}

