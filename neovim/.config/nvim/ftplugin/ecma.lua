print('This is a test of filetypes!')

require 'neotest'.setup({
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

require 'caskey'.emit('NeoTestConfigured')

require 'dap-vscode-js'.setup({
  adapters = { 'pwa-node' }
})

local dapext = require 'dap.ext.vscode'
pcall(function()
  dapext.json_decode = require 'json5'.parse
end)

pcall(dapext.load_launchjs, nil, {
  ['pwa-node'] = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
})
