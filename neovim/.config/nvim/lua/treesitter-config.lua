require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["aa"] = { query = "@parameter.outer" }, -- "Around argument"
                ["ia"] = { query = "@parameter.inner" }, -- "Inside argument"
                ["af"] = { query = "@function.outer" },
                ["if"] = { query = "@function.inner" },
                ["ac"] = { query = "@class.outer" },
                ["ic"] = { query = "@class.inner" },
            },
            selection_model = {
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'V',
                ['@class.outer'] = 'V',
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

vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
