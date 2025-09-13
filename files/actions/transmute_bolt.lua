local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local ents=EntityGetInRadius(x,y,8) --needs to be big enough otherwise it won't detect

local function member_in_list(list,member)
	for i=1,#list do
		if list[i]==member then return true end
	end
	return false
end
local function list_shared_member_count(list1,list2)
	local sharecount=0
	for i=1,#list1 do
		if member_in_list(list2,list1[i]) then sharecount=sharecount+1 end
	end
	return sharecount
end

local function transmute(mat_name)
	database={}
	for entry in GlobalsGetValue("ELECTRUM_MASTER_MATERIALS_DATABASE",""):gmatch("[^\x04]+") do
		local sp=entry:find("\x03")
		local mat=entry:sub(1,sp-1)
		database[mat]={}
		for tag in entry:sub(sp+1,#entry):gmatch("[^\x1F]+") do
			database[mat][#database[mat]+1]=tag
		end
	end
	
	local eligable={} 
	if database[mat_name] then
		local tags=database[mat_name]
		for i=1,#tags do --for each tag our material has...
			local tag=tags[i]
			
			local subset={}
			for entry in GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_"..tag,""):gmatch("[^\x1F]+") do
				subset[#subset+1]=entry
			end
			
			for n=1,#subset do --check every other material with that tag.
				local thismat=subset[n]
				if (not member_in_list(eligable,thismat) ) and list_shared_member_count(database[thismat],tags )>=math.floor(0.80*math.min(#database[thismat],#tags)) then --if they share at least 80% of their tags (communitive), rounded down to not punish materials with small amounts of tags.
					eligable[#eligable+1]=subset[n]
				end
			end
			
		end
	end
	
	if #eligable>1 then
		return eligable[math.random(1,#eligable)] --fuck seeded random. nuh-uh.
	else
		return  mat_name --all else fails, return itself.
	end
end

for i=1,#ents do --for each container entity
local invcomp=EntityGetFirstComponentIncludingDisabled(ents[i], "MaterialInventoryComponent")
if invcomp then
	local newmats={} --this is so that if 2 materials transmute into the same one, we don't delete anything.
	local mats=ComponentGetValue2(invcomp,"count_per_material_type")
	for m=1,#mats do --get each material, store the lest abundant.
		if mats[m]~=0 then
			local thismat=CellFactory_GetName(m-1)
			local result=transmute(thismat)
			AddMaterialInventoryMaterial(ents[i], thismat ,0) 
			newmats[ result ] =(newmats[ result ]  or 0) + mats[m]
		end
	end

	for mat,count in pairs(newmats) do
		AddMaterialInventoryMaterial(ents[i],mat,count)
	end
	
end
end

