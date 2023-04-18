vim.g["test#strategy"] = "toggleterm"
vim.g["test#enabled_runners"] = {"ruby#rails"}
vim.g["test#ruby#runner"] = "rails"
-- let test#strategy = 'neoterm'
-- let test#enabled_runners = ["ruby#rails"]
-- let test#ruby#runner = 'rails'

local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
 		return
end

neotest.setup({
  adapters = {
    require("neotest-jest"),
    require("neotest-vim-test")({ allow_file_types = { "ruby" } }),
  },
})

local opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>t", ":TestNearest<CR>", opts)
--keymap("n", "<leader>t", "<cmd>lua require('neotest').run.run()<cr>", opts)
--keymap("n", "<leader>T", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", opts)
keymap("n", "<leader>T", ":TestFile<CR>", opts)
-- keymap("n", "<leader>t", require("neotest").run.run(), opts)
-- keymap("n", "<leader>T", neotest.run.run(vim.fn.expand("%")), opts)
-- keymap("n", "<leader>d", neotest.run.run({strategy = "dap"}), opts)
