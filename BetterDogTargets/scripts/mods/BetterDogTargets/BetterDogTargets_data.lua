local mod = get_mod("BetterDogTargets")

return {
	name = "Better Dog Targets",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "use_dim_colors",
				type = "checkbox",
				default_value = false,
				title = "use_dim_colors_option"
			}
		}
	}
}
