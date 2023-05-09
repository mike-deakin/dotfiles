require'neotest'.setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npx jest",
      env = { CI = true },
      cwd = function(_)
        return vim.fn.getcwd()
      end,
    }),
  }
})

require'caskey'.emit('NeoTestConfigured')
