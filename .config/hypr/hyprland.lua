-- Environment Variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Monitors
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.33",
})

-- Autostart
hl.on("hyprland.start", function () 
    hl.exec_cmd("systemctl --user start hyprpolkitagent")    
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh")
end)

-- Master Configuration
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding       = 6,
        rounding_power = 3,
        active_opacity   = 0.9,
        inactive_opacity = 0.9,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
            -- Glow effects now support gradients in v0.56 if configured here
        },
        blur = {
            enabled   = true,
            size      = 10,
            passes    = 2,
            vibrancy  = 0.1696,
            special   = true,
        },
    },
    group = {
        groupbar = {
            disable_when_only = true, -- NEW in 0.56: Automatically hides group bar when only 1 window remains
        }
    },
    animations = {
        enabled = false,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
        focus_master_on_close = true, -- NEW in 0.56: Refines focus-switching logic when a window closes
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

-- External Files
require("modules/keybinds")
require("modules/rules")
require("modules/animations")