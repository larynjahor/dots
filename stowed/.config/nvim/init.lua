local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader      = " "
vim.g.maplocalleader = ","

require("lazy").setup({
    spec = {
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        { dir = "~/gits/arc.nvim", opts = {}},
        require("plugins.cmp"),
        require("plugins.fzf"),
        require("plugins.lsp"),
        require("plugins.qf"),
        require("plugins.hl"),
        require("plugins.ts"),
        {"rrethy/base16-nvim", config = function() 
            vim.cmd[[colorscheme base16-nord]] 
        end},
        {"windwp/nvim-autopairs"},
        {"kylechui/nvim-surround"},
        {"terrortylor/nvim-comment"},
        {"ray-x/go.nvim"},
        {"abecodes/tabout.nvim"},
        {"j-hui/fidget.nvim", opts = {
            progress = {
                display = {
                    done_icon = ":)",
                    done_style = "WarningMsg",
                },
            },
            notification = {
                view = {
                    group_separator_hl = "DiagnosticWarn"
                },
                window = {
                    normal_hl = "DiagnosticWarn"
                }
            },
        }},

        {"farmergreg/vim-lastplace"},
        {"ryvnf/readline.vim"},
        {"nvim-lua/plenary.nvim"},
    }
})

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
-- vim.o.textwidth      = 80
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
vim.opt.listchars    = {
    space = "·",
    trail = "·",
    tab   = "  ",
}

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
    callback = function()
        require'vim.highlight'.on_yank{higroup="Search", timeout=250}
    end
})

vim.keymap.set("n", "<leader>e",  vim.cmd.Explore)
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

-- vim.cmd [[highlight @comment guibg=#323844 guifg=#535d72 gui=bold,italic]]

require("custom.status")
require("custom.arc")
