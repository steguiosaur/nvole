local opts = { noremap = true }
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---- LINE NAVIGATION
-- line navigation
keymap({ "n", "v" }, "<S-j>", "}", opts)
keymap({ "n", "v" }, "<S-k>", "{", opts)

keymap({ "n", "v" }, "<S-n>", "<C-d>", opts)
keymap({ "n", "v" }, "<S-m>", "<C-u>", opts)

-- insert mode navigation
keymap("i", "<C-h>", "<C-o>h", opts)
keymap("i", "<C-j>", "<C-o>j", opts)
keymap("i", "<C-k>", "<C-o>k", opts)
keymap("i", "<C-l>", "<C-o>l", opts)

---- TEXT CONTROLS
-- word count
keymap("n", "<C-g>", "g<C-g>", opts)

-- move text up and down
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", opts)
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", opts)
keymap("i", "<A-j>", "<ESC><cmd>m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC><cmd>m .-2<CR>==gi", opts)
keymap("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", opts)

keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "replace word" })
keymap("n", "<leader>gs", vim.cmd.Git, { desc = "git status" })

-- indent mode on (while holding <Shift>)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- disable yank on paste
keymap("v", "p", '"_dP', opts)

---- WINDOW CONTROLS
-- vertical and horizontal window
keymap("n", "<leader>v", "<C-w>v", opts)
keymap("n", "<leader>h", "<C-w>s", opts)

-- window navigation
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)

-- window resize
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- window vertical to horizontal (vice versa)
keymap("n", "<C-S-Up>", "<C-w><S-k>", opts)
keymap("n", "<C-S-Down>", "<C-w><S-j>", opts)
keymap("n", "<C-S-Left>", "<C-w><S-h>", opts)
keymap("n", "<C-S-Right>", "<C-w><S-l>", opts)

-- buffer navigation
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap("n", "<S-q>", "<cmd>bw<CR>", opts)

-- Duplicate a line and comment out the first line
vim.keymap.set('n', 'yc', 'yy<cmd>normal gcc<CR>p')

---- ADDITIONAL KEYMAPS
-- fast <ESC>
keymap("i", "jj", "<ESC>", opts)

-- save and quit
keymap("n", "<leader>q", "<cmd>q<CR>", opts)
keymap("n", "<leader>w", "<cmd>w<CR>", opts)

-- remove highlight
keymap("n", "<Esc>", "<cmd>noh<CR>", opts)

-- word count
keymap("v", "<C-g>", "g<C-g>", opts)
