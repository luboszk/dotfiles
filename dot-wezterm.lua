-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Official Catppuccin Mocha palette (catppuccin/wezterm)
local mocha = {
	foreground = "#cdd6f4",
	background = "#1e1e2e",
	cursor_bg = "#f5e0dc",
	cursor_border = "#f5e0dc",
	cursor_fg = "#11111b",
	selection_bg = "#585b70",
	selection_fg = "#cdd6f4",

	ansi = {
		"#45475a", -- black   (surface1)
		"#f38ba8", -- red
		"#a6e3a1", -- green
		"#f9e2af", -- yellow
		"#89b4fa", -- blue
		"#f5c2e7", -- magenta (pink)
		"#94e2d5", -- cyan    (teal)
		"#bac2de", -- white   (subtext1)
	},
	brights = {
		"#585b70", -- bright black   (surface2)
		"#f38ba8", -- bright red
		"#a6e3a1", -- bright green
		"#f9e2af", -- bright yellow
		"#89b4fa", -- bright blue
		"#f5c2e7", -- bright magenta
		"#94e2d5", -- bright cyan
		"#a6adc8", -- bright white   (subtext0)
	},

	indexed = {
		[16] = "#fab387", -- peach
		[17] = "#f5e0dc", -- rosewater
	},
}

return {
	font = wezterm.font("MesloLGS Nerd Font Mono", { weight = "Regular" }),
	font_size = 12,

	enable_tab_bar = false,

	colors = mocha,
	-- window_decorations = "RESIZE",
	window_background_opacity = 0.95,
	macos_window_background_blur = 20,

	-- default_prog = { "/usr/local/bin/nu" },
}
