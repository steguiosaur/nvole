return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",       -- buffer completions
        "hrsh7th/cmp-path",         -- path completions
        "hrsh7th/cmp-nvim-lsp",     -- completion on lsp
        "hrsh7th/cmp-cmdline",      -- cmdline completions
        "saadparwaiz1/cmp_luasnip", -- snippet completions
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local cmp_ok, cmp = pcall(require, "cmp")
        local snip_ok, luasnip = pcall(require, "luasnip")

        if not cmp_ok then
            return
        end
        if not snip_ok then
            return
        end

        luasnip.config.set_config({
            enable_autosnippets = true,
        })

        require("luasnip.loaders.from_snipmate").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snips/" })
        luasnip.filetype_extend("javascript", { "javascriptreact" })
        luasnip.filetype_extend("javascript", { "typescriptreact" })
        luasnip.filetype_extend("javascript", { "html" })
        luasnip.filetype_extend("python", { "django" })
        luasnip.filetype_extend("c", { "cdoc" })
        luasnip.filetype_extend("blade", { "html" })
        luasnip.filetype_extend("php", { "html" })
        luasnip.filetype_extend("php", { "phpdoc" })
        luasnip.filetype_extend("vue", { "html" })

        local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                documentation = cmp.config.window.bordered({
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                }),
                completion = cmp.config.window.bordered({
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                    scrollbar = true,
                }),
            },
            view = {
                docs = {
                    auto_open = true,
                },
            },
            experimental = {
                ghost_text = false,
                native_menu = false,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        luasnip = "[Snip]",
                        nvim_lsp = "[LSP]",
                        path = "[Path]",
                        buffer = "[Buff]",
                        nvim_lua = "[NvLua]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = {
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lua" },
            },
        })
    end,
}
