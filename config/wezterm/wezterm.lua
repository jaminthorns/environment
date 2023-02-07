local wezterm = require "wezterm"
local action = wezterm.action
local mac_os = {{os_status mac-os && echo true || echo false}}
local wsl = {{os_status wsl && echo true || echo false}}

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  return tab.active_pane.title
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_config = tab.is_active and "active_tab" or "inactive_tab"
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
  front_end = "WebGpu",

  -- Tab Bar
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
    foreground = "#f8f8f2",
    background = "#282a36",
    cursor_fg = "black",
    cursor_bg = "white",
    cursor_border = "white",
    selection_fg = "white",
    selection_bg = "#44475a",
    ansi = { "#21222c", "#ff5555", "#50fa7b", "#f1fa8c", "#bd93f9", "#ff79c6", "#8be9fd", "#f8f8f2" },
    brights = { "#6272a4", "#ff6e6e", "#69ff94", "#ffffa5", "#d6acff", "#ff92df", "#a4ffff", "#ffffff" },
    tab_bar = {
      background = "#282a36",
      active_tab = { bg_color = "#ffffff", fg_color = "#21222c", intensity = "Bold" },
      inactive_tab = { bg_color = "#6272a4", fg_color = "#21222c" },
    }
  },

  keys = {
    -- Cursor Control
    { key = "LeftArrow", mods = "{{modifier_key upper}}", action = action.SendString("\x01") },
    { key = "RightArrow", mods = "{{modifier_key upper}}", action = action.SendString("\x05") },
    { key = "Backspace", mods = "{{modifier_key upper}}", action = action.SendString("\x15") },
    { key = "UpArrow", mods = "{{modifier_key upper}}", action = action.SendString("\x1b[1;5H") },
    { key = "DownArrow", mods = "{{modifier_key upper}}", action = action.SendString("\x1b[1;5F") },

    -- Tab/Pane Control
    { key = "n", mods = "CTRL|SHIFT", action = action.SpawnTab("DefaultDomain") },
    { key = "w", mods = "CTRL|SHIFT", action = action.CloseCurrentPane({ confirm = false }) },
    { key = "|", mods = "CTRL|SHIFT", action = action.SplitHorizontal({ domain = "DefaultDomain" }) },
    { key = "{", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Prev") },
    { key = "}", mods = "CTRL|SHIFT", action = action.ActivatePaneDirection("Next") },
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = action.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = action.ActivateTabRelative(1) },

    -- Miscellaneous
    { key = "Enter", mods = "ALT", action = action.SendKey({ key = "Enter", mods = "ALT" }) },
    { key = "k", mods = "{{modifier_key upper}}", action = action.Multiple { action.ClearScrollback("ScrollbackAndViewport"), action.SendKey({ key = "l", mods = "CTRL" }) } },
  },
}

if wsl then
  config.default_domain = "WSL:Ubuntu"
  config.wsl_domains = { { name = "WSL:Ubuntu", distribution = "Ubuntu", default_cwd = "~" } }
end

return config
