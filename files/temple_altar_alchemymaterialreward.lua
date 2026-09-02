dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")
dofile_once("mods/Electrum/files/alchemy_reward_predefines.lua")

local x, y = EntityGetTransform( GetUpdatedEntityID() )

local ents=EntityGetInRadiusWithTag(x, y, 60, "EL_specialflask")--EntityGetInRadius(x,y,60)

local detectedflask

for i=1,#ents do
	local entid=ents[i]
	if EntityGetRootEntity(entid) == entid then
		detectedflask=entid
		break
	end	
end

if detectedflask then
	local _REWARDMATERIAL
	local invcomp=EntityGetFirstComponentIncludingDisabled(detectedflask, "MaterialInventoryComponent")
	local succcomp=EntityGetFirstComponentIncludingDisabled(detectedflask, "MaterialSuckerComponent")
	local capacity=ComponentGetValue2(succcomp,"barrel_size")
	local mats=ComponentGetValue2(invcomp,"count_per_material_type")
	
	local rewardedflaskreagents=split(    (GlobalsGetValue("Electurm_alchemyspellrewards") or "") , "\001" )

	
	for m=1,#(mats or {}) do
		if mats[m]>=capacity*.98 then --find a material which completely fills (or is pretty close)
			local _MATERIALNAME=CellFactory_GetName(m-1)
			if (not isin(_MATERIALNAME,rewardedflaskreagents)) and _REWARDPOOL[_MATERIALNAME] then
				AddMaterialInventoryMaterial(detectedflask, _MATERIALNAME ,0) 
				rewardedflaskreagents[#rewardedflaskreagents+1]=_MATERIALNAME
				_REWARDMATERIAL=_MATERIALNAME
				GlobalsSetValue("Electurm_alchemyspellrewards",concat(rewardedflaskreagents,"\001"))
				break
			end
		end
	end
		
		
	if _REWARDMATERIAL then	
		local pickfrom=_REWARDPOOL[_REWARDMATERIAL]		
		local pickedspell
		local extramsg=""
		if #pickfrom==1 then --if the mat drops a material spell, just drop it
			pickedspell=pickfrom[1]
		else --otherwise, pick a card, any card!
			local rcalls=tonumber(GlobalsGetValue("Electrum_alchemyspellrandomcalls")) or 0
			rcalls=rcalls+1
			pickedspell=pickrandomfromlist(pickfrom,rcalls)
	
			if rcalls%4==0 then --every 4th submit give a bonus reward
				local bonusspell=pickrandomfromlist(_SPECIALREWARDSPELLPOOL, math.floor(rcalls/4) )
				CreateItemActionEntity(bonusspell,x+20,y)
			end
			if rcalls%11==0 then --something something orbs.
				if not GameHasFlagRun("PERK_PICKED_EL_PERSONAL_LAB") then
					perk_spawn( x-20, y, "EL_PERSONAL_LAB" )
				else
					EntityRemoveTag(EntityLoad( "mods/Electrum/files/entities/misc/greater_shitty_chest.xml", x-20, y),"chest")
				end
			end
			if rcalls%5==0 then --every 5th, give a treasure chest, too. why 5th? spacing reasons.
				EntityRemoveTag(EntityLoad( "mods/Electrum/files/entities/misc/less_shitty_chest.xml", x-20, y),"chest") 
			end
			GlobalsSetValue("Electrum_alchemyspellrandomcalls",tostring(rcalls))
		end 
		
		CreateItemActionEntity(pickedspell,x,y)	
	
		GamePrintImportant("Your hard work has been rewarded.",extramsg)		
		local fxent = EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", x, y)
	end

end

