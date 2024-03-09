local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- config.unix_domains = {{ name = "unix" }}
-- config.default_gui_startup_args = { "connect", "unix" }

-- config.enable_wayland = true -- enabled by default

config.audible_bell = "Disabled"
config.check_for_updates = false

config.max_fps = 240

config.font = wezterm.font_with_fallback {
    { family = "Fira Mono Nerd Font",  weight = 400 },
    { family = "nonicons" } -- for the icons
}

config.font_size = 17.3

config.default_prog = {
    "/bin/zsh",
}

-- comment out if you want to have the tab bar
config.enable_tab_bar = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

config.window_decorations = "RESIZE"

config.window_padding = {
    left = 2,
    right = 0,
    top = 0,
    bottom = 0,
}

local rose_pine = wezterm.get_builtin_color_schemes()['rose-pine']
rose_pine.background = wezterm.color.get_default_colors().background

config.color_schemes = {
    ["rose-pine"] = rose_pine
}

config.color_scheme = "rose-pine"
config.window_background_opacity = 0.93

local sessionizer = require("sessionizer")

config.keys = {
    {
        key = "s",
        mods = "SUPER",
        action = wezterm.action_callback(sessionizer.toggle);
    },
    -- full screen pane
    {
        key = "z",
        mods = "SUPER",
        action = wezterm.action.TogglePaneZoomState
    },
    -- adjust pane size
    {
        key = "h",
        mods = "SUPER|SHIFT",
        action = wezterm.action{AdjustPaneSize={"Left", 2}}
    },
    {
        key = "j",
        mods = "SUPER|SHIFT",
        action = wezterm.action{AdjustPaneSize={"Down", 2}}
    },
    {
        key = "k",
        mods = "SUPER|SHIFT",
        action = wezterm.action{AdjustPaneSize={"Up", 2}}
    },
    {
        key = "l",
        mods = "SUPER|SHIFT",
        action = wezterm.action{AdjustPaneSize={"Right", 2}}
    },
    -- vertical and horizontal are reversed because wez did it that way
    -- vertical split 
    {
        key = "2",
        mods = "SUPER",
        action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}
    },
    -- horizontal split
    {
        key = "1",
        mods = "SUPER",
        action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}
    },
    -- close pane
    {
        key = "w",
        mods = "SUPER",
        action = wezterm.action{CloseCurrentPane={confirm=true}}
    },
    -- open tab 1
    {
        key = "8",
        mods = "SUPER",
        action = wezterm.action{ActivateTab=0}
    },
    -- open tab 2
    {
        key = "9",
        mods = "SUPER",
        action = wezterm.action{ActivateTab=1}
    },
    -- open tab 3
    {
        key = "0",
        mods = "SUPER",
        action = wezterm.action{ActivateTab=2}
    },
    -- move left
    {
        key = "h",
        mods = "SUPER",
        action = wezterm.action{ActivatePaneDirection="Left"}
    },
    -- move down
    {
        key = "j",
        mods = "SUPER",
        action = wezterm.action{ActivatePaneDirection="Down"}
    },
    -- move up
    {
        key = "k",
        mods = "SUPER",
        action = wezterm.action{ActivatePaneDirection="Up"}
    },
    -- move right
    {
        key = "l",
        mods = "SUPER",
        action = wezterm.action{ActivatePaneDirection="Right"}
    },
    -- rotate panes
    {
        key = "r",
        mods = "SUPER",
        action = wezterm.action.RotatePanes "Clockwise"
    },
    {
        key = "r",
        mods = "SUPER|SHIFT",
        action = wezterm.action.RotatePanes "CounterClockwise"
    },
    -- next tab
    {
        key = "]",
        mods = "SUPER",
        action = wezterm.action{ActivateTabRelative=1}
    },
    -- previous tab
    {
        key = "[",
        mods = "SUPER",
        action = wezterm.action{ActivateTabRelative=-1}
    },
}

return config
