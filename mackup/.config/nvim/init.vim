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
Plug 'alvan/vim-closetag'
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
Plug 'shopify/shadowenv.vim'
Plug 'jparise/vim-graphql'
Plug 'Shopify/vim-sorbet', { 'branch': 'master' }

call plug#end()

filetype plugin indent on

set autoindent
set smartindent
set expandtab
set shiftwidth=4

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype eruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

syntax enable

set number

set noswapfile
set ignorecase

set termguicolors
set background=dark
colorscheme OceanicNext
set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

set wildignore+=*/.git/*,*/tmp/*,*.swp,*.mypy_cache/*,node_modules/*,*/sorbet/*

function! s:find_git_root()  
   return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'dir':s:find_git_root(),'options': '--delimiter : --nth 4..'}, <bang>0)
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Custom key mappings
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"
autocmd InsertEnter,InsertLeave * set cul!
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
nnoremap <esc> :noh<CR><esc>
"map <c-p> :GFiles --cached --others --exclude-standard -x '*.rbi'<CR>
nnoremap <LocalLeader>p :Ag<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" vim-test
nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>
let test#strategy = 'neoterm'

" neoterm
let g:neoterm_default_mod = 'botright'
let g:neoterm_size = 30
noremap <Leader>tt :Ttoggle<CR>
noremap <Leader>n :Ttoggle<CR>
tnoremap <C-o> <C-\><C-n>

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
  \   'git grep --line-number -- '.shellescape(<q-args>).' -- ":!*.rbi"', 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang -nargs=* GFiles2
  \ call fzf#vim#gitfiles(
  \   '--cached --others --exclude-standard -- ":!*.rbi"',
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

map <c-p> :GFiles2<CR>

nnoremap <LocalLeader>g :GGrep<CR>
