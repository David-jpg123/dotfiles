local theme = {
        general = {
        gaps_in     = 3,
        gaps_out    = 6,
        border_size = 1,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(555767aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 4,
            color        = 0xee1a1a1a, -- rgba(1a1a1aee)
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 2,
            vibrancy = 0,
        },
    },
}

return theme
