local trouble = require("trouble")
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

trouble.setup({})

keymap("n", "<Leader>r", ":TroubleToggle document_diagnostics<CR>", opts)
-- keymap("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, opts)
vim.keymap.set("n", "<leader>q", function() require("trouble").toggle("quickfix") end)
