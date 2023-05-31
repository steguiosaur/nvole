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

require("config.comment")
require("config.trouble")
require("config.toggleterm")

require("config.preview")
require("config.glow")

-- Completion and Lsp Settings
require("config.lspconfig").setup()
require("config.cmp")
require("config.mason")
require("config.null-ls")

require("snippets.all")
