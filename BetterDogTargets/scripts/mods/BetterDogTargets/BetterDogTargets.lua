local mod = get_mod("BetterDogTargets")
local UISettings = require("scripts/settings/ui/ui_settings")

local OutlineSettings

function UpdateOutlineSettings()
	if not OutlineSettings then return
	end
	
	local orig = OutlineSettings.MinionOutlineExtension.adamant_smart_tag
	for i = 1, 4 do
		local no = table.clone(orig)
		local c
		if not mod:get("use_dim_colors") then
			c = Color["player_slot_"..i.."_bright"](255, true)
		else
			c = Color["player_slot_"..i](255, true)
		end
		no.color[1] = c[2] / 255.0
		no.color[2] = c[3] / 255.0
		no.color[3] = c[4] / 255.0
		OutlineSettings.MinionOutlineExtension["adamant_smart_tag"..i] = no
	end
end

function on_setting_changed()
	UpdateOutlineSettings()
end

mod:hook_require("scripts/settings/outline/outline_settings", function(instance)
	OutlineSettings = instance
	UpdateOutlineSettings()
end)

mod:hook_require("scripts/settings/smart_tag/smart_tag_settings", function(instance)
	local template = instance.templates.enemy_companion_target;
	if template then
		for i = 1, 4 do
			local nt = table.clone(template)
			nt.name = template.name..i
			nt.target_unit_outline = template.target_unit_outline..i
			instance.templates[nt.name] = nt
		end
	end
end)

mod:hook_require("scripts/extension_systems/smart_tag/smart_tag_system", function(instance)
	mod:hook(instance, "_create_tag_locally", function(func, self, tag_id, template_name, tagger_unit, target_unit, target_location, replies, is_hotjoin_synced)
		if (template_name == "enemy_companion_target") then
			local player = Managers.state.player_unit_spawn:owner(tagger_unit)
			local playerSlot = player and player.slot and player:slot()
			if playerSlot then
				template_name = template_name..playerSlot
			end
		end
		
		return func(self, tag_id, template_name, tagger_unit, target_unit, target_location, replies, is_hotjoin_synced)
	end)
end)
