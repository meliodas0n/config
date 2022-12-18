call plug#begin()
    Plug 'bling/vim-bufferline'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'luochen1990/rainbow'
    Plug 'preservim/nerdtree'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
    Plug 'ryanoasis/vim-devicons'
    Plug 'arcticicestudio/nord-vim'
    Plug 'morhetz/gruvbox'
    Plug 'jiangmiao/auto-pairs'
    " Plug 'davidhalter/jedi-vim'
    Plug 'wsdjeg/flygrep.vim'
    Plug 'majutsushi/tagbar'
    " Plug 'Valloric/YouCompleteMe'
    Plug 'arcticicestudio/nord-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
    Plug 'sainnhe/everforest'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:rainbow_active = 1 
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

nnoremap <C-t> :NERDTreeToggle<CR>

let mapleader=" "
let maplocalleader="\\"

syntax on
set termguicolors
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
colorscheme everforest 
set background=dark

if &term == "alacritty"
    let &term = "xterm-256color"
endif

set nocompatible
filetype plugin indent on
set encoding=UTF-8
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set relativenumber
set mouse=a
set hlsearch
set incsearch
set hidden
set fdm=indent
set foldlevelstart=99
set ignorecase
set smartcase
"set colorcolumn=120

nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" transparency
" hi Normal ctermbg=NONE guibg=NONE

" tagbar
nmap <F8> :TagbarToggle<CR>

let g:ycm_global_ycm_extra_conf='~/.vim/autoload/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_python_binary_path='/usr/bin/python3'
