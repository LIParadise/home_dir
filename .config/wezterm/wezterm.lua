local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font settings
config.font = wezterm.font("Iosevka")
config.font_size = 14.0

-- Bell settings
config.audible_bell = "Disabled" -- Disables the system beep
config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 120,
}

-- Trigger custom command on bell (mimics command_on_bell)
wezterm.on('bell', function(window, pane)
    wezterm.background_child_process({
          'pw-play',
          '--volume', '0.56',
          wezterm.home_dir .. '/.config/kitty/gawr-gura-a-short.mp3'
    })
end)

-- Window settings (initial size in columns/rows)
config.initial_cols = 92
config.initial_rows = 28
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.87

config.scrollback_lines = 2097152

return config
