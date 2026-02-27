vim.cmd.colorscheme("default")

vim.opt.fillchars:append({ diff = " " })
vim.opt.diffopt:append({
    'filler',
    'inline:none',
    'algorithm:patience',
    'indent-heuristic',
    'linematch:60',
})

-- vim.o.autcomplete =  true
vim.o.completeopt = 'fuzzy,menuone,noinsert,popup'

if vim.loop.fs_stat(vim.fn.expand("~/arcadia/junk/larynjahor/ya.nvim")) ~= nil then
    vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.fn.expand("~/arcadia/junk/larynjahor/ya.nvim/")
end

vim.o.guifont        = "FantasqueSansM Nerd Font:h20:b"
vim.o.autochdir      = false
vim.o.cmdheight      = 1
vim.o.cursorline     = false
vim.o.number         = true
vim.o.relativenumber = true
vim.o.termguicolors  = true
vim.o.expandtab      = true
vim.o.undofile       = true
vim.o.hidden         = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.shiftwidth     = 4
vim.o.softtabstop    = 4
vim.o.tabstop        = 4
vim.o.smartindent    = true
vim.o.updatetime     = 300
vim.o.signcolumn     = "auto"
vim.o.background     = "dark"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.clipboard      = "unnamedplus,unnamed"
vim.o.colorcolumn    = "80"
vim.o.wildignorecase = true
vim.o.signcolumn     = "yes"
vim.o.foldmethod     = "expr"
vim.o.foldexpr       = "nvim_treesitter#foldexpr()"
vim.o.foldnestmax    = 10
vim.o.foldlevel      = 10000
vim.o.list           = true
vim.o.conceallevel = 2
vim.o.swapfile = false
vim.opt.listchars    = {
    space = "·",
    trail = "·",
    tab   = "  ",
}

require("vim._extui").enable {
    enable = true,
    msg = {
        target = "cmd",
        timeout = 4000,
    },
}

vim.o.cmdheight = 0

vim.opt.cmdheight = 0
vim.api.nvim_create_autocmd({ 'CmdlineEnter', "CmdlineLeave" }, {
    group = vim.api.nvim_create_augroup("cmdline-auto-hide", { clear = true }),
    callback = function(args)
        local target_height = args.event == 'CmdlineEnter' and 1 or 0
        if vim.opt_local.cmdheight:get() ~= target_height then
            vim.opt_local.cmdheight = target_height
            vim.cmd.redrawstatus()
        end
    end,
})

vim.g.mapleader      = " "
vim.g.maplocalleader = ","

if vim.g.vscode then
    return
end


vim.pack.add({
    "https://github.com/farmergreg/vim-lastplace",
    "https://github.com/ryvnf/readline.vim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/terrortylor/nvim-comment",
    "https://github.com/ray-x/go.nvim",
    "https://github.com/rrethy/base16-nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    -- "https://github.com/Olical/conjure",

    "https://github.com/saghen/blink.cmp",
    "https://github.com/rafamadriz/friendly-snippets",

    "https://github.com/shellRaining/hlchunk.nvim",

    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/ray-x/lsp_signature.nvim",

    "https://github.com/stevearc/quicker.nvim",

    "https://github.com/j-hui/fidget.nvim",

    {src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main"},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main"},


    "https://github.com/stevearc/oil.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://gitlab.com/motaz-shokry/gruvbox.nvim",
})

vim.api.nvim_create_user_command("Update", function ()
    vim.pack.update(nil, { force = true })
end, { })


vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
    callback = function()
        vim.highlight.on_yank{higroup="Search", timeout=250}
    end
})

vim.keymap.set("n", "<leader>e",  vim.cmd.Oil)
vim.keymap.set("v", "<M-e>",  ":w !/bin/sh<CR>", {noremap = true})
vim.keymap.set("v", "<M-E>",  "ygv:!/bin/sh<CR>P", {noremap = true})
vim.keymap.set("v", ">",          ">gv")
vim.keymap.set("v", "<",          "<gv")
vim.keymap.set("n", "n",          "nzzzv")
vim.keymap.set("n", "N",          "Nzzzv")
vim.keymap.set("i", ",",          ",<C-g>u")
vim.keymap.set("i", ".",          ".<C-g>u")
vim.keymap.set("n", "L",          ";")
vim.keymap.set("n", "H",          ",")
vim.keymap.set("n", "Y",          "y$")
vim.keymap.set("n", "J",          "mzJ`z")
vim.keymap.set("n", "<leader>q",  vim.cmd.copen)
vim.keymap.set("t", "<esc>",      "<C-\\><C-n>")
vim.keymap.set("n", "<esc>",      vim.cmd.noh)
vim.keymap.set("n", "<C-u>",      "<C-u>zz")
vim.keymap.set("n", "<C-d>",      "<C-d>zz")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "K",          ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J",          ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>gq", function ()
    vim.diagnostic.setqflist({open = true, severity = vim.diagnostic.severity.ERROR})
