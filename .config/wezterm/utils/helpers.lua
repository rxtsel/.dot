local wezterm = require("wezterm")

local M = {}

local function get_color_scheme()
	if wezterm.gui and wezterm.gui.get_appearance():find("Dark") then
		return "Solarized Osaka"
	end
	return "Solarized Osaka Light"
end

local function get_tab_bar_bg()
	if wezterm.gui and wezterm.gui.get_appearance():find("Dark") then
		return "002c38"
	end
	return "ede7d3"
end

M.color_scheme = get_color_scheme()
M.tab_bar_bg = get_tab_bar_bg()

return M
