local lsp_servers = { 
    "clangd", 
    "rust_analyzer", 
    "pyright",
    "gopls"
}

local cmp_backends = {
    "nvim_lsp", 
    "luasnip", 
    "buffer",
    "path",
    "cmdline"
}

local packages = {
    "RRethy/nvim-base16",
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim",
    "nvim-lua/plenary.nvim",
    "TimUntersberger/neogit",
    "kosayoda/nvim-lightbulb",
    "L3MON4D3/LuaSnip",
    "nvim-lualine/lualine.nvim",
    "ryvnf/readline.vim",
    "junegunn/vim-easy-align",
    "rcarriga/nvim-notify",
    "windwp/nvim-autopairs",
    "terrortylor/nvim-comment",
    "kylechui/nvim-surround",
    "ijimiji/tabout.nvim",
    "RishabhRD/nvim-lsputils",
    "RishabhRD/popfix",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "ijimiji/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "rafamadriz/friendly-snippets"
}

vim.g.maplocalleader = ","
vim.g.mapleader      = " "
vim.o.autochdir      = true
vim.o.cursorline     = true
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
vim.o.textwidth      = 80
vim.o.updatetime     = 300
vim.o.signcolumn     = "number"
vim.o.background     = "dark"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.clipboard      = "unnamedplus,unnamed"
vim.o.colorcolumn    = "+1"
vim.o.wildmode       = "full"

local icons = {
    warning       = "◍",
    problem       = "◍",
    info          = "◍",
    hint          = "◍",
    bulb          = "◍",
    Text          = "",
    Method        = "",
    Function      = "",
    Constructor   = "",
    Field         = "",
    Variable      = "",
    Class         = "ﴯ",
    Interface     = "",
    Module        = "",
    Property      = "ﰠ",
    Unit          = "",
    Value         = "",
    Enum          = "",
    Keyword       = "",
    Snippet       = "",
    Color         = "",
    File          = "",
    Reference     = "",
    Folder        = "",
    EnumMember    = "",
    Constant      = "",
    Struct        = "",
    Event         = "",
    Operator      = "",
    TypeParameter = ""
}

do 
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    end
    require("packer").startup(function()
        for _, package in ipairs(packages) do
            use{package}
        end
        if packer_bootstrap then
            require('packer').sync()

        end
    end)
end

require("impatient")

local auto = vim.api.nvim_create_autocmd 
local map = vim.keymap.set
local noremap = {noremap = true}
local fmt = string.format
local colors = {}


function highlight(face)
    local cmd = fmt("highlight! %s", face.name)

    if face.foreground then
        cmd = fmt("%s guifg=%s", cmd, face.foreground)
    end
    if face.background then
        cmd = fmt("%s guibg=%s", cmd, face.background)
    end
    if face.style then
        cmd = fmt("%s gui=%s", cmd, face.style)
    end

    vim.cmd(cmd)
end

function colorscheme(theme, bat)
    vim.cmd("colorscheme " .. theme)
    if bat then
        vim.cmd(fmt("let $BAT_THEME = '%s'", (bat and bar or "ansi")))
    end
    colors["black"]         = vim.g.terminal_color_0
    colors["red"]           = vim.g.terminal_color_1
    colors["green"]         = vim.g.terminal_color_2
    colors["yellow"]        = vim.g.terminal_color_3
    colors["blue"]          = vim.g.terminal_color_4
    colors["magenta"]       = vim.g.terminal_color_5
    colors["cyan"]          = vim.g.terminal_color_6
    colors["white"]         = vim.g.terminal_color_7
    colors["grey"]          = vim.g.terminal_color_8
    colors["light_red"]     = vim.g.terminal_color_9
    colors["light_green"]   = vim.g.terminal_color_10
    colors["light_yellow"]  = vim.g.terminal_color_11
    colors["light_blue"]    = vim.g.terminal_color_12
    colors["light_magenta"] = vim.g.terminal_color_13
    colors["light_cyan"]    = vim.g.terminal_color_14
    colors["light_white"]   = vim.g.terminal_color_15
end

colorscheme("base16-nord")


require("luasnip.loaders.from_vscode").lazy_load()
require('nvim-lightbulb').setup({autocmd = {enabled = true}})
require("nvim-autopairs").setup{}
require("nvim_comment").setup{}
require("nvim-surround").setup{}
require("mason").setup{}
require("mason-lspconfig").setup{
    ensure_installed = lsp_servers
}

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

