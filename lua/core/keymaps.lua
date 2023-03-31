local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shortened function name
local keymap = vim.api.nvim_set_keymap

---------------------------------------- keymaps -----------------------------------------
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

---------------------------------------- normal ------------------------------------------
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

-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader><S-q>", ":bdelete<CR>", opts)

-- move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- save and quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)

-- remove highlight
keymap("n", "<Esc><Esc>", ":noh<CR>", opts)

-- File Tree NETRW
keymap("n", "<leader>e", ":Lex 25<CR>", opts)


---------------------------------------- insert ------------------------------------------
-- fast <ESC>
keymap("i", "jj", "<ESC>", opts)

-- move text up and down
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)


---------------------------------------- visual ------------------------------------------
-- indent mode on (while holding <Shift>)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- disable yank on paste
keymap("v", "p", '"_dP', opts)

