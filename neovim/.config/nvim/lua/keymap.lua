--require 'leap'.set_default_keymaps()
-- Helpers stolen from https://github.com/AyeSpacey/Nvimfy/blob/main/lua/keymaps.lua
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.keymap.set(mode, lhs, rhs, options)
end

local cmd = vim.cmd
local ck = require 'caskey'
--local nodenav = require 'treesitter-nodenav' -- This doesn't work :(
local sts = require 'syntax-tree-surfer'

ck.setup({
	{
		['<C-s>'] = { act = ck.cmd 'w', desc = 'Save for normal humans', mode = 'n' },
		['<C-c>'] = { act = '"+y', desc = 'Copy to OS clipboard', mode = 'v' },
	},
	{
		name = 'NvimTree',
		mode = 'n',
		['<F2>'] = { act = ck.cmd 'NvimTreeToggle', desc = 'Toggle file tree' },
		['<F3>'] = { act = ck.cmd 'NvimTreeFindFileToggle', desc = 'Toggle file tree, jump to current file' },
	},
	{
		mode = 'n',
		name = 'Quickfix',
		desc = 'Quickfix list navigation',
		['<C-j>'] = { act = ck.cmd 'cnext' },
		['<C-k>'] = { act = ck.cmd 'cprev' },
	},
	{
		mode = 'n',
		name = 'Treesitter actions',
		desc = 'Moves and swaps powered by Treesitter (not dot-repeatable yet)',
		['<M-k>'] = { act = function() sts.move('n', true) end, desc = 'Swap parent node with its sibling upwards.' },
		['<M-j>'] = { act = function() sts.move('n', false) end, desc = 'Swap parent node with its sibling downwards.' },
		['<M-h>'] = { act = function() sts.surf('prev', 'normal', true) end, desc = 'Swap node with previous sibling.' },
		['<M-l>'] = { act = function() sts.surf('next', 'normal', true) end, desc = 'Swap node with next sibling.' },
	},
	{
		mode = { 'n', 'x', 'o' },
		name = 'Flash motions',
		['s'] = { act = function() require 'flash'.jump() end },
		['S'] = { act = function() require 'flash'.treesitter() end },
		['r'] = { mode = 'o', act = function() require 'flash'.remote() end }
	},
	{
		name = 'Line moves',
		desc = 'Moves and swaps by line',
		{
			mode = 'n',
			['J'] = { act = require 'move-line'.moveLineDown },
			['K'] = { act = require 'move-line'.moveLineUp },
		},
		{
			mode = 'x',
			['J'] = { act = require 'move-line'.moveLinesDown },
			['K'] = { act = require 'move-line'.moveLinesUp },
		},
	},
	['<leader>'] = {
		mode = 'n',
		['b'] = {
			desc = 'Buffer management',
			['b'] = { act = ck.cmd 'BufferLinePick', desc = 'Pick buffer by label' },
			['d'] = { act = ck.cmd 'bd', desc = 'Delete current' },
			['a'] = { act = ck.cmd '%bd', desc = 'Delete all' },
			['o'] = { act = ck.cmd '%bd|e#', desc = 'Delete others' },
			['p'] = { act = ck.cmd 'bp', desc = 'Go to previous buffer' },
			['n'] = { act = ck.cmd 'bn', desc = 'Go to next buffer' },
		},
		['f'] = function()
			local tb = require 'telescope.builtin'

			return {
				name = 'Telescope',
				desc = 'Fuzzy-finder',
				['f'] = { act = tb.git_files, desc = 'Find files in git' },
				['o'] = { act = function() tb.git_files({ others = true }) end },
				['h'] = { act = function() tb.find_files({ hidden = true }) end, desc = 'Find in all files' },
				['g'] = { act = tb.live_grep, desc = 'Grep for text in files' },
				['b'] = { act = tb.buffers, desc = 'Search for buffers' },
				['k'] = { act = tb.keymaps, desc = 'Serach in keymap' },
				['c'] = { act = tb.comands, desc = 'Serach for user commands' },
				['s'] = { act = tb.treesitter, desc = 'Search treesitter symbols' },
				['w'] = { act = tb.grep_string, desc = 'Find word under cursor' },
				['?'] = { act = tb.help_tags, desc = 'Search help pages' },
			}
		end,
		['g'] = function()
			local tb = require 'telescope.builtin'

			return {
				name = 'Git operations',
				['b'] = { act = tb.git_bcommits, desc = 'Commit log of current buffer' },
				['c'] = { act = tb.git_commits, desc = 'Commit log of current directory/project' },
				['s'] = { act = tb.git_branches, desc = 'List & switch branches' },
				['d'] = { act = tb.git_status, desc = 'Status/diff view' },
			}
		end,
		['d'] = function()
			local dap = require 'dap'

			return {
				desc = 'Debugger (DAP)',
				when = ck.emitted 'DapConfigured',
				['t'] = { act = dap.toggle_breakpoint, desc = 'Toggle breakpoint' },
				['c'] = {
					act = function() dap.set_breakpoint(vim.fn.input("Breakpoint condition:")) end,
					desc = 'Set contitional breakpoint'
				},
				['d'] = { act = dap.continue, desc = 'Continue' },
				['o'] = { act = dap.step_over, desc = 'Step over' },
				['i'] = { act = dap.step_into, desc = 'Step into' },
				['u'] = { act = dap.step_out, desc = 'Step out (think "up")' },
				['r'] = { act = dap.repl.open, desc = 'Open REPL' },
				['l'] = { act = dap.run_last, desc = 'Run last' },
				['x'] = { act = dap.terminate, desc = 'Terminate debug connection' },
			}
		end,
		['t'] = function()
			local test = require 'neotest'
			return {
				desc = 'Run Tests',
				when = ck.emitted 'NeoTestConfigured',
				['t'] = { act = function() test.run.run() end, desc = 'Run nearest test' },
				['a'] = { act = function() test.run.run(vim.fn.expand('%')) end, desc = 'Run all tests in file' },
				['d'] = { act = function() test.run.run({ strategy = 'dap' }) end, desc = 'Debug nearest test' },
				['o'] = { act = function() test.output_panel.toggle() end, desc = 'Toggle output panel' },
			}
		end,
		['na'] = {
			act = require 'ts-node-action'.node_action,
			desc = 'TreeSitter node action',
		},
	},
})

-- QoL Hacks
map({ 'n', 'v' }, ';', ':') -- One-touch comands
-- Snippets
map('n', '<leader>y', '<Plug>(vsnip-select-text)')
map('x', '<leader>y', '<Plug>(vsnip-select-text)<Esc>')
map('n', '<leader>x', '<Plug>(vsnip-cut-text)')
map('x', '<leader>x', '<Plug>(vsnip-cut-text)')

-- Duplicate line
map('n', '∂', '"dY"dp') -- ∂ == option+d
map('n', '<M-d>', '"dY"dp')
-- Duplicate line down
map('n', 'Ô', '"dY"dp') -- Ô == option+shift+j
map('n', '<S-M-j>', '"dY"dp') -- Ô == option+shift+j
-- Duplicate line up
map('n', '', '"dY"dP') --  == option+shift+k
map('n', '<S-M-k>', '"dY"dP') --  == option+shift+k

-- Custom Commands
cmd("command! RSource source $MYVIMRC") -- (R)e-(Source) init.vim