end, {noremap = true})

vim.keymap.set('n', '<C-j>', function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        local ok, _ = pcall(vim.cmd.cnext)
        if not ok then
            pcall(vim.cmd.cfirst)
        end

        return
    end

    vim.diagnostic.jump({
        count = 1
    })
end, { desc = 'Next quickfix (cycle)', noremap = true })

vim.keymap.set('n', '<C-k>', function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        local ok, _ = pcall(vim.cmd.cprev)
        if not ok then
            pcall(vim.cmd.clast)
        end
    end

    vim.diagnostic.jump({
        count = -1
    })
end, { desc = 'Prev quickfix (cycle)', noremap = true })

vim.keymap.set("n", "<M-j>", function()
    local ok, _ = pcall(vim.cmd.colder)
    if ok then
        return
    end

    while pcall(vim.cmd.cnewer) do end
end)

vim.keymap.set("n", "<M-k>", function()
    local ok, _ = pcall(vim.cmd.cnewer)
    if ok then
        return
    end

    while pcall(vim.cmd.colder) do end
end)


vim.cmd.colorscheme('base16-nord')
-- vim.cmd.colorscheme('gruvbox')

-- vim.cmd.highlight("@comment guibg=#323844 guifg=#535d72 gui=bold")

if not vim.o.autocomplete then
    require("blink.cmp").setup({
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        signature = {
            enabled = true,
            window = {
                border = "single",
            }
        },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind" }
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = "single"

                },
            },
        },
        fuzzy = { implementation = "lua" }
    })
end

do
    require("fzf-lua").setup({
        hls = {
            normal = "Normal",
            border = "Normal",
            title = "Normal",
            title_flags = "Normal",
            backdrop = "Normal",
            preview_normal = "Normal",
            preview_border = "Normal",
            preview_title = "Normal",
            cursor = "Normal",
            cursorline = "Normal",
            cursorlinenr = "Normal",
            search = "Normal",
            scrollborder_e = "Normal",
            scrollborder_f = "Normal",
            scrollfloat_e = "Normal",
            scrollfloat_f = "Normal",
            help_normal = "Normal",
            help_border = "Normal",
            header_bind = "Normal",
            header_text = "Normal",
            path_colnr = "Normal",
            path_linenr = "Normal",
            buf_name = "Normal",
            buf_id = "Normal",
            buf_nr = "Normal",
            buf_linenr = "Normal",
            buf_flag_cur = "Normal",
            buf_flag_alt = "Normal",
            tab_title = "Normal",
            tab_marker = "Normal",
            dir_icon = "Normal",
            dir_part = "Normal",
            file_part = "Normal",
            live_prompt = "Normal",
            live_sym = "Normal",
        },
        fzf_colors = {
            ["fg"] = {"fg", "Normal"},
            ["bg"] = {"bg", "Normal"},
            ["preview-fg"] = {"fg", "Normal"},
            ["preview-bg"] = {"fg", "Normal"},
            ["hl"] = {"bg", "Search"},
            ["hl+"] = {"bg", "Search"},
            ["fg+"] = {"fg", "Normal"},
            ["bg+"] = {"bg", "Visual"},
            ["gutter"] = "-1",
            ["query"] = {"fg", "Normal"},
            ["disabled"] = {"fg", "Normal"},
            ["info"] = {"fg", "Normal"},
            ["border"] = {"fg", "Normal"},
            ["scrollbar"] = {"fg", "Normal"},
            ["preview-border"] = {"fg", "Normal"},
            ["preview-scrollbar"] = {"fg", "Normal"},
            ["separator"] = {"fg", "Normal"},
            ["label"] = {"fg", "Normal"},
            ["preview-label"] = {"fg", "Normal"},
            ["prompt"] = {"fg", "Error"},
            ["pointer"] = {"fg", "Normal"},
            ["marker"] = {"fg", "MoreMsg", "bold"},
            ["spinner"] = {"fg", "Normal"},
            ["header"] = {"fg", "Normal"},
        },
        winopts = {
            border = "single",
            height = 0.9,
            width = 0.9,
            preview = {
                wrap = "nowrap",
                hidden = "hidden",
            },
        },
    })

    vim.keymap.set("n", "<C-p>", function() require("fzf-lua").files({follow = true}) end)
    vim.keymap.set("n", "<M-s>", function()
        require("fzf-lua").live_grep({
            follow = true,
            toggle_ignore_flag = "--fixed-strings",
            no_ignore          = true,
            actions = {
                ["ctrl-r"] = require('fzf-lua').actions.toggle_ignore,
            },
        })
    end)
    vim.keymap.set("n", "<leader>fF", require("fzf-lua").builtin)
    vim.keymap.set("n", "<M-x>", require("fzf-lua").commands)
    vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags)
    vim.keymap.set("n", "<leader>fH", require("fzf-lua").highlights)
    vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers)
    vim.keymap.set("n", "<C-x><C-r>", require("fzf-lua").oldfiles)
    vim.keymap.set("n", "<C-r>", require("fzf-lua").resume)
    vim.keymap.set("n", "gr", require("fzf-lua").lsp_references)
    vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations)

    require("fzf-lua").register_ui_select()
