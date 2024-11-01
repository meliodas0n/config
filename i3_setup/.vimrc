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
  Plug 'Yggdroot/indentLine'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'timakro/vim-yadi'
  Plug 'chiel92/vim-autoformat'
  Plug 'aktersnurra/no-clown-fiesta.nvim'
  Plug 'jacoborus/tender.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'powerline/powerline-fonts'
  Plug 'fcpg/vim-fahrenheit'
  Plug 'AlessandroYorba/Sierra'
  Plug 'AlessandroYorba/Arcadia'
  Plug 'AlessandroYorba/Breve'
  Plug 'Lokaltog/vim-distinguished'
  Plug 'karoliskoncevicius/moonshine-vim'
  Plug 'mattn/emmet-vim'
  Plug 'alvan/vim-closetag'
  Plug 'AndrewRadev/tagalong.vim'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

" cursor blinking
let &t_SI = "\<esc>[5 q" "blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q" "blinking underline in replace mode
let &t_EI = "\<esc>[ q"  "default cursor

let g:user_emmet_leader_key=','
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="apprentice"
let g:rainbow_active = 1 
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:indetLine_setColors = 0
let g:indentLine_char = '┊' 
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let mapleader=" "
let maplocalleader="\\"

"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>
inoremap <c-b> <Esc>:NERDTreeToggle<cr>
nnoremap <c-b> <Esc>:NERDTreeToggle<cr>

syntax on
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
let g:onedark_termcolors=256
let g:sierra_Twilight = 1
set termguicolors
set background=dark
colorscheme nightfox

if &term == "alacritty"
  let &term = "xterm-256color"
endif

" Indentation Hopefully
set expandtab 
set softtabstop=2
set tabstop=2
set shiftwidth=2
set nocompatible
filetype plugin indent on
set encoding=UTF-8
set autoindent
set number
set relativenumber
set mouse=a
set hlsearch
set incsearch
set hidden
" set fdm=indent
set foldlevelstart=99
set ignorecase
set smartcase
"set colorcolumn=120

nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
noremap <F4> :Autoformat<CR>

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" transparency
" hi Normal ctermbg=NONE guibg=NONE

" tagbar
nmap <F8> :TagbarToggle<CR>
