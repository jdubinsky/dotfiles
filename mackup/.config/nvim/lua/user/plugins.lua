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

local ruby_version = vim.fn.executable "ruby" == 1 and vim.fn.system('ruby -e "puts RUBY_VERSION"'):gsub("\n", "")
  or nil

require("lazy").setup({
  "nvim-tree/nvim-web-devicons",
  "Mofiqul/dracula.nvim",
  { 
    "neovim/nvim-lspconfig",
  },
  "nvim-treesitter/nvim-treesitter",
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  { "Shopify/shadowenv.vim" },
  -- {
  --   "mason-org/mason-lspconfig.nvim",
  --   opts = {},
  --   dependencies = {
  --       { "mason-org/mason.nvim", opts = {} },
  --       "neovim/nvim-lspconfig",
  --   },
  -- },
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
      },
    },
    opts_extend = { "sources.default" }
  },
  {'kevinhwang91/nvim-bqf', ft = 'qf'},
  "antoinemadec/FixCursorHold.nvim",
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = { accept = "<C-j>" },
        },
      })
    end
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  { 'echasnovski/mini.nvim', version = false },
})

require('mini.ai').setup()
-- require('mini.completion').setup()
require('mini.comment').setup()
require('mini.pairs').setup()
require('mini.bufremove').setup()
require('mini.clue').setup()
local pick = require('mini.pick')
pick.setup()
local extras = require('mini.extra')
extras.setup()
require('mini.sessions').setup({
  directory = '~/.sessions',
  file = '',
})
require('mini.visits').setup()
local minident = require('mini.indentscope')
minident.setup({
  draw = {
    animation = minident.gen_animation.none(),
  }
})
require('mini.statusline').setup()
require('mini.trailspace').setup()
require('mini.colors').setup()
local files = require('mini.files')
files.setup()

local starter = require('mini.starter')
starter.setup({
  items = {
    starter.sections.sessions(5, true),
    starter.sections.recent_files(5, false, false),
  }
})

vim.ui.select = MiniPick.ui_select

pick.registry.git_files_ignore = function(opts)
  return pick.builtin.files(vim.tbl_deep_extend('force', {
    command = { 'git', 'ls-files', '--exclude-standard', '--cached', '--others', '--', ':!*.js', ':!*.rbi', ':!*.html' },
    cwd = vim.fn.getcwd(),
  }, opts or {}))
end

-- vim.keymap.set('n', '<C-p>', function()
--   pick.registry.git_files_ignore()
--   -- pick.builtin.files({ tool = 'git' })
-- end, { desc = 'Search Git files' })

pick.registry.git_grep = function(opts)
  return pick.builtin.grep_live(vim.tbl_deep_extend('force', {
    command = { 'git', 'grep', '--line-number', '--column', '--color=never', '--', ':!*.js', ':!*.rbi' }
  }, opts or {}))
end

-- vim.keymap.set('n', '<leader>ff', '<cmd>lua MiniFiles.open()<cr>', {desc = 'Open mini.files'})
--
vim.keymap.set('n', '<leader>ff', function()
  require("mini.files").open(vim.uv.cwd(), true)
end, {desc = 'Open mini.files (cwd)'})

-- vim.keymap.set('n', '<leader>g', function()
--   pick.registry.git_grep()
-- end, { desc = 'Search Git files' })

vim.keymap.set('n', '<leader>ws', function()
  local session_name = vim.fn.input('Session Name: ') -- Prompt for session name
  if session_name ~= '' then
    require('mini.sessions').write(session_name, { force = true })
    print('Session saved as: ' .. session_name)
  else
    print('Session creation canceled.')
  end
end, { desc = 'Write a new session' })
