-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Ef-Deuteranopia-Dark'
config.enable_scroll_bar = true

-- No single tab
config.hide_tab_bar_if_only_one_tab = true

-- Fonts
config.font_size = 12
config.font = wezterm.font('JetBrainsMono Nerd Font', {weight = 'Medium', italic = false})

-- Mouse
config.hide_mouse_cursor_when_typing = true
config.default_cursor_style = 'SteadyUnderline'

-- and finally, return the configuration to wezterm
return config
