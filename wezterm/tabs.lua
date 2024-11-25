local wt = require 'wezterm'

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir.file_path
  local HOME_DIR = os.getenv('HOME')
  local dirname = string.gsub(current_dir, '(.*[/\\])(.*)', '%2')

  if string.len(dirname) > 12 then
    dirname = string.gsub(dirname, '(%w)%w*[-_ ]', '%1-')
  end

  return current_dir == HOME_DIR and '~' or dirname
end

local function tab_has_unseen_output(tab)
  if not tab.is_active then
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output == true then
        return true
      end
    end
  end
  return false
end

return function(config)
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false

  wt.on(
    'format-tab-title',
    function(tab, _tabs, _panes, _config, _hover, _max_width)
      local cwd = wt.format({
        { Attribute = { Intensity = 'Bold' } },
        { Text = get_current_working_dir(tab) },
      })

      local title = string.format(' %d: %s ', tab.tab_id, cwd)

      if tab_has_unseen_output(tab) then
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
end
