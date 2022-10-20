local od = require 'onedark'
od.setup {
    style = 'dark',
    transparent = true,
    term_colors = false,
    ending_tildes = false,
    highlights = {
        Comment = { fg = '#e55561', fmt = 'italic' },
        Todo = { fg = '#e55561', fmt = 'bold' }
    }
}
od.load()

-- Temporary fixes (onedark is still using deprecated TS highlight groups and some new tags are not linked)
vim.api.nvim_set_hl(0, "@tag", { link = 'TSTag' })
vim.api.nvim_set_hl(0, "@constructor", { link = 'TSConstructor' })

require 'lualine'.setup {
    options = {
        theme = 'onedark',
        disabled_filetypes = {
            'NvimTree'
        }
    },
    tabline = {
        lualine_a = { { 'buffers', mode = 2, max_length = vim.o.columns * 1 / 2 } },
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
    },
    sections = {
        lualine_c = { { 'filename', path = 1 } }
    },
    inactive_sections = {
        lualine_c = { { 'filename', path = 1 } }
    },
}

vim.opt.list = true
vim.opt.listchars:append("eol:⊣")
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    char = '┊',
    use_treesitter = true,
    show_end_of_line = true,
}
