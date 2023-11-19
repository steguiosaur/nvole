local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local rt_ok, rust_tools = pcall(require, "rust-tools")

if not lspconfig_ok then return end

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	max_concurrent_installers = 10,
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"cmake",
		"cssls",
		"diagnosticls",
		"html",
		"jdtls",
		"jsonls",
		"pyright",
		"tsserver",
		"zls",
		"kotlin_language_server",
		"groovyls",
		"ltex",
	},
	automatic_installation = {
		exclude = {
			"clangd",
			"lua_ls",
			"rust_analyzer",
			"texlab",
			"typst_lsp",
		},
	},
})

local capabilities = require("lsp.lspconfig").capabilities

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		silent = true,
		border = "rounded",
	}),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	}),
}

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc.
end

lspconfig.cssls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("lsp.servers.cssls").on_attach,
	settings = require("lsp.servers.cssls").settings,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("lsp.servers.jsonls").settings,
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("lsp.servers.tsserver").settings,
})

lspconfig.asm_lsp.setup({
    cmd = {"asm-lsp"},
	filetypes = { "s", "S", "asm" },
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})

lspconfig.jdtls.setup({
	filetypes = { "java" },
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("lsp.servers.jdtls").settings,
})

lspconfig.ltex.setup({
	filetypes = { "tex", "md" },
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})

lspconfig.kotlin_language_server.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})

lspconfig.groovyls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
})

for _, server in ipairs({ "bashls", "pyright", "cmake", "html", "diagnosticls" }) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end

-- Requires manual installation for Termux
-- Lua_ls
if vim.fn.executable("lua-language-server") == 1 then
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		handlers = handlers,
		on_attach = on_attach,
		settings = require("lsp.servers.lua_ls").settings,
	})
end

-- LaTeX
if vim.fn.executable("texlab") == 1 then
	lspconfig.texlab.setup({
		cmd = { "texlab" },
		filetypes = { "tex", "plaintex", "bib" },
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end

-- Clangd
if vim.fn.executable("clangd") == 1 then
	lspconfig.clangd.setup({
        cmd = { "clangd", "--compile-commands-dir=build" },
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end

-- Rust
if vim.fn.executable("rust-analyzer") == 1 then
	if rt_ok then
		rust_tools.setup({
			server = {
				on_attach = on_attach,
				capabilities = capabilities,
				handlers = handlers,
			},
		})
	end
end

-- Zig Language Server
if vim.fn.executable("zls") == 1 then
	lspconfig.zls.setup({
		cmd = { "zls" },
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end
