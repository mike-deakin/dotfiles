local ts_install = function (language)
  vim.cmd([[TSInstall ]] .. language)
end

local languages = {
  'bash',
  'c',
  'elixir',
  'haskell',
  'lua',
  'python',
  'vim',
}

for _, lang in ipairs(languages) do
  ts_install(lang)
end
