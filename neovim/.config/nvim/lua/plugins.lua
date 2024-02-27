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

return require('packer').startup({
  function(use)
    -- Meta
    use 'wbthomason/packer.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
      require 'treesitter-config'
    end }
    use { 'nvim-treesitter/playground', opt = true, cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' } }
    use { 'Nexmean/caskey.nvim' } -- Group-based keymap configuration syntax
    use {
      'm4xshen/hardtime.nvim',
      requires = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require'hardtime'.setup()
      end,
    }

    -- Style
    use 'navarasu/onedark.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'lukas-reineke/indent-blankline.nvim' -- Show indentation levels
    use { 'akinsho/bufferline.nvim', tag = 'v3.*', requires = 'kyazdani42/nvim-web-devicons' }

    -- file browser
    use {
      'nvim-tree/nvim-tree.lua',
      cmd = 'NvimTree*',
      requires = 'nvim-tree/nvim-web-devicons',
      config = function()
        -- disable netrw
        vim.g.loaded = 1
        vim.g.loaded_netrwPlugin = 1
        require 'nvim-tree'.setup {
          renderer = {
            group_empty = true,
          },
        }
      end
    }

    -- remote pairing
    use { 'jbyuki/instant.nvim', opt = true, cmd = { 'InstantStartSession', 'InstantJoinSession' } }

    -- Additional functions
    use 'tpope/vim-sleuth'                                                  -- auto indent width detection
    use 'tpope/vim-surround'                                                -- surround text with matching character pairs ()[]{}, etc
    use { 'tpope/vim-abolish', opt = true, cmd = { 'Abolish', 'Subvert' } } -- word-related mutations (case, endings, search/replace, etc
    use 'chaoren/vim-wordmotion'                                            -- camel-case word motions
    use 'scrooloose/nerdcommenter'
    --use 'ggandor/leap.nvim'                                                      -- label-based navigation (like vimium)
    use 'folke/flash.nvim'
    use { 'nat-418/boole.nvim', config = function() require 'boole-config' end } -- Better increment/decrement functions
    use {
      'smjonas/live-command.nvim',
      opt = true,
      cmd = { 'Norm', 'Reg' },
      config = function()
        require 'live-command-config'
      end
    }

    -- IDE stuff
    use { 'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'Issafalcon/lsp-overloads.nvim',
      },
      config = function() require 'lsp' end
    }
    use { 'weilbith/nvim-code-action-menu', opt = true, cmd = 'CodeActionMenu' } -- lsp code actions in descriptive window
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'psiska/telescope-hoogle.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      }
    }                                                 -- Fuzzy finder
    use 'nvim-treesitter/nvim-treesitter-textobjects' -- Syntax-aware motions
    use 'ziontee113/syntax-tree-surfer'               -- Syntax-aware motions
    use 'ckolkey/ts-node-action'
    use 'airblade/vim-gitgutter'
    use 'f-person/git-blame.nvim'
    use {
      'nvim-neotest/neotest',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'haydenmeade/neotest-jest',
        'rouge8/neotest-rust',
        'nvim-neotest/neotest-plenary',
        '~/play/neotest-junit'
      },
    }
    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      opt = true,
      cmd = { 'Octo' },
      config = function()
        require 'octo'.setup()
      end
    }
    use {
      'mfussenegger/nvim-jdtls', -- Java language server
      module = { 'jdtls' }
    }

    -- Debugging
    use {
      'mfussenegger/nvim-dap',
      --cmd = { 'Dap*' },
    }
    use { 'rcarriga/nvim-dap-ui' }
    use { 'theHamsta/nvim-dap-virtual-text',
      config = function() require 'nvim-dap-virtual-text'.setup({}) end
    }
    use 'nvim-telescope/telescope-dap.nvim' -- DAP propmts in telescope
    use { 'mxsdev/nvim-dap-vscode-js',
      requires = {
        'microsoft/vscode-js-debug',
        run = 'npm install --legacy-peer-deps && npm run compile'
      },
      module = 'dap-vscode-js',
      ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
    }

    -- Completions & snippets
    use { 'hrsh7th/nvim-cmp', requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'rafamadriz/friendly-snippets',
      { 'tzachar/cmp-fuzzy-buffer', requires = { 'tzachar/fuzzy.nvim' } },
      { 'tzachar/cmp-fuzzy-path',   requires = { 'tzachar/fuzzy.nvim' } },
    }, config = function() require 'cmp-config' end }
    use {
      'windwp/nvim-autopairs',
      config = function() require('nvim-autopairs').setup {} end
    }

    -- Misc
    use { 'nullchilly/fsread.nvim', opt = true, cmd = { 'FSRead', 'FSToggle' } } -- "Flow-state" reading. Defocus word endings to make it faster to read
    use {
      'mickael-menu/zk-nvim',                                                    -- Zettelkasten notes (via `zk` cli tool)
      opt = true,
      cmd = { 'Zk*' },
      config = function()
        require 'zk'.setup({
          picker = 'telescope'
        })
      end
    }
    use {
      'ellisonleao/glow.nvim',
      config = function()
        require('glow').setup({
          width = 999,
          height = 999,
          width_ratio = 0.8,
          height_ratio = 0.8,
          border = 'shadow',
          install_path = '$GOPATH/bin/glow'
        })
      end,
      cmd = { 'Glow' }
    }
    use {
      'luckasRanarison/nvim-devdocs',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'nvim-treesitter/nvim-treesitter',
      },
      cmd = { 'Devdocs*' },
      config = function()
        require 'nvim-devdocs'.setup({})
      end,
    }

    -- Non-plugin packages
    use {
      'Joakker/lua-json5',
      run = './install.sh'
    }
    use {
      'fwcd/kotlin-language-server',
      run = './gradlew installDist',
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
  }
})
