local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)


local ents=EntityGetInRadius(x,y,8) --needs to be big enough otherwise it won't detect

--print(tostring(#ents))
for i=1,#ents do --for each container entity
local invcomp=EntityGetFirstComponentIncludingDisabled(ents[i], "MaterialInventoryComponent")
if invcomp then
	local mats=ComponentGetValue2(invcomp,"count_per_material_type")
	local highestid,highestcount=nil,-math.huge
	--print("going through mats")
	for m=1,#mats do --get each material, store the most abundant.
		if mats[m]>highestcount and mats[m]~=0 then
			highestid=m
			highestcount=mats[m]
			print("found a material",tostring(m),tostring(mats[m]))
		end
	end
	--print("highest was",tostring(highestid),tostring(highestcount) )
	for m=1,#mats do --now that we have the highest, go through each and delete the one that isn't
		if m~=highestid and mats[m]~=0 then
			print("removing",tostring(m),tostring(mats[m]) )
			AddMaterialInventoryMaterial(ents[i], CellFactory_GetName(m-1) ,-mats[m]*0) 
		end
	end
	--print("ent")
end
end

