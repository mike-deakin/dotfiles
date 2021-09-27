" General
set nocompatible	" disable compatibility to classic vi
set hlsearch		" HighLight search matches
set number		" show line number(s)
set rnu			" show relative line numbers
set fileencodings+=utf-8
set encoding=utf-8

" Tabs & Whitespace
set tabstop=4		" column width of tab character
set softtabstop=4	" treat groups of 4 spaces like a tab char
set expandtab		" convert tabs to spaces
set shiftwidth=4	" auto-indent width
filetype plugin indent on "auto-indent based on file type

" Editor niceties
syntax on
"set wildmode=list:longest	" bash-like tab completions (?)

" vim-plug plugins "
call plug#begin()
" Style
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'flazz/vim-colorschemes' " Are there better schemes?
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot' "Improved syntax highlighting etc.

" File browser
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" Remote pairing
Plug 'jbyuki/instant.nvim'

" Additional functions
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'chaoren/vim-wordmotion'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'

Plug 'airblade/vim-gitgutter'

Plug 'jbyuki/instant.nvim'

call plug#end()

map <C-n> :NERDTreeToggle<CR>

let g:instant_username = 'mdeakin'

colorscheme onedark

