call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mhartington/oceanic-next'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'HerringtonDarkholme/deoplete-typescript'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdcommenter'

Plug 'w0rp/ale'

Plug 'ludovicchabant/vim-gutentags'

call plug#end()

map <c-p> :GFiles<CR>

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

filetype plugin indent on
set expandtab
set tabstop=4
set shiftwidth=4
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 expandtab
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescript.tsx setlocal expandtab tabstop=2 shiftwidth=2 expandtab
autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 expandtab

set ignorecase
set smartcase
set number

set noswapfile

" Auto indent
set ai
" Smart indent
set si

set autochdir

set autoread

set paste

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

syntax on

nnoremap <esc> :noh<CR><esc>

nnoremap <LocalLeader>p :Ag<CR>
" Theme
syntax enable
colorscheme OceanicNext

let g:airline_theme='oceanicnext'

set wildignore+=*/.git/*,*/tmp/*,*.swp,*.mypy_cache/*,node_modules/*

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'javascript',
                \]

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

set completeopt=noinsert,menuone,noselect

let b:ale_linters = ['flake8', 'mypy']
let b:ale_fixers = {'javascript.jsx': ['prettier'], 'css': ['prettier'], 'javascript': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma --no-semi'
let g:airline#extensions#ale#enabled = 1

let g:python_host_skip_check=1
let g:python3_host_prog = '/Users/jacobdubinsky/.pyenv/shims/python3'
