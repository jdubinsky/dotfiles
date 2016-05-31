" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0


" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Show line numbers
set number

" Disable backup files
set nobackup

" Set to current directory
set autochdir

" Whitespace
set wrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

colorscheme desert

ca F find

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

execute pathogen#infect()

