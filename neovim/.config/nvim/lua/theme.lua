vim.opt.termguicolors = true

local od = require 'onedark'
od.setup {
    style = 'dark',
    transparent = false,
    term_colors = false,
    ending_tildes = false,
    highlights = {
        ['@comment'] = { fg = '#e55561', fmt = 'italic' },
        ['@todo'] = { fg = '#e55561', fmt = 'bold' }
    }
}
od.load()

require 'lualine'.setup {
    options = {
        theme = 'onedark',
        disabled_filetypes = {
            'NvimTree'
        }
    },
    tabline = {},
    sections = {
        lualine_c = { { 'filename', path = 1 } }
    },
    inactive_sections = {
        lualine_c = { { 'filename', path = 1 } }
    },
}

require 'bufferline'.setup {
    options = {
        buffer_close_icon = '',
        close_icon = '',
        numbers = 'ordinal',
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        tab_size = 14,
        indicator = { style = 'underline' },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        },
    },
}

vim.opt.list = true
vim.opt.listchars:append("eol:⊣")
require("indent_blankline").setup {
    char = '┊',
    use_treesitter = true,
    show_end_of_line = true,
}
