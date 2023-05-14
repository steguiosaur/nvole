local o = vim.o -- set options

---------- OPTIONS
-- numberline
o.number = true         -- show numberline
o.relativenumber = true -- relative numberline

-- tab options
o.expandtab = true -- enables space for tabs
o.tabstop = 4      -- number of spaces in a tab
o.softtabstop = 4  -- number of spaces per <Tab> and <Backspace>

o.autoindent = false -- copy indent from previous line
o.shiftwidth = 4 -- space for indentation

-- word search/highlighting
o.hlsearch = true   -- highlight searched words
o.incsearch = true  -- show search current matched patterns
o.ignorecase = true -- case insensitive search
o.smartcase = true  -- override "ignorecase" when upper case is in pattern

o.cursorline = true -- highlight current cursor line
o.showmatch = true  -- show matching parenthesis and brackets

-- text display formatting
o.wrap = true               -- wrap lines extending the window
o.breakindent = true        -- linebreak follows indentation
o.breakat = " ^!@*-+;:,./?" -- linebreakable characters
o.linebreak = true          -- break long lines in "breakat"

o.conceallevel = 0          -- reveal syntax on Markdown files
o.fileencoding = "utf-8"    -- file encoding in buffer
o.textwidth = 0             -- no string limitation
o.shortmess = 'c'           -- shorten message prompts

-- navigation
o.scrolloff = 5 -- lines above and below cursor
o.mouse = 'a'   -- mouse support

-- statusline and commandline
o.laststatus = 2            -- last window statusline enable
o.showmode = false          -- show current mode
o.showtabline = 1           -- shows tabline
o.signcolumn = "yes"        -- shows signcolumn

o.modeline = true           -- file specific options on comments
o.clipboard = "unnamedplus" -- connect to system clipboard
o.confirm = true            -- confirm on exit

-- commandline completion
o.wildmenu = true           -- command completion on <Tab>
o.wildmode = "longest,full" -- event on <Tab>
o.wildignore = "*.o, *.docx, *.pdf, *.jpg, *.png, *.gif, *.img"

-- etc
o.termguicolors = true -- enable 24-bit RGB color in the TUI
o.hidden = true        -- hide current unsaved edited file on :e instead of exiting
o.title = true         -- show filename and directory on titlestring
o.undofile = true      -- persistent undo
o.pumheight = 10
o.swapfile = false     -- swapfiles for recovery
o.updatetime = 250


---------- GLOBAL & AUTOCMD
if vim.fn.has("Android") == 1 then
    vim.g.python3_host_prog = '$PREFIX/bin/python'
    vim.g.python_host_prog = '$PREFIX/bin/python2'
else
    vim.g.python3_host_prog = '/usr/bin/python'
    vim.g.python_host_prog = '/usr/bin/python2'
    -- vertical help buffer
    vim.cmd("autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif")
end
