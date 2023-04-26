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

local function lspinfo()
    vim.cmd('LspInfo')
end

local function trouble()
    vim.cmd('Trouble document_diagnostics')
end

-- Lualine
require('lualine').setup{
    options = { theme = 'nightfly' },
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '|', right = '|'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch', 
            'diff',
            {
                'diagnostics',
                on_click = trouble
            },
            'filename'
        },
        lualine_c = {},
        lualine_x = { 
            {
                require("lsp-progress").progress,
                on_click = lspinfo
            },
            'encoding', 'fileformat', 'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
}
