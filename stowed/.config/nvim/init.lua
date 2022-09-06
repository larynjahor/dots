local execute = vim.api.nvim_command
local fn = vim.fn
local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format
function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end
ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")
require("impatient")

require("packer").startup(function()
    use "nvim-treesitter/nvim-treesitter"
    use "lukas-reineke/indent-blankline.nvim"
    use "ray-x/go.nvim"
    use "RRethy/nvim-base16"
    use "lervag/vimtex"
    use "farmergreg/vim-lastplace"
    use "nvim-telescope/telescope-ui-select.nvim"
    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use "nvim-lua/plenary.nvim"
    use "TimUntersberger/neogit"
    use "kosayoda/nvim-lightbulb"
    use "L3MON4D3/LuaSnip"
    use "jose-elias-alvarez/null-ls.nvim"
    use "nvim-lualine/lualine.nvim"
    use "ryvnf/readline.vim"
    use "junegunn/vim-easy-align"
    use "rcarriga/nvim-notify"
    use "windwp/nvim-autopairs"
    use "terrortylor/nvim-comment"
    use "kylechui/nvim-surround"
    use "ijimiji/tabout.nvim"
    use "RishabhRD/nvim-lsputils"
    use "RishabhRD/popfix"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "ijimiji/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "rafamadriz/friendly-snippets"
    use "nvim-telescope/telescope.nvim"
    use "ijimiji/std.lua"
end)

vim.g.maplocalleader = ","
vim.g.mapleader      = " "
vim.o.autochdir      = false
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
vim.o.tabstop        = 4
vim.o.smartindent    = true
vim.o.textwidth      = 80
vim.o.updatetime     = 300
vim.o.signcolumn     = "number"
vim.o.background     = "dark"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.clipboard      = "unnamedplus,unnamed"
vim.o.colorcolumn    = "+1"
vim.o.wildmode       = "lastused:longest"
vim.o.wildignorecase = true

local std     = require("std")
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local cmd     = vim.api.nvim_create_user_command
local hl      = vim.api.nvim_set_hl
local map     = vim.keymap.set
local noremap = { noremap = true }
local fmt     = string.format
local lsp_servers = { 
    "clangd", 
    "rust_analyzer", 
    "pyright",
    "texlab",
    "gopls",
}

function shade_color(color, delta)
    local hex = string.sub(color, 2, 7)
    return fmt("#%06x", std.max(std.min(tonumber("0x" .. hex) + delta, 0xffffff), 0x000000))
end

local colors = {}

local mt = {
    __index = function(table, key)
        local colors = {
            ["black"]         = vim.g.terminal_color_0,
            ["red"]           = vim.g.terminal_color_1,
            ["green"]         = vim.g.terminal_color_2,
            ["yellow"]        = vim.g.terminal_color_3,
            ["blue"]          = vim.g.terminal_color_4,
            ["magenta"]       = vim.g.terminal_color_5,
            ["cyan"]          = vim.g.terminal_color_6,
            ["white"]         = vim.g.terminal_color_7,
            ["grey"]          = vim.g.terminal_color_8,
            ["light_red"]     = vim.g.terminal_color_9,
            ["light_green"]   = vim.g.terminal_color_10,
            ["light_yellow"]  = vim.g.terminal_color_11,
            ["light_blue"]    = vim.g.terminal_color_12,
            ["light_magenta"] = vim.g.terminal_color_13,
            ["light_cyan"]    = vim.g.terminal_color_14,
            ["light_white"]   = vim.g.terminal_color_15,
        }
        return colors[key]
    end
}

setmetatable(colors, mt)

vim.cmd "color base16-nord"

local ls = require("luasnip")
function load_snippets(filetype) 
    local snippets = require("snippets."..filetype)

    if snippets.auto ~= nil then
        ls.add_snippets(filetype, snippets["auto"], { 
            type = "autosnippets", 
            key = "all_auto", 
        })
        ls.add_snippets(filetype, snippets["normal"])
    else 
        ls.add_snippets(filetype, snippets)
    end
end

