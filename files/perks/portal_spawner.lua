local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if GameHasFlagRun("PERK_PICKED_" .. "EL_PERSONAL_LAB") then
	local backupportal=EntityLoad("mods/Electrum/files/perks/portal_to_lab.xml",pos_x-300+16,pos_y-16)
end