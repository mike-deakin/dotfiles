" General
set nocompatible	" disable compatibility to classic vi
set hlsearch		" HighLight search matches
set lazyredraw      " Don't animate macros etc.
set number		" show line number(s)
set rnu			" show relative line numbers
set cursorline  " highlight current line of cursor
set fileencodings+=utf-8
set encoding=utf-8
let maplocalleader=","

" Tabs & Whitespace
set tabstop=4		" column width of tab character
set softtabstop=4	" treat groups of 4 spaces like a tab char
set expandtab		" convert tabs to spaces
set shiftwidth=4	" auto-indent width
filetype plugin indent on "auto-indent based on file type

" Editor niceties
syntax on
set completeopt=menu,menuone,noselect
"set wildmode=list:longest	" bash-like tab completions (?)

" vim-plug plugins
call plug#begin()
Plug 'dstein64/vim-startuptime'
" Style
Plug 'ryanoasis/vim-devicons'
Plug 'navarasu/onedark.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}

" File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" Remote pairing
Plug 'jbyuki/instant.nvim', { 'on': ['InstantStartSession', 'InstantJoinSession'] }

" Additional functions
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth' " auto indent width detection
Plug 'tpope/vim-surround' " surround text with matching character pairs ()[]{}, etc
Plug 'tpope/vim-abolish' " word-related mutations (case, endings, search/replace, etc
Plug 'chaoren/vim-wordmotion' " camel-case word motions
Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation levels
Plug 'scrooloose/nerdcommenter'
Plug 'ggandor/leap.nvim' " label-based navigation (like vimium)

" IDEA-like stuff
Plug 'neovim/nvim-lspconfig' " https://github.com/neovim/nvim-lspconfig
Plug 'weilbith/nvim-code-action-menu' " lsp code actions in descriptive window
Plug 'nvim-lua/plenary.nvim' " required for telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " fzf-style matching for telescope 
Plug 'nvim-telescope/telescope.nvim' " Fuzzy finder

Plug 'Olical/conjure'

" Completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'airblade/vim-gitgutter'

call plug#end()

let NERDTreeShowHidden = 1

let g:instant_username = 'mdeakin'

let g:move_key_modifier = 'C'

lua << EOF
require'theme'
require'keymap'
require'lsp' -- Language Server Protocol
require'cmp-config'
require'telescope-config'
require'treesitter-config'
EOF
