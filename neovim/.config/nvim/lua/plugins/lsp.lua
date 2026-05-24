vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = { enable = false },
		}
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		client.server_capabilities.semanticTokensProvider = nil
	end
})

return {
	{
		'mrcjkb/rustaceanvim',
		version = '^9',
		lazy = false, -- This plugin is already lazy, so no need to double the lazy
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
		},
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local servers = {
				'ts_ls',
				'lua_ls',
				'gobls',
				'hls',
				'elixirls',
				'pylsp',
				'ruby_lsp',
				'jsonls',
				'yamlls',
				'marksman'
			}
			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end
		end,
		--opts = {
		--servers = {
		--['*'] = {
		--keys = {
		--{'<space>e', vim.diagnostic.open_float}
		--}
		--},
		--ts_ls = {},
		--jsonls = {},
		--lua_ls = {
		--settings = {
		--Lua = {
		--hint = {
		--enable = true,
		--},
		--runtime = {
		--version = 'LuaJIT',
		--},
		--diagnostics = {
		--globals = { 'vim' },
		--},
		--workspace = {
		--library = vim.api.nvim_get_runtime_file("", true),
		--},
		--telemetry = { enable = false },
		--}
		--}
		--}
		--}
		--}
	}
}