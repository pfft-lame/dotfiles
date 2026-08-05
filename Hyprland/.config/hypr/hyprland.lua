-- Hyprland Lua config (0.55+)
-- https://wiki.hypr.land/Configuring/Start/
--
-- Each category lives in its own module under config/ and is `require`d
-- here (equivalent to the old `source` lines).

require("config.envar")
require("config.monitors")
require("config.autostart")
require("config.variables")
require("config.decorations")
require("config.input-rules")
require("config.window-rules")
require("config.keybindings")