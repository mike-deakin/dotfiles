local wt = require 'wezterm'

local config = {}

if wt.config_builder then
  config = wt.config_builder()
end

config.term = 'wezterm'
config.color_scheme = 'Andromeda'
config.font = wt.font 'Hack Nerd Font Mono'
config.font_size = 11
config.underline_position = '-3'
config.send_composed_key_when_left_alt_is_pressed = true

wt.on('toggle-transparency', function(window, _)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.75
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

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

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format('file://%s', os.getenv('HOME'))

  return current_dir == HOME_DIR and '~'
      or string.gsub(current_dir, '(.*[/\\])(.*)', '%2')
end

wt.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local has_unseen_output = false
    if not tab.is_active then
      for _, pane in ipairs(tab.panes) do
        if pane.has_unseen_output then
          has_unseen_output = true
          break
        end
      end
    end

    local cwd = wt.format({
      { Attribute = { Intensity = 'Bold' } },
      { Text = get_current_working_dir(tab) },
    })

    local title = string.format(' %d: %s ', tab.tab_id, cwd)

    if has_unseen_output then
      return {
        { Foreground = { Color = '#28719c' } },
        { Text = title },
      }
    end

    return {
      { Text = title },
    }
  end
)

return config
