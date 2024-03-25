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
  { "akinsho/toggleterm.nvim", version = "*" },
  "folke/trouble.nvim",
  "nvim-treesitter/nvim-treesitter",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/nvim-cmp",
  "junegunn/fzf",
  { "ibhagwan/fzf-lua", branch = "main" },
  "antoinemadec/FixCursorHold.nvim",
  "vim-test/vim-test",
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     -- "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     -- "nvim-treesitter/nvim-treesitter",
  --     "vim-test/vim-test",
  --     "nvim-neotest/neotest-vim-test",
  --     -- "zidhuss/neotest-minitest",
  --     -- "haydenmeade/neotest-jest",
  --     -- "olimorris/neotest-rspec",
  --   }
  -- },
  "numToStr/Comment.nvim",
  "nvim-lualine/lualine.nvim",
  "ojroques/nvim-osc52",
  "andymass/vim-matchup",
  "github/copilot.vim",
})
