local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )


local ents=EntityGetInRadius(x, y, 20)--EntityGetInRadius(x,y,60)

local mats_spawn_spells={
magic_liquid_berserk = "BERSERK_FIELD",
magic_liquid_faster_levitation_and_movement = "LEVITATION_FIELD",
magic_liquid_movement_faster = "LEVITATION_FIELD",
magic_liquid_faster_levitation = "LEVITATION_FIELD",
magic_liquid_teleportation = "TELEPORTATION_FIELD",
magic_liquid_unstable_teleportation = "TELEPORTATION_FIELD",
magic_liquid_protection_all = "SHIELD_FIELD",
blood_cold = "FREEZE_FIELD",
magic_liquid_polymorph = "POLYMORPH_FIELD",
magic_liquid_random_polymorph = "CHAOS_POLYMORPH_FIELD",
magic_liquid_unstable_polymorph = "CHAOS_POLYMORPH_FIELD",
}


for i=1,#ents do
	local entid=ents[i]
	if EntityGetRootEntity(entid) == entid then
		local invcomp=EntityGetFirstComponentIncludingDisabled(entid, "MaterialInventoryComponent")
		if invcomp and invcomp~=0 then
			local mats=ComponentGetValue2(invcomp,"count_per_material_type")
			for m=1,#(mats or {}) do
				local _MATERIALNAME=CellFactory_GetName(m-1)
				
				if _MATERIALNAME=="el_cocoa" and mats[m]>=125 and not REGENERATE then
					AddMaterialInventoryMaterial(entid, _MATERIALNAME , math.max(0,mats[m]-125) ) 
					EntityLoad("mods/Electrum/files/pixel_scenes/alchemist_house/regen.xml", x, y)
					return
				end
				
				if mats[m]>=1000 then
					for mat,spell in pairs(mats_spawn_spells) do
						if _MATERIALNAME==mat then
							AddMaterialInventoryMaterial(entid, _MATERIALNAME , mats[m]-1000 ) 
							EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", x, y)
							CreateItemActionEntity(spell,x,y-20)
						end
					end
				end
			end
		end
	end
	
end









