-- Default configurations
require("core.options")
require("core.keymaps")
require("core.lazy") -- plugin manager
require("core.colorscheme")


-- Plugin Settings
require("config.treesitter")
require("config.gitsigns")
require("config.indentline")
require("config.autopairs")
require("config.colorizer")

require("config.lualine")
require("config.bufferline")
require("config.alpha")

require("config.telescope")
require("config.nvimtree")


-- Completion and Lsp Settings
require("lsp.handlers").setup()
require("lsp.cmp")
require("lsp.mason")
require("lsp.null-ls")

require("lsp.settings")
