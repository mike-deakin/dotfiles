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
  use 'nvim-telescope/telescope-packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground', opt = true, cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' } }

  -- Style
  use 'navarasu/onedark.nvim'
  use 'nvim-lualine/lualine.nvim'

  -- file browser
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }

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
  use { 'nat-418/boole.nvim', config = function() require'boole-config' end }
  use { "smjonas/live-command.nvim", config = function() require'live-command-config' end }

  -- IDEA-like stuff
  use { 'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = function() require'lsp' end
  }
  use 'weilbith/nvim-code-action-menu' -- lsp code actions in descriptive window
  use 'nvim-lua/plenary.nvim' -- required for telescope
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- fzf-style matching for telescope
  use 'nvim-telescope/telescope-dap.nvim' -- DAP propmts in telescope
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use { 'nvim-treesitter/nvim-treesitter-textobjects' } -- Syntax-aware motions
  use 'mfussenegger/nvim-dap'
  use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
  use 'airblade/vim-gitgutter'

  use 'Olical/conjure'

  -- Completions & snippets
  use { 'hrsh7th/nvim-cmp', requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
  }, config = function() require'cmp-config' end }

  -- Non-plugin packages
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile"
  }

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
