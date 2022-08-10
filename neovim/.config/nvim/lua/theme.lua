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

vim.opt.list = true
vim.opt.listchars:append("eol:⊣")
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    char = '┊',
    use_treesitter = true,
    show_end_of_line = true,
}

-- Some colour overrides
-- Not ideal. variable themeing would be nice or a fork might be needed?
vim.cmd[[highlight Comment ctermfg=14 gui=italic guifg=#e55561]]
vim.cmd[[highlight Todo ctermfg=0 ctermbg=11 gui=bold guifg=#e55561]]
vim.cmd[[highlight TSComment gui=italic guifg=#e55561]]
