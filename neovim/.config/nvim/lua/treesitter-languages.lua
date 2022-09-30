local ts_install = function (language)
  vim.cmd([[TSInstall ]] .. language)
end

local languages = {
  'bash',
  'c',
  'elixir',
  'lua',
  'python',
  'vim',
  'javascript',
  'typescript',
  'jsx',
  'tsx',
}

for _, lang in ipairs(languages) do
  ts_install(lang)
end
