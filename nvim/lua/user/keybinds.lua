-- Terminal: Ctrl+o to enter normal mode
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Enter normal mode', silent = true })

-- Window/split navigation with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate left', silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate down', silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate up', silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate right', silent = true })

-- Same navigation from terminal mode (automatically enters normal mode first)
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Navigate left', silent = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Navigate down', silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Navigate up', silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Navigate right', silent = true })

-- File explorer
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open Oil file explorer' })

-- Terminal
vim.keymap.set('n', '<leader>n', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })

-- Fuzzy finder
vim.keymap.set('n', '<C-p>', function()
  require('fzf-lua').files()
end, { desc = 'Fuzzy find files' })
vim.keymap.set('n', '<leader>g', function()
  require('fzf-lua').live_grep({ rg_opts = '--column --line-number --no-heading --color=always -i' })
end, { desc = 'Live grep files' })

-- Copy to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })

-- LSP keybindings
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic info' })

-- Clear search highlighting with Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlighting' })

-- Test keybindings
vim.keymap.set('n', '<leader>t', function() require('user.test').TestCurrentLine() end, { desc = 'Run test at cursor' })
vim.keymap.set('n', '<leader>T', function() require('user.test').TestCurrentFile() end, { desc = 'Run all tests in file' })
