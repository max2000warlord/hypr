--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
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
hl.window_rule({
	match = { title = "1Password" },
	float = true,
	size = "monitor_w*0.5 monitor_h*0.6",
	center = true,
})

hl.window_rule({
	match = { title = "Volume Control" },
	float = true,
	size = "monitor_w*0.35 monitor_h*0.4",
})

hl.window_rule({
	match = { class = "blueman-manager" },
	float = true,
	size = "monitor_w*0.4 monitor_h*0.4",
})

hl.window_rule({
	match = { class = "waypaper" },
	float = true,
	size = "monitor_w*0.5 monitor_h*0.5",
})

hl.window_rule({
	match = { title = "KDE Connect" },
	float = true,
})

hl.window_rule({
	match = { class = "xfce-polkit" },
	float = true,
})

-- nwg-look
hl.window_rule({
	match = { class = "nwg-look" },
	float = true,
})

hl.window_rule({
	match = { class = "sddm-conf" },
	float = true,
})

hl.window_rule({
	match = { class = "swayimg" },
	float = true,
})

hl.window_rule({
	match = { title = "Calculator" },
	float = true,
})

hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	match = { title = "jetbrains-toolbox" },
	float = true,
	center = true,
})

-- No border: Ghostty, Neovide, GLava
local noborders = { "com.mitchellh.ghostty", "neovide" }

for _, nb in ipairs(noborders) do
	hl.window_rule({
		border_size = 0,
		match = { class = nb },
	})
end

local noshadows = { "waybar", "com.mitchellh.ghostty", "neovide" }

for _, nsh in ipairs(noshadows) do
	hl.window_rule({
		match = { class = nsh },
		no_shadow = true,
	})
end

local lr = { "waybar", "rofi" }

for _, ns in ipairs(lr) do
	hl.layer_rule({
		match = { namespace = ns },
		blur = true,
	})
end
