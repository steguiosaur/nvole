local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shortened function name
local keymap = vim.keymap.set

---------- KEYMAPS
-- <Space> as mapleader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--  normal_mode = "n"
--  insert_mode = "i"
--  visual_mode = "v"
--  visual_block_mode = "x"
--  term_mode = "t"
--  command_mode = "c"

---------- NORMAL MODE
-- line navigation on linebreak
keymap("n", "<S-j>", "}", opts)
keymap("n", "<S-k>", "{", opts)

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
keymap("n", "<S-q>", ":bw<CR>", opts)

-- move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- save and quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)

-- remove highlight
keymap("n", "<Esc><Esc>", ":noh<CR>", opts)

-- word count
keymap("n", "<C-g>", "g<C-g>", opts)

keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
keymap("n", "<leader>gs", vim.cmd.Git)

---------- INSERT MODE
-- fast <ESC>
keymap("i", "jj", "<ESC>", opts)

-- insert mode navigation
keymap('i', '<C-h>', '<C-o>h', opts)
keymap('i', '<C-j>', '<C-o>j', opts)
keymap('i', '<C-k>', '<C-o>k', opts)
keymap('i', '<C-l>', '<C-o>l', opts)

-- move text up and down
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)


---------- VISUAL MODE
-- line navigation on visual linebreak
keymap("v", "<S-j>", "}", opts)
keymap("v", "<S-k>", "{", opts)

-- indent mode on (while holding <Shift>)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- disable yank on paste
keymap("v", "p", '"_dP', opts)

-- word count
keymap("v", "<C-g>", "g<C-g>", opts)


---------- PLUGIN MAPPINGS
-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fc", ":Telescope git_commits<CR>", opts)
keymap("n", "<leader>fs", ":Telescope git_status<CR>", opts)

-- MarkdownPreview
keymap("n", "<leader>lm", ":MarkdownPreview<CR>", opts)
keymap("n", "<leader>ls", ":MarkdownPreviewStop<CR>", opts)
keymap("n", "<leader>lt", ":MarkdownPreviewToggle<CR>", opts)
keymap("n", "<leader>lg", ":Glow<CR>", opts)

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)

-- ToggleTerm
keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)

keymap('t', '<esc>', [[<C-\><C-n>]], term_opts)
keymap('t', 'jk', [[<C-\><C-n>]], term_opts)
keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)
keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], term_opts)
