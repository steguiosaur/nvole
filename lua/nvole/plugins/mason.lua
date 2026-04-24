return {
    "mason-org/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        require("nvole.core.mason-init").setup()
    end,
}
