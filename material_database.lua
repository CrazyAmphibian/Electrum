
function parse_materials_cellfactory() --alternative method that should hopefully work with mods.
	local material_tags_database={} -- [mat_id]={tag1,tag2,...}
	local i=1
	while true do
		local cellname=CellFactory_GetName(i)
		--print(cellname or "")
		if cellname=="unknown" then break end
		material_tags_database[cellname]=CellFactory_GetTags(i)
		i=i+1
	end
	return material_tags_database
end


function should_material_be_blacklisted(materialname,materialdata)
	--destructive things that you definitely don't want to have appear.
	if materialname=="creepy_liquid" then return true end
	if materialname=="just_death" then return true end
	if materialname=="monster_powder_test" then return true end
	if materialname=="rat_powder" then return true end
	if materialname=="fungus_powder" then return true end
	if materialname=="fungus_powder_bad" then return true end
	--muh balance
	if materialname=="midas_precursor" then return true end
	if materialname=="midas" then return true end
	if materialname=="mimic_liquid" then return true end
	if materialname=="magic_liquid_hp_regeneration_unstable" then return true end
	if materialname=="magic_liquid_hp_regeneration" then return true end
	if materialname=="magic_gas_hp_regeneration" then return true end
	
	for i=1,#materialdata do
		local tag=materialdata[i]
		if tag=="[box2d]" then return true end --this will cause many glitches
		if tag=="[catastrophic]" then return true end --graham. also in case another mod tags it with such.
		if tag=="[antimatter]" then return true end --chemical curiosities
		if tag=="[electrum_ignored]" then return true end
	end
	
	return false
end

function should_tag_be_ignored(tag) --if the tag doesn't have any real meaning. mutually exclusive with the blacklist, as materials will be pruned before this is called.
	if tag=="[electrum_rewarding]" then return true end
	
	return false
end


function initialize_material_database()
	print("Electrum: beginning parsing of materials.xml")
	local _NUM_MATS,_NUM_TAGS =0,0
	
	material_data=parse_materials_cellfactory()
	local dump=""
	local listall=""
	for i,v in pairs(material_data) do
		--if should_material_be_blacklisted(i,v) then
		--	material_data[i]=nil
		--else
			dump=dump..i.."\x03"..table.concat(v,"\x1F").."\x04"
			listall=listall..i.."\x1F"
		--end
	end
	
	
	
	GlobalsSetValue("ELECTRUM_MASTER_MATERIALS_DATABASE", dump )
	GlobalsSetValue("ELECTRUM_MATERIALS_DATABASE_LISTALL", listall )
	
	local material_data_by_tags={}
	for mat,tags in pairs(material_data) do
		_NUM_MATS=_NUM_MATS+1
		for i=1,#tags do
			local tag=tags[i]
			if not material_data_by_tags[tag] then material_data_by_tags[tag]={} end
			material_data_by_tags[tag][#material_data_by_tags[tag]+1]=mat
		end
	end
	
	for tag,materials in pairs(material_data_by_tags) do
		_NUM_TAGS=_NUM_TAGS+1
		GlobalsSetValue("ELECTRUM_MATERIAL_DATABASE_TAG_"..tag, table.concat(materials,"\x1F") )
	end
	print("Electrum: success. found ".._NUM_MATS.." materials and ".._NUM_TAGS.." tags.")
end



function material_has_tag(matname,tag)
	for material_id in GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_"..tag,""):gmatch("[^\x1F]+") do
		if material_id==matname then
			return true
		end
	end
	return false
end

function material_get_tags(matname)
	local out={}
	for entry in GlobalsGetValue("ELECTRUM_MASTER_MATERIALS_DATABASE",""):gmatch("[^\x04]+") do
		local sp=entry:find("\x03")
		local mat=entry:sub(1,sp-1)
		if mat==matname then
			for tag in entry:sub(sp+1,#entry):gmatch("[^\x1F]+") do
				out[#out+1]=tag
			end
			break
		end
	end
	return out
end

function get_materials_with_tags(tag_table)
	if type(tag_table)~="table" then tag_table={tag_table} end
	local foundmats={}
	for i=1,#tag_table do
		local tag=tag_table[i]
		for material_id in GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_"..tag,""):gmatch("[^\x1F]+") do
			foundmats[material_id]=true
		end
	end
	local out={}
	for mid,_ in pairs(foundmats) do --this is to prevent a material showing up multiple times, since it may have more than 1 tag we look for
		out[#out+1]=mid
	end
	
	return out
end

function get_full_material_database()
	local out={}
	for entry in GlobalsGetValue("ELECTRUM_MASTER_MATERIALS_DATABASE",""):gmatch("[^\x04]+") do
		local sp=entry:find("\x03")
		local mat=entry:sub(1,sp-1)
		out[mat]={}
		for tag in entry:sub(sp+1,#entry):gmatch("[^\x1F]+") do
			out[mat][#out[mat]+1]=tag
		end	
	end
	return out
end
