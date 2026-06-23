local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.setup(config)
	-- Leader key
	config.leader = {
		key = "a",
		mods = "CTRL",
		timeout_milliseconds = 500,
	}

	-- Keymaps
	config.keys = {
		-- Pane splitting
		{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- Pane navigation
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		-- Pane zoom
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		-- Tabs
		{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
		-- Lazygit
		{ key = "g", mods = "LEADER", action = act.SpawnCommandInNewTab({ args = { "lazygit" } }) },
	}
end

return M
