return {
	{
		'folke/which-key.nvim',
		opts = {
			preset = 'helix'
		}
	},
	{
		url = 'git@github.com:mike-deakin/caskey.nvim.git',
		dependencies = { "folke/which-key.nvim" }
	}, -- Group-based keymap configuration syntax

	-- file browser
	{
		'nvim-tree/nvim-tree.lua',
		lazy = false,
		--cmd = 'NvimTree*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		init = function()
			-- disable netrw
			vim.g.loaded = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = {
			renderer = {
				group_empty = true
			}
		}
	},

	-- remote pairing
	{
		'jbyuki/instant.nvim',
		cmd = { 'InstantStartSession', 'InstantJoinSession' }
	},

	-- Additional functions
	{ -- surround text with matching character pairs ()[]{},, etc
		'nvim-mini/mini.surround',
		version = '*',
		init = function()
			require 'mini.surround'.setup()
		end
	},
	{ -- word-related mutations (case, endings, search/replace, etc
		'tpope/vim-abolish',
		lazy = true,
		cmd = { 'Abolish', 'Subvert' }
	},
	{ 'chaoren/vim-wordmotion',   lazy = false }, -- camel-case word motions
	{ 'scrooloose/nerdcommenter', lazy = false },
	'folke/flash.nvim',
	{ -- Better increment/decrement functions
		'nat-418/boole.nvim',
		opts = {
			mappings = {
				increment = '<C-a>',
				decrement = '<C-x>',
			}
		}
	},
	{
		'smjonas/live-command.nvim',
		lazy = true,
		cmd = { 'Norm' },
		opts = {
			commands = {
				Norm = { cmd = 'norm' }
			}
		}
	},

	-- IDE stuff
	"aznhe21/actions-preview.nvim",
	{                                  -- TODO: extract to plugin file and merge with telescope-config.lua
		'nvim-telescope/telescope.nvim', -- Fuzzy finder window
		dependencies = {
			'nvim-lua/plenary.nvim',
			'psiska/telescope-hoogle.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		init = function() require 'telescope-config' end,
	},
	'nvim-treesitter/nvim-treesitter-textobjects', -- Syntax-aware motions
	--'ziontee113/syntax-tree-surfer',               -- Syntax-aware motions
	'ckolkey/ts-node-action',
	--'airblade/vim-gitgutter',
	{
		'lewis6991/gitsigns.nvim',
		lazy = false,
	},
	{
		'nvim-neotest/neotest',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'antoinemadec/FixCursorHold.nvim',
			'haydenmeade/neotest-jest',
			'rouge8/neotest-rust',
			'nvim-neotest/neotest-plenary',
			--'~/play/neotest-junit'
			'nvim-neotest/nvim-nio'
		},
	},
	{
		'pwntester/octo.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'kyazdani42/nvim-web-devicons',
		},
		lazy = true,
		cmd = { 'Octo' },
		config = function()
			require 'octo'.setup()
		end
	},
	{
		'mfussenegger/nvim-jdtls', -- Java language server
		module = { 'jdtls' },
	},

	-- Debugging
	{
		'mfussenegger/nvim-dap',
		--cmd = { 'Dap*' },
	},
	'rcarriga/nvim-dap-ui',
	'theHamsta/nvim-dap-virtual-text',
	'nvim-telescope/telescope-dap.nvim', -- DAP propmts in telescope
	{
		'mxsdev/nvim-dap-vscode-js',
		dependencies = {
			'microsoft/vscode-js-debug',
			build = 'npm install --no-save --legacy-peer-deps && npm run compile'
		},
		module = 'dap-vscode-js',
		ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
	},

	-- Completions & snippets
	{ --TODO: move to plugin file and merge with cmp-config.lua
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'rafamadriz/friendly-snippets',
			{ 'tzachar/cmp-fuzzy-buffer', dependencies = { 'tzachar/fuzzy.nvim' } },
			{ 'tzachar/cmp-fuzzy-path',   dependencies = { 'tzachar/fuzzy.nvim' } },
		},
		config = function()
			require 'cmp-config'
		end
	},
	{
		'windwp/nvim-autopairs',
		opts = {},
	},

	-- Misc
	{ 'nullchilly/fsread.nvim', cmd = { 'FSRead', 'FSToggle' } }, -- "Flow-state" reading. Defocus word endings to make it faster to read
	{
		'mickael-menu/zk-nvim',                                     -- Zettelkasten notes (via `zk` cli tool)
		cmd = { 'ZkNew', 'ZkNotes' },
		opts = { picker = 'telescope' },
	},
	{
		'ellisonleao/glow.nvim', -- Markdown renderer/reader
		opts = {
			width = 999,
			height = 999,
			width_ratio = 0.8,
			height_ratio = 0.8,
			border = 'shadow',
			install_path = '$GOPATH/bin/glow'
		},
		cmd = { 'Glow' }
	},
	'liuchengxu/graphviz.vim',
	'aklt/plantuml-syntax',
	{
		'luckasRanarison/nvim-devdocs',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		cmd = { 'DevdocsOpen' }, -- More needed
		opts = {},
	},

	-- Non-plugin packages
	{
		'Joakker/lua-json5',
		build = './install.sh'
	},
}