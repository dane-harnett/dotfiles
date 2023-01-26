local wezterm = require("wezterm")
return {
	font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font" }),
	font_rules = {
		{
			italic = true,
			font = wezterm.font_with_fallback({ "JetBrains Mono" }),
		},
	},
	font_size = 16.0,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	keys = {
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
	use_fancy_tab_bar = false,
}
