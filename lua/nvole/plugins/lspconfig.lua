return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        "p00f/clangd_extensions.nvim",
        "mfussenegger/nvim-jdtls",
        "simrat39/rust-tools.nvim",
    },
    config = function()
    end,
}
