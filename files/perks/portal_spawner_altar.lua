local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if GameHasFlagRun("PERK_PICKED_EL_PERSONAL_LAB") then
	local backupportal=EntityLoad("mods/Electrum/files/perks/portal_to_lab.xml",pos_x+72,pos_y-70)
	if backupportal then
		EntityRemoveComponent(entity_id, GetUpdatedComponentID())
	end
end