end

do
    require("hlchunk").setup({
        indent = {
            enable = true,
        },
        chunk = {
            enable = true,
            delay = 10,
            chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "┌",
                left_bottom = "└",
                right_arrow = ">",
            },
        },
    })

    vim.api.nvim_set_hl(0, "HLChunk1", { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Search")), "bg", "gui") })
    vim.api.nvim_set_hl(0, "HLChunk2", { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Error")), "fg", "gui") })
end


do
    require("quicker").setup({
        type_icons = {
            E = "",
            W = "",
            I = "",
            N = "",
            H = "",
        },
        follow = {
            enabled = true,
        },
        keys = {
            {
                "<TAB>",
                function()
                    require("quicker").toggle_expand({ before = 2, after = 2, add_to_existing = true})
                end,
                desc = "Expand quickfix context",
            },
        },
    })
end

do
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function(args)
            vim.lsp.buf.format({ async = false, buf = args.buf})
        end,
        group = vim.api.nvim_create_augroup("GoFormat", { clear = true}),
    })

    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
    end)

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lspmaps", { clear = true }),
        callback = function(args)
            local client  = assert(vim.lsp.get_client_by_id(args.data.client_id))

            if client:supports_method('textDocument/completion') and vim.o.autocomplete and false then
                local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end

                client.server_capabilities.completionProvider.triggerCharacters = chars
                vim.lsp.completion.enable(true, args.data.client_id, args.buf, {autotrigger = true})
            end

            vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false, undercurl = true })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = false })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = false })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = false })
            vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = vim.g.terminal_color_3 })
            vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = vim.g.terminal_color_3 })
            vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = vim.g.terminal_color_3 })

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
            vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

            vim.b.formatexpr = vim.lsp.formatexpr()
        end,
    })

    vim.lsp.enable({
        "gopls",
        "lua_ls",
        "clangd",
        -- "ty"
        "basedpyright",
    })
end

do
    local disable_func = function(lang, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end

    require('nvim-treesitter').install({ "go", "lua", "python", "yaml", "vimdoc", "bash", "zig", "sql" })

    vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'go', "markdown", "python", "yaml"},
        callback = function(args)
            if not disable_func(vim.bo.filetype, args.buf) then
                vim.treesitter.start(args.buf)
            end
        end,
    })
end

do
    require("fidget").setup({})
    require("nvim-surround").setup({})
    require('nvim_comment').setup({})
    require("nvim-autopairs").setup({})
    require("arcitive")
end


require("tiny-inline-diagnostic").setup({
    hi = {
        background = "Normal",
    },
    options = {
        show_source = {
            enabled = true,
            if_many = true,
        },
        multilines = {
            enabled = true,
            always_show = true,
        },
    },
})

vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md" },
    callback = function()
        vim.o.conceallevel = 0
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
    pattern = { "*.md" },
    callback = function()
        vim.o.conceallevel=2
    end,
})

do
    local win_opts = {
        border = "single",
    }

    require("oil").setup({
        columns = {
            {"permissions", highlight = "Include"},
            "size",
            {"mtime", format = "%d.%m.%y %H:%M", highlight = "Label"},
        },
        float = win_opts,
        confirmation = win_opts,
        progress = win_opts,
        ssh = win_opts,
        keymaps_help = win_opts,
        view_options = {
            is_hidden_file = function(name)
                if name == ".." then
                    return false
                end

                local m = name:match("^%.")
                return m ~= nil
            end,
        },
        use_default_keymaps = false,
        keymaps = {
            ["<C-r>"] = "actions.refresh",
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
    })
end


---@class TaskOpts
---@field base_cmd string
---@field efm string?
---@field cwd string?
---@field default_args string?
---@field escape_args boolean?

---@param opts TaskOpts
---@return function
local function task(opts)
    return function(params)
        local lines = {}
        local args = params.args ~= "" and params.args or (opts.default_args or "")

        if opts.escape_args ~= nil and opts.escape_args then
            args = "'" .. args .. "'"
        end

        local raw_cmd = opts.base_cmd.." "..args
        local handle = require("fidget").progress.handle.create({
            title = opts.base_cmd,
            message = "Running",
            lsp_client = { name = raw_cmd},
        })


        local push_stderr = function(_, stderr, _)
            if stderr == nil then
                return
            end

            handle:report({
                title = raw_cmd,
                message = table.concat(stderr, "\n")
            })

            vim.list_extend(lines, stderr)
        end


        vim.fn.jobstart(vim.fn.expandcmd(raw_cmd), {
            stdin = "null",
            stdout_buffered = false,
            stderr_buffered = false,
            on_stderr = push_stderr,
            on_stdout = push_stderr,
            on_exit = function(_, exit_code, event)
                -- if exit_code ~= 0 then
                --     return vim.notify(table.concat(stderr, "\n", vim.log.levels.INFO))
                -- end

                handle:finish()

                if opts.efm == nil then
                    return
                end

                local prev_cwd = vim.fn.getcwd()

                if opts.cwd ~= nil then
                    vim.cmd.lcd({ args = { opts.cwd }, mods = { emsg_silent = true, noautocmd = true } })
                end

                local valid_items  = vim.tbl_filter(
                    function(qf_item)
                        return qf_item.valid == 1
                    end,
                    vim.fn.getqflist({
                        lines = lines,
                        efm = opts.efm,
                    }).items
                )

                -- for _, item in ipairs(valid_items) do
                --     item.user_data = {
                    --         error_text = item.text
                    --     }
                    --
                    --     item.type = "error"
                    -- end

                    table.sort(valid_items, function (a, b)
                        if a.bufnr == nil and b.bufnr == nil then
                            return false
                        end

                        if a.bufnr ~= b.bufnr then
                            return a.bufnr > b.bufnr
                        end

                        return a.lnum < b.lnum
                    end)

                    if #valid_items == 0 then
                        vim.cmd.lcd({ args = { prev_cwd }, mods = { emsg_silent = true, noautocmd = true }})

                        return
                    end

                    vim.fn.setqflist({}, " ", {
                        title = raw_cmd,
                        items = valid_items,
                    })

                    vim.cmd.lcd({ args = { prev_cwd }, mods = { emsg_silent = true, noautocmd = true }})

                    vim.cmd.copen()
                end,
            }
        )
    end
end

vim.api.nvim_create_user_command("RG", task({base_cmd = "rg --follow --vimgrep --fixed-strings --smart-case", efm = "%f:%l:%c:%m", escape_args = true}), {
    desc = "RipGrep query",
    nargs = "+",
    bang = true,
})

vim.keymap.set("v", "<M-s>", function()
    vim.cmd.RG(vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), {type = vim.fn.mode()}))
end)

