local wezterm = require("wezterm")

return {
	font_size = 10.5,

	keys = {
		{
			-- disable weird C-BS moving cursor to start in neovim;
			mods = "CTRL",
			key = "Backspace",
			action = wezterm.action.DisableDefaultAssignment,
		},

		{
			mods = "CTRL|SHIFT",
			key = "Enter",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "CTRL|SHIFT",
			key = "|",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},

		{
			mods = "CTRL|SHIFT",
			key = "h",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "l",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "j",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			mods = "CTRL|SHIFT",
			key = "k",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
	},
}
