local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shortened function name
local keymap = vim.api.nvim_set_keymap

---------------------------------------- keymaps
-- <Space> as mapleader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Modes
--  normal_mode = "n"
--  insert_mode = "i"
--  visual_mode = "v"
--  visual_block_mode = "x"
--  term_mode = "t"
--  command_mode = "c"

---------------------------------------- normal
-- line navigation on linebreak
keymap("n", "<S-j>", "gj", opts)
keymap("n", "<S-k>", "gk", opts)

-- vertical and horizontal window
keymap("n", "<leader>v", "<C-w>v", opts)
keymap("n", "<leader>h", "<C-w>s", opts)

-- window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)

-- window resize
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- window vertical to horizontal (vice versa)
keymap("n", "<C-S-Up>", "<C-w><S-k>", opts)
keymap("n", "<C-S-Down>", "<C-w><S-j>", opts)
keymap("n", "<C-S-Left>", "<C-w><S-h>", opts)
keymap("n", "<C-S-Right>", "<C-w><S-l>", opts)

-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-q>", ":bdelete<CR>", opts)

-- move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- save and quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)

-- remove highlight
keymap("n", "<Esc><Esc>", ":noh<CR>", opts)


---------------------------------------- insert
-- fast <ESC>
keymap("i", "jj", "<ESC>", opts)

-- move text up and down
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)


---------------------------------------- visual
-- line navigation on visual linebreak
keymap("v", "<S-j>", "gj", opts)
keymap("v", "<S-k>", "gk", opts)

-- indent mode on (while holding <Shift>)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- disable yank on paste
keymap("v", "p", "pgvy", opts)


---------------------------------------- plugin
-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, nowait = true }
    end

    keymap('n', '<CR>', api.node.open.edit, opts('Open'))
    keymap('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    keymap('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    keymap('n', 'r', api.fs.rename, opts('Rename'))
    keymap('n', 'R', api.tree.reload, opts('Refresh'))
    keymap('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    keymap('n', 'S', api.tree.search_node, opts('Search'))

end

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fc", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fs", ":Telescope git_status<CR>", opts)
