local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local rewardedflaskreagents={}

split = function(s,seperator) --trying to figure this shit out has made me want to kill myself.
if not s then return {} end
local out={}
	local n=1
	n=1--string.find(s,seperator,n,true)
	if not n then return {s} end
	local nn
	while n<=#s do
		local n1,n2=string.find(s,seperator,n,true)
		if n1 then
			out[#out+1]=s:sub(n,n1-1)
		else
			out[#out+1]=s:sub(n)
		end
		
		n=(n2 or #s)+1
	end
	return out
end

concat=function(t,s)
local ns=""
for i=1,#t do
ns=ns..t[i]..(i==#t and "" or s)
end
return ns
end

local _STDSPELLPOOL={ --a bunch of alchemy-related spells.
"BLOOD_TO_ACID",
"TRANSMUTATION",
"LAVA_TO_BLOOD",
"TOXIC_TO_ACID",
"WATER_TO_POISON",
"POISON_TRAIL",
"GUNPOWDER_TRAIL",
"SOILBALL",
"SEA_ALCOHOL",
"EL_MATERIAL_CAST",
"EL_SEA_SLIME",
"EL_SEA_WORM_ATTRACTOR",
}

local _SPECIALREWARDSPELLPOOL={
"EL_FLASK_FILL",
"EL_POUCH_FILL",
"EL_SPLITBOLT",
"EL_ALCHEMISTHIISI_ATTACK",
"EL_CONCENTRATEBOLT",
"EL_PURIFYBOLT",
}



if ModIsEnabled("grahamsperks") then
_STDSPELLPOOL[#_STDSPELLPOOL+1]="GRAHAM_POWDER_EVAPORATION"
_SPECIALREWARDSPELLPOOL[#_SPECIALREWARDSPELLPOOL+1]="EL_BALLOON_FILL"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_BALOON_SUMMON"
end

if ModIsEnabled("cool_spell") then
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_MOREBLOOD"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_PLANK"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_BEAM"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_VACUUM_MOD"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_PAYLOAD_ACID"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_PAYLOAD_POLY"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_PAYLOAD_BESERK"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="OVERCAST_PAYLOAD_POISON"
end

if true then
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_FLASK_SUMMON"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_POUCH_SUMMON"
end

local _REWARDPOOL={ 
["water"]={"MATERIAL_WATER"}, --materials which give their material spell.
["blood"]={"MATERIAL_BLOOD"},
["oil"]={"MATERIAL_OIL"},
["acid"]={"MATERIAL_ACID"},
["cement"]={"MATERIAL_CEMENT"},
["water"]={"MATERIAL_WATER"},

["magic_liquid_movement_faster"]=_STDSPELLPOOL, --[magic_liquid]!
["magic_liquid_polymorph"]=_STDSPELLPOOL, 
["magic_liquid_random_polymorph"]=_STDSPELLPOOL, 
["magic_liquid_unstable_polymorph"]=_STDSPELLPOOL, 
["magic_liquid_protection_all"]=_STDSPELLPOOL,
["magic_liquid_berserk"]=_STDSPELLPOOL,
["magic_liquid_mana_regeneration"]=_STDSPELLPOOL,
["material_confusion"]=_STDSPELLPOOL,
["magic_liquid_faster_levitation"]=_STDSPELLPOOL,
["magic_liquid_faster_levitation_and_movement"]=_STDSPELLPOOL,
["magic_liquid_invisibility"]=_STDSPELLPOOL,
["magic_liquid_charm"]=_STDSPELLPOOL,
["magic_liquid_unstable_teleportation"]=_STDSPELLPOOL,
["magic_liquid_teleportation"]=_STDSPELLPOOL,
["magic_liquid_worm_attractor"]=_STDSPELLPOOL,
["material_darkness"]=_STDSPELLPOOL,
["magic_liquid_weakness"]=_STDSPELLPOOL,

["blood_worm"]=_STDSPELLPOOL, --other stuff that's used in alchemy
["purifying_powder"]=_STDSPELLPOOL,
["coal"]=_STDSPELLPOOL,
["salt"]=_STDSPELLPOOL,
["sodium"]=_STDSPELLPOOL,
["alcohol"]=_STDSPELLPOOL,
["lava"]=_STDSPELLPOOL,
["slime"]=_STDSPELLPOOL,
["blood_worm"]=_STDSPELLPOOL,
["diamond"]=_STDSPELLPOOL,
["silver"]=_STDSPELLPOOL,
["gold"]=_STDSPELLPOOL,
["brass"]=_STDSPELLPOOL,
["copper"]=_STDSPELLPOOL,
["honey"]=_STDSPELLPOOL,


["urine"]=_STDSPELLPOOL, --other crap that might as well be here.
["pus"]=_STDSPELLPOOL,
}

if true then --electrum materials. but why would these not load in? eh, for the sake of consistency
_REWARDPOOL["el_metalmakerjuice"]=_STDSPELLPOOL
_REWARDPOOL["el_antipoly_liquid"]=_STDSPELLPOOL
_REWARDPOOL["el_electrum"]=_STDSPELLPOOL
_REWARDPOOL["el_aqua_regia"]=_STDSPELLPOOL
_REWARDPOOL["el_cocoa"]=_STDSPELLPOOL

_REWARDPOOL["el_bloodmix"]=_STDSPELLPOOL

_REWARDPOOL["el_stable"]=_STDSPELLPOOL
_REWARDPOOL["el_unstable"]=_STDSPELLPOOL
_REWARDPOOL["el_chaotic"]=_STDSPELLPOOL

_REWARDPOOL["el_healthpotion"]=_STDSPELLPOOL
_REWARDPOOL["el_weakhealthpotion"]=_STDSPELLPOOL

_REWARDPOOL["magic_liquid_movement_faster"]={"EL_MATERIAL_ACCELERATIUM"}
_REWARDPOOL["magic_liquid_polymorph"]={"EL_MATERIAL_POLYMORPH"}
end

if not ModIsEnabled("material_spells") then 

end


if ModIsEnabled("grahamsperks") then
_REWARDPOOL["radioactive_liquid"]={"GRAHAM_MATERIAL_RADIOACTIVE"}
_REWARDPOOL["graham_pureliquid"]={"GRAHAM_MATERIAL_PURE"}
_REWARDPOOL["graham_mundane"]=_STDSPELLPOOL
_REWARDPOOL["graham_bubbly"]=_STDSPELLPOOL
_REWARDPOOL["graham_hellblood"]=_STDSPELLPOOL
_REWARDPOOL["graham_slush"]=_STDSPELLPOOL
_REWARDPOOL["graham_statium"]=_STDSPELLPOOL
_REWARDPOOL["graham_resist"]=_STDSPELLPOOL
end


if ModIsEnabled("cool_spell") then
_REWARDPOOL["overcast_magic_liquid_mystery"]={"OVERCAST_MATERIAL_ANOMALY"}
_REWARDPOOL["overcast_oxidizing_dust"]={"OVERCAST_MATERIAL_OXIDIZING"}
_REWARDPOOL["sodium"]={"OVERCAST_MATERIAL_SODIUM"}
end



local isin=function(thing,tab)
for i=1,#tab do
if tab[i]==thing then return true end
end
end

rewardedflaskreagents=split(    (GlobalsGetValue("Electurm_alchemyspellrewards") or "") , "\001" )
--print(GlobalsGetValue("Electurm_alchemyspellrewards"),#rewardedflaskreagents)

local ents=EntityGetInRadiusWithTag(x, y, 60, "EL_specialflask")--EntityGetInRadius(x,y,60)

--local detectedflask=ents[1]
local detectedflask

for i=1,#ents do
	local entid=ents[i]
	
	--if (entname=="mods/Electrum/files/entities/items/masteralchemistflask.xml" or entname=="mods/Electrum/files/entities/items/stasisbeaker.xml") and EntityGetRootEntity(entid) == entid then
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
	for m=1,#(mats or {}) do
		if mats[m]>=capacity*.98 then --find a material which completely fills (or is pretty close)
			local _MATERIALNAME=CellFactory_GetName(m-1)
			if (not isin(_MATERIALNAME,rewardedflaskreagents)) and _REWARDPOOL[_MATERIALNAME] then
				AddMaterialInventoryMaterial(detectedflask, _MATERIALNAME ,0) 
				rewardedflaskreagents[#rewardedflaskreagents+1]=_MATERIALNAME
				_REWARDMATERIAL=_MATERIALNAME
				GlobalsSetValue("Electurm_alchemyspellrewards",concat(rewardedflaskreagents,"\001"))
				--print("POST",concat(rewardedflaskreagents,"\001"),#rewardedflaskreagents,#concat(rewardedflaskreagents,"\001"))
				break
			end
		end
	end
		
		
	if _REWARDMATERIAL then	
		local pickfrom=_REWARDPOOL[_REWARDMATERIAL]		
		local pickedspell
		if #pickfrom==1 then --if the mat drops a material spell, just drop it
			pickedspell=pickfrom[1]
		else --otherwise, pick a card, any card!
			local rcalls=tonumber(GlobalsGetValue("Electrum_alchemyspellrandomcalls")) or 0
			rcalls=rcalls+1
			SetRandomSeed(StatsGetValue("world_seed"),rcalls)
			GlobalsSetValue("Electrum_alchemyspellrandomcalls",rcalls)
			pickedspell=pickfrom[Random(1,#pickfrom)]

			if rcalls%5==0 then --every 5th submit give a bonus reward
				local bonusspell=_SPECIALREWARDSPELLPOOL[Random(1,#_SPECIALREWARDSPELLPOOL)]
				CreateItemActionEntity(bonusspell,x+20,y)
			end
		end
		
	
		local spellentid=CreateItemActionEntity(pickedspell,x,y)
	
	
		GamePrintImportant("Your hard work has been rewarded.")		
		local fxent = EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", x, y)
	end

end






