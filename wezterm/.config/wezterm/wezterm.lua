local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font" })
config.font_rules = {
  {
    italic = true,
    font = wezterm.font_with_fallback({ "JetBrains Mono" }),
  },
}
config.font_size = 16.0
-- If you want to disable ligatures in most fonts, then you may want to use a setting like this:
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.keys = {
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
}
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

return config
