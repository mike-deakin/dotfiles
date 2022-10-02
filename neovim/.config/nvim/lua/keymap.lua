require'leap'.set_default_keymaps()
-- Helpers stolen from https://github.com/AyeSpacey/Nvimfy/blob/main/lua/keymaps.lua
-- In fact, a lot is stolen from Nvimfy
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local cmd = vim.cmd
local s = {silent = true}

 -- QoL Hacks
map({'n', 'v'}, ';', ':') -- One-touch commands
map('n', '<C-s>', ':w<CR>') -- Save for normal humans
map('v', '<C-c>', '"+y') -- Copy to OS clipboard

 -- Quickfix list navigation
map('n', '<C-j>', ':cnext<CR>')
map('n', '<C-k>', ':cprev<CR>')

 -- Files and navigation
map('n', '<F2>', '<cmd>NERDTreeToggle<CR>')
map('n', '<F3>', '<cmd>NERDTreeToggle<CR><C-w>w<cmd>NERDTreeFind<CR>')
map('n', '<leader>fa', '<cmd>Telescope<CR>')
map('n', '<leader>ff', '<cmd>lua require"telescope-config".project_files()<CR>')
map('n', '<leader>fh', '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<CR>')
map('n', '<leader>fg', '<cmd>lua require"telescope.builtin".live_grep()<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fk', '<cmd>Telescope keymaps<CR>')
map('n', '<leader>f?', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
map('n', '<leader>g', '<cmd>lua require"telescope.builtin".grep_string()<CR>')

 -- Window/Buffer management
map('n', '<leader>ba', ':%bd<CR>') -- Delete all open buffers
map('n', '<leader>bo', ':%bd|e#<CR>') -- Delete all other open buffers
map('n', '<leader>bb', ':bd<CR>') -- Delete current buffer

 -- Snippets
map('i', '<Tab>', function()
    return vim.fn['vsnip#available'](1) == 1 and '<Plug>(vsnip-jump-next)' or '<Tab>'
end, {expr = true})
map('i', '<S-Tab>', function()
    return vim.fn['vsnip#available'](-1) == 1 and '<Plug>(vsnip-jump-next)' or '<S-Tab>'
end, {expr = true})
map('n', '<leader>y', '<Plug>(vsnip-select-text)')
map('x', '<leader>y', '<Plug>(vsnip-select-text)<Esc>')
map('n', '<leader>d', '<Plug>(vsnip-cut-text)')
map('x', '<leader>d', '<Plug>(vsnip-cut-text)')

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
