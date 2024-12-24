local M = {}

TerminalBuffer = -1

M.bufexists = function(buf)
  return vim.fn.bufexists(buf) == 1
end

M.start_or_open_terminal = function()
  if TerminalBuffer == -1 or not M.bufexists(TerminalBuffer) then
    vim.cmd[[botright split]]
    vim.cmd[[terminal]]
    TerminalBuffer = vim.fn.bufnr()
  else
    vim.cmd("botright sb " .. TerminalBuffer)
  end
end

return M
