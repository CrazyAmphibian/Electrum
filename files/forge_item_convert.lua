
for _,id in pairs(EntityGetInRadius(pos_x, pos_y, 70)) do
	if EntityGetRootEntity(id) == id then
		local fn=EntityHasTag(id,"EL_specialflask")
		if fn then
			
			local isMAF=EntityHasTag(id,"EL_masteralchemistflask")
			
			local x,y = EntityGetTransform(id)
			
			local ic=EntityGetFirstComponentIncludingDisabled(id, "ItemComponent")
			local pu=ComponentGetValue2(ic,"has_been_picked_by_player") --detect if the player has picked it up. prevents repeated conversions.
			if not pu then break end
			
			newflask=EntityLoad(isMAF and "mods/Electrum/files/entities/items/stasisbeaker.xml" or "mods/Electrum/files/entities/items/masteralchemistflask.xml" , x, y)
			
			if not newflask then break end
			
			local invcomp_o=EntityGetFirstComponentIncludingDisabled(id, "MaterialInventoryComponent")
			local mats_o=ComponentGetValue2(invcomp_o,"count_per_material_type")
			
			local invcomp_n=EntityGetFirstComponentIncludingDisabled(id, "MaterialInventoryComponent")
			local mats_n=ComponentGetValue2(invcomp_n,"count_per_material_type")
			
			for m=1,#(mats_o or {}) do
				local _MATERIALNAME=CellFactory_GetName(m-1)
				AddMaterialInventoryMaterial(newflask, _MATERIALNAME ,mats_o[m]) 
				AddMaterialInventoryMaterial(id, _MATERIALNAME ,0) 
			end
	
		
			
			EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
			
			EntityRemoveComponent(id,EntityGetFirstComponentIncludingDisabled(id,"LuaComponent")) --if we don't remove it, it'll respawn itself
			
			EntityKill(id)
			converted = true
		end
	end
end