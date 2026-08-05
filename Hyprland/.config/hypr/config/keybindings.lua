local var = require("config.variables")
local mainMod = "SUPER"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(var.terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave-browser"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(var.fileManager))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(var.menu))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))              -- dwindle
-- hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next())

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind("ALT + Tab", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + u", hl.dsp.exec_cmd("hyprlock && systemctl suspend"))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Move window with mainMod + CTRL + vim keys
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "up" }))

-- Move active window to a workspace with mainMod + CTRL + [0-9]
local moveToWSMods = { "CTRL", "SHIFT" }
for _, mod in ipairs(moveToWSMods) do
    for _, i in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }) do
        hl.bind(mainMod .. " + " .. mod .. " + " .. i % 10, hl.dsp.window.move({ workspace = i }))
    end
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scr .. "/Volume.sh --inc"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scr .. "/Volume.sh --dec"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scr .. "/Volume.sh --toggle"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scr .. "/Volume.sh --toggle-mic"), { locked = true, repeating = true })
hl.bind("F9", hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })
hl.bind("F8", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- hl.bind("xf86MonBrightnessDown", hl.dsp.exec_cmd(scr .. "/Brightness.sh --dec")) -- decrease monitor brightness
-- hl.bind("xf86MonBrightnessUp", hl.dsp.exec_cmd(scr .. "/Brightness.sh --inc"))   -- increase monitor brightness

hl.bind(mainMod .. " + CTRL + SHIFT + M", function()
    for _, screen in ipairs(hl.get_monitors()) do
        -- Internal laptop panels are normally eDP-* or LVDS-*
        if screen.name:match("^eDP%-") or screen.name:match("^LVDS%-") then
            hl.monitor({
                output = screen.name,
                disabled = true,
            })
            hl.exec_cmd("pkill -x noctalia; noctalia &")
            return
        end
    end
end)
hl.bind(mainMod .. " + CTRL + SHIFT + S", function()
    hl.exec_cmd("hyprctl reload")
end)
