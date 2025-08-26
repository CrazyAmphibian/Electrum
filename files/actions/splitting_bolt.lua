local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local ents=EntityGetInRadius(x,y,8) --needs to be big enough otherwise it won't detect

--print(tostring(#ents))
for i=1,#ents do --for each container entity
local invcomp=EntityGetFirstComponentIncludingDisabled(ents[i], "MaterialInventoryComponent")
if invcomp then
	local mats=ComponentGetValue2(invcomp,"count_per_material_type")
	local lowestid,lowestcount=nil,math.huge
	local matcount=0

	for m=1,#mats do --get each material, store the lest abundant.
		if mats[m]~=0 then
			if mats[m]<lowestcount then
			lowestid=m
			lowestcount=mats[m]
			end
			matcount=matcount+1
			--print("found a material",tostring(m),tostring(mats[m]))
		end
	end

	if lowestid and matcount>1 then --ensure that it doesn't delete everything.
		local newent=EntityLoad("data/entities/items/pickup/potion_empty.xml",x+math.random(-10,10),y+math.random(0,5) )
		AddMaterialInventoryMaterial(newent, CellFactory_GetName(lowestid-1) ,lowestcount) 
		AddMaterialInventoryMaterial(ents[i], CellFactory_GetName(lowestid-1) ,0) 
	end
	
	--print("ent")
end
end

