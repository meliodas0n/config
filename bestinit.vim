" plugins using vim-plug
call plug#begin()
  Plug 'bling/vim-bufferline'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'luochen1990/rainbow'
  Plug 'preservim/nerdtree'
  Plug 'neoclide/coc.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'jiangmiao/auto-pairs'
  Plug 'majutsushi/tagbar'
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', {'do' : 'TSUpdate'}
  Plug 'Yggdroot/indentLine'
  Plug 'timakro/vim-yadi'
  Plug 'aktersnurra/no-clown-fiesta.nvim'
  Plug 'jacoborus/tender.vim'
  Plug 'powerline/powerline-fonts'
  Plug 'fcpg/vim-fahrenheit'
  Plug 'Lokaltog/vim-distinguished'
  Plug 'alvan/vim-closetag'
  Plug 'AndrewRadev/tagalong.vim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" general settings
syntax on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set nocompatible
set encoding=UTF-8
set autoindent
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

" airline, rainbow brackets, nerdtree and indetline
"  settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "apprentice"
let g:rainbow_active = 1 
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:indetLine_setColors = 0
let g:indentLine_char = '┊'

" leaders
let mapleader = " "
let maplocalleader = "\\"

" telescope commands
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" open folder structure
inoremap <c-b> <Esc>:NERDTreeToggle<cr>
nnoremap <c-b> <Esc>:NERDTreeToggle<cr>

" roam around buffers
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
noremap <F4> :Autoformat<CR>

" tab autocompletion
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" tagbar
nmap <F8> :TagbarToggle<CR>
