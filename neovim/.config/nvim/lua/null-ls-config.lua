local null_ls = require'null-ls'

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.code_actions.ts_node_action
  }
})
