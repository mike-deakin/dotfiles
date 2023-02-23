local telescope = require('telescope')
local builtin = require('telescope.builtin')
telescope.load_extension('fzf')
telescope.load_extension('packer')

local M = {}

M.project_files = function()
  local ok = pcall(builtin.git_files, {hidden = true})
  if not ok then builtin.find_files() end
end

return M

