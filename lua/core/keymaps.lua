local opts = { noremap = true, silent = true }
local silent = { silent = true }
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


---- LINE NAVIGATION
-- line navigation on linebreak
keymap("n", "<S-j>", "}", opts)
keymap("n", "<S-k>", "{", opts)
keymap("v", "<S-j>", "}", opts)
keymap("v", "<S-k>", "{", opts)


-- insert mode navigation
keymap('i', '<C-h>', '<C-o>h', opts)
keymap('i', '<C-j>', '<C-o>j', opts)
keymap('i', '<C-k>', '<C-o>k', opts)
keymap('i', '<C-l>', '<C-o>l', opts)


---- TEXT CONTROLS
-- word count
keymap("n", "<C-g>", "g<C-g>", opts)

-- move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("i", "<A-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<ESC>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
keymap("n", "<leader>gs", vim.cmd.Git)

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


---- ADDITIONAL KEYMAPS
-- fast <ESC>
keymap("i", "jj", "<ESC>", opts)

-- save and quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)

-- remove highlight
keymap("n", "<Esc><Esc>", ":noh<CR>", opts)

-- word count
keymap("v", "<C-g>", "g<C-g>", opts)

-- Inkscape
-- vim.cmd([[
-- inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
-- nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
-- ]])

---- PLUGIN MAPPINGS
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

keymap('t', '<esc>', [[<C-\><C-n>]], silent)
keymap('t', 'jk', [[<C-\><C-n>]], silent)
keymap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], silent)
keymap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], silent)
keymap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], silent)
keymap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], silent)
keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], silent)

-- LSP
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
keymap("n", "gb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
