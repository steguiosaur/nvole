local options = {
    number          = true,     -- show numberline
    relativenumber  = true,     -- relative numberline

    -- tab options
    expandtab       = true,     -- enables space for tabs
    tabstop         = 4,        -- number of spaces in a tab
    softtabstop     = 4,        -- number of spaces per <Tab> and <Backspace>
    autoindent      = false,    -- copy indent from previous line
    shiftwidth      = 4,        -- space for indentation

    -- word search/highlighting
    hlsearch        = true,     -- highlight searched words
    incsearch       = true,     -- show search current matched patterns
    ignorecase      = true,     -- case insensitive search
    smartcase       = true,     -- override "ignorecase" on upper case pattern
    cursorline      = true,     -- highlight current cursor line
    showmatch       = true,     -- show matching parenthesis and brackets

    -- text display formatting
    wrap            = true,     -- wrap lines extending the window
    breakindent     = true,     -- linebreak follows indentation
    breakat         = " ^!@*-+;:,./?", -- linebreakable characters
    linebreak       = true,     -- break long lines in "breakat"
    conceallevel    = 0,        -- reveal syntax on Markdown files
    fileencoding    = "utf-8",  -- file encoding in buffer
    textwidth       = 80,        -- no string limitation
    colorcolumn     = "+1",
    shortmess = vim.o.shortmess .. 'af',

    -- navigation
    scrolloff       = 5,        -- lines above and below cursor
    mouse           = 'a',      -- mouse support

    -- statusline and commandline
    laststatus      = 2,        -- last window statusline enable
    showmode        = false,    -- show current mode
    showtabline     = 1,        -- shows tabline
    signcolumn      = "yes",    -- shows signcolumn
    modeline        = true,     -- file specific options on comments
    clipboard       = "unnamedplus", -- connect to system clipboard
    confirm         = true,     -- confirm on exit

    -- commandline completion
    wildmenu        = true,     -- command completion on <Tab>
    wildmode        = "longest,full", -- event on <Tab>
    wildignore      = "*.o, *.docx, *.pdf, *.jpg, *.png, *.gif, *.img",

    -- etc
    termguicolors   = true,     -- enable 24-bit RGB color in the TUI
    hidden          = true,     -- hide current unsaved edited file on :e
    title           = true,     -- show filename and directory on titlestring
    undofile        = true,     -- persistent undo
    pumheight       = 10,
    swapfile        = false,    -- swapfiles for recovery
    updatetime      = 250,
    fillchars       = {eob = " "}
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

---- GLOBAL & AUTOCMD
if vim.fn.has("Android") == 0 then
    vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
end

-- Set NeoVim's temporary directory to the system's default
vim.o.directory = vim.fn.getenv('TMPDIR')

vim.cmd("filetype plugin on")
vim.cmd("syntax on")
