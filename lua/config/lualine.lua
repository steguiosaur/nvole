require('lsp-progress').setup({
    spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
    client_format = function(client_name, spinner, series_messages)
        return #series_messages > 0
                and (table.concat(
                    series_messages,
                    ", "
                ) .. " " .. spinner .. " " .. "[" .. client_name .. "]" )
            or nil
    end,
    format = function(client_messages, client_name)
        local sign = " LSP" -- nf-fa-gear \uf013
        return #client_messages > 0
                and (" " .. table.concat(client_messages, " " .. sign))
            or sign
    end,

})

-- Lualine
require('lualine').setup{
    options = { theme = 'nightfly' },
    section_separators = { left = '|', right = '|'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                on_click = function () vim.cmd('Trouble document_diagnostics') end
            },
            'filename'
        },
        lualine_c = {},
        lualine_x = {
            {
                require("lsp-progress").progress,
                on_click = function() vim.cmd('LspInfo') end
            },
            'fileformat', 'encoding', 'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
}
