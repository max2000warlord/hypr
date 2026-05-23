if hl.plugin.hyprglass then
	local hg = hl.plugin.hyprglass

	hg.config({
		default_theme = "dark",
		default_preset = "blurry",
	})

	-- Layers
	local glass = { "ghostty", "glava", "neovide", "rofi" }

	for _, hgl in ipairs(glass) do
		hg.layer(hgl, { preset = "blurry" })
	end

	-- Custom preset overriding built-in "blurry"
	hg.preset("blurry", {
		blur_strength = 0.4,
		blur_iterations = 3,
		vibrancy = 0.1696,
		refraction_strength = 1.5,
		lens_distortion = 1,
	})

	hg.preset("contrasted", {
		inherits = "high_contrast",
		contrast = 1.2,
		adaptive_dim = 1.5,
		dark = { tint_color = 0x02142aa9 },
	})
end

-- hl.config({
-- 	plugin = {
-- 		hyprexpo = {
-- 			columns = 3,
-- 			gap_size = 5,
-- 			gap_size_outer = 0,
-- 			bg_col = "rgb(111111)",
-- 			workspace_method = "center current",
-- 			skip_empty = false,
-- 			max_workspace = 0,
-- 			show_workspace_numbers = false,
-- 			workspace_number_color = "rgb(ffffff)",
-- 			window_icon_enable = false,
-- 			window_icon_position = "bottom-right",
-- 			window_icon_size = 32,
-- 			label_enable = false,
-- 			label_text_mode = "id",
-- 			label_token_map = "",
-- 			selection_label_enable = false,
-- 			selection_label_token_map = "a,s,d,f,g,q,w,e,r,t,z,x,c,v,b",
-- 			gesture_distance = 300,
-- 			cancel_key = "escape",
-- 		},
-- 	},
-- })

hl.bind("SUPER + g", function()
	hl.plugin.hyprexpo.expo("toggle")
end)
