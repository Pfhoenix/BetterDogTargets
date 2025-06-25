local mod = get_mod("Better Dog Targets")
local UISettings = require("scripts/settings/ui/ui_settings")

local OutlineSettings

local function _update_material_layers_color(unit, extension, wanted_outline_color, material_layers)
	if wanted_outline_color then
		local outline_config = extension.outline_config

		if outline_config then
			local color_unit = unit

			for i = 1, #material_layers do
				local material_layer_name = material_layers[i]
				local material_variable_name = "outline_color"

				Unit.set_vector3_for_material(color_unit, material_layer_name, material_variable_name, Vector3(wanted_outline_color[1], wanted_outline_color[2], wanted_outline_color[3]))
			end

			local visual_loadout_extension = ScriptUnit.extension(unit, "visual_loadout_system")
			local visual_loadout_slots = visual_loadout_extension:inventory_slots()

			for slot_name, slot in pairs(visual_loadout_slots) do
				local slot_unit, attachments = visual_loadout_extension:slot_unit(slot_name)

				if slot.use_outline then
					for j = 1, #material_layers do
						local material_layer_name = material_layers[j]
						local material_variable_name = "outline_color"

						Unit.set_vector3_for_material(slot_unit or slot.unit, material_layer_name, material_variable_name, Vector3(wanted_outline_color[1], wanted_outline_color[2], wanted_outline_color[3]))
					end

					if attachments then
						for j = 1, #attachments do
							local attachment_unit = attachments[j]

							for k = 1, #material_layers do
								local material_layer_name = material_layers[k]
								local material_variable_name = "outline_color"

								Unit.set_vector3_for_material(attachment_unit, material_layer_name, material_variable_name, Vector3(wanted_outline_color[1], wanted_outline_color[2], wanted_outline_color[3]))
							end
						end
					end
				end
			end
		end
	end
end

local function UpdateOutlineSettings()
	if not OutlineSettings then return
	end

	local orig = OutlineSettings.MinionOutlineExtension.adamant_smart_tag
	for i = 1, 4 do
		local c = mod:get("player_"..i.."_color")
		if c then
			c = Color[c](255, true)
			local no = OutlineSettings.MinionOutlineExtension["adamant_smart_tag"..i]
			if not no then
				no = table.clone(orig)
				OutlineSettings.MinionOutlineExtension["adamant_smart_tag"..i] = no
			end
			no.color[1] = c[2] / 255.0
			no.color[2] = c[3] / 255.0
			no.color[3] = c[4] / 255.0
		end
	end
end

function mod:on_setting_changed()
	UpdateOutlineSettings()
end

-- this sets at the start of the game
mod:hook_require("scripts/settings/outline/outline_settings", function(instance)
	OutlineSettings = instance
	UpdateOutlineSettings()
end)

-- this sets at the start of the game
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

--mod:hook_require("scripts/extension_systems/outline/outline_system", function(instance)
--	mod:hook_safe(instance, "add_outline", function(self, unit, outline_name)
--		if string.sub(outline_name, 1, -2) ~= "adamant_smart_tag" then return end
--		local color = OutlineSettings.MinionOutlineExtension[outline_name].color
--		local extension = ScriptUnit.extension(unit, "outline_system")
		
--		if not extension then return end

--		for i = 1, #extension.outlines do
--			if extension.outlines[i].name == outline_name then
--					local old = extension.settings[outline_name].color
--					mod:notify("Changing color "..old[1]..","..old[2]..","..old[3].." to "..color[1]..","..color[2]..","..color[3])
--					extension.settings[outline_name].color = color
--					_update_material_layers_color(unit, extension, extension
--																	.settings[outline_name]
--																	.color, 
--																	extension
--																	.settings[outline_name]
--																	.material_layers)
--				return
--			end
--		end
--	end)
--end)