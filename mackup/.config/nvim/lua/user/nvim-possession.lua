require("nvim-possession").setup({
  autosave = false,
  autoswitch = {
    enable = true,
  }
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>sl", "<cmd>lua require('nvim-possession').list()<CR>", opts)
keymap("n", "<leader>sn", "<cmd>lua require('nvim-possession').new()<CR>", opts)
keymap("n", "<leader>su", "<cmd>lua require('nvim-possession').update()<CR>", opts)
keymap("n", "<leader>sd", "<cmd>lua require('nvim-possession').delete()<CR>", opts)
