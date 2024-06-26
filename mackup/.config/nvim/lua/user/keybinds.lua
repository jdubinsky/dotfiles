local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- leader key
keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- escape
keymap("n", "<esc>", ":noh<CR><esc>", opts)

-- navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-o>", "<C-\\><C-n>", opts)

-- copy + paste
keymap("n", "<Leader>y", '"*y', opts)
keymap("n", "<Leader>p", '"*p', opts)
keymap("n", "<Leader>Y", '"+y', opts)
keymap("n", "<Leader>P", '"+p', opts)
keymap("v", "<Leader>y", '"*y', opts)
keymap("v", "<Leader>p", '"*p', opts)
keymap("v", "<Leader>Y", '"+y', opts)
keymap("v", "<Leader>P", '"+p', opts)

-- quickfix
-- keymap("n", "<leader>q", ":copen<CR>", opts)
-- keymap("n", "<leader>Q", ":cclose<CR>", opts)
