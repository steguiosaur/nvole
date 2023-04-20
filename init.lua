-- Default configurations
require("core.options")
require("core.lazy") -- plugin manager
require("core.colorscheme")

-- Plugin Settings
require("config")
require("core.keymaps")

-- Completion and Lsp Settings
require("lsp.cmp")
require("lsp.handlers").setup()
require("lsp.mason")
require("lsp.null-ls")

require("lsp.settings")
