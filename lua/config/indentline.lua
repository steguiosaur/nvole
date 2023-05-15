vim.opt.list = true
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_current_context = false,
    show_current_context_start = true,
    show_end_of_line = true,
}