ls.config.setup {
    history = true,
    enable_autosnippets = true,
}

require('go').setup()
require("luasnip.loaders.from_vscode").lazy_load({exclude = {"tex"}})
require('nvim-lightbulb').setup({autocmd = {enabled = true}})
require("nvim-autopairs").setup{}
require("nvim_comment").setup{}
require("nvim-surround").setup{}
require("mason").setup{}
require("mason-lspconfig").setup{
    ensure_installed = lsp_servers
}
require("null-ls").setup({
    sources = {},
})
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "go" },
    auto_install = true,
    highlight = {
        enable = true,
    },
}

hl(0, "DiagnosticWarn", {fg = colors.yellow})
local lsp_icons = {
    warning       = "◍",
    problem       = "◍",
    info          = "◍",
    hint          = "◍",
    bulb          = "◍"
}
local signs = {
    Error = lsp_icons["problem"], 
    Warn = lsp_icons["warning"], 
    Hint = lsp_icons["hint"], 
    Info = lsp_icons["hint"], 
    Bulb = lsp_icons["bulb"]
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.fn.sign_define("LightBulbSign", {text = signs["Bulb"], texthl = "LspDiagnosticsDefaultWarning", linehl = "", numhl = ""})

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
local on_attach = function()
    map("n", "gD",            vim.lsp.buf.declaration,             noremap)
    map("n", "gd",            vim.lsp.buf.definition,              noremap)
    map("n", "<C-LeftMouse>", vim.lsp.buf.definition,              noremap)
    map("n", "K",             vim.lsp.buf.hover,                   noremap)
    map("n", "gi",            vim.lsp.buf.implementation,          noremap)
    map("n", "<space>wa",     vim.lsp.buf.add_workspace_folder,    noremap)
    map("n", "<space>wr",     vim.lsp.buf.remove_workspace_folder, noremap)
    map("n", "<space>D",      vim.lsp.buf.type_definition,         noremap)
    map("n", "<space>r",      vim.lsp.buf.rename,                  noremap)
    map("n", "<space>ca",     vim.lsp.buf.code_action,             noremap)
    map("n", "<space>wl", "lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", noremap)
    map("n", "<c-j>", "<CMD>lua vim.diagnostic.goto_next({ float = { border = 'single' }})<CR>", noremap)
    map("n", "<c-k>", "<CMD>lua vim.diagnostic.goto_prev({ float = { border = 'single' }})<CR>", noremap)
end
local lspconfig = require('lspconfig')
for _,server in ipairs(lsp_servers) do
    lspconfig[server].setup{
        on_attach = on_attach,
    }
end

local icons = {
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

local luasnip = require("luasnip")
local cmp = require'cmp'

map("c", "<C-n>", cmp.select_next_item, noremap)
map("c", "<C-p>", cmp.select_prev_item, noremap)

map("c", "<Tab>", cmp.select_next_item, {})
map("c", "<S-Tab>", cmp.select_prev_item, {})

local sources = {
    { name = "nvim_lsp" }, 
    { name = "luasnip" }, 
    { name = "buffer" },
    { name = "path" },
    { name = "cmdline" }
}

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
        lualine_x = {
            {
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

require("telescope").load_extension("ui-select")

local no_preview = function()
    return require('telescope.themes').get_dropdown({
        borderchars = {
            { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
            prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        },
        width = 0.8,
        previewer = false,
        prompt_title = false
    })
end
local preview = function()
    return require('telescope.themes').get_dropdown({
        borderchars = {
            { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
            prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        },
        prompt_title = false
    })
end

require('telescope').setup{
    extensions = {
        ["ui-select"] = {
            no_preview()
        }
    }
}

local delta = 0x050505

hl(0, "TelescopeNormal", {
    bg = shade_color(colors.black, -delta),
    fg = colors.white
})

hl(0, "TelescopeBorder", {
    bg = shade_color(colors.black, -delta),
    fg = colors.white -- shade_color(colors.black, -delta),
})

hl(0, "TelescopePromptNormal", {
    bg = shade_color(colors.black, -delta),
    fg = colors.blue
})

hl(0, "TelescopeMatching", {
    fg = colors.yellow
})

hl(0, "TelescopePromptBorder", {
    bg = shade_color(colors.black, -delta),
    fg = colors.white -- shade_color(colors.black, -delta),
})

hl(0, "TelescopePromptPrefix", {
    bg = nil,
    fg = colors.red
})

map("n", "gr",               function () require'telescope.builtin'.lsp_references(no_preview()) end, noremap)
map("n", "<leader>f",        function () require'telescope.builtin'.find_files(no_preview()) end, noremap)
map("n", "<leader>s",        function () require'telescope.builtin'.live_grep(preview())   end, noremap)
map("n", "<leader>b",        function () require'telescope.builtin'.buffers(no_preview())    end, noremap)
map("n", "<leader>ha",       function () require'telescope.builtin'.help_tags(no_preview())  end, noremap)
map("n", "<leader>hh",       function () require'telescope.builtin'.highlights(no_preview()) end, noremap)
map("n", "<leader>Q",        function () require'telescope.builtin'.diagnostics(preview())   end, noremap)
map("n", "<leader><leader>", function () require'telescope.builtin'.commands(no_preview())   end, noremap)

map({"x", "n"}, "ga", "<Plug>(EasyAlign)", {})
map("v", ">", ">gv", noremap)
map("v", "<", "<gv", noremap)
map("n", "n", "nzzzv", noremap)
map("n", "N", "Nzzzv", noremap)
map("i", ",", ",<C-g>u", noremap)
map("i", ".", ".<C-g>u", noremap)
map("n", "L", "g$", noremap)
map("n", "H", "^]", noremap)
map("n", "Y", "y$", noremap)
map("n", "<C-j>", "<cmd>cnext<cr>", noremap)
map("n", "<C-k>", "<cmd>cprev<cr>", noremap)
map("n", "<leader>q", "<cmd>copen<cr>", noremap)
map("t", "<esc>", "<C-\\><C-n>", noremap)
map("n", "<esc>", "<cmd>noh<cr>", {})
map("n", "<leader>g", "<cmd>Neogit<cr>", noremap)

autocmd("BufWritePre", {
    pattern = "*.go", 
    group = augroup("go", {clear = true}),
    callback = function() 
        require("go.format").goimport()  -- goimport + gofmt
    end
})

autocmd("TextYankPost", {
    pattern = "*", 
    group = augroup("highlight-on-yank", {clear = true}),
    callback = function() 
        require'vim.highlight'.on_yank{higroup="Substitute", timeout=250}
    end
})

local attach_to_buffer = function(output_bufnr, pattern, command)
    autocmd("BufWritePost", {
        group = augroup("jahor-autorun", {clear = true}),
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

cmd("AutoRun", function()
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

map("n", "<C-`>", "<CMD>ToggleTerm<CR>", nnoremap)
map("t", "<C-`>", "<CMD>ToggleTerm<CR>", nnoremap)
cmd("ToggleTerm", function()
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
        vim.opt_local.cursorline = false

        vim.cmd("startinsert!")
    end
end, {})

cmd("Update", function()
    vim.cmd [[source %]]
    require('packer').sync()
end, {})

if vim.fn.exists("g:neovide") ~= 0 then
    vim.o.guifont = "Iosevka Term:h18"
    local function get_font_table()
        local font = std.strsplit(vim.o.guifont, ":")
        font[2] = tonumber(string.sub(font[2], 2, 3))

        return font
    end

    local function font_tbl_to_string(tbl)
        return std.strjoin(tbl, ":")
    end
    local function change_font_size(delta)
        local font = get_font_table() 
        font[2] = "h" .. std.min(std.max(font[2] + delta, 5), 60)
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

require("snippets")

autocmd("BufWinEnter", {
    pattern = "*.tex", 
    group = augroup("tex-local-settings", {clear = true}),
    callback = function() 
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "ru"
        map({"i"}, "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", noremap)
        hl(0, "SpellBad", {fg = colors.red, underline = true})
    end
})
