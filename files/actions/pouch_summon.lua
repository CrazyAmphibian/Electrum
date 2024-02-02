local entity_id = GetUpdatedEntityID()
if not entity_id  or entity_id==0 then return end

local x, y = EntityGetTransform(entity_id)
local ent=EntityLoad("data/entities/items/pickup/powder_stash.xml",x,y)
--pouches start with shit in them, so let's fix that.

--get the inventory component
local comp=EntityGetFirstComponentIncludingDisabled(ent, "MaterialInventoryComponent")
--then get an array of its materials
local cv=ComponentGetValue2(comp,"count_per_material_type")
--then for each material we find:
for i=1, #cv do
	AddMaterialInventoryMaterial(ent, CellFactory_GetName(i-1) ,-cv[i]*0) --remove however much material is in there.
end

