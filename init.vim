call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm'

Plug 'mhartington/oceanic-next'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'neomake/neomake'

Plug 'zchee/deoplete-jedi'

Plug 'tpope/vim-sleuth'

Plug 'pangloss/vim-javascript'

Plug 'mxw/vim-jsx'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'

Plug 'ambv/black'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }

call plug#end()


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

" Auto indent
set ai
" Smart indent
set si

set autochdir

set autoread
autocmd! BufWritePost init.vim source %

set completeopt-=preview

syntax on

nnoremap <esc> :noh<CR><esc>

" Theme
syntax enable
colorscheme OceanicNext

call neomake#configure#automake('w')

let g:airline_theme='oceanicnext'

let mapleader = "\<Space>"

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|site-packages\|__pycache__\|venv'

let g:neomake_python_enabled_makers = ['flake8', 'pylint']

let g:deoplete#enable_at_startup = 1

function! TabWrap()
    if pumvisible()
        return "\<C-N>"
    elseif strpart( getline('.'), 0, col('.') - 1 ) =~ '^\s*$'
        return "\<tab>"
    elseif &omnifunc !~ ''
        return "\<C-X>\<C-O>"
    else
        return "\<C-N>"
    endif
endfunction

imap <silent><expr><tab> TabWrap()