local on_attach = function()
    map("n", "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap)
    map("n", "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>", noremap)
    map("n", "K",         "<cmd>lua vim.lsp.buf.hover()<CR>", noremap)
    map("n", "gi",        "<cmd>lua vim.lsp.buf.implementation()<CR>", noremap)
    map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", noremap)
    map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", noremap)
    map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", noremap)
    map("n", "<space>D",  "<cmd>lua vim.lsp.buf.type_definition()<CR>", noremap)
    map("n", "<space>r",  "<cmd>lua vim.lsp.buf.rename()<CR>", noremap)
    map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", noremap)
    map("n", "gr",        "<cmd>lua vim.lsp.buf.references()<CR>", noremap)
    map("n", "<space>f",  "<cmd>lua vim.lsp.buf.formatting()<CR>", noremap)
    map("n", "<c-j>", "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'single' }})<CR>", noremap)
    map("n", "<c-k>", "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'single' }})<CR>", noremap)
end

local lspconfig = require('lspconfig')
for _,server in ipairs(lsp_servers) do
    lspconfig[server].setup{
        on_attach = on_attach,
    }
end

do
    local luasnip = require("luasnip")
    local cmp = require'cmp'

    map("c", "<C-n>", cmp.select_next_item, noremap)
    map("c", "<C-p>", cmp.select_prev_item, noremap)


    local sources = {}

    for _, source in ipairs(cmp_backends) do
        table.insert(sources, { name = source })
    end

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered({
                border = "single"
            }),
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
                return vim_item
            end
        },
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),

        }),
        sources = cmp.config.sources(sources)
    })

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
        })
    }) 
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })
end


local nord_theme = {
    inactive = {
        a = { bg = colors.grey, fg = colors.black, gui = "bold" },
        b = { bg = colors.grey, fg = colors.black },
        c = { bg = colors.grey, fg = colors.black },
        x = { bg = colors.grey, fg = colors.red },
        y = { bg = colors.grey, fg = colors.black },
        z = { bg = colors.grey, fg = colors.black },
    },
    visual = {
        a = { bg = colors.blue, fg = colors.black, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.black },
        c = { bg = colors.grey, fg = colors.black },
        x = { bg = colors.grey, fg = colors.red },
        y = { bg = colors.blue, fg = colors.black },
        z = { bg = colors.yellow, fg = colors.black },
    },
    replace = {
        a = { bg = colors.magenta, fg = colors.black, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.black },
        c = { bg = colors.grey, fg = colors.black },
        x = { bg = colors.grey, fg = colors.red },
        y = { bg = colors.blue, fg = colors.black },
        z = { bg = colors.yellow, fg = colors.black },
    },
    normal = {
        a = { bg = colors.red,  fg = colors.black, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.black },
        c = { bg = colors.grey, fg = colors.black },
        x = { bg = colors.grey, fg = colors.red },
        y = { bg = colors.blue, fg = colors.black },
        z = { bg = colors.yellow, fg = colors.black },

    },
    insert = {
        a = { bg = colors.green, fg = colors.black, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.black },
        c = { bg = colors.grey, fg = colors.black },
        x = { bg = colors.grey, fg = colors.red },
        y = { bg = colors.blue, fg = colors.black },
        z = { bg = colors.yellow, fg = colors.black },
    },
    command = {
        a = { bg = colors.white,fg = colors.black, gui = "bold" },
        b = { bg = colors.yellow, fg = colors.black },
        c = { bg = colors.grey, fg = colors.black },
        x = { bg = colors.grey, fg = colors.red },
        y = { bg = colors.blue, fg = colors.black },
        z = { bg = colors.yellow, fg = colors.black },
    },
}


