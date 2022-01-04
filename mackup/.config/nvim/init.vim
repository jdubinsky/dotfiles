call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'scrooloose/nerdcommenter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
Plug 'folke/trouble.nvim'


" {{{ lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'iamcco/diagnostic-languageserver'

call plug#end()


filetype plugin indent on

set autoindent
set smartindent
set expandtab
set shiftwidth=4

syntax enable

set number
set noswapfile
set ignorecase
set termguicolors
set background=dark
set completeopt=menu,menuone,noselect

colorscheme OceanicNext

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

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'dir':s:find_git_root(),'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <LocalLeader>p :Ag<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" neoterm
let g:neoterm_default_mod = 'botright'
let g:neoterm_size = 30
noremap <Leader>tt :Ttoggle<CR>
noremap <Leader>n :Ttoggle<CR>
tnoremap <C-o> <C-\><C-n>

" trouble
nnoremap <LocalLeader>r :TroubleToggle document_diagnostics<CR>

" nerd commenter
let g:NERDSpaceDelims = 1

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>).' -- ":!*.rbi" ":!*test*" ":!*.graphql"', 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang -nargs=* GFiles2
  \ call fzf#vim#gitfiles(
  \   '--cached --others --exclude-standard -- ":!*.rbi"',
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

map <c-p> :GFiles2<CR>

nnoremap <LocalLeader>g :GGrep<CR>

" vim-test
nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>
let test#strategy = 'neoterm'
let test#ruby#runner = 'rails'

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
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
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

end

lspconfig.diagnosticls.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    filetypes = { 'ruby' },
    init_options = {
        linters = {
            rubocop = {
                sourceName = 'rubocop',
                rootPatterns = { '.git' },
                command = './bin/rubocop',
                debounce = 100,
                args = {
                  '--format',
                  'json',
                  '--force-exclusion',
                  '--stdin',
                  '%filepath',
                },
                parseJson = {
                  errorsRoot = 'files[0].offenses',
                  line = 'location.start_line',
                  endLine = 'location.last_line',
                  column = 'location.start_column',
                  endColumn = 'location.end_column',
                  message = '[rubocop] [${cop_name}] ${message}',
                  security = 'severity',
                },
                securities = {
                  fatal = 'error',
                  error = 'error',
                  warning = 'warning',
                  convention = 'info',
                  refactor = 'info',
                  info = 'info',
                }
            }
        },
        filetypes = {
            ruby = 'rubocop'
        }
    }
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.graphql.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.sorbet.setup{
    on_attach = on_attach,
    cmd = { "./bin/srb", "tc", "--lsp" },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   virtual_text = {
     spacing = 2,
   },
 }
)
EOF
