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
config.color_scheme = 'Tokyo Night'
config.enable_scroll_bar = true

-- No single tab
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

wezterm.on("update-right-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then stat = window:active_key_table() end
	if window:leader_is_active() then stat = "LDR" end

	local PATH_SEPARATOR = package.config:sub(1, 1)
	-- Current working directory
	local basename = function(s)
		-- Nothign a little regex can't fix
		return string.gsub(s, "(.*[" .. PATH_SEPARATOR .. "])(.*)", "%2")
	end
	local dirname = function(s)
		return string.gsub(s, "(.*[//])(.*)(/.*)", "%2")
	end
	local cwd = dirname(pane:get_current_working_dir())
	-- Current command
	local cmd = basename(pane:get_foreground_process_name())

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Status bar in the top right corner of the terminal
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		{ Text = wezterm.nerdfonts.oct_table .. " " .. stat },
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_folder .. " " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "FFB86C" } },
		{ Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. " " .. time },
		{ Text = " " },
	}))
end)

-- Fonts
config.font_size = 12
config.font = wezterm.font_with_fallback({
	{ family = "MesloLGM Nerd Font Mono", scale = 1.2 },
	{ family = "JetBrainsMono Nerd Font", scale = 1.2 },
	{ family = "UbuntuMono Nerd Font", scale = 1.2 },
})
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"

-- Keys
config.leader = {key = "w", mods = "CTRL", timeout_milliseconds = 1000 }

-- Mouse
config.hide_mouse_cursor_when_typing = true
config.default_cursor_style = 'SteadyUnderline'

-- and finally, return the configuration to wezterm
return config
