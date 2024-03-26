local wt = require 'wezterm'

local config = {}

if wt.config_builder then
  config = wt.config_builder()
end

config.term = 'wezterm'
config.color_scheme = 'Andromeda'
config.font = wt.font 'Hack Nerd Font Mono'
config.underline_position = '-3'
config.send_composed_key_when_left_alt_is_pressed = true
config.window_padding = {
  left = 3,
  right = 3,
  top = 3,
  bottom = 0,
}

config.keys = {
  {
    key = 'b',
    mods = 'CTRL|SHIFT',
    action = wt.action.EmitEvent 'toggle-transparency',
  },
  {
    key = 'w',
    mods = 'SUPER',
    action = wt.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'SUPER|SHIFT',
    action = wt.action.CloseCurrentTab { confirm = true },
  },
}

if string.find(wt.target_triple, "darwin") ~= nil then
    require'mac-conf'(config)
else
    require'linux-conf'(config)
end

require'tabs'(config)

wt.on('toggle-transparency', function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.75
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

return config
