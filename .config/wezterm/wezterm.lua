local wezterm = require("wezterm")
local helpers = require("utils.helpers")
local config = wezterm.config_builder()

require("utils.tab_bar").setup(config)
require("utils.keymaps").setup(config)

-- Appearance
config.color_scheme = helpers.color_scheme
config.window_background_opacity = 0.65
config.window_decorations = "RESIZE | NONE"
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Font
config.font = wezterm.font("DankMono Nerd Font")
config.font_size = 17

-- Terminal
config.term = "wezterm"
config.scrollback_lines = 10000
config.cursor_blink_rate = 0

-- Miscellaneous
config.check_for_updates = false
config.adjust_window_size_when_changing_font_size = false

return config
