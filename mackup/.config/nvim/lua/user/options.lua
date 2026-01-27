local set = vim.opt

-- set ruby host dynamically
if vim.env.RUBY_ROOT then
  vim.g.ruby_host_prog = vim.env.RUBY_ROOT
end

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
-- set.list = true
-- set.listchars = { trail = '·', nbsp = '␣' }

-- vim.g.root_spec = { "lsp", "zone.nix", { ".git", "lua" }, "cwd" }
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }
