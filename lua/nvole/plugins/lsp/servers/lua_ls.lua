local M = {}

M.settings = {
    Lua = {
        runtime = {
            version = "LuaJIT",
        },
        diagnostics = {
            globals = { "vim" },
        },
        telemetry = {
            enable = false,
        },
    },
}

return M
