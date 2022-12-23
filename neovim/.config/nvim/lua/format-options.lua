local dotconf = require('dotconf')

local M = {}

local editorConfigOptionKeys = {
  insertSpaces = "indent_style",
  tabSize = "tab_width",
  trimTrailingWhitespace = "trim_trailing_whitespace",
  insertFinalNewline = "insert_final_newline",
}

local editorConfigMappings = {
  ["indent_style"] = {
    key = "insertSpaces",
    typeCast = function (opt)
      return opt == "space"
    end
  },
  ["tab_width"] = {
    key = "tabSize",
    typeCast = tonumber,
  },
  ["trim_trailing_whitespace"] = {
    key = "trimTrailingWhitespace",
    typeCast = function (opt)
      return opt == "true"
    end
  },
  ["insert_final_newline"] = {
    key = "insertFinalNewline",
    typeCast = function (opt)
      return opt == "true"
    end
  },
}

local function squashMatch(config)
  local options = {}
  for key, value in pairs(config) do
    local pattern = vim.fn.glob2regpat(key)
    if string.match(vim.api.nvim_buf_get_name(0), pattern) then
      for edconfname, lspinfo in pairs(editorConfigMappings) do
        options[lspinfo.key] = lspinfo.typeCast(value[edconfname])
      end
      --for lspname, edconfname in pairs(editorConfigOptionKeys) do
        --options[lspname] = value[edconfname]
      --end
    end
  end
  return options
end

M.loadEditorconfigOptions = function()
  local configPath = vim.fn.getcwd() .. "/.editorconfig" -- TODO: also scan for files in lsp workspace

  local config = dotconf.parse(configPath)
  return config and squashMatch(config)
end

M.lspFormat = function(formatting_options, vim_lsp_options)
  formatting_options = formatting_options or {}
  vim_lsp_options = vim_lsp_options or {}
  vim_lsp_options.formatting_options = formatting_options

  vim.lsp.buf.format(vim_lsp_options)
end

M.editorconfigLspFormat = function (options)
  M.lspFormat(M.loadEditorconfigOptions(), options)
end

return M
