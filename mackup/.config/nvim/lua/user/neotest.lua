vim.g["test#strategy"] = "toggleterm"
-- vim.g["test#enabled_runners"] = {"ruby#rails"}
vim.g["test#ruby#runner"] = "rails"
-- vim.g["test#javascript#runner"] = "mocha"

local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
 		return
end

neotest.setup({
  adapters = {
    -- require("neotest-jest"),
    -- require("neotest-rspec"),
    -- require("neotest-minitest")({
    --   test_cmd = function()
    --     return vim.tbl_flatten({
    --       "bin/rails",
    --       "test",
    --     })
    --   end
    -- }),
    require("neotest-vim-test")({ allow_file_types = { "ruby" } }),
  },
})

-- require("neotest-minitest")({
--   test_cmd = function()
--     return vim.tbl_flatten({
--       "bin/rails",
--       "test",
--     })
--   end
-- })

local opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
-- keymap("n", "<leader>t", ":TestNearest<CR>", opts)
keymap("n", "<leader>t", "<cmd>lua require('neotest').run.run()<cr>", opts)
keymap("n", "<leader>T", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", opts)
-- keymap("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", opts)
keymap("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", opts)
keymap("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", opts)
-- keymap("n", "<leader>T", ":TestFile<CR>", opts)
-- keymap("n", "<leader>t", require("neotest").run.run(), opts)
-- keymap("n", "<leader>T", neotest.run.run(vim.fn.expand("%")), opts)
-- keymap("n", "<leader>d", neotest.run.run({strategy = "dap"}), opts)
