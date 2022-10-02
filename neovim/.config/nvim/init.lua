-- General
vim.opt.compatible = false
vim.opt.hlsearch = true
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.rnu = true
vim.opt.cursorline = true
vim.opt.mouse = ""
vim.opt.fileencodings = vim.opt.fileencodings + { 'utf-8' }
vim.opt.encoding = 'utf-8'
vim.g.maplocalleader = ','

-- Tabs & Whitespace
vim.opt.tabstop = 4 -- column width of tab character
vim.opt.softtabstop = 4 -- treat groups of 4 spaces like a tab char
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- auto-indent width
vim.cmd([[filetype plugin indent on]]) -- auto-indent based on file type

-- Editor niceties
vim.cmd([[syntax on]])
vim.opt.completeopt = "menu,menuone,noselect"

-- vim-plug plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Meta
Plug 'dstein64/vim-startuptime'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Style
Plug 'ryanoasis/vim-devicons'
Plug 'navarasu/onedark.nvim'
Plug 'nvim-lualine/lualine.nvim'

-- file browser
Plug('scrooloose/nerdtree', { ['on'] = 'NERDTreeToggle' })
Plug('xuyuanp/nerdtree-git-plugin', { ['on'] = 'NERDTreetoggle' })

-- remote pairing
Plug('jbyuki/instant.nvim', { ['on'] = { 'InstantStartSession', 'InstantJoinSession' } })

-- Additional functions
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth' -- auto indent width detection
Plug 'tpope/vim-surround' -- surround text with matching character pairs ()[]{}, etc
Plug 'tpope/vim-abolish' -- word-related mutations (case, endings, search/replace, etc
Plug 'chaoren/vim-wordmotion' -- camel-case word motions
Plug 'lukas-reineke/indent-blankline.nvim' -- Show indentation levels
Plug 'scrooloose/nerdcommenter'
Plug 'ggandor/leap.nvim' -- label-based navigation (like vimium)

-- IDEA-like stuff
Plug 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
Plug 'weilbith/nvim-code-action-menu' -- lsp code actions in descriptive window
Plug 'nvim-lua/plenary.nvim' -- required for telescope
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' }) -- fzf-style matching for telescope
Plug 'nvim-telescope/telescope.nvim' -- Fuzzy finder
Plug 'nvim-treesitter/nvim-treesitter-textobjects' -- Syntax-aware motions

Plug 'Olical/conjure'

-- Completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'airblade/vim-gitgutter'

vim.call('plug#end')

vim.g.NERDTreeShowHidden = 1
vim.g.instant_username = 'mdeakin'

require'theme'
require'keymap'
require'lsp' -- Language Server Protocol
require'cmp-config'
require'telescope-config'
require'treesitter-config'
