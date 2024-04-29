require("oil").setup()

vim.api.nvim_set_keymap("n", "<leader>o", 'Oil', { silent = true, expr = true })
