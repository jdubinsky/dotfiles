vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', '<space>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
  end,
})

vim.keymap.set("n", "<space>e", function()
  vim.diagnostic.open_float(nil, { focusable = true })
end)

vim.lsp.enable('gopls')
vim.lsp.enable('golangci_lint_ls')

vim.lsp.enable('ts_ls')

vim.lsp.enable('graphql')

function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

local local_srb_exists = file_exists("./bin/srb")
local sorbet_cmd = {}

if local_srb_exists then
  sorbet_cmd = { "./bin/srb", "tc", "--lsp" }
else
  sorbet_cmd = { "srb", "tc", "--lsp" }
end

vim.lsp.enable('sorbet')
vim.lsp.config('sorbet', {
  filetypes = { 'ruby', 'eruby' },
  -- cmd = { "srb", "tc", "--lsp", "--ignore=ruby/" },
  -- cmd = { "direnv", "exec", ".", "./bin/srb", "tc", "--lsp" },
  -- cmd = { "direnv", "exec", ".", "bin/srb", "tc", "--lsp" },
  -- cmd = { "shadowenv", "exec", "--", "bin/srb", "tc", "--lsp" },
  -- cmd = { "direnv", "exec", ".", "srb", "tc", "--ignore=ruby/", "--lsp" },
  -- cmd = { "shadowenv", "exec", "--", "bundle", "exec", "srb", "tc", "--lsp" },
  -- cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
  -- cmd = { "nix-shell", "--run", "srb tc --lsp" },
  -- root_dir = function(fname)
  --   return vim.fs.dirname(vim.fs.find({'shell.nix', 'default.nix', '.git'}, { upward = true })[1])
  -- end,
  mason = false,
})

vim.lsp.enable('ruby_lsp')
-- vim.lsp.config('ruby_lsp', {
  -- mason = false,
  -- cmd = { "shadowenv", "exec", "--", "ruby-lsp" },
  -- cmd = { "direnv", "exec", ".", "ruby-lsp" },
-- })


vim.lsp.enable('eslint')
-- vim.lsp.config('eslint', {
--   cmd = { 'vscode-eslint-language-server', '--stdio' },
--   filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'json' },
--   root_dir = function(fname)
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     eslint = {
--       enable = true,
--       packageManager = 'npm',
--       useESLintClass = true,
--       nodePath = '/opt/homebrew/lib/node_modules',
--       options = {
--         resolvePluginsRelativeTo = '/opt/homebrew/lib/node_modules',
--       }
--     }
--   }
-- })

vim.opt.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false
})
