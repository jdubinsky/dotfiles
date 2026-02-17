vim.g["test#strategy"] = "toggleterm"
vim.g["test#ruby#runner"] = "rails"
vim.g["test#ruby#minitest#executable"] = "bin/rails"

local opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>t", ":TestNearest<CR>", opts)
keymap("n", "<leader>T", ":TestFile<CR>", opts)
