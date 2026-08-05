hl.on("hyprland.start", function()
    -- SYSTEM
    hl.exec_cmd("/usr/libexec/polkit-mate-authentication-agent-1")
    hl.exec_cmd("polkit-agent-helper-1")
    hl.exec_cmd("systemctl start --user polkit-mate-authentication-agent-1")

    -- -- DESKTOP
    -- hl.exec_cmd("hypridle")
    hl.exec_cmd("noctalia")
end)
