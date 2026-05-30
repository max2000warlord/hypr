---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "ghostty"
local browser = "zen-browser"
local fileManager = "thunar"
local menu = "rofi -show drun"
local code = "neovide"
local lock = "hyprlock"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local comboMod = "SUPER + SHIFT" -- Sets "Windows" key as main modifier
local altComboMod = "ALT + SUPER" -- Sets "Alt" + "Windows" as combo modifier
local ctrlMod = "SUPER + CTRL" -- Sets "Windows" + "Ctrl" as combo modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(browser))
hl.bind(comboMod .. " + X", hl.dsp.exec_cmd(code))
local closeWindowBind = hl.bind(comboMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(comboMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(comboMod .. " + L", hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- screencapping with grim/slurp
hl.bind(
	"CTRL + SHIFT + P",
	hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots/ -f '$(date +'%Y-%m-%d_%H-%M-%S').png'")
)
hl.bind(comboMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(
	altComboMod .. " + S",
	hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots/ -f '$(date +'%Y-%m-%d_%H-%M-%S').png'")
)
hl.bind(ctrlMod .. " + P", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(comboMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(altComboMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Swap tiles
hl.bind(comboMod .. " + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(comboMod .. " + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(comboMod .. " + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(comboMod .. " + down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + SPACE", hl.dsp.workspace.toggle_special("magic"))
hl.bind(altComboMod .. " + SPACE", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
local media_binds = {
	{ "XF86AudioRaiseVolume", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" },
	{ "XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" },
	{ "XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" },
	{ "XF86AudioMicMute", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" },
	{ "XF86MonBrightnessUp", "brightnessctl -e4 -n2 set 5%+" },
	{ "XF86MonBrightnessDown", "brightnessctl -e4 -n2 set 5%-" },
}

for _, b in ipairs(media_binds) do
	hl.bind(b[1], hl.dsp.exec_cmd(b[2]), { locked = true, repeating = true })
end

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
