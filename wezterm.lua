local wezterm = require("wezterm")
local act = wezterm.action

return {
	font_size = 10.5,

	background = {
		{
			source = {
				File = "/home/yosuanicolaus/Pictures/wallpapers-nvchad/forest-stairs.jpg",
				-- File = "/home/yosuanicolaus/Pictures/wallpapers-nvchad/fractal-flower.jpg",
				-- File = "/home/yosuanicolaus/Pictures/wallpapers-nvchad/autumn_leaves.jpg",
				-- File = "/home/yosuanicolaus/Pictures/wallpapers-nvchad/sea-ship.jpg",
				-- File = "/home/yosuanicolaus/Pictures/wallpapers-nvchad/mudaha.jpg",
			},
			hsb = { brightness = 0.05 },
		},
	},

	keys = {
		{ key = "Backspace", mods = "CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },
		{ key = "g", mods = "CTRL|SHIFT", action = wezterm.action({ EmitEvent = "trigger-vim-with-scrollback" }) },

		{
			mods = "CTRL|SHIFT",
			key = "Enter",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "CTRL|SHIFT",
			key = "|",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},

		{
			mods = "CTRL|SHIFT",
			key = "h",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "l",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "j",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "k",
			action = act.ActivatePaneDirection("Up"),
		},
	},
}
