call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sleuth'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'neoclide/coc-solargraph'
Plug 'alvan/vim-closetag'

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
colorscheme OceanicNext
set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

set wildignore+=*/.git/*,*/tmp/*,*.swp,*.mypy_cache/*,node_modules/*

function! s:find_git_root()  
   return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'dir':s:find_git_root(),'options': '--delimiter : --nth 4..'}, <bang>0)

" Custom key mappings
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
nnoremap <esc> :noh<CR><esc>
map <c-p> :GFiles --cached --others --exclude-standard<CR>
nnoremap <LocalLeader>p :Ag<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

let g:airline_theme='oceanicnext'

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

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)


nnoremap <LocalLeader>g :GGrep<CR>

