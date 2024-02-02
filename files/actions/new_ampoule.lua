local spellent = GetUpdatedEntityID()

if not spellent  or spellent==0 then return end

local spellcomp=EntityGetFirstComponentIncludingDisabled(spellent, "MaterialInventoryComponent")
local cv=ComponentGetValue2(spellcomp,"count_per_material_type")

local x, y = EntityGetTransform(spellent)
local tofill=EntityLoad("mods/Electrum/files/entities/items/ampoule.xml",x,y)





local fillcomp=EntityGetFirstComponentIncludingDisabled(spellent, "MaterialInventoryComponent")
print(tostring(x),tostring(y))
for i=1, #cv do
	if cv[i]~=0 then
		print(i,cv[i])
		AddMaterialInventoryMaterial(spellent, CellFactory_GetName(i-1) ,0) 
		AddMaterialInventoryMaterial(tofill, CellFactory_GetName(i-1) ,cv[i]) 
	end
	
end


--for whatever reason it don't drop on death?
--it should be fine if it doesn't, it caps its inventory.
--print("killing",spellent)
EntityInflictDamage( spellent, 1/0, "DAMAGE_PHYSICS_BODY_DAMAGED", "", "NONE", 0, 0)
