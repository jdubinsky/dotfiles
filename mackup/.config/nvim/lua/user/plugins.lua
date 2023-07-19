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
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  { "akinsho/toggleterm.nvim", version = "*" },
  "folke/trouble.nvim",
  "nvim-treesitter/nvim-treesitter",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  "junegunn/fzf",
  { "ibhagwan/fzf-lua", branch = "main" },
  "antoinemadec/FixCursorHold.nvim",
  "nvim-neotest/neotest",
  "haydenmeade/neotest-jest",
  "nvim-neotest/neotest-vim-test",
  "vim-test/vim-test",
  "numToStr/Comment.nvim",
  "nvim-lualine/lualine.nvim",
  "ojroques/nvim-osc52",
  "andymass/vim-matchup",
})
