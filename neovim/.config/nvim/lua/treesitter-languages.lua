local ts_install = function (language)
  vim.cmd([[TSInstall ]] .. language)
end

local languages = {
  'bash',
  'c',
  'elixir',
  'go',
  'graphql',
  'haskell',
  'hcl',
  'java',
  'javascript',
  'kotlin',
  'lua',
  'python',
  'query',
  'rust',
  'tsx',
  'typescript',
  'vim',
}

for _, lang in ipairs(languages) do
  ts_install(lang)
end
