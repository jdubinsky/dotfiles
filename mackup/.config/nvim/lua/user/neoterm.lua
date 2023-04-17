vim.g.neoterm_default_mod = "botright"
vim.g.neoterm_size = 30

local status_ok, neoterm = pcall(require, "neoterm")
if not status_ok then
  return
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--keymap("n", "<Leader>t", ":Ttoggle<CR>", opts)
-- keymap("n", "<Leader>n", ":Ttoggle<CR>", opts)
