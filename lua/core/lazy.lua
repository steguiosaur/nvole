-- automatically installs lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


---------- PLUGINS
-- Install plugins here
require("lazy").setup({

    -- UI Display
    "sam4llis/nvim-tundra", -- colorscheme
    "norcalli/nvim-colorizer.lua", -- color highlighter
    "nvim-tree/nvim-web-devicons", -- adds file glyphs
    "nvim-lualine/lualine.nvim", -- statusline
    {"arkav/lualine-lsp-progress", dependencies = "nvim-lualine/lualine.nvim"},
    {"akinsho/bufferline.nvim", version = "v3.*", dependencies = "nvim-tree/nvim-web-devicons"},
    {"goolord/alpha-nvim", dependencies = "nvim-tree/nvim-web-devicons"}, -- start screen

    -- Defaults
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

    -- File Management
    "nvim-tree/nvim-tree.lua",
    {"nvim-telescope/telescope.nvim", tag = "0.1.1", dependencies = "nvim-lua/plenary.nvim"},

    -- Syntax
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "lukas-reineke/indent-blankline.nvim",
    "windwp/nvim-autopairs", -- autopair brackets and parenthesis

    -- Git
    "tpope/vim-fugitive", -- git commands on nvim
    "lewis6991/gitsigns.nvim", -- git diff on the side

    -- Functionalities
    {"folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons"},
    "numToStr/Comment.nvim", -- fast code comment
    {'akinsho/toggleterm.nvim', version = "*", config = true},


    -- LSP
    "neovim/nvim-lspconfig", -- LSP enable
    "williamboman/mason.nvim", -- LSP, dap, debugger installer
    "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
    "jose-elias-alvarez/null-ls.nvim", -- LSP diagnostics and code actions

    -- Completion plugins
    "hrsh7th/nvim-cmp", -- The completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "hrsh7th/cmp-nvim-lsp", -- completion on lsp

    -- Snippet
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",

    -- Language Server
    "simrat39/rust-tools.nvim", -- Rust
    "lervag/vimtex", -- LaTeX

    -- Debugger
    "mfussenegger/nvim-dap",

})