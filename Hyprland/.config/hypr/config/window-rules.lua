-- Ignore maximize requests from apps.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- CUSTOM WINDOW RULES ------------------------------------------------
-- hl.window_rule({ match = { class = ".*" }, opacity = "0.95 0.95" })
hl.window_rule({ match = { class = "nwg-look", title = "nwg-look" }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })
hl.window_rule({
    match = { class = "zen", title = "Sign in – Google accounts — Zen Browser" },
    float = true,
})
hl.window_rule({ match = { class = "thunar", title = "File Operation Progress" }, float = true })
hl.window_rule({ match = { class = "Vivaldi-stable", title = "Vivaldi Settings:.*" }, float = true })
hl.window_rule({
    match = { class = "Vivaldi-stable", title = "Vivaldi Settings: Display All - Vivaldi" },
    float = true,
})
