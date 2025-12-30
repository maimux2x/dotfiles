-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 130
config.initial_rows = 200

-- or, changing the font size and color scheme.
config.font_size = 13
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.use_ime = true
config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end

  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- Cursor color
config.colors = {
  cursor_bg = "#FFFFFF",
  cursor_fg = "#000000",
  cursor_border = "#FFFFFF",
}

-- Key bindings
local act = wezterm.action

wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

config.leader = { key = "w", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  -- Copy mode
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  -- Split pane
  { key = "d", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "r", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") }
}

-- Finally, return the configuration to wezterm:
return config
