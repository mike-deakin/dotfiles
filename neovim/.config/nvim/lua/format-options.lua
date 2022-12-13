local dotconf = require('dotconf')

local M = {}

local editorConfigOptionKeys = {
  insertSpaces = "indent_style",
  tabSize = "tab_width",
  trimTrailingWhitespace = "trim_trailing_whitespace",
  insertFinalNewline = "insert_final_newline",
}

local function squashMatch(config)
  local options = {}
  for key, value in pairs(config) do
    local pattern = vim.fn.glob2regpat(key)
    if string.match(vim.api.nvim_buf_get_name(0), pattern) then
      for lspname, edconfname in pairs(editorConfigOptionKeys) do
        options[lspname] = value[edconfname]
      end
    end
  end
  return options
end

M.loadEditorconfigOptions = function()
  local cwd = vim.fn.getcwd()
  local configPath = cwd .. "/.editorconfig" -- TODO: also scan for files in lsp workspace

  return squashMatch(dotconf.parse(configPath))
end

M.lspFormat = function(options)
  options = options or {}

  vim.lsp.buf.format({ formatting_options = options, async = true })
end

M.editorconfigLspFormat = function ()
  M.lspFormat(M.loadEditorconfigOptions())
end

return M
