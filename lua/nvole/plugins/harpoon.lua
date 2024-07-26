return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>aa", function() harpoon:list():add() end, { desc = "harpoon add file" })
        vim.keymap.set("n", "<leader>af", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "harpoon view files" })
        vim.keymap.set("n", "<leader>ap", function() harpoon:list():prev() end, { desc = "harpoon prev file" })
        vim.keymap.set("n", "<leader>an", function() harpoon:list():next() end, { desc = "harpoon next file" })

        vim.keymap.set("n", "<C-a>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-d>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-f>", function() harpoon:list():select(4) end)
    end,
}
