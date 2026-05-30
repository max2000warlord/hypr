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
