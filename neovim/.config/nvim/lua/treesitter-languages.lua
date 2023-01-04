local ts_install = function (language)
  vim.cmd([[TSInstall ]] .. language)
end

local languages = {
  'query',
  'bash',
  'c',
  'elixir',
  'lua',
  'python',
  'vim',
  'javascript',
  'typescript',
  'tsx',
  'graphql',
  'hcl',
}

for _, lang in ipairs(languages) do
  ts_install(lang)
end
