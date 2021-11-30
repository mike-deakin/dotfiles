vim.g.onedark_toggle_style_keymap = '<nop>' -- Doesn't work anyway
vim.g.onedark_style = 'darker'
vim.g.onedark_transparent_background = true
vim.g.onedark_hide_ending_tildes = true
require'onedark'.setup()
require'lualine'.setup {
    options = {
        theme = 'onedark'
    },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    }
}

-- Some colour overrides
-- Not ideal. variable themeing would be nice or a fork might be needed?
vim.cmd[[highlight Comment ctermfg=14 gui=italic guifg=#e55561]]
vim.cmd[[highlight Todo ctermfg=0 ctermbg=11 gui=bold guifg=#e55561]]
vim.cmd[[highlight TSComment gui=italic guifg=#e55561]]
