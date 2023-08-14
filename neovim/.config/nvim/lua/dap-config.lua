local dap = require 'dap'
local dapui = require'dapui'

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

local dapGroup = vim.api.nvim_create_augroup("DapCompletions", { clear = true })
local dapCompletions = require 'dap.ext.autocompl'
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dap-repl" },
  callback = dapCompletions.attach,
  group = dapGroup
})

require 'telescope'.load_extension('dap')
