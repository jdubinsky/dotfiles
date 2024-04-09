local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
 		return
end

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "%.rbi$",
    }
  }
}

telescope.load_extension('fzf')

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<c-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
