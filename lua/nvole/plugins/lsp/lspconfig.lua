return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvim-tree/nvim-tree.lua",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"p00f/clangd_extensions.nvim",
		"mfussenegger/nvim-jdtls",
		"simrat39/rust-tools.nvim",
	},
	config = function()
		local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_ok then
			return
		end
		local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if not cmp_ok then
			return
		end

		local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				active = signs,
			},
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "single",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- vim.fn.execute("au CursorHold * lua vim.diagnostic.open_float(0, { scope = 'cursor' })", true)

		-- LSP HANDLERS
		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = "single" })
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
		vim.lsp.handlers["textDocument/publishDiagnostics"] =
			vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true })

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem = {
			documentationFormat = { "markdown", "plaintext" },
			snippetSupport = true,
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			},
		}
		capabilities.offsetEncoding = { "utf-8" }
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

		local opts = { noremap = true, silent = true }
		local keymap = vim.keymap.set

		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- NVIM LSP KEYMAPS
			keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
			keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
			keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
			keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
			keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
			keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			keymap("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
			keymap("n", "gb", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
			keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
		end

		for _, server in ipairs({
			"diagnosticls",
			"asm_lsp",
			"bashls",
			"cmake",
			"html",
			"groovyls",
			"kotlin_language_server",
			"eslint",
			"tailwindcss",
		}) do
			lspconfig[server].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		lspconfig.ltex.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				ltex = {
					language = "en-GB",
					enabled = { "latex" },
				},
			},
		})

		lspconfig.phpactor.setup({
			cmd = { "phpactor", "language-server", "-vv" },
			filetypes = { "php", "blade" },
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = function(_)
				return vim.loop.cwd()
			end,
			init_options = {
				["language_server_phpstan.enabled"] = false,
				["language_server_psalm.enabled"] = false,
				["language_server_completion.trim_leading_dollar"] = true,
				["language_server_worse_reflection.inlay_hints.enable"] = true,
				["language_server_worse_reflection.inlay_hints.params"] = true,
				["language_server_worse_reflection.inlay_hints.types"] = true,
				["language_server_configuration.auto_config"] = true,
				["code_transform.import_globals"] = true,
			},
		})

		lspconfig.volar.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		if vim.fn.executable("clangd") == 1 then
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--background-index",
					"--compile-commands-dir=build",
					"--clang-tidy",
					"--cross-file-rename",
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--header-insertion-decorators",
					"--header-insertion=iwyu",
					"--pch-storage=memory",
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		local rt_ok, rust_tools = pcall(require, "rust-tools")
		if vim.fn.executable("rust-analyzer") == 1 then
			if rt_ok then
				rust_tools.setup({
					server = {
						on_attach = on_attach,
						capabilities = capabilities,
					},
				})
			end
		end

		if vim.fn.executable("zls") == 1 then
			lspconfig.zls.setup({
				cmd = { "zls" },
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end

		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = require("nvole.plugins.lsp.servers.pyright").settings,
		})

		if vim.fn.executable("lua-language-server") == 1 then
			lspconfig.lua_ls.setup({
				ft = { "lua" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = require("nvole.plugins.lsp.servers.lua_ls").settings,
			})
		end

		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
				client.server_capabilities.documentRangeFormattingProvider = true
			end,
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
				scss = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		lspconfig.tsserver.setup({
			ft = { "ts" },
			capabilities = capabilities,
			on_attach = on_attach,
			settings = require("nvole.plugins.lsp.servers.tsserver").settings,
		})

		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = require("nvole.plugins.lsp.servers.jsonls").settings,
		})

		if vim.fn.executable("texlab") == 1 then
			lspconfig.texlab.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
	end,
}
