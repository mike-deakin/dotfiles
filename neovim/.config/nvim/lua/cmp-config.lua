local cmp = require 'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

if cmp ~= nil then
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'vsnip' },
      { name = 'fuzzy_buffer' },
    }, { { name = 'buffer' } }),
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-s>'] = cmp.mapping.complete({
        config = {
          sources = {
            { name = 'vsnip' }
          }
        }
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item()
          else
            cmp.confirm()
          end
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<S-Tab>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    }),
  }

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
      { name = 'fuzzy_buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' }
    })
  })

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