require('lualine').setup {
    options = {
        icons_enabled = icons,
        theme = nord_theme,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
        bg = colors.grey
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {{"branch", "diff", "diagnostics", color = {fg = colors.black, bg = colors.red}}},
        lualine_y = {{"encoding", padding = 1}},
        lualine_z = {{"filesize", padding = 1}},
        lualine_x = {{
            function()
                local current_line = vim.fn.line "."
                local total_lines = vim.fn.line "$"
                local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                local line_ratio = current_line / total_lines
                local index = math.ceil(line_ratio * #chars)
                return chars[index]
            end,
            padding = { left = 0, right = 0 },
        }
    },
},
}

-- mappings
map({"x", "n"}, "ga", "<Plug>(EasyAlign)", {})
map("v", ">", ">gv", noremap)
map("v", "<", "<gv", noremap)
map("n", "n", "nzzzv", noremap)
map("n", "N", "Nzzzv", nnoremap)
map("i", ",", ",<C-g>u", noremap)
map("i", ".", ".<C-g>u", noremap)
map("n", "L", "g$", noremap)
map("n", "H", "^]", noremap)
map("n", "Y", "y$", noremap)
map("t", "<esc>", "<C-\\><C-n>", noremap)
map("n", "<esc>", "<cmd>noh<cr>", {})

-- autocmds
auto("TextYankPost", {
    pattern = "*", 
    callback = function() 
        require'vim.highlight'.on_yank{higroup="Substitute", timeout=250}
    end
})


do
    local attach_to_buffer = function(output_bufnr, pattern, command)
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup("jahor-autorun", {clear = true}),
            pattern = pattern,
            callback = function()
                local append_data = function(_, data)
                    if data then
                        vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                    end
                end

                vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {"output: "})
                vim.fn.jobstart(command, {
                    stdout_buffered = true,
                    on_stdout = append_data,
                    on_stderr = append_data,
                })
            end,
        })
    end

    vim.api.nvim_create_user_command("AutoRun", function()
        vim.cmd("vsplit")
        local prev_win = vim.fn.win_findbuf(vim.fn.bufnr("%"))[1]
        local bufnr = vim.api.nvim_create_buf(true, true)
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, bufnr)

        vim.opt_local.number = false
        vim.opt_local.relativenumber = false

        vim.api.nvim_set_current_win(prev_win)

        local pattern = vim.fn.input("Pattern: ")
        local command = vim.split(vim.fn.input("Command: "), " ")
        attach_to_buffer(tonumber(bufnr), pattern, command)
    end, {})
end


do
    map("n", "<C-`>", "<CMD>ToggleTerm<CR>", nnoremap)
    map("t", "<C-`>", "<CMD>ToggleTerm<CR>", nnoremap)
    vim.api.nvim_create_user_command("ToggleTerm", function()
        local height = 15
        local buffer_id = vim.fn.bufnr("term")
        local window_id = vim.fn.win_findbuf(buffer_id)[1]

        if window_id then
            return vim.api.nvim_win_hide(0)
        else
            vim.cmd("split")
            if (buffer_id == -1) then
                vim.cmd("terminal")
            else
                vim.cmd(("buffer " .. buffer_id))
            end

            vim.cmd(("resize " .. height))

            vim.opt_local.number = false
            vim.opt_local.relativenumber = false

            vim.cmd("startinsert!")
        end
    end, {})
end

do
    local function min(a, b)
        if a > b then
            return b
        end
        return a
    end

    local function max(a, b)
        if a > b then
            return a
        end
        return b
    end

    local function split (inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end

    local function strjoin(delimiter, list)
        local len = #list
        if len == 0 then
            return "" 
        end
        local string = list[1]
        for i = 2, len do 
            string = string .. delimiter .. list[i] 
        end
        return string
    end

    local function get_font_table()
        local font = split(vim.o.guifont, ":")
        font[2] = tonumber(string.sub(font[2], 2, 3))

        return font
    end

    local function font_tbl_to_string(tbl)
        return strjoin(":", tbl)
    end

    local function change_font_size(delta)
        local font = get_font_table() 
        font[2] = "h" .. min(max(font[2] + delta, 5), 60)
        vim.o.guifont = font_tbl_to_string(font)
    end

    local delta = 1

    map({"n", "i", "c", "v", "s"}, "<C-MouseDown>", function()
        change_font_size(delta)
    end, noremap)

    map({"n", "i", "c", "v", "s"}, "<C-MouseUp>", function()
        change_font_size(-delta)
    end, noremap)
end

if vim.fn.exists("g:neovide") ~= 0 then
    vim.o.guifont = "Iosevka Term:h18"
end

do 
    highlight({name = "DiagnosticWarn", foreground = colors.yellow})
    signs = {Error = icons["problem"], Warn = icons["warning"], Hint = icons["hint"], Info = icons["hint"], Bulb = icons["bulb"]}
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    vim.fn.sign_define("LightBulbSign", {text = signs["Bulb"], texthl = "LspDiagnosticsDefaultWarning", linehl = "", numhl = ""})
end
