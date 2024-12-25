math.randomseed(os.time())
local wezterm = require("wezterm")
local act = wezterm.action

local function ShuffleInPlace(t)
	for i = #t, 2, -1 do
		local j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end
end

local backgrounds = {}

-- to refresh, if some wallpapers are deleted
os.execute("find /home/yosuanicolaus/Pictures/wezterm/ -type f -print > /home/yosuanicolaus/.bglist")

for f in io.lines("/home/yosuanicolaus/.bglist") do
	backgrounds[#backgrounds + 1] = {
		file = f,
		brightness = 0.035,
	}
end

ShuffleInPlace(backgrounds)

function UpdateBackgrounds(window)
	for _, item in pairs(window:mux_window():tabs_with_info()) do
		if item.is_active then
			window:set_config_overrides({
				background = {
					{
						source = {
							File = backgrounds[item.index + 1].file,
						},
						hsb = { brightness = backgrounds[item.index + 1].brightness },
					},
				},
			})
			break
		end
	end
end

wezterm.on("update-status", UpdateBackgrounds)

return {
	font_size = 10.4,
	warn_about_missing_glyphs = false,
	window_decorations = "RESIZE",

	keys = {
		{ key = "Backspace", mods = "CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },
		{ key = "g", mods = "CTRL|SHIFT", action = wezterm.action({ EmitEvent = "trigger-vim-with-scrollback" }) },
		-- {
		-- 	mods = "CTRL|SHIFT",
		-- 	key = "b",
		-- 	action = ShuffleInPlace(backgrounds),
		-- },

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
