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
require("lazy").setup{

    -- UI Display
    "sam4llis/nvim-tundra", -- colorscheme
    "norcalli/nvim-colorizer.lua", -- color highlighter
    {"nvim-lualine/lualine.nvim", -- statusline
        dependencies = {
            "linrongbin16/lsp-progress.nvim",
            "nvim-tree/nvim-web-devicons",
        }
    },
    {"akinsho/bufferline.nvim", version = "v3.*", dependencies = "nvim-tree/nvim-web-devicons"},
    {"goolord/alpha-nvim", -- start screen
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "BlakeJC94/alpha-nvim-fortune"
        }
    },

    -- Defaults
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

    -- File Management
    {"nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons"},
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
    {"akinsho/toggleterm.nvim", version = "*", config = true},


    -- LSP
    "neovim/nvim-lspconfig", -- LSP enable
    "williamboman/mason.nvim", -- LSP, dap, debugger installer
    "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
    "jose-elias-alvarez/null-ls.nvim", -- LSP diagnostics and code actions

    -- Completion plugins
    {"hrsh7th/nvim-cmp", -- The completion plugin
        dependencies = {
            "hrsh7th/cmp-buffer", -- buffer completions
            "hrsh7th/cmp-path", -- path completions
            "hrsh7th/cmp-nvim-lsp", -- completion on lsp
            "hrsh7th/cmp-cmdline", -- cmdline completions

            "saadparwaiz1/cmp_luasnip", -- snippet completions
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
        },
    },

    -- Language Server
    {"simrat39/rust-tools.nvim", dependencies = "nvim-lspconfig", ft = "rust"}, -- Rust
    "lervag/vimtex", -- LaTeX
    {"iamcco/markdown-preview.nvim", build = "cd app && npm install"},
    {"ellisonleao/glow.nvim", cmd = "Glow"},

    -- Debugger
    "mfussenegger/nvim-dap",

}
