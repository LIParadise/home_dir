local wezterm = require 'wezterm'
return {
    font = wezterm.font 'JetBrains Mono',
    font_size = 14.0,
    window_decorations = "RESIZE",
    keys = {
        { key = 'F11', mods = '', action = wezterm.action.ToggleFullScreen, },
    }
    color_scheme = "Eighties (base16)",
    scrollback_lines = 1048576,
}
