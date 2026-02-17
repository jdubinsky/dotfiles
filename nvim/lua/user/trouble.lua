local trouble = require("trouble")
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

trouble.setup({})

keymap("n", "<Leader>r", "<cmd>Trouble diagnostics toggle<cr>", opts)
