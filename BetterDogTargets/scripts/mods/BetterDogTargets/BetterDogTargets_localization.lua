local mod = get_mod("Better Dog Targets")
local InputUtils = require("scripts/managers/input/input_utils")

local localizations = {
	mod_description = {
		en = "Changes the color of the pings dog targets to be the local color assigned to the player, so you can see who has set their dog to which targets.",
	},
	player_1_color = {
		en = "Player Slot 1 Color"
	},
	player_2_color = {
		en = "Player Slot 2 Color"
	},
	player_3_color = {
		en = "Player Slot 3 Color"
	},
	player_4_color = {
		en = "Player Slot 4 Color"
	},
	hide_markers = {
		en = "Hide HUD Markers"
	},
	recolor_markers = {
		en = "Recolor HUD Markers"
	},
}

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
    local color_values = Color[color_name](255, true)
    local text = InputUtils.apply_color_to_input_text(readable(color_name), color_values)
    localizations[color_name.."_color_option"] = {
        en = text
    }
end

return localizations
