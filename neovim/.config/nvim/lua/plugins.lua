vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

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
  use { 'williamboman/mason.nvim', config = function() require 'mason'.setup() end }

  -- Style
  use 'navarasu/onedark.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim' -- Show indentation levels
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons' }

  -- file browser
  use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons' }

  -- remote pairing
  use { 'jbyuki/instant.nvim', opt = true, cmd = { 'InstantStartSession', 'InstantJoinSession' } }

  -- Additional functions
  use 'tpope/vim-sleuth' -- auto indent width detection
  use 'tpope/vim-surround' -- surround text with matching character pairs ()[]{}, etc
  use 'tpope/vim-abolish' -- word-related mutations (case, endings, search/replace, etc
  use 'chaoren/vim-wordmotion' -- camel-case word motions
  use 'scrooloose/nerdcommenter'
  use 'ggandor/leap.nvim' -- label-based navigation (like vimium)
  use { 'nat-418/boole.nvim', config = function() require 'boole-config' end }
  use { "smjonas/live-command.nvim", config = function() require 'live-command-config' end }
  use 'neomake/neomake'

  -- IDEA-like stuff
  use { 'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = function() require 'lsp' end
  }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' } -- lsp code actions in descriptive window
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- fzf-style matching for telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy finder
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Syntax-aware motions
  use 'ziontee113/syntax-tree-surfer' -- Syntax-aware motions
  use 'ckolkey/ts-node-action'
  use 'airblade/vim-gitgutter'
  use { 'ThePrimeagen/refactoring.nvim', config = function() require 'refactoring'.setup() end }

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use { 'theHamsta/nvim-dap-virtual-text',
    config = function() require 'nvim-dap-virtual-text'.setup({}) end
  }
  use 'nvim-telescope/telescope-dap.nvim' -- DAP propmts in telescope
  use 'mxsdev/nvim-dap-vscode-js' -- js/ts debugging

  use 'Olical/conjure'

  -- Completions & snippets
  use { 'hrsh7th/nvim-cmp', requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'rafamadriz/friendly-snippets',
  }, config = function() require 'cmp-config' end }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use { 'tzachar/cmp-fuzzy-buffer', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } }
  use { 'tzachar/cmp-fuzzy-path', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } }

  -- Misc
  use "nullchilly/fsread.nvim" -- "Flow-state" reading. Defocus word endings to make it faster to read

  -- Non-plugin packages
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile"
  }
  use {
    'Joakker/lua-json5',
    run = './install.sh'
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
