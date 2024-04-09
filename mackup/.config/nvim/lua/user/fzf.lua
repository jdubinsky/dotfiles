local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

require'fzf-lua'.setup {
  -- ignore all '.lua' and '.vim' files
  file_ignore_patterns = { "%.rbi$" }
}


keymap("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<CR>", opts)
keymap("n", "<LocalLeader>g", "<cmd>lua require('fzf-lua').live_grep({ cmd = 'git grep --line-number --column --color=always' })<CR>", opts)
