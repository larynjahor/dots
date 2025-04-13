local yolist_enabled = false

local analyses_settings = {
    undeclaredname = false,
    stubmethods = false,
    appends = false,
    asmdecl = false,
    assign = false,
    atomic = false,
    atomicalign = false,
    bools = false,
    buildtag = false,
    cgocall = false,
    composites = false,
    copylocks = false,
    deepequalerrors = false,
    defer = false,
    defers = false,
    deprecated = false,
    directive = false,
    embed = false,
    errorsas = false,
    fillreturns = false,
    framepointer = false,
    hostport = false,
    httpresponse = false,
    ifaceassert = false,
    infertypeargs = false,
    loopclosure = false,
    lostcancel = false,
    modernize = false,
    nilfunc = false,
    nilness = false,
    nonewvars = false,
    noresultvalues = false,
    printf = false,
    shadow = false,
    shift = false,
    sigchanyzer = false,
    simplifycompositelit = false,
    simplifyrange = false,
    simplifyslice = false,
    slog = false,
    sortslice = false,
    stdmethods = false,
    stdversion = false,
    stringintconv = false,
    structtag = false,
    testinggoroutine = false,
    tests = false,
    timeformat = false,
    unmarshal = false,
    unreachable = false,
    unsafeptr = false,
    unusedfunc = false,
    unusedparams = false,
    unusedresult = false,
    unusedvariable = false,
    unusedwrite = false, 
    waitgroup = false,
    yield = false,
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "ray-x/lsp_signature.nvim",
    },
    config = function()
        local autocmd = vim.api.nvim_create_autocmd
        local au      = vim.api.nvim_create_augroup


        local border = {
            { '┌', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '┐', 'FloatBorder' },
            { '│', 'FloatBorder' },
            { '┘', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '└', 'FloatBorder' },
            { '│', 'FloatBorder' },
        }

        -- Add the border on hover and on signature help popup window
        local handlers = {
            ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
            ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        }

        autocmd("LspAttach", {
            group = au("lspmaps", { clear = true }),
            callback = function(args)
                vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false, undercurl = true })
                vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = false })
                vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = false })
                vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = false })
                vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = vim.g.terminal_color_3 })
                vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = vim.g.terminal_color_3 })
                vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = vim.g.terminal_color_3 })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition)
                vim.keymap.set("n", "K", vim.lsp.buf.hover)
                vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
                vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
                vim.b.formatexpr = vim.lsp.formatexpr()
                vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
                vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)
                vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
            end,
        })

        local lspconfig = require("lspconfig")

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimport()
            end,
            group = vim.api.nvim_create_augroup("GoFormat", { clear = true}),
        })

        local gopls_config = {
            -- cmd = {"/Users/larynjahor/gits/tools/gopls/gopls", "serve", "--debug=localhost:6060"},
            handlers = handlers,
            settings = {
                gopls = {
                    staticcheck = true,
                    verboseWorkDoneProgress = true,
                    analysisProgressReporting = true,
                    analyses = analyses_settings,
                    env = {
                        CGO_ENABLED = "0",
                        FOO = "1",
                        GOPRIVATE = "*.yandex-team.ru,*.yandexcloud.net",
                    },
                },
            }
        }

        if string.match(vim.fn.getcwd(), "/arcadia") then
            local targets = {
                -- "yy/backend",
                -- "thefeed/backend",
                "neuroexpert/backend",
                "neuro",
                "browser/backend/extra/summary-bot",
                -- "portal/avocado/morda-go",
                "library/go/yandex/oauth",
                "junk/larynjahor",
                "alice/library/go/setrace",
            }

            if yolist_enabled then
                gopls_config.settings.gopls.env["GOPACKAGESDRIVER"] = "/Users/larynjahor/gits/stable/spd/spd"
                gopls_config.settings.gopls.env["SPDTARGETS"] = table.concat(targets, ",")

                gopls_config.settings.gopls.directoryFilters = {
                    "-"
                }

                for _, target in ipairs(targets) do
                    table.insert(gopls_config.settings.gopls.directoryFilters, "+"..target)
                end
            end

            if not yolist_enabled then
                gopls_config.cmd = {os.getenv("HOME").."/.ya/tools/v4/gopls-darwin-arm64/gopls", "serve", "--debug=localhost:6060" }
            end

            gopls_config.settings.gopls.env["GOFLAGS"] = "-mod=vendor"
        end

        lspconfig.gopls.setup(gopls_config)
        lspconfig.lua_ls.setup({})
        lspconfig.basedpyright.setup({
          root_dir = lspconfig.util.root_pattern("pyrightconfig.json"),
        })
    end
}
