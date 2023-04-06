require 'leap'.set_default_keymaps()
-- Helpers stolen from https://github.com/AyeSpacey/Nvimfy/blob/main/lua/keymaps.lua
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.keymap.set(mode, lhs, rhs, options)
end

local cmd = vim.cmd
local ck = require 'caskey'

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
	['<leader>'] = {
		mode = 'n',
		['b'] = {
			desc = 'Buffer management',
			['b'] = { act = ck.cmd 'BufferLinePick' },
			['d'] = { act = ck.cmd 'bd', desc = 'Delete current' },
			['a'] = { act = ck.cmd '%bd|e#', desc = 'Delete all' },
			['o'] = { act = ck.cmd '%bd', desc = 'Delete others' },
		},
		['f'] = function()
			local tb = require 'telescope.builtin'

			return {
				name = 'Telescope',
				desc = 'Fuzzy-finder',
				['f'] = { act = tb.git_files },
				['o'] = { act = function() tb.git_files({ others = true }) end },
				['h'] = { act = function() tb.find_files({ hidden = true }) end },
				['g'] = { act = tb.live_grep },
				['b'] = { act = tb.buffers },
				['k'] = { act = tb.keymaps },
				['c'] = { act = tb.comands },
				['?'] = { act = tb.help_tags },
			}
		end,
		['g'] = {
			desc = 'Grep string in buffer',
			act = function() require 'telescope.builtin'.grep_string() end
		},
		['d'] = function()
			local dap = require 'dap'

			return {
				desc = 'Debugger (DAP)',
				['t'] = { act = dap.toggle_breakpoint, desc = 'Toggle breakpoint' },
				['c'] = { act = function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = 'Set contitional breakpoint'},
				['d'] = { act = dap.continue, desc = 'Continue' },
				['o'] = { act = dap.step_over, desc = 'Step over'},
				['i'] = { act = dap.step_into, desc = 'Step into'},
				['u'] = { act = dap.step_out, desc = 'Step out (think "up")'},
				['r'] = { act = dap.repl.open, desc = 'Open REPL'},
				['l'] = { act = dap.run_last, desc = 'Run last'},
				['x'] = { act = dap.terminate, desc = 'Terminate debug connection'},
			}
		end,
		['na'] = {
			act = require'ts-node-action'.node_action,
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

-- Refactors
map('n', '<leader>na', '<cmd>lua require"ts-node-action".node_action()<CR>')

-- Debugging
map('n', '<leader>de', '<cmd>lua require"dapui".eval(nil, {width = 50, height = 10})<CR>')

-- Treesitter functions
-- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
vim.keymap.set("n", "vU", function()
	vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
	return "g@l"
end, { silent = true, expr = true })
vim.keymap.set("n", "vD", function()
	vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
	return "g@l"
end, { silent = true, expr = true })

-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
vim.keymap.set("n", "vd", function()
	vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
	return "g@l"
end, { silent = true, expr = true })
vim.keymap.set("n", "vu", function()
	vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
	return "g@l"
end, { silent = true, expr = true })

map("n", "vx", '<cmd>STSSelectMasterNode<cr>')
map("n", "vn", '<cmd>STSSelectCurrentNode<cr>')
map("x", "J", '<cmd>STSSelectNextSiblingNode<cr>')
map("x", "K", '<cmd>STSSelectPrevSiblingNode<cr>')
map("x", "H", '<cmd>STSSelectParentNode<cr>')
map("x", "L", '<cmd>STSSelectChildNode<cr>')
map("x", "<A-j>", '<cmd>STSSwapNextVisual<cr>')
map("x", "<A-k>", '<cmd>STSSwapPrevVisual<cr>')

-- Line operations
map('n', '<M-j>', '<cmd>lua require"move-line".moveLineDown()<CR>')
map('n', '∆', '<cmd>lua require"move-line".moveLineDown()<CR>') -- ∆ == option+j
map('n', '<M-k>', '<cmd>lua require"move-line".moveLineUp()<CR>')
map('n', '˚', '<cmd>lua require"move-line".moveLineUp()<CR>')    -- ˚ == option+k
map('x', '<M-j>', ':<C-u>lua require"move-line".moveLinesDown()<CR>')
map('x', '∆', ':<C-u>lua require"move-line".moveLinesDown()<CR>') -- ∆ == option+j
map('x', '<M-k>', ':<C-u>lua require"move-line".moveLinesUp()<CR>')
map('x', '˚', ':<C-u>lua require"move-line".moveLinesUp()<CR>')  -- ˚ == option+k

-- Duplicate line
map('n', '∂', '"dY"dp') -- ∂ == option+d
map('n', '<M-d>', '"dY"dp')

-- Duplicate line down
map('n', 'Ô', '"dY"dp')      -- Ô == option+shift+j
map('n', '<S-M-j>', '"dY"dp') -- Ô == option+shift+j
-- Duplicate line up
map('n', '', '"dY"dP')     --  == option+shift+k
map('n', '<S-M-k>', '"dY"dP') --  == option+shift+k

-- Custom Commands
cmd("command! RSource source $MYVIMRC") -- (R)e-(Source) init.vim
