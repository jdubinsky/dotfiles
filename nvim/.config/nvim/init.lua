-- Minimal config for testing claudecode.nvim
-- To restore your full config: mv init.lua.backup init.lua

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.number = true
vim.opt.termguicolors = true

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

  -- ClaudeCode.nvim
  {
    "coder/claudecode.nvim",
    commit = "93f8e48", -- Pin to version before terminal focus issue
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "devx claude --continue",
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

-- Show message
vim.api.nvim_echo({
  { "Minimal config loaded!\n", "Title" },
  { "Press <Space>ac to test ClaudeCode\n", "Normal" },
  { "To restore full config: mv init.lua.backup init.lua and restart", "Comment" },
}, true, {})
