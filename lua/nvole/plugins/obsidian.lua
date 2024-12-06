return {
    "epwalsh/obsidian.nvim",
    enabled = false,
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/Obsidian/Obsidian-vault/",
            },
        },
        ui = { enable = false },
        follow_url_func = function(url)
            vim.fn.jobstart({ "xdg-open", url })
        end,
    },
}
