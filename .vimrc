augroup AutoReloadVimRC
  au!
  "automatically reload vimrc when it's saved "credits: http://vimbits.com/bits/128
  au BufWritePost .vimrc so ~/.vimrc
augroup END

set nocompatible              " be iMproved, required
filetype off                  " required

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/LeaderF'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" End plugins

filetype plugin indent on
syntax enable

set paste
set ignorecase

set t_Co=256

let mapleader = "\<Space>"

" colorscheme OceanicNext
let g:airline_theme='oceanicnext'

let g:deoplete#enable_at_startup = 1

" Tab complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
