dofile_once("mods/Electrum/material_database.lua")

local function get_epoch() --because the noita devs couldn't be bothered to just remove the dangerous OS library functions. smh. not truly the epoch, but good enough.
local year,month,day,hour,minute,second=GameGetDateAndTimeLocal()
	local t=year
	t=t*365 + day
	t=t*24 + hour
	t=t*60 + minute
	t=t*60 + second
	return t
end


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
	database=get_full_material_database()
	
	--remove blacklisted materials
	for mat,tags in pairs(database) do
		if should_material_be_blacklisted(mat,tags) then
			database[mat]=nil
		else
			for n=#tags,1,-1 do --go in reverse order, since elements will be shifted back
				if should_tag_be_ignored(tags[n]) then
					table.remove(tags,n) --prune accessory tags.
				end
			end
		end
	end
	--check if we are included
	if not database[mat_name] then
		return mat_name
	end
	
	local eligable={}
	local ourtags=database[mat_name]
	for mat,tags in pairs(database) do
		if mat~=mat_name then --ignore self.
			local shared_tags=list_shared_member_count(ourtags,tags)
			local tags_unshared=math.max(#ourtags,#tags)-shared_tags
			if (shared_tags > tags_unshared) and shared_tags>=2 and shared_tags>0.8*math.min(#ourtags,#tags) then --if the 2 materials share more tags than they don't, and they share at least 2 tags, and they share over 66% their tags
				eligable[#eligable+1]=mat
			end
		end
	end
	
	if #eligable>1 then
		return eligable[math.random(1,#eligable)] --fuck seeded random. nuh-uh.
	else
		return  mat_name --all else fails, return itself.
	end
end

math.randomseed(get_epoch())

for i=1,#ents do --for each container entity
	local invcomp=EntityGetFirstComponentIncludingDisabled(ents[i], "MaterialInventoryComponent")
	if invcomp and EntityGetRootEntity(ents[i]) == ents[i] then
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

