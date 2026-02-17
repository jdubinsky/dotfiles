-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.number = true
vim.opt.termguicolors = true

-- Tab settings
vim.opt.tabstop = 4        -- Display tabs as 4 spaces
vim.opt.shiftwidth = 4     -- Indent with 4 spaces
vim.opt.expandtab = true   -- Convert tabs to spaces (disable for Go)
vim.opt.softtabstop = 4    -- Tab key inserts 4 spaces

-- Go-specific settings (use real tabs, but display as 4 spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false  -- Go uses real tabs
  end,
})
