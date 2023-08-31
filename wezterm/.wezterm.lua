local wt = require'wezterm'

local config = {}

if wt.config_builder then
    config = wt.config_builder()
end

config.term = 'wezterm'
--config.color_scheme = 'Afterglow'
config.color_scheme = 'Andromeda'
--config.window_background_opacity = 1.0
config.font = wt.font 'Hack Nerd Font Mono'
config.font_size = 13

wt.on('toggle-transparency', function (window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.75
  else
    overrides.window_background_opacity = nil
  end
end)


config.keys = {
  {
    key = 'B',
    mods = 'CTRL',
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

return config
