--if one ever gets destroyed, spawn it back.

local entity_id = GetUpdatedEntityID()


if entity_id and EntityGetRootEntity(entity_id) == entity_id then
local x, y = EntityGetTransform(entity_id)
local invcomp=EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialInventoryComponent")
if invcomp then
local mats=ComponentGetValue2(invcomp,"count_per_material_type")


local new_entity_id=EntityLoad("mods/Electrum/files/entities/items/masteralchemistflask.xml",x,y)
if not new_entity_id then return end
local new_invcomp=EntityGetFirstComponentIncludingDisabled(new_entity_id, "MaterialInventoryComponent")
if not new_invcomp then return end

for m=1,#mats do --get each material in the old, and put it in the new
	AddMaterialInventoryMaterial(new_entity_id, CellFactory_GetName(m-1) ,mats[m]) 		
end



end
end
