local wezterm = require("wezterm")

local selected_scheme = "nord"
local scheme = wezterm.get_builtin_color_schemes()[selected_scheme]

local C_ACTIVE_BG = scheme.selection_bg
local C_ACTIVE_FG = scheme.ansi[6]
local C_BG = scheme.background
local C_HL_1 = scheme.ansi[5]
local C_HL_2 = scheme.ansi[4]
local C_INACTIVE_FG
local bg = wezterm.color.parse(scheme.background)
local h, s, l, a = bg:hsla()
if l > 0.5 then
	C_INACTIVE_FG = bg:complement_ryb():darken(0.3)
else
	C_INACTIVE_FG = bg:complement_ryb():lighten(0.3)
end

scheme.tab_bar = {
	background = C_BG,
	new_tab = {
		bg_color = C_BG,
		fg_color = C_HL_2,
	},
	active_tab = {
		bg_color = C_ACTIVE_BG,
		fg_color = C_ACTIVE_FG,
	},
	inactive_tab = {
		bg_color = C_BG,
		fg_color = C_INACTIVE_FG,
	},
	inactive_tab_hover = {
		bg_color = C_BG,
		fg_color = C_INACTIVE_FG,
	},
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	if tab.is_active then
		return {
			{ Foreground = { Color = C_HL_1 } },
			{ Text = " " .. tab.tab_index + 1 },
			{ Foreground = { Color = C_HL_2 } },
			{ Text = ": " },
			{ Foreground = { Color = C_ACTIVE_FG } },
			{ Text = tab.active_pane.title .. " " },
			{ Background = { Color = C_BG } },
			{ Foreground = { Color = C_HL_1 } },
			{ Text = "|" },
		}
	end
	return {
		{ Foreground = { Color = C_HL_1 } },
		{ Text = " " .. tab.tab_index + 1 },
		{ Foreground = { Color = C_HL_2 } },
		{ Text = ": " },
		{ Foreground = { Color = C_INACTIVE_FG } },
		{ Text = tab.active_pane.title .. " " },
		{ Foreground = { Color = C_HL_1 } },
		{ Text = "|" },
	}
end)

return {
	color_schemes = {
		[selected_scheme] = scheme,
	},
	color_scheme = selected_scheme,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	font = wezterm.font("JetBrainsMono Nerd Font Propo"),
	hide_tab_bar_if_only_one_tab = true,
	command_palette_bg_color = "#3B4252",
}
