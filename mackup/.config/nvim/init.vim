call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'scrooloose/nerdcommenter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
Plug 'folke/trouble.nvim'
Plug 'andymass/vim-matchup'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" {{{ lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

filetype plugin indent on

set autoindent
set smartindent
set expandtab
set shiftwidth=2

syntax enable

set number
set noswapfile
set ignorecase
set termguicolors
set background=dark
set completeopt=menu,menuone,noselect
set colorcolumn=120

colorscheme dracula
" colorscheme OceanicNext

" Custom key mappings
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <esc> :noh<CR><esc>

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

function! s:find_git_root()
   return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'dir':s:find_git_root(),'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <LocalLeader>p :Ag<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" neoterm
let g:neoterm_default_mod = 'botright'
let g:neoterm_size = 30
noremap <Leader>tt :Ttoggle<CR>
noremap <Leader>n :Ttoggle<CR>
tnoremap <C-o> <C-\><C-n>

" quickfix
nnoremap <silent> <leader>gs mA:GscopeFind s <C-R><C-W><cr>
nnoremap <leader>b :cclose<CR>`A

" trouble
nnoremap <LocalLeader>r :TroubleToggle document_diagnostics<CR>

" nerd commenter
let g:NERDSpaceDelims = 1

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>).' -- ":!*.rbi" ":!*test*" ":!*.graphql"', 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" command! -bang -nargs=* GFiles
  " \ call fzf#vim#gitfiles(
  " \   '--cached --others --exclude-standard -- ":!*.rbi"',
  " \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" nnoremap <c-p> :GFiles<CR>
" nnoremap <LocalLeader>g :GGrep<CR>


nnoremap <c-p> <cmd>lua require('fzf-lua').git_files()<CR>
nnoremap <LocalLeader>g <cmd>lua require('fzf-lua').live_grep({ cmd = "git grep --line-number --column --color=always" })<CR>

vnoremap <leader>c :OSCYank<CR>

" vim-test
nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>
let test#strategy = 'neoterm'
let test#enabled_runners = ["ruby#rails"]
let test#ruby#runner = 'rails'

function! RubySpinTestTransform(cmd) abort
  return 'ssh spin@$(spin show -l -o fqdn) "cd /home/spin/src/github.com/Shopify/shopify && ' .. a:cmd .. '"'
endfunction

" let g:test#custom_transformations = {'ruby': function('RubySpinTestTransform')}
" let g:test#transformation = 'ruby'

lua << EOF

require'lualine'.setup()

require("trouble").setup()

require'nvim-web-devicons'.setup {
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 default = true;
}

local cmp = require('cmp')

cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    }
})

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<space>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'CursorHold' }, {
    buffer = bufnr,

    callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request(
        'textDocument/diagnostic',
        { textDocument = params },
        function(err, result)
          if err then return end

          vim.lsp.diagnostic.on_publish_diagnostics(
            nil,
            vim.tbl_extend('keep', params, { diagnostics = result.items }),
            { client_id = client.id }
          )
        end
      )
    end,
  })
end

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.graphql.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.sorbet.setup{
    on_attach = on_attach,
    cmd = { "./bin/srb", "tc", "--lsp" },
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "graphql", "json", "javascript", "typescript", "lua", "tsx", "markdown", "yaml", "http", "html", "python", "scss", "vim" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

lspconfig.ruby_ls.setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'lspconfig'.pyright.setup{}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false
})

EOF
