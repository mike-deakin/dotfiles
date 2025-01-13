local telescope = require('telescope')
local builtin = require('telescope.builtin')
pcall(telescope.load_extension,'fzf')
pcall(telescope.load_extension,'packer')
pcall(telescope.load_extension,'hoogle')

telescope.setup({
  pickers = {
    live_grep = {
      file_ignore_patterns = { 'node_modules', '.git', '.venv' },
      additional_args = function (_)
        return { '--hidden' }
      end,
    }
  }
})

local M = {}

M.project_files = function()
  local ok = pcall(builtin.git_files, {hidden = true})
  if not ok then builtin.find_files() end
end

return M

