call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'scrooloose/nerdcommenter'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'vim-airline/vim-airline'
" Plug 'nvim-lualine/lualine.nvim'
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
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
nnoremap <LocalLeader>r :TroubleToggle lsp_document_diagnostics<CR>

" let g:airline_theme='oceanicnext'

function! s:find_git_tags()  
   let git_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
   let tag_root =  git_root . "/.tags"
   return tag_root
endfunction

set tags=./.tags,.tags
execute "set tags+=".s:find_git_tags()
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ },
      \ }
let g:gutentags_ctags_executable_ruby = 'ripper-tags'
let g:gutentags_generate_on_new = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.erb'

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

-- require'lualine'.setup()

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

lspconfig.solargraph.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    solargraph = {
      diagnostics = true
    }
  },
}

lspconfig.tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.graphql.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.sorbet.setup{
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
