return {
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            hint = {
                enable = true,
            },
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = vim.tbl_filter(function(d)
                    return not d:match(vim.fn.stdpath('config') .. '/?a?f?t?e?r?')
                end, vim.api.nvim_get_runtime_file('', true)),
            },
            telemetry = {
                enable = false,
            },
        },
        disable = {
            "unused-local",     -- To disable "unused local `variable`"
            "missing-fields",   -- Example for another common warning
            "missing-parameter", -- Example for another common warning
            "empty-block",
            "trailing-space",
        },
    },
}
