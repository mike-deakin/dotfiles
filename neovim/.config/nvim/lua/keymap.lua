-- Helpers stolen from https://github.com/AyeSpacey/Nvimfy/blob/main/lua/keymaps.lua
-- In fact, a lot is stolen from Nvimfy
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local cmd = vim.cmd
local s = {silent = true}

 -- QoL Hacks
map('n', ';', ':') -- One-touch commands
map('n', '<C-s>', ':w<CR>') -- Save for normal humans
map('v', '<C-c>', '"+y') -- Copy to OS clipboard

 -- Quickfix list navigation
map('n', '<C-j>', ':cnext<CR>')
map('n', '<C-k>', ':cprev<CR>')

 -- Files and navigation
map('n', '<F2>', ':NERDTreeToggle<CR>')
map('n', '<C-F2>', ':NERDTreeFind<CR>')
map('n', '<leader>f', ':Files<CR>')

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
cmd("command! RSource echo stdpath('config') . '/init.vim' | source") -- (R)e-(Source) init.vim
