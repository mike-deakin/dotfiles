require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Select outer part of function region."},
                ["if"] = { query = "@function.inner", desc = "Select inner part of function region."},
                ["ac"] = { query = "@class.outer", desc = "Select outer part of class region."},
                ["ic"] = { query = "@class.inner", desc = "Select inner part of class region."},
            },
            selection_model = { -- I don't know what this does or means...
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'V',
                ['@class.outer'] = '<C-v>',
            },
        },
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
    },
}

-- vim.cmd[[set foldmethod=expr]]
-- vim.cmd[[set foldexpr=nvim_treesitter#foldexpr()]]
