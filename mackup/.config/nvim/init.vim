call plug#begin('~/.local/share/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'scrooloose/nerdcommenter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-airline/vim-airline'
"Plug 'tpope/vim-sleuth'
"Plug 'vim-ruby/vim-ruby'
"Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
"Plug 'alvan/vim-closetag'
"Plug 'peitalin/vim-jsx-typescript'
"Plug 'leafgarland/typescript-vim'
"Plug 'pangloss/vim-javascript'
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
"Plug 'jparise/vim-graphql'

" {{{ lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
" lsp }}}

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
set completeopt=menuone,noselect
set shortmess+=c

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
nnoremap <LocalLeader>r :TroubleToggle<CR>

lua << EOF
require('lspkind').init({})

local lspconfig = require('lspconfig')

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

lspconfig.solargraph.setup {
  settings = {
    solargraph = {
      diagnostics = true
    }
  },
}

lspconfig.tsserver.setup {}

lspconfig.graphql.setup{}

lspconfig.sorbet.setup{}

lspconfig.diagnosticls.setup{
  filetypes = { "javascript", "javascript.jsx", "typescript", "typescript.tsx" },
  init_options = {
    filetypes = {
      javascript = "eslint",
      ["javascript.jsx"] = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint",
      typescript = "eslint",
      ["eslint.tsx"] = "eslint",
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = { ".git" },
        debounce = 100,
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity",
        };
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    }
  }
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

require("trouble").setup {}
EOF
