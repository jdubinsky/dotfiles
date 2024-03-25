vim.g["test#strategy"] = "toggleterm"
vim.g["test#ruby#runner"] = "rails"

-- local status_ok, neotest = pcall(require, "vim-test")
-- if not status_ok then
--  		return
-- end

local opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>t", ":TestNearest<CR>", opts)
keymap("n", "<leader>T", ":TestFile<CR>", opts)
