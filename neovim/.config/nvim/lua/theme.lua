vim.opt.termguicolors = true
vim.opt.laststatus = 3

local od = require 'onedark'
od.setup {
    style = 'dark',
    transparent = true,
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

-- Big, smelly hack incoming!
-- bufferline just copies whatever colors the highlight 'Normal' has
-- but that looks awful with a transparent background
-- This sets it to a prettier color first, sets up bufferline, then reverts 'Normal'
local normal_hl = vim.api.nvim_get_hl_by_name('Normal', true)
vim.api.nvim_set_hl(0, 'Normal', { bg = '#3b3f4c' })

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

vim.api.nvim_set_hl(0, 'Normal', normal_hl)

vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { link = 'Whitespace' })
vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', { link = 'Whitespace' })
vim.api.nvim_set_hl(0, 'IndentBlanklineContext', { fg = '#98c379', nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#98c379', nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextSpaceChar', { fg = '#98c379', nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineContextStart', { sp = '#98c379', underline = true })
vim.opt.list = true
vim.opt.listchars:append("eol:⊣")
require("indent_blankline").setup {
    char = '┊',
    context_char = '▏',
    use_treesitter = true,
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = true,
}
