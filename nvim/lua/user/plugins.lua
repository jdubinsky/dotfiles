-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  -- Snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      picker = { enabled = true },
      scope = { enabled = true },
      terminal = {
        enabled = true,
        win = {
          style = "terminal",
          position = "float",
          border = "rounded",
          height = 0.9,
          width = 0.9,
        },
      },
    },
  },

  -- Theme
  "Mofiqul/dracula.nvim",
  "nvim-tree/nvim-web-devicons",

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "go" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",      -- Lua
        "gopls",       -- Go
        "ts_ls",       -- TypeScript/JavaScript
        "rust_analyzer", -- Rust
        "pyright",     -- Python
        "yamlls",      -- YAML
      },
      automatic_installation = true,
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Using new Neovim 0.11+ native API
      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- Configure other LSPs with new API
      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        root_markers = { 'go.mod', '.git' },
      })
      vim.lsp.enable('gopls')

      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        root_markers = { 'package.json', 'tsconfig.json', '.git' },
      })
      vim.lsp.enable('ts_ls')

      vim.lsp.config('rust_analyzer', {
        cmd = { 'rust-analyzer' },
        root_markers = { 'Cargo.toml', '.git' },
      })
      vim.lsp.enable('rust_analyzer')

      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        root_markers = { 'pyproject.toml', 'setup.py', '.git' },
      })
      vim.lsp.enable('pyright')

      vim.lsp.config('yamlls', {
        cmd = { 'yaml-language-server', '--stdio' },
        root_markers = { '.git' },
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = "action.{yml,yaml}",
            },
          },
        },
      })
      vim.lsp.enable('yamlls')
    end,
  },

  -- Completion
  {
    'saghen/blink.cmp',
    version = 'v0.*',  -- Use pre-built binaries
    opts = {
      keymap = { preset = 'default' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
      fuzzy = {
        prebuilt_binaries = {
          download = true,  -- Allow downloading pre-built binaries from GitHub
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    },
  },

  -- Go support
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(_, opts)
      require("go").setup(opts)

      -- Auto-format with goimports on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()',
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v23.10.0/bin/node",
        suggestion = {
          auto_trigger = true,
          keymap = { accept = "<C-j>" },
        },
      })
    end,
  },

  -- Mini.nvim (for features snacks doesn't have)
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require('mini.ai').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.bufremove').setup()
      require('mini.sessions').setup({ directory = '~/.sessions', file = '' })
      require('mini.statusline').setup()
      require('mini.trailspace').setup()
    end,
  },

  -- ClaudeCode.nvim
  {
    "coder/claudecode.nvim",
    commit = "93f8e48", -- Pin to version before terminal focus issue
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "devx claude --resume",
      terminal = {
        enabled = true,
        win = {
          position = "float",
          border = "rounded",
        },
      },
    },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    },
  },
})
