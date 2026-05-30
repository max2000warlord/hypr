-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --all")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("~/.config/hypr/inits/wallust.sh")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar & awww-daemon &")
	hl.exec_cmd("pipewire & pipewire-pulse & wireplumber")
	hl.exec_cmd("nm-applet & blueman-applet & dunst")
	hl.exec_cmd("1password")
end)