vim.api.nvim_create_user_command("YGen", task({base_cmd = "ya make --replace-result --keep-going -DBUILD_LANGUAGES=GO -DCONSISTENT_DEBUG=yes --prefetch -j32 -DEMIT_NEEDDIR_HINTS=yes --add-result=.go --add-result=.gosrc --no-output-for=.cgo1.go --no-output-for=.res.go --no-output-for=_cgo_gotypes.go --no-output-for=_cgo_import.go -DTRAVERSE_RECURSE_FOR_TESTS=yes", efm = "$S/%f:%l:%c: %m,%f:%l:%c: %m", cwd =  vim.fn.expand("~/arcadia")}), {
    desc = "Run codegen with ya make.",
    nargs = "*",
    bang = true,
})

vim.api.nvim_create_user_command("Yoimports", task({base_cmd = "ya tool yoimports -w", default_args =  "."}), {
    desc = "Run yo imports.",
    nargs = "*",
    bang = true,
})

vim.api.nvim_create_user_command("Yofix", task({base_cmd = "ya tool fix", default_args =  "."}), {
    desc = "Run yo fix.",
    nargs = "*",
    bang = true,
})

vim.api.nvim_create_user_command("YMake", task({stream_stdout = true, base_cmd = "ya make", efm = "%.%#$S/%f:%l:%c:%m,%f:%l:%c:%m", cwd =  vim.fn.expand("~/arcadia")}), {
    desc = "Run ya make.",
    nargs = "*",
    bang = true,
    complete = "file",
})

do
    vim.api.nvim_set_hl(0, "RedBG",       {bg   = vim.g.terminal_color_1, fg = vim.g.terminal_color_0, bold = true})
    vim.api.nvim_set_hl(0, "RedFG",       {bg   = vim.g.terminal_color_8, fg = vim.g.terminal_color_1, bold = true})
    vim.api.nvim_set_hl(0, "GreenBG",     {bg   = vim.g.terminal_color_2, fg = vim.g.terminal_color_0, bold = true})
    vim.api.nvim_set_hl(0, "YellowBG",    {bg   = vim.g.terminal_color_3, fg = vim.g.terminal_color_0, bold = true})
    vim.api.nvim_set_hl(0, "BlueBG",      {bg   = vim.g.terminal_color_4, fg = vim.g.terminal_color_0, bold = true})
    vim.api.nvim_set_hl(0, "MagentaBG",   {bg   = vim.g.terminal_color_5, fg = vim.g.terminal_color_0, bold = true})
    vim.api.nvim_set_hl(0, "CyanBG",      {bg   = vim.g.terminal_color_6, fg = vim.g.terminal_color_0, bold = true})

    function Status_line()
        local mode_map = {
            ['n']  = 'NORMAL',
            ['no'] = 'N·OPERATOR',
            ['v']  = 'VISUAL',
            ['V']  = 'V·LINE',
            ['']   = 'V·BLOCK',
            [''] = 'V·BLOCK',
            ['s']  = 'SELECT',
            ['S']  = 'S·LINE',
            [''] = 'S·BLOCK',
            ['i']  = 'INSERT',
            ['ic'] = 'INSERT',
            ['R']  = 'REPLACE',
            ['Rv'] = 'V·REPLACE',
            ['c']  = 'COMMAND',
            ['cv'] = 'VIM·EX',
            ['ce'] = 'EX',
            ['r']  = 'PROMPT',
            ['rm'] = 'MORE',
            ['r?'] = 'CONFIRM',
            ['!']  = 'SHELL',
            ['t']  = 'TERMINAL',
        }
        local mode = mode_map[vim.api.nvim_get_mode().mode] or '?'

        local statusline = ""

        local pos = " "
        do
            local current_line = vim.fn.line(".")
            local total_lines = vim.fn.line("$")
            local chars =
            { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            pos = chars[index]
        end

        statusline = statusline .. "%#RedBG#"
        statusline = statusline .. " " .. mode .. " "

        statusline = statusline .. "%#YellowBG#"
        statusline = statusline .. " %f "

        statusline = statusline .. "%#default#"

        statusline = statusline .. "%#RedFG#"

        statusline = statusline .. "%="

        statusline = statusline .. "%#GreenBG#"
        statusline = statusline .. " %l:%c "

        statusline = statusline .. "%#RedFG#"
        statusline = statusline .. pos

        statusline = statusline .. "%#BlueBG#"
        statusline = statusline .. " %Y "

        return statusline
    end

    vim.opt.statusline = '%!v:lua.Status_line()'
end


