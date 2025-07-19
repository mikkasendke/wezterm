local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- config.unix_domains = { { name = "unix" } }
-- config.default_gui_startup_args = { "connect", "unix" }


config.enable_wayland = true -- enabled by default
config.audible_bell = "Disabled"
config.check_for_updates = false

config.max_fps = 120 -- ignored anyway

config.font = wezterm.font_with_fallback {
    -- { family = "SF Mono Nerd Font",       weight = 400 },
    -- { family = "RobotoMonoNerdFont",      weight = 400 },
    -- { family = "Fira Mono Nerd Font", weight = 400 },
    { family = "JetBrainsMonoNLNerdFont", weight = 400 },
    -- { family = "Comic Mono",              weight = 400 },
    -- { family = "Comic Shanns Mono Nerd Font Mono", weight = 400 },
    -- { family = "IosevkaNerdFont", weight = 400 },
    -- { family = "nonicons" } -- for the icons
    { family = "Symbols Nerd Font" }
}

config.font_size = 17.3
-- config.font_size = 14.61718

config.default_prog = {
    "/run/current-system/sw/bin/zsh"
}

config.adjust_window_size_when_changing_font_size = false

config.bold_brightens_ansi_colors = false

config.hide_mouse_cursor_when_typing = true

-- comment out if you want to have the tab bar
config.enable_tab_bar = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 80

config.window_decorations = "TITLE | RESIZE"
-- config.window_decorations = "NONE"

config.window_padding = {
    left = 15,
    -- left = 0,
    right = 0,
    top = 15,
    -- top = 0,
    bottom = 0,
}

local colorscheme = wezterm.get_builtin_color_schemes()["rose-pine"]
-- local colorscheme = wezterm.get_builtin_color_schemes()["tokyonight_moon"]
-- local colorscheme = wezterm.get_builtin_color_schemes()["GruvboxDark"]

-- colorscheme.background = "191919"
-- colorscheme.background = "1d1d1d"
-- colorscheme.background = "101010"
colorscheme.background = "000000"
-- colorscheme.background = "1f1f1f"


colorscheme.selection_bg = "555577"

config.color_schemes = {
    ["current-colorscheme"] = colorscheme
}

config.color_scheme = "current-colorscheme"

-- config.window_background_opacity = 0.65
config.window_background_opacity = 1
local function switch_opacity(window)
    local overrides = window:get_config_overrides() or {}
    if overrides.window_background_opacity == 1 then
        overrides.window_background_opacity = 0.65
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

-- local sessionizer = require("sessionizer")


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
    -- {
    --     key = "s",
    --     mods = "ALT",
    --     action = wezterm.action_callback(sessionizer.toggle),
    -- },
    -- {
    --     key = "m",
    --     mods = "ALT",
    --     action = wezterm.action_callback(sessionizer.goto_most_recent),
    -- },
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

local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"
local history = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-history"


local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

table.insert(config.keys, {
    key = "g",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
    end),
})

local schema = {
    options = {
        callback =                                       -- function(window, pane, id, label)
            history.Wrapper(sessionizer.DefaultCallback) --(window, pane, id, label)
        -- local opts = {
        --     relative = true,
        --     restore_text = true,
        --     on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        --     close_open_tabs = true,
        --     window = (wezterm.gui.gui_windows()[1]):mux_window(),
        -- }
        -- local state = resurrect.state_manager.load_state(id, "workspace")
        -- resurrect.workspace_state.restore_workspace(state, opts)
        -- end
    },
    sessionizer.DefaultWorkspace {},
    history.MostRecentWorkspace {},

    wezterm.home_dir .. "/dev",
    wezterm.home_dir .. "/.nixos-config",
    wezterm.home_dir .. "/.config",
    wezterm.home_dir .. "/.config/wezterm",
    wezterm.home_dir .. "/.config/nvim",
    wezterm.home_dir .. "/.config/sway",
    wezterm.home_dir .. "/.config/waybar",
    wezterm.home_dir .. "/.config/ags",
    wezterm.home_dir .. "/Uni",

    sessionizer.FdSearch { wezterm.home_dir .. "/dev" },
    sessionizer.FdSearch(wezterm.home_dir .. "/Uni"),

    processing = sessionizer.for_each_entry(function(entry)
        entry.label = entry.label:gsub(wezterm.home_dir, "~")
    end)
}

