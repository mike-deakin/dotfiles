local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({ function(use)
  -- Meta
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Style
  use 'ryanoasis/vim-devicons'
  use 'navarasu/onedark.nvim'
  use 'nvim-lualine/lualine.nvim'

  -- file browser
  use { 'scrooloose/nerdtree', opt = true, cmd = { 'NERDTreeToggle' } }
  use { 'xuyuanp/nerdtree-git-plugin', opt = true, cmd = { 'NERDTreeToggle' } }

  -- remote pairing
  use { 'jbyuki/instant.nvim', opt = true, cmd = { 'InstantStartSession', 'InstantJoinSession' } }

  -- Additional functions
  use 'tpope/vim-sensible'
  use 'tpope/vim-sleuth' -- auto indent width detection
  use 'tpope/vim-surround' -- surround text with matching character pairs ()[]{}, etc
  use 'tpope/vim-abolish' -- word-related mutations (case, endings, search/replace, etc
  use 'chaoren/vim-wordmotion' -- camel-case word motions
  use 'lukas-reineke/indent-blankline.nvim' -- Show indentation levels
  use 'scrooloose/nerdcommenter'
  use 'ggandor/leap.nvim' -- label-based navigation (like vimium)

  -- IDEA-like stuff
  use 'neovim/nvim-lspconfig' -- https://github.com/neovim/nvim-lspconfig
  use 'weilbith/nvim-code-action-menu' -- lsp code actions in descriptive window
  use 'nvim-lua/plenary.nvim' -- required for telescope
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- fzf-style matching for telescope
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = { 'nvim-treesitter/nvim-treesitter' } } -- Syntax-aware motions

  use 'Olical/conjure'

  -- Completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'airblade/vim-gitgutter'

  if packer_bootstrap then
    require 'packer'.sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  } })