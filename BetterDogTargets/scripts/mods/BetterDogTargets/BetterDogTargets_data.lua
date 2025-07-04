local mod = get_mod("Better Dog Targets")

local colorOptions = {}

local function readable(text)
    local readable_string = ""
    local tokens = string.split(text, "_")
    for i, token in ipairs(tokens) do
        local first_letter = string.sub(token, 1, 1)
        token = string.format("%s%s", string.upper(first_letter), string.sub(token, 2))
        readable_string = string.trim(string.format("%s %s", readable_string, token))
    end

    return readable_string
end

local color_names = Color.list
for i, color_name in ipairs(color_names) do
	local entry = {
		text = color_name.."_color_option",
		value = color_name,
	}
	colorOptions[i] = entry
end
table.sort(colorOptions, function(a, b)
	return a.value < b.value
end)

return {
	name = "Better Dog Targets",
	description = mod:localize("mod_description"),
	allow_rehooking = true,
	options = {
		widgets = {
			{
				setting_id = "player_1_color",
				type = "dropdown",
				default_value = "player_slot_1_bright",
				options = table.clone(colorOptions),
			},
			{
				setting_id = "player_2_color",
				type = "dropdown",
				default_value = "player_slot_2_bright",
				options = table.clone(colorOptions),
			},
			{
				setting_id = "player_3_color",
				type = "dropdown",
				default_value = "player_slot_3_bright",
				options = table.clone(colorOptions),
			},
			{
				setting_id = "player_4_color",
				type = "dropdown",
				default_value = "player_slot_4_bright",
				options = table.clone(colorOptions),
			},
			{
				setting_id = "hide_markers",
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = "recolor_markers",
				type = "checkbox",
				default_value = true
			},
		}
	}
}
