-- Minimal config for testing claudecode.nvim
-- To restore your full config: mv init.lua.backup init.lua

-- Set leader key
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

-- Ctrl+o to enter normal mode from terminal
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
      -- Inline shell command to create project-based session ID
      terminal_cmd = "devx claude --resume",
      -- terminal_cmd = [[bash -c 'unset CLAUDECODE; HASH=$(echo -n "$PWD" | shasum -a 256 | cut -c1-32); SESSION_ID=$(echo "$HASH" | sed -E "s/(.{8})(.{4})(.{4})(.{4})(.{12})/\1-\2-\3-\4-\5/"); exec devx claude --session-id "$SESSION_ID" --permission-mode acceptEdits']],
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

-- Set colorscheme
vim.cmd.colorscheme("dracula")

-- Additional keybindings
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open Oil file explorer' })
vim.keymap.set('n', '<leader>n', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })
vim.keymap.set('n', '<C-p>', function()
  require('fzf-lua').files()
end, { desc = 'Fuzzy find files' })

-- Copy to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })

-- LSP keybindings
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- Clear search highlighting with Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlighting' })

-- Test functions using treesitter
function get_nearest_function_name()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Convert to 0-indexed

  -- Get the parser for the buffer (auto-detect language)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    return nil
  end

  -- Parse and get the tree
  local trees = parser:parse()
  if not trees or #trees == 0 then
    return nil
  end

  local tree = trees[1]
  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  if not node then
    return nil
  end

  while node do
    local node_type = node:type()

    if node_type == "function_declaration" or node_type == "method_declaration" then
      local name_node = node:field("name")[1]
      if name_node then
        local func_name = vim.treesitter.get_node_text(name_node, bufnr)
        return func_name
      end
    end
    node = node:parent()
  end

  return nil
end

function TestCurrentLine()
  local filetype = vim.bo.filetype
  local file_path = vim.fn.expand('%:p')
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local cmd

  if filetype == "go" then
    local func_name = get_nearest_function_name()
    if func_name then
      local pkg_path = "./" .. vim.fn.expand('%:.:h')
      cmd = ("go test -v -run %s %s"):format(func_name, pkg_path)
    else
      vim.notify("No test function found at cursor", vim.log.levels.WARN)
      return
    end
  elseif filetype == "ruby" then
    cmd = ("dev test %s:%d"):format(file_path, line_num)
  else
    vim.notify("No test command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Execute command in toggleterm (opens if not open)
  require("toggleterm").exec(cmd)
end

function TestCurrentFile()
  local file_path = vim.fn.expand('%:p')
  local filetype = vim.bo.filetype
  local cmd

  if filetype == "ruby" then
    cmd = ("dev test %s"):format(file_path)
  elseif filetype == "go" then
    cmd = ("go test -v ./%s"):format(vim.fn.expand('%:.:h'))
  else
    vim.notify("No test command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Execute command in toggleterm (opens if not open)
  require("toggleterm").exec(cmd)
end

function DebugCurrentTest()
  local filetype = vim.bo.filetype
  local cmd

  if filetype == "go" then
    local func_name = get_nearest_function_name()
    if func_name then
      local pkg_path = "./" .. vim.fn.expand('%:.:h')
      cmd = ("dlv test %s -- -test.run %s"):format(pkg_path, func_name)
    else
      vim.notify("No test function found at cursor", vim.log.levels.WARN)
      return
    end
  else
    vim.notify("Debug command only configured for Go files", vim.log.levels.WARN)
    return
  end

  -- Execute command in toggleterm (opens if not open)
  require("toggleterm").exec(cmd)
end

-- Test keybindings
vim.keymap.set('n', '<leader>t', TestCurrentLine, { desc = 'Run test at cursor' })
vim.keymap.set('n', '<leader>T', TestCurrentFile, { desc = 'Run all tests in file' })
