--================
--helper functions
--================
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

function pickrandomfromlist(list,numbercalls)
	SetRandomSeed(StatsGetValue("world_seed"),0x46524F47)
	local listcopy={}
	for i=1,#list do listcopy[i]=list[i] end --shuffle the list depending on the world seed.
	for i=1,#listcopy do
		local p=Random(1,#listcopy)
		listcopy[p],listcopy[i]=listcopy[i],listcopy[p]
	end
	
	local r=numbercalls+StatsGetValue("world_seed")
	local n= (r%(#list))+1
	return listcopy[n]
end

concat=function(t,s)
local ns=""
for i=1,#t do
ns=ns..t[i]..(i==#t and "" or s)
end
return ns
end

isin=function(thing,tab)
for i=1,#tab do
if tab[i]==thing then return true end
end
end

--================
--defining rewards
--================

_STDSPELLPOOL={ --a bunch of alchemy-related spells.
"BLOOD_TO_ACID",
"TRANSMUTATION",
"LAVA_TO_BLOOD",
"TOXIC_TO_ACID",
"WATER_TO_POISON",
"POISON_TRAIL",
"GUNPOWDER_TRAIL",
"SOILBALL",
"SEA_ALCOHOL",
"SEA_LAVA",
"SEA_ACID_GAS",
"CIRCLE_FIRE",
"VACUUM_LIQUID",
"VACUUM_POWDER",
"STATIC_TO_SAND",
"LIQUID_TO_EXPLOSION",
}

_SPECIALREWARDSPELLPOOL={
"EL_FLASK_FILL",
"EL_POUCH_FILL",
"EL_SPLITBOLT",
"EL_ALCHEMISTHIISI_ATTACK",
"EL_PURIFYBOLT",
"EL_TRANSMUTEBOLT",
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
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_MATERIAL_CAST"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_SEA_SLIME"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_SEA_WORM_ATTRACTOR"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_FLASK_SUMMON"
_STDSPELLPOOL[#_STDSPELLPOOL+1]="EL_POUCH_SUMMON"
end

--===========================
--defining what gives rewards
--===========================

_REWARDPOOL={ 
 --materials which have a droplet material spell.
["water"]={"MATERIAL_WATER"},
["blood"]={"MATERIAL_BLOOD"},
["oil"]={"MATERIAL_OIL"},
["acid"]={"MATERIAL_ACID"},
["cement"]={"MATERIAL_CEMENT"},
["water"]={"MATERIAL_WATER"},


["mimic_liquid"]=_STDSPELLPOOL, --mimicmic

--materials tagged [magic_liquid]
["magic_liquid_movement_faster"]=_STDSPELLPOOL, 
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
["magic_liquid_weakness"]=_STDSPELLPOOL,
["material_darkness"]=_STDSPELLPOOL,
["pus"]=_STDSPELLPOOL,
["material_rainbow"]=_STDSPELLPOOL,
["magic_liquid_hp_regeneration_unstable"]=_STDSPELLPOOL,
["magic_liquid_hp_regeneration"]=_STDSPELLPOOL,

--materials tagged [alchemy] (except a lot of random shit)
["peat"]=_STDSPELLPOOL,
["purifying_powder"]=_STDSPELLPOOL,
["burning_powder"]=_STDSPELLPOOL,
["gunpowder"]=_STDSPELLPOOL,
["gunpowder_explosive"]=_STDSPELLPOOL, --why are there so many gunpower variants?
["gunpowder_tnt"]=_STDSPELLPOOL,
["coal"]=_STDSPELLPOOL,
["sulphur"]=_STDSPELLPOOL,
["lavasand"]=_STDSPELLPOOL,
["bone"]=_STDSPELLPOOL,
["salt"]=_STDSPELLPOOL,
["sodium"]=_STDSPELLPOOL,
["brass"]=_STDSPELLPOOL,
["gold"]=_STDSPELLPOOL,
["copper"]=_STDSPELLPOOL,
["silver"]=_STDSPELLPOOL,
["diamond"]=_STDSPELLPOOL,
["snow"]=_STDSPELLPOOL,
["sand"]=_STDSPELLPOOL,
["sand_surface"]=_STDSPELLPOOL, --huuuuuuhhhH?????
["sand_blue"]=_STDSPELLPOOL,
["fungi"]=_STDSPELLPOOL,
["honey"]=_STDSPELLPOOL,
["slime"]=_STDSPELLPOOL,
["endslime"]=_STDSPELLPOOL,
["soil"]=_STDSPELLPOOL,
["soil_dead"]=_STDSPELLPOOL,
["soil_lush"]=_STDSPELLPOOL,
["soil_lush_dark"]=_STDSPELLPOOL,
["pea_soup"]=_STDSPELLPOOL,
["rotten_meat"]=_STDSPELLPOOL,

--materials tagged [chaotic_transmutation] (except earlier ones and other shit)
["blood_worm"]=_STDSPELLPOOL, 
["lava"]=_STDSPELLPOOL,
["swamp"]=_STDSPELLPOOL,
["alcohol"]=_STDSPELLPOOL,


--other materials for the sake of more materials or because they do alchemy, too.
["radioactive_liquid"]=_STDSPELLPOOL,
["liquid_fire"]=_STDSPELLPOOL,
["poison"]=_STDSPELLPOOL,
["mud"]=_STDSPELLPOOL,
["urine"]=_STDSPELLPOOL,
["water_swamp"]=_STDSPELLPOOL,
["water_salt"]=_STDSPELLPOOL,
["blood_cold_vapour"]=_STDSPELLPOOL,
["porridge"]=_STDSPELLPOOL,
["fungi_creeping"]=_STDSPELLPOOL,
["void_liquid"]=_STDSPELLPOOL,
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

_REWARDPOOL["el_staticlite"]=_STDSPELLPOOL

_REWARDPOOL["el_yeast"]=_STDSPELLPOOL

_REWARDPOOL["el_superoxide"]=_STDSPELLPOOL

	if not ModIsEnabled("material_spells") then 
		--_REWARDPOOL["magic_liquid_movement_faster"]={"EL_MATERIAL_ACCELERATIUM"} --spell is being deprecated, remove in like a few months.
		_REWARDPOOL["magic_liquid_polymorph"]={"EL_MATERIAL_POLYMORPH"}
	end
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


--material auto-detection. you should still manually specify materials, but this should definitely help catch things that were missed, and offer an amount of automatic mod compatibility
local searchtags={"[alchemy]","[magic_liquid]","[chaotic_transmutation]","[electrum_rewarding]"}
for i=1,#searchtags do
	local tag=searchtags[i]
	for material_id in GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_"..tag,""):gmatch("[^\x1F]+") do
		--print(material_id.." "..tag)
		if not _REWARDPOOL[material_id] then
			--print(material_id.." "..tag)
			_REWARDPOOL[material_id]=_STDSPELLPOOL
		end
	end
end
