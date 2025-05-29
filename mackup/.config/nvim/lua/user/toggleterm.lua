local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
 		return
end

toggleterm.setup({
	open_mapping = [[<leader>n]],
	direction = "horizontal",
  autochdir = true,
	size = 20,
  shade_terminals = false,
  insert_mappings = false,
  terminal_mappings = false,
})

function TestCurrentLine()
  local file_path = vim.fn.expand('%:p')
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local cmd = ("dev test %s:%d"):format(file_path, line_num)

  -- Get the terminal with id 1 (change if you use a different id)
  local term_id = 1
  local term = require("toggleterm.terminal").get(term_id)
  if not term then
    -- Open terminal if not already open
    require("toggleterm").exec("", term_id, 12, "horizontal")
    term = require("toggleterm.terminal").get(term_id)
  end

  -- Send the command to the terminal
  term:send(cmd, true)
end

function TestCurrentFile()
  local file_path = vim.fn.expand('%:p')
  local cmd = ("dev test %s"):format(file_path)

  -- Get the terminal with id 1 (change if you use a different id)
  local term_id = 1
  local term = require("toggleterm.terminal").get(term_id)
  if not term then
    -- Open terminal if not already open
    require("toggleterm").exec("", term_id, 12, "horizontal")
    term = require("toggleterm.terminal").get(term_id)
  end

  -- Send the command to the terminal
  term:send(cmd, true)
end

vim.keymap.set('n', '<leader>t', TestCurrentLine)
vim.keymap.set('n', '<leader>T', TestCurrentFile)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-o>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
