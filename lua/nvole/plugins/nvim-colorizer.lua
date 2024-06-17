return {
    "norcalli/nvim-colorizer.lua", -- color highlighter
    event = 'VeryLazy',
    config = function()
        require('colorizer').setup()
    end,
}
