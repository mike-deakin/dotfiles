local M = {}

local ts_utils_status, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
local ts_locals_status, ts_locals = pcall(require, 'nvim-treesitter.ts_utils')

if not ts_utils_status or not ts_locals_status then
  return false
end

local function get_scope_parent()
    local cursor_node = ts_utils.get_node_at_cursor()
    local cursor_scope = ts_locals.containing_scope(cursor_node, 0)

    return cursor_scope:parent()
end

local function move_to_node(node)
  local line, column = node:start()
  vim.fn.cursor(line + 1, column + 1)
end

local function move_to_node_end(node)
  local line, column = node:end_()
  vim.fn.cursor(line + 1, column + 1)
end

M.scope_start = function()
  move_to_node(get_scope_parent())
end

M.scope_end = function()
  move_to_node_end(get_scope_parent())
end

M.next_sibling = function()
  local sibling_node = ts_utils.get_node_at_cursor():next_sibling()
  move_to_node(sibling_node)
end

M.prev_sibling = function()
  local sibling_node = ts_utils.get_node_at_cursor():prev_sibling()
  move_to_node(sibling_node)
end

return M
