require'leap'.set_default_keymaps()
-- Helpers stolen from https://github.com/AyeSpacey/Nvimfy/blob/main/lua/keymaps.lua
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local cmd = vim.cmd

 -- QoL Hacks
map({'n', 'v'}, ';', ':') -- One-touch commands
map('n', '<C-s>', ':w<CR>') -- Save for normal humans
map('v', '<C-c>', '"+y') -- Copy to OS clipboard

 -- Quickfix list navigation
map('n', '<C-j>', ':cnext<CR>')
map('n', '<C-k>', ':cprev<CR>')

 -- Files and navigation
map('n', '<F2>', '<cmd>NvimTreeToggle<CR>')
map('n', '<F3>', '<cmd>NvimTreeFindFileToggle<CR>')
map('n', '<leader>fa', '<cmd>Telescope<CR>')
map('n', '<leader>ff', '<cmd>lua require"telescope-config".project_files()<CR>')
map('n', '<leader>fh', '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<CR>')
map('n', '<leader>fg', '<cmd>lua require"telescope.builtin".live_grep()<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fk', '<cmd>Telescope keymaps<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands<CR>')
map('n', '<leader>f?', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
map('n', '<leader>g', '<cmd>lua require"telescope.builtin".grep_string()<CR>')

 -- Window/Buffer management
map('n', '<leader>B', '<cmd>BufferLinePick<CR>')
map('n', '<leader>ba', ':%bd<CR>') -- Delete all open buffers
map('n', '<leader>bo', ':%bd|e#<CR>') -- Delete all other open buffers
map('n', '<leader>bd', ':bd<CR>') -- Delete current buffer

 -- Snippets
map('i', '<Tab>', function()
    return vim.fn['vsnip#available'](1) == 1 and '<Plug>(vsnip-jump-next)' or '<Tab>'
end, {expr = true})
map('i', '<S-Tab>', function()
    return vim.fn['vsnip#available'](-1) == 1 and '<Plug>(vsnip-jump-next)' or '<S-Tab>'
end, {expr = true})
map('n', '<leader>y', '<Plug>(vsnip-select-text)')
map('x', '<leader>y', '<Plug>(vsnip-select-text)<Esc>')
map('n', '<leader>x', '<Plug>(vsnip-cut-text)')
map('x', '<leader>x', '<Plug>(vsnip-cut-text)')

-- Refactors
map(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>"
)
map("v", "<leader>re", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>rf", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>rv", [[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
map("v", "<leader>ri", [[<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

map("n", "<leader>rr", [[<cmd>lua require'telescope'.extensions.refactoring.refactors()<CR>]])
map("n", "<leader>rb", [[<Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
--map("n", "<leader>rB", [[<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})
map("n", "<leader>ri", [[<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

-- Debugging
map('n', '<leader>dt', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dc', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dd', '<cmd>lua require"dap".continue()<CR>')
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
map('n', '<leader>do', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>di', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<leader>du', '<cmd>lua require"dap".step_out()<CR>') -- Think step "up"
map('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<leader>dr', '<cmd>lua require"dap".repl.open()<CR>')
map('n', '<leader>dl', '<cmd>lua require"dap".run_last()<CR>')
map('n', '<leader>dx', '<cmd>lua require"dap".terminate()<CR>')
map('n', '<leader>de', '<cmd>lua require"dapui".eval(nil, {width = 50, height = 10})<CR>')

 -- Line operations
map('n', '<M-j>', '<cmd>lua require"move-line".moveLineDown()<CR>')
map('n', '∆', '<cmd>lua require"move-line".moveLineDown()<CR>') -- ∆ == option+j
map('n', '<M-k>', '<cmd>lua require"move-line".moveLineUp()<CR>')
map('n', '˚', '<cmd>lua require"move-line".moveLineUp()<CR>') -- ˚ == option+k
map('x', '<M-j>', ':<C-u>lua require"move-line".moveLinesDown()<CR>')
map('x', '∆', ':<C-u>lua require"move-line".moveLinesDown()<CR>') -- ∆ == option+j
map('x', '<M-k>', ':<C-u>lua require"move-line".moveLinesUp()<CR>')
map('x', '˚', ':<C-u>lua require"move-line".moveLinesUp()<CR>') -- ˚ == option+k

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
