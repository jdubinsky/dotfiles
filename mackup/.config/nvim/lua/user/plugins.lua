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
  "andymass/vim-matchup",
  "github/copilot.vim",
  -- {
  --   "https://git.sr.ht/~swaits/zellij-nav.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   keys = {
  --     { "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left"  } },
  --     { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
  --     { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
  --     { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
  --   },
  --   opts = {},
  -- },
    {
      "gennaro-tedesco/nvim-possession",
      dependencies = {
          "ibhagwan/fzf-lua",
      },
      config = true,
      init = function()
          local possession = require("nvim-possession")
          vim.keymap.set("n", "<leader>sl", function()
              possession.list()
          end)
          vim.keymap.set("n", "<leader>sn", function()
              possession.new()
          end)
          vim.keymap.set("n", "<leader>su", function()
              possession.update()
          end)
          vim.keymap.set("n", "<leader>sd", function()
              possession.delete()
          end)
      end,
  },
  -- {
  -- 'rmagatti/auto-session',
  --   lazy = false,
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  --     -- log_level = 'debug',
  --   }
  -- }
})