-- local schemaStyled = {
--     options = { callback = history.Wrapper(sessionizer.DefaultCallback), prompt = "Choose workspace: ", title = "no one can see this" },
--     sessionizer.DefaultWorkspace {},
--     history.MostRecentWorkspace {},
--     {
--         wezterm.home_dir .. "/dev",
--         wezterm.home_dir .. "/.nixos-config",
--         wezterm.home_dir .. "/.config/wezterm",
--         wezterm.home_dir .. "/.config/nvim",
--         wezterm.home_dir .. "/.config/sway",
--         wezterm.home_dir .. "/.config/waybar",
--         wezterm.home_dir .. "/.config/ags",
--         processing = sessionizer.for_each_entry(function(entry)
--             entry.label = wezterm.format {
--                 { Foreground = { Color = "#777777" } },
--                 { Text = "cfg: " .. entry.label },
--             }
--         end)
--     },
--     {
--         sessionizer.FdSearch(wezterm.home_dir .. "/dev"),
--         processing = sessionizer.for_each_entry(function(entry)
--             entry.label = wezterm.format {
--                 { Foreground = { Color = "#f05133" } },
--                 { Text = "git: " .. entry.label },
--             }
--         end)
--     },
--     {
--         wezterm.home_dir .. "/Uni",
--         sessionizer.FdSearch(wezterm.home_dir .. "/Uni"),
--         processing = sessionizer.for_each_entry(function(entry)
--             entry.label = wezterm.format {
--                 { Foreground = { Color = "#2277dd" } },
--                 { Text = "uni: " .. entry.label },
--             }
--         end)
--     },
--
--     processing = sessionizer.for_each_entry(function(entry)
--         entry.label = entry.label:gsub(wezterm.home_dir, "~")
--     end)
-- }
--
-- local schemaReplica = {
--     options = {
--         prompt = "Workspace to switch: ",
--         callback = history.Wrapper(sessionizer.DefaultCallback)
--     },
--     {
--         sessionizer.AllActiveWorkspaces { filter_current = false, filter_default = false },
--         processing = sessionizer.for_each_entry(function(entry)
--             entry.label = wezterm.format {
--                 { Foreground = { Color = "#88cc99" } },
--                 { Text = "󱂬 : " .. entry.label },
--             }
--         end)
--     },
--     wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-zoxide.git".Zoxide {},
--     processing = sessionizer.for_each_entry(function(entry)
--         entry.label = entry.label:gsub(wezterm.home_dir, "~")
--     end),
-- }

local schema2 = {
    options = {
        prompt = "Switch branch to: ",
        callback = function(win, pane, id, label)
            local success, out, err = wezterm.run_child_process { "git", "-C", pane:get_current_working_dir().file_path, "switch", id }
            -- wezterm.log_info("path: ", "(" .. pane:get_current_working_dir().file_path .. ")")
            -- wezterm.log_info("err: ", err)
            -- wezterm.log_info("out: ", out)
            -- wezterm.log_info("id: ", "(" .. id .. ")")
        end
    },
    function()
        local path = ""
        for k, v in pairs(wezterm.mux.all_windows()) do
            if wezterm.mux.get_active_workspace() == v:get_workspace() then
                path = v:active_pane():get_current_working_dir().file_path
            end
        end

        local success, out, err = wezterm.run_child_process { "git", "-C", path, "branch", "-l" }
        local s, current, e = wezterm.run_child_process { "git", "-C", path, "branch", "--show-current" }
        current = current:gsub("\n", "")
        local entries = {}

        for line in out:gmatch "[^\n]+" do
            line = line:gsub(" ", "")
            line = line:gsub("*", "")
            local entry

            wezterm.log_info("line: ", "(" .. line .. ")")
            wezterm.log_info("current: ", "(" .. current .. ")")
            if line == current then
                table.insert(entries, 1, {
                    label = wezterm.format {
                        { Foreground = { Color = "#4466ff" } },
                        { Text = "current: " .. line },
                    },
                    id = line
                })
            else
                entry = { label = line, id = line }
                table.insert(entries, entry)
            end
        end
        return entries
    end
}

table.insert(config.keys, {
    key = "s",
    mods = "ALT",
    action = sessionizer.show(schema)
})

table.insert(config.keys, {
    key = "e",
    mods = "ALT",
    action = sessionizer.show(schema2)
})
--
-- table.insert(config.keys, {
--     key = "d",
--     mods = "ALT",
--     action = sessionizer.show(schemaStyled)
-- })
--
-- table.insert(config.keys, {
--     key = "g",
--     mods = "ALT",
--     action = sessionizer.show(schemaReplica)
-- })
-- local e = { options = { always_fuzzy = false, callback = schemaReplica.options.callback }, schemaReplica }
-- table.insert(config.keys, {
--     key = "h",
--     mods = "ALT",
--     action = sessionizer.show(e)
-- })

table.insert(config.keys, {
    key = "m",
    mods = "ALT",
    action = history.switch_to_most_recent_workspace
})


return config
