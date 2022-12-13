local M = {}

M.parse = function (path)
  local configFile = io.open(path, "r")
  if configFile == nil then
    return {}
  end

  local section
  local config = {}

  for line in io.lines(path) do
    local s, e = string.find(line, '^%b[]')
    if s then
      section = string.sub(line, s+1, e-1)
      config[section] = {}
    end

    local _,_, key, value = string.find(line, '^%s*(%S+)%s*=%s*(%S+)')
    if section and key and value then
      config[section][key] = value
    end
  end

  return config
end

return M
