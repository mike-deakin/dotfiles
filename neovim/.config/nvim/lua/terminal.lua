local M = {}

M.start_or_open_terminal = function(options)
  -- TODO: Verify options given
  local terminal_buffer = vim.fn.bufnr("term://") -- TODO: Check if there's a more deterministic (is there a way of confirming the buffer type?)

  if terminal_buffer == -1 then
    vim.cmd("botright split term://" .. options.shell)
  else
    vim.cmd("sb " .. terminal_buffer)
  end
end

return M
