local set = vim.opt

set.expandtab = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.termguicolors = true
set.number = true
-- set.noswapfile = true
set.ignorecase = true
set.background = "dark"
set.completeopt = "menu,menuone,noselect"
-- set.colorcolumn = 120
set.swapfile = false
set.cindent = true

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
