local M = {}

TerminalBuffer = -1

M.start_or_open_terminal = function()
  if TerminalBuffer == -1 then
    vim.cmd[[botright split]]
    vim.cmd[[terminal]]
    TerminalBuffer = vim.fn.bufnr()
  else
    vim.cmd("botright sb " .. TerminalBuffer)
  end
end

return M
