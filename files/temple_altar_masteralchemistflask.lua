local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local gottenmasterflasks={}

split = function(s,seperator) 
local out={}
	for d in s:gmatch("[^"..seperator.."]+") do out[#out+1]=d end
	return out
end



local isin=function(thing,tab)
for i=1,#tab do
if tab[i]==thing then return true end
end
end



local ngp=SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") or 0
local pw=GetParallelWorldPosition( x, 0 )

gottenmasterflasks=split(    (GlobalsGetValue("Electurm_masteralchemistflask-unlocks") or "") , "\001" )

--print(GlobalsGetValue("Electurm_masteralchemistflask-unlocks") or "")

local ents=EntityGetInRadius(x,y,60)

local detectingpouch,detectingpotion
for i=1,#ents do
	local entid=ents[i]
	local ispouch,ispotion
	
	local entname=EntityGetFilename(entid)
	if entid~=0 and EntityGetRootEntity(entid) == entid and #(EntityGetComponent(entid,"MaterialSuckerComponent") or {})==1 and (ComponentGetValue2(EntityGetComponent(entid,"MaterialSuckerComponent")[1],"barrel_size") or 0)>=1500 and ComponentGetValue2(EntityGetComponent(entid,"MaterialSuckerComponent")[1],"material_type")==1 then
		ispouch=true
	end
	
	if entid~=0 and EntityGetRootEntity(entid) == entid and #(EntityGetComponent(entid,"MaterialSuckerComponent") or {})==1 and (ComponentGetValue2(EntityGetComponent(entid,"MaterialSuckerComponent")[1],"barrel_size") or 0)>=1000 and ComponentGetValue2(EntityGetComponent(entid,"MaterialSuckerComponent")[1],"material_type")==0 then
		ispotion=true --i should have done a check like this earlier.
	end

	if ispouch and not detectingpouch then
		detectingpouch=entid
	end
	if ispotion and not detectingpotion then
		detectingpotion=entid
	end
		
	if detectingpotion and detectingpouch then break end
end

if detectingpotion and detectingpouch then
	local currcheck=tostring(ngp).."\001"..tostring(pw)
	if not isin(currcheck,gottenmasterflasks) then
		--print(string.format("used the master flask @NG+%i, PW:%i",ngp,pw))
		gottenmasterflasks[#gottenmasterflasks+1]=currcheck
		--print(currcheck)
		
		GamePrintImportant("Your resourcefulness has been rewarded.","You have been blessed with a gift to assist you.")
		local newmats={}
		

		
		
		
	local invcomp=EntityGetFirstComponentIncludingDisabled(detectingpotion, "MaterialInventoryComponent")
	if invcomp then
		local mats=ComponentGetValue2(invcomp,"count_per_material_type")
		newmats=mats
	end
	
	invcomp=EntityGetFirstComponentIncludingDisabled(detectingpouch, "MaterialInventoryComponent")
	if invcomp then
		local mats=ComponentGetValue2(invcomp,"count_per_material_type")
		for m=1,#mats do --get each material, store the most abundant.
			newmats[m]=(newmats[m] or 0)+mats[m]
		end
	end
		
	EntityKill(detectingpotion)
	EntityKill(detectingpouch)
	local newflask=EntityLoad("mods/Electrum/files/entities/items/masteralchemistflask.xml", x, y-100) --spawn the flask overhead.
		
		
	invcomp=EntityGetFirstComponentIncludingDisabled(newflask, "MaterialInventoryComponent")
	for m=1,#newmats do --now that we have the highest, go through each and delete the one that isn't
		AddMaterialInventoryMaterial(newflask, CellFactory_GetName(m-1) ,newmats[m]) 
	end
		
		
		
		local fxent = EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", x, y-100)

		
	else
		--print(string.format("you already tried @NG+%i, PW:%i",ngp,pw))
	end
	
elseif (detectingpotion or detectingpouch) and GlobalsGetValue("Electrum_masteralchemistflask-hint")~="yes" then
GlobalsSetValue("Electrum_masteralchemistflask-hint","yes")
GamePrintImportant("Your quest is amusing those above.","bring forth another comparable vessel.")
end

--print(table.concat(gottenmasterflasks,"\001"),tostring(#gottenmasterflasks))

GlobalsSetValue("Electurm_masteralchemistflask-unlocks",table.concat(gottenmasterflasks,"\001"))



