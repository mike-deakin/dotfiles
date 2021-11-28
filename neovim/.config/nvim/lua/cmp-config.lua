local cmp = require'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }
}
