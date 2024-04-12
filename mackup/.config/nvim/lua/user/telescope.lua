local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
 		return
end

telescope.setup {
  -- extensions = {
  --   fzf = {
  --     override_generic_sorter = true,
  --     override_file_sorter = false,
  --     case_mode = "smart_case",
  --   },
  --   ["zf-native"] = {
  --     file = {
  --       enable = true,
  --       highlight_results = true,
  --       match_filename = true,
  --       initial_sort = nil,
  --     },
  --     generic = {
  --       enable = false,
  --       highlight_results = true,
  --       match_filename = false,
  --       initial_sort = nil,
  --     },
  --   }
  -- },
  defaults = {
    file_ignore_patterns = {
      "%.rbi$",
    }
  }
}

-- telescope.load_extension('fzf')
telescope.load_extension('zf-native')
-- telescope.load_extension('fzy_native')

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>p", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<c-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
keymap("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
