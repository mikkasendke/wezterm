local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.enable_wayland = true
config.max_fps = 240

config.audible_bell = "Disabled"
config.mux_enable_ssh_agent = false
config.check_for_updates = false

config.font_size = 15
config.adjust_window_size_when_changing_font_size = false
config.font = wezterm.font { family = "JetBrainsMonoNLNerdFont", weight = 400 }
-- config.font = wezterm.font { family = "Comic Shanns Mono Nerd Font Mono", weight = 400 }

config.default_prog = { "/run/current-system/sw/bin/zsh" }

config.bold_brightens_ansi_colors = false
config.hide_mouse_cursor_when_typing = true

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
    top = 15,
    left = 15,
    right = 0,
    bottom = 0,
}

local colorscheme = wezterm.get_builtin_color_schemes()["rose-pine"]
-- local colorscheme = wezterm.get_builtin_color_schemes()["tokyonight_moon"]
-- local colorscheme = wezterm.get_builtin_color_schemes()["GruvboxDarkHard"]
colorscheme.background = "202020"
-- colorscheme.background = "0a0c0e"
colorscheme.selection_bg = "555577"
config.color_schemes = { ["current-colorscheme"] = colorscheme }
config.color_scheme = "current-colorscheme"
config.inactive_pane_hsb = { brightness = .5 }

local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"
local history = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-history"

local schema = {
    options = {
        callback = history.Wrapper(sessionizer.DefaultCallback)
    },
    sessionizer.DefaultWorkspace {},
    history.MostRecentWorkspace {},

    wezterm.home_dir .. "/.nixos-config",
    wezterm.home_dir .. "/.config",
    wezterm.home_dir .. "/.config/wezterm",
    wezterm.home_dir .. "/.config/nvim",
    wezterm.home_dir .. "/.config/sway",
    wezterm.home_dir .. "/.config/waybar",
    wezterm.home_dir .. "/.config/ags",
    wezterm.home_dir .. "/dev",

    sessionizer.FdSearch { wezterm.home_dir .. "/dev" },
    wezterm.home_dir .. "/Uni",
    sessionizer.FdSearch(wezterm.home_dir .. "/Uni"),

    processing = sessionizer.for_each_entry(function(entry)
        entry.label = entry.label:gsub(wezterm.home_dir, "~")
    end)
}

config.disable_default_key_bindings = true
config.keys = {
    {
        key = "s",
        mods = "ALT",
        action = sessionizer.show(schema)
    },
    {
        key = "m",
        mods = "ALT",
        action = history.switch_to_most_recent_workspace
    },
    {
        key = "z",
        mods = "ALT",
        action = wezterm.action.TogglePaneZoomState
    },
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
    {
        key = "h",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Left" }
    },
    {
        key = "j",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Down" }
    },
    {
        key = "k",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Up" }
    },
    {
        key = "l",
        mods = "ALT",
        action = wezterm.action { ActivatePaneDirection = "Right" }
    },
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
    {
        key = "n",
        mods = "ALT",
        action = wezterm.action { ActivateTabRelative = 1 }
    },
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
    {
        key = "x",
        mods = "ALT",
        action = wezterm.action.ActivateCopyMode,
    },
    {
        key = "f",
        mods = "ALT",
        action = wezterm.action.Search { CaseSensitiveString = "" },
    },
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
