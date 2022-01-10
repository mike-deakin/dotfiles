require'onedark'.setup {
    style = 'dark',
    transparent = true,
    term_colors = false,
    ending_tildes = false,
}
require'onedark'.load()

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
