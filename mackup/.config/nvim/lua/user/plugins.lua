local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-tree/nvim-web-devicons",
  "Mofiqul/dracula.nvim",
  -- {
  --   'nvim-telescope/telescope.nvim',
  --     tag = '0.1.6',
  --     dependencies = { 'nvim-lua/plenary.nvim' }
  -- },
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  { "akinsho/toggleterm.nvim", version = "*" },
  "folke/trouble.nvim",
  "nvim-treesitter/nvim-treesitter",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  {'kevinhwang91/nvim-bqf', ft = 'qf'},
  { "ibhagwan/fzf-lua", branch = "main" },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- "natecraddock/telescope-zf-native.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "vim-test/vim-test",
  "numToStr/Comment.nvim",
  "nvim-lualine/lualine.nvim",
  "ojroques/nvim-osc52",
  "andymass/vim-matchup",
  "github/copilot.vim",
})
