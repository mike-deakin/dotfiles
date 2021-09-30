" General
set nocompatible	" disable compatibility to classic vi
set hlsearch		" HighLight search matches
set lazyredraw      " Don't animate macros etc.
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
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot' "Improved syntax highlighting etc.

" File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'

" Remote pairing
Plug 'jbyuki/instant.nvim'

" Additional functions
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'chaoren/vim-wordmotion'
Plug 'yggdroot/indentline'  " Show indentation levels
Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'    " Disabled for now
                                " (it was very verbose and annoying)

" IDEA-like stuff
Plug 'neovim/nvim-lspconfig' " https://github.com/neovim/nvim-lspconfig

Plug 'airblade/vim-gitgutter'

call plug#end()

map <C-n> :NERDTreeToggle<CR>

let g:instant_username = 'mdeakin'

colorscheme onedark
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
let g:onedark_terminal_italics=0 "doesn't work in current iterm2 settings

" Syntastic defaults
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" \Syntastic

" Language Server Protocol
lua require('lsp')
" \LSP
