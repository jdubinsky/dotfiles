local status_ok, osc = pcall(require, "osc52")
if not status_ok then
 		return
end

osc.setup({})
vim.keymap.set('n', '<leader>c', osc.copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', osc.copy_visual)
