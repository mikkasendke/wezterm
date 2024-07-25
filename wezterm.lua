local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- config.unix_domains = {{ name = "unix" }}
-- config.default_gui_startup_args = { "connect", "unix" }

config.enable_wayland = true -- enabled by default

config.audible_bell = "Disabled"
config.check_for_updates = false

config.font = wezterm.font_with_fallback {
    { family = "SF Mono", weight = 400 },
    -- { family = "RobotoMonoNerdFont", weight = 400 },
    -- { family = "Fira Mono Nerd Font", weight = 400 },
    -- { family = "JetBrainsMonoNL", weight = 400 },
    -- { family = "IosevkaNerdFont", weight = 400 },
    { family = "nonicons" } -- for the icons
}

config.font_size = 17.3

config.default_prog = {
    "/bin/zsh",
}

config.adjust_window_size_when_changing_font_size = false

config.bold_brightens_ansi_colors = false



-- comment out if you want to have the tab bar
config.enable_tab_bar = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 24

config.window_decorations = "RESIZE"

config.window_padding = {
    left = 2,
    right = 0,
    top = 0,
    bottom = 0,
}

local colorscheme = wezterm.get_builtin_color_schemes()["rose-pine"]
-- local colorscheme = wezterm.get_builtin_color_schemes()["tokyonight_moon"]
-- local colorscheme = wezterm.get_builtin_color_schemes()["Gruvbox dark, medium (base16)"]


-- colorscheme.background = wezterm.color.get_default_colors().background
colorscheme.background = "161616"
colorscheme.selection_bg = "555577"

config.color_schemes = {
    ["current-colorscheme"] = colorscheme
}

config.color_scheme = "current-colorscheme"

config.window_background_opacity = 0.85
local function switch_opacity(window)
    local overrides = window:get_config_overrides() or {}
    if overrides.window_background_opacity == 1 then
        overrides.window_background_opacity = 0.85
    else
        overrides.window_background_opacity = 1
    end
    window:set_config_overrides(overrides)
end

config.inactive_pane_hsb = {
    -- saturation = 0.1,
    -- brightness = 0.1,
}

local function toggle_tab_bar(window)
    local overrides = window:get_config_overrides() or {}
    overrides.enable_tab_bar = not overrides.enable_tab_bar
    window:set_config_overrides(overrides)
end

local sessionizer = require("sessionizer")

config.disable_default_key_bindings = true

config.keys = {
    {
        key = "o",
        mods = "ALT",
        action = wezterm.action_callback(switch_opacity),
    },
    {
        key = "t",
        mods = "ALT|SHIFT",
        action = wezterm.action_callback(toggle_tab_bar),
    },
    {
        key = "s",
        mods = "ALT",
        action = wezterm.action_callback(sessionizer.toggle),
    },
    {
        key = "m",
        mods = "ALT",
        action = wezterm.action_callback(sessionizer.goto_most_recent),
    },
    -- full screen pane
    {
        key = "z",
        mods = "ALT",
        action = wezterm.action.TogglePaneZoomState
    },
    -- adjust pane size
    {
        key = "h",
        mods = "ALT|SHIFT",
        action = wezterm.action { AdjustPaneSize = { "Left", 1 } }
    },
    {
        key = "j",
        mods = "ALT|SHIFT",
        action = wezterm.action { AdjustPaneSize = { "Down", 1 } }
    },
    {
        key = "k",
        mods = "ALT|SHIFT",
        action = wezterm.action { AdjustPaneSize = { "Up", 1 } }
    },
    {
        key = "l",
        mods = "ALT|SHIFT",
        action = wezterm.action { AdjustPaneSize = { "Right", 1 } }
    },
    -- vertical and horizontal are reversed because wez did it that way
    -- vertical split the keys are like 1, 2
    {
        key = "\"",
        mods = "ALT",
        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } }
    },
    {
        key = "2",
        mods = "ALT",
        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } }
    },
    -- horizontal split
    {
        key = "!",
        mods = "ALT",
        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } }
    },
    {
        key = "1",
        mods = "ALT",
        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } }
    },
    -- close pane
    {
        key = "w",
        mods = "ALT",
        action = wezterm.action { CloseCurrentPane = { confirm = true } }
    },
    {
        key = "q",
        mods = "ALT",
        action = wezterm.action { CloseCurrentPane = { confirm = true } }
    },
    -- those three are like 8, 9, 0
    -- open tab 1
    {
        key = "}",
        mods = "ALT",
        action = wezterm.action { ActivateTab = 0 }
    },
    {
        key = "8",
        mods = "ALT",
        action = wezterm.action { ActivateTab = 0 }
    },
    -- open tab 2
    {
        key = "]",
        mods = "ALT",
        action = wezterm.action { ActivateTab = 1 }
    },
    {
        key = "9",
        mods = "ALT",
        action = wezterm.action { ActivateTab = 1 }
    },
    -- open tab 3
    {
        key = "&",
        mods = "ALT",
        action = wezterm.action { ActivateTab = 2 }
    },
    {
        key = "0",
        mods = "ALT",
        action = wezterm.action { ActivateTab = 2 }
    },
    -- move left
    {
        key = "h",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Left" }
    },
    -- move down
    {
        key = "j",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Down" }
    },
    -- move up
    {
        key = "k",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Up" }
    },
    -- move right
    {
        key = "l",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Right" }
    },
    -- rotate panes
    {
        key = "r",
        mods = "ALT",
        action = wezterm.action.RotatePanes "Clockwise"
    },
    {
        key = "r",
        mods = "ALT|SHIFT",
        action = wezterm.action.RotatePanes "CounterClockwise"
    },
    -- next tab
    {
        key = "n",
        mods = "ALT",
        action = wezterm.action { ActivateTabRelative = 1 }
    },
    -- previous tab
    {
        key = "p",
        mods = "ALT",
        action = wezterm.action { ActivateTabRelative = -1 }
    },
    { key = "l", mods = "CTRL|ALT", action = wezterm.action.ShowDebugOverlay },
    {
        key = "t",
        mods = "ALT",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    -- copy mode
    {
        key = "x",
        mods = "ALT",
        action = wezterm.action.ActivateCopyMode,
    },
    -- search mode
    {
        key = "f",
        mods = "ALT",
        action = wezterm.action.Search { CaseSensitiveString = "" },
    },
    -- copy paste
    {
        key = "c",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CopyTo "Clipboard",
    },
    {
        key = "c",
        mods = "ALT",
        action = wezterm.action.CopyTo "Clipboard",
    },
    {
        key = "v",
        mods = "CTRL|SHIFT",
        action = wezterm.action.PasteFrom "Clipboard",
    },
    {
        key = "v",
        mods = "ALT",
        action = wezterm.action.PasteFrom "Clipboard",
    },
    {
        key = "+",
        mods = "ALT",
        action = wezterm.action.IncreaseFontSize,
    },
    {
        key = "-",
        mods = "ALT",
        action = wezterm.action.DecreaseFontSize,
    },
    -- { Don't like it
    --     key = "k",
    --     mods = "ALT",
    --     action = wezterm.action.ClearScrollback "ScrollbackOnly",
    -- },
    {
        key = "p",
        mods = "ALT|SHIFT",
        action = wezterm.action.ActivateCommandPalette,
    },
    {
        key = "u",
        mods = "ALT",
        action = wezterm.action.CharSelect,
    },
    {
        key = "i",
        mods = "ALT",
        action = wezterm.action.QuickSelect,
    },
    {
        key = "Tab",
        mods = "ALT",
        action = wezterm.action.ActivateTabRelative(1),
    },
}

return config
