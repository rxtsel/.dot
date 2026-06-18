local helpers = require("utils.helpers")
local wezterm = require("wezterm")

local M = {}

function M.setup(config)
	-- Tab title
	wezterm.on("format-tab-title", function(tab, _, _, cfg, _, _)
		local tab_bar_palette = cfg.resolved_palette.tab_bar
		local palette = cfg.resolved_palette

		local index = tab.tab_index + 1
		local title = tab.active_pane.title
		if title == "" then
			title = "shell"
		end

		if tab.is_active then
			return {
				{ Background = { Color = "fdf5e2" } },
				{ Foreground = { Color = tab_bar_palette.background } },
				{ Text = "" },
				{ Background = { Color = "fdf5e2" } },
				{ Foreground = { Color = palette.ansi[4] } },
				{ Attribute = { Intensity = "Bold" } },
				{ Text = string.format(" %d ", index) },
				{ Background = { Color = palette.ansi[4] } },
				{ Foreground = { Color = "fdf5e2" } },
				{ Text = "" },
				{ Background = { Color = palette.ansi[4] } },
				{ Foreground = { Color = "fdf5e2" } },
				{ Text = " " .. title .. " " },
				{ Background = { Color = tab_bar_palette.background } },
				{ Foreground = { Color = palette.ansi[4] } },
				{ Text = "" },
			}
		end

		return {
			{ Background = { Color = tab_bar_palette.background } },
			{ Foreground = { Color = palette.ansi[8] } },
			{ Text = " " .. index .. " " },
			{ Foreground = { Color = palette.ansi[8] } },
			{ Text = "" },
			{ Foreground = { Color = palette.ansi[8] } },
			{ Text = " " .. title .. " " },
		}
	end)

	config.colors = {
		tab_bar = {
			background = helpers.tab_bar_bg,
		},
	}
end

return M
