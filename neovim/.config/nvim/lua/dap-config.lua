local dap = require 'dap'

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

require 'dap-vscode-js'.setup {
  adapters = { 'pwa-node', 'pwa-chrome' }
}

for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-chrome",
      request = "attach",
      name = "Attach to Chrome debugger",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome against localhost",
      url = "http://localhost:1234",
      webRoot = "${workspaceFolder}",
      sourceMapPathOverrides = {
        ["/__parcel_source_root/*"] = "${webRoot}/*"
      },
    },
  }
end

local dapGroup = vim.api.nvim_create_augroup("DapCompletions", { clear = true })
local dapCompletions = require'dap.ext.autocompl'
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dap-repl" },
  callback = dapCompletions.attach,
  group = dapGroup
})

require'telescope'.load_extension('dap')
