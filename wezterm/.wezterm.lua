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
	use_fancy_tab_bar = false,
}
