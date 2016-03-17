set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
 
" auto reload .vimrc
autocmd! bufwritepost .vimrc source %
 
" better copy paste
set clipboard=unnamed
 
" rebinder leader key
let mapleader = ","
 
" quicksave
noremap <C-s> :update<CR>
 
" folding
set foldmethod=indent
set foldlevel=99
 
" move between tabs
" map <Leader>h <esc>:tabprevious<CR>
" map <Leader>l <esc>:tabnext<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
"map <C-h> :tabp
"map <C-l> :tabn
 
" sort function
vnoremap <Leader>s :sort<CR>
 
" better indenting code blocks
vnoremap <c-]> >gv " better indentation
vnoremap <c-[> <gv " better indentation
 
" SHOW WHITESPACE
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
 
" Color scheme
"syntax enable
"set background=dark
colorscheme desert
 
" syntax higlighting on vimrc
filetype off
filetype plugin indent on
syntax on
 
" show line number and length
set number " show line #
set tw=79 " width of doc
set nowrap " no wrap on load
set fo-=t " no wrap while typing
set colorcolumn=80
highlight ColorColumn ctermbg=233
 
" easy formatting paragraph
" vmap Q gq
" nmap Q gqap
 
" search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <silent> <esc> :noh<CR><esc>
 
" swap file dir
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/

" auto change dir
set autochdir

ca F find

execute pathogen#infect()

let g:syntastic_javascript_checkers = ['eslint']
let g:javascript_enable_domhtmlcss = 1

