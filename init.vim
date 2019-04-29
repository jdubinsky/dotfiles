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

Plug 'mxw/vim-jsx'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdcommenter'

Plug 'w0rp/ale'

call plug#end()

map <c-p> :GFiles<CR>

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

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

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

syntax on

nnoremap <esc> :noh<CR><esc>

" Theme
syntax enable
colorscheme OceanicNext

let g:airline_theme='oceanicnext'

let mapleader = "\<Space>"

set wildignore+=*/.git/*,*/tmp/*,*.swp

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'javascript',
                \]

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

set completeopt=noinsert,menuone,noselect

let b:ale_linters = ['pyflakes', 'flake8', 'pylint']
let b:ale_fixers = {'javascript.jsx': ['prettier'], 'css': ['prettier'], 'javascript': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma --no-semi'
