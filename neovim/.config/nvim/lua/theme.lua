--vim.cmd('colorscheme onedark')
--vim.g['airline_powerline_fonts'] = 1
--vim.g['airline#extensions#tabline#enabled'] = 1
--vim.g['airline_theme'] = 'onedark'
--vim.g['onedark_terminal_italics'] = 0  -- doesn't work in current iterm2 settings

vim.g.onedark_toggle_style_keymap = '<leader>tt'
vim.g.onedark_style = 'deep'
vim.g.onedark_transparent_background = true
vim.g.onedark_hide_ending_tildes = true
vim.g.onedark_italic_comment = false
require'onedark'.setup()
require'lualine'.setup {
    options = {
        theme = 'onedark'
    }
}
