vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("n", "L", "g$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>q", vim.cmd.copen)
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<esc>", vim.cmd.noh)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
