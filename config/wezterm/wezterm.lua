local wezterm = require "wezterm"
local action = wezterm.action
local mac_os = {{os_status mac-os && echo true || echo false}}
local wsl = {{os_status wsl && echo true || echo false}}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_config = tab.is_active and "active_tab" or hover and "inactive_tab_hover" or "inactive_tab"
  local cap_bg_color = config.colors.tab_bar.background
  local cap_fg_color = config.colors.tab_bar[tab_config].bg_color

  return {
    { Background = { Color = cap_bg_color } },
    { Foreground = { Color = cap_fg_color } },
    { Text = "" },
    "ResetAttributes",
    { Text = " " .. tab.active_pane.title .. " " },
    "ResetAttributes",
    { Background = { Color = cap_bg_color } },
    { Foreground = { Color = cap_fg_color } },
    { Text = "" },
  }
end)

local config = {
  initial_cols = 100,
  initial_rows = 25,
  max_fps = 144,
  alternate_buffer_wheel_scroll_speed = 1,
  audible_bell = "Disabled",
  window_close_confirmation = "NeverPrompt",
  inactive_pane_hsb = { brightness = 0.75 },
  front_end = wsl and "OpenGL" or "WebGpu",

  -- Tab bar
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  show_new_tab_button_in_tab_bar = false,
  show_tab_index_in_tab_bar = false,
  tab_max_width = 100,

  -- Fonts
  font_size = mac_os and 12 or 9,
  bold_brightens_ansi_colors = false,
  font = wezterm.font("JetBrains Mono"),
  font_rules = {
    { intensity = "Bold", italic = false, font = wezterm.font("JetBrains Mono Bold") },
    { intensity = "Normal", italic = true, font = wezterm.font("JetBrains Mono Italic") },
    { intensity = "Bold", italic = true, font = wezterm.font("JetBrains Mono Bold Italic") },
  },

  -- Colors
  colors = {
    foreground = "#F8F8F2",
    background = "#282A36",
    cursor_fg = "black",
    cursor_bg = "white",
    cursor_border = "white",
    selection_fg = "white",
    selection_bg = "#44475A",
    ansi = { "#21222C", "#FF5555", "#50FA7B", "#F1FA8C", "#BD93F9", "#FF79C6", "#8BE9FD", "#F8F8F2" },
    brights = { "#6272A4", "#FF6E6E", "#69FF94", "#FFFFA5", "#D6ACFF", "#FF92DF", "#A4FFFF", "#FFFFFF" },
    tab_bar = {
      background = "#282A36",
      active_tab = { bg_color = "#F8F8F2", fg_color = "#21222C", intensity = "Bold" },
      inactive_tab = { bg_color = "#6272A4", fg_color = "#21222C", intensity = "Bold" },
      inactive_tab_hover = { bg_color = "#B0B8D1", fg_color = "#21222C", intensity = "Bold" },
    }
  },

  keys = {
    -- Tab/pane control
    { key = "n", mods = "CTRL|SHIFT", action = action.SpawnTab("DefaultDomain") },
    { key = "w", mods = "CTRL|SHIFT", action = action.CloseCurrentPane({ confirm = false }) },
    { key = "|", mods = "CTRL|SHIFT", action = action.SplitHorizontal({ domain = "DefaultDomain" }) },
    { key = "{", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Prev") },
    { key = "}", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Next") },
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = action.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = action.ActivateTabRelative(1) },

    -- Screen/cursor control
    { key = "k", mods = "{{command_key upper}}", action = action.Multiple { action.ClearScrollback("ScrollbackAndViewport"), action.SendKey({ key = "l", mods = "CTRL" }) } },
    { key = "LeftArrow", mods = "{{command_key upper}}", action = action.SendString("\x01") },
    { key = "RightArrow", mods = "{{command_key upper}}", action = action.SendString("\x05") },
    { key = "Backspace", mods = "{{command_key upper}}", action = action.SendString("\x15") },
    { key = "UpArrow", mods = "{{command_key upper}}", action = action.SendString("\x1b[1;5H") },
    { key = "DownArrow", mods = "{{command_key upper}}", action = action.SendString("\x1b[1;5F") },
    { key = "LeftArrow", mods = "ALT", action = action.SendString("\x1bb") },
    { key = "RightArrow", mods = "ALT", action = action.SendString("\x1bf") },
    { key = "Delete", mods = "ALT", action = action.SendString("\x1bd") },

    -- Disable fullscreen shortcut
    { key = "Enter", mods = "ALT", action = action.SendKey({ key = "Enter", mods = "ALT" }) },
  },
}

if wsl then
  config.default_domain = "WSL:Ubuntu"
end

return config
