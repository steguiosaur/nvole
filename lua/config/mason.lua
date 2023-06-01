local add_server = {
    "clangd",
    "lua_ls",
    "zls",
    "rust_analyzer",
    "texlab"
}

local default = {
    "bashls",
    "cmake",
    "cssls",
    "diagnosticls",
    "html",
    "jsonls",
    "pyright",
    "tsserver"
}

local servers = vim.fn.has("Android") == 1 and default or vim.tbl_extend("force", default, add_server)

require("config.servers")

require("mason").setup{
	ui = {
		icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
		},
	},
	max_concurrent_installers = 10,
}
require("mason-lspconfig").setup({
	ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

local opts = {}

for _, server in pairs(servers) do

	opts = {
		on_attach = require("config.lspconfig").on_attach,
		capabilities = require("config.lspconfig").capabilities,
	}

	server = vim.split(server, "@")[1]

	lspconfig[server].setup(opts)
end
