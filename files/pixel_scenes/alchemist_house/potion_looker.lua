local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local _REWARDPOOL={ 

["magic_liquid_berserk"]=_STDSPELLPOOL,


}

if true then --electrum materials. but why would these not load in? eh, for the sake of consistency
_REWARDPOOL["el_cocoa"]=_ELECTRUMCOOLSPELLPOOL
end


local ents=EntityGetInRadius(x, y, 20)--EntityGetInRadius(x,y,60)

local REGENERATE,BERZERK=false,false

for i=1,#ents do
	local entid=ents[i]
	

	if EntityGetRootEntity(entid) == entid then
		local invcomp=EntityGetFirstComponentIncludingDisabled(entid, "MaterialInventoryComponent")
		if invcomp and invcomp~=0 then
		local mats=ComponentGetValue2(invcomp,"count_per_material_type")
		
		for m=1,#(mats or {}) do
			local _MATERIALNAME=CellFactory_GetName(m-1)
			
			if _MATERIALNAME=="el_cocoa" and mats[m]>=125 and not REGENERATE then
				REGENERATE=true
				AddMaterialInventoryMaterial(entid, _MATERIALNAME , math.max(0,mats[m]-125) ) 
			elseif _MATERIALNAME=="magic_liquid_berserk" and mats[m]>=1000 and not BERZERK then
				BERZERK=true
				AddMaterialInventoryMaterial(entid, _MATERIALNAME , mats[m]-1000 ) 
			end
			

		end
		
		
		
		
		end
	end
	
end



if BERZERK then
	local fxent = EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", x, y)
	
	CreateItemActionEntity("BERSERK_FIELD",x,y-20)
end


if REGENERATE then
 EntityLoad("mods/Electrum/files/pixel_scenes/alchemist_house/regen.xml", x, y)
end










