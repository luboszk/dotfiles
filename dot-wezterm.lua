-- Pull in the wezterm API
local wezterm = require("wezterm")

return {
	font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Regular" }),
	font_size = 12,

	enable_tab_bar = false,

	color_scheme = "Catppuccin Mocha",
	-- window_decorations = "RESIZE",
	window_background_opacity = 0.75,
	macos_window_background_blur = 10,

	-- default_prog = { "/usr/local/bin/nu" },
}
