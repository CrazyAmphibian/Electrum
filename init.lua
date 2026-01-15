-- all functions below are optional and can be left out
--taken from graham's mod code. trusting their shit to work :clueless:
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations then
	translations = translations .. (ModTextFileGetContent( "mods/Electrum/text.csv" ) or "")
	translations = translations:gsub("\r\n","\n") -- why are we removing carriage return?
	translations = translations:gsub("\n\n","\n")
	ModTextFileSetContent( "data/translations/common.csv", translations )
end



local function parse_materials_xml(txt)
	local material_tags_database={}

	for materialdata in txt:gmatch("<CellData.->") do --wildcard match any non-greedy
		local s,e = materialdata:find("name=\".-\"")
		if s and e then 
			local name=materialdata:sub(s+6,e-1)
			s,e = materialdata:find("tags=\".-\"")
			if s and e then 
				local tagstr=materialdata:sub(s+6,e-1)
				local tags={}
				for tag in tagstr:gmatch("[^,]+") do --match any character but comma greedy
					tags[#tags+1]=tag
				end
				material_tags_database[name]=tags
			end
		end
	end

	for materialdata in txt:gmatch("<CellDataChild.->") do --as above, so below
		local s,e = materialdata:find("name=\".-\"")
		if s and e then 
			local name=materialdata:sub(s+6,e-1)
			s,e = materialdata:find("tags=\".-\"")
			if s and e then  --override parent tags
				local tagstr=materialdata:sub(s+6,e-1)
				local tags={}
				for tag in tagstr:gmatch("[^,]+") do
					tags[#tags+1]=tag
				end
				material_tags_database[name]=tags
			else --use parent tags
				local s,e = materialdata:find("_parent=\".-\"")
				if s and e then 
					local parent=materialdata:sub(s+9,e-1)
					material_tags_database[name]=material_tags_database[parent]
				end
			end
		end
	end
	return material_tags_database
end

local function should_material_be_blacklisted(materialname,materialdata)
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
	
	--electrum materials
	if materialname=="el_destabalized_polymorph" then return true end
	if materialname=="el_antipoly_liquid" then return true end
	if materialname=="el_healthpotion" then return true end
	
	--graham's things.
	if materialname=="graham_graymatter_liquid " then return true end
	if materialname=="graham_creepypoly" then return true end
	
	for i=1,#materialdata do
		local tag=materialdata[i]
		if tag=="[box2d]" then return true end --this will cause many glitches
		if tag=="[catastrophic]" then return true end --graham. redundant, but just in case another mod tags it with such.
		if tag=="[electrum_ignored]" then return true end
	end
	
	return false
end



--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
--	local x = ProceduralRandom(0,0)
--	print( "===================================== random " .. tostring(x) )

dofile("mods/Electrum/files/pixel_scenes/personal_lab/append.lua")
dofile("mods/Electrum/files/pixel_scenes/alchemist_house/append.lua")


--[[ the issue with this is that many materials are children of others, and that makes parsing stuff really, really hard. too much work for me, at least.

--parse materials file
local mattxt=ModTextFileGetContent("data/materials.xml")
local matd={}
if mattxt then
	for matdata in mattxt:gmatch("<CellData.->") do
		local s,e=matdata:find("name=\".-\"")
		if s then
			local matname=matdata:sub(s+6,e-1)
			matd[matname]={}
			local s,e=matdata:find("tags=\".-\"")
			if s then
				local mattags=matdata:sub(s,e)
				for tag in mattags:gmatch("%[.-%]") do
					matd[matname][#matd[matname]+1]=tag:sub(2,#tag-1)
				end
			end
		end
	end
end
local submit=""
for mat,tags in pairs(matd) do
	submit=submit..mat.."\003"..table.concat(tags,"\001").."\002"
end
print(#submit)
ELECTRUM_MATERIAL_DATABASE=submit
]]


end


-- This code runs when all mods' filesystems are registered

--ModMagicNumbersFileAdd( "mods/Electrum/files/magic_numbers.xml" ) -- Will override some magic numbers using the specified file
--ModRegisterAudioEventMappings( "mods/Electrum/files/audio_events.txt" ) -- Use this to register custom fmod events. Event mapping files can be generated via File -> Export GUIDs in FMOD Studio.

ModMaterialsFileAdd( "mods/Electrum/files/mats.xml" ) 
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Electrum/files/actions.lua" )
ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/Electrum/files/statuses.lua" )
ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/Electrum/files/potion.lua" )


ModLuaFileAppend( "data/scripts/magic/altar_tablet_magic.lua", "mods/Electrum/files/temple_altar_masteralchemistflask.lua")
ModLuaFileAppend( "data/scripts/magic/altar_tablet_magic.lua", "mods/Electrum/files/temple_altar_alchemymaterialreward.lua")

ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/Electrum/files/perks.lua")



local ft=ModTextFileGetContent("data/entities/buildings/coop_respawn.xml")
local labperkxml='<LuaComponent execute_on_added="1" execute_every_n_frame="30" script_source_file="mods/Electrum/files/perks/portal_spawner.lua" />'
ModTextFileSetContent("data/entities/buildings/coop_respawn.xml",ft:gsub("</Entity>",labperkxml.."</Entity>"))


local content = ModTextFileGetContent("data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml")
if content then
	content = content:gsub("</Entity>", [[
			<LuaComponent 
				_enabled="1" 
				execute_every_n_frame="240"
				script_source_file="mods/electrum/files/temple_altar_masteralchemistflask.lua" 
			>
			</LuaComponent>
			
			<LuaComponent 
				_enabled="1" 
				execute_every_n_frame="240"
				script_source_file="mods/electrum/files/temple_altar_alchemymaterialreward.lua" 
			>
			</LuaComponent>
			
			<LuaComponent 
				_enabled="1" 
				execute_every_n_frame="30"
				script_source_file="mods/Electrum/files/perks/portal_spawner_altar.lua" 
			>
			</LuaComponent>
			
		</Entity>
		]])
	ModTextFileSetContent("data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml", content)
end



local mastermaster = ModTextFileGetContent( "data/entities/animals/boss_wizard/death.lua" )
if mastermaster then 
	mastermaster=mastermaster:gsub("AddFlagPersistent%( \"miniboss_wizard\" %)","AddFlagPersistent( \"miniboss_wizard\" )\n EntityLoad( \"mods/Electrum/files/wands/leveraction.xml\",  x , y )",1)
	ModTextFileSetContent( "data/entities/animals/boss_wizard/death.lua", mastermaster )
end



local content = ModTextFileGetContent("data/scripts/buildings/forge_item_convert.lua")
local append =ModTextFileGetContent("mods/Electrum/files/forge_item_convert.lua")
if content and append then
	content = content:gsub("if converted then", append.."\nif converted then")
	ModTextFileSetContent("data/scripts/buildings/forge_item_convert.lua", content)
end


content = ModTextFileGetContent("data/scripts/newgame_plus.lua")
if content then
	content=content:gsub("SessionNumbersSetValue%( \"NEW_GAME_PLUS_COUNT\", newgame_n %)",
	"SessionNumbersSetValue( \"NEW_GAME_PLUS_COUNT\", newgame_n )\n  GlobalsSetValue(\"Electurm_alchemyspellrewards\",\"\")\n  GlobalsSetValue(\"Electrum_alchemyspellrandomcalls\",\"\")\n if GameHasFlagRun(\"PERK_PICKED_EL_PERSONAL_LAB\") then EntityLoad(\"mods/Electrum/files/perks/portal_to_lab.xml\",860,-1220) end\n ",
	1)
	ModTextFileSetContent("data/scripts/newgame_plus.lua",content)
end




if ModIsEnabled("anvil_of_destiny") then
  ModLuaFileAppend("mods/anvil_of_destiny/files/scripts/modded_content.lua", "mods/Electrum/files/anvilofdestiny.lua")
  print("Electrum: added content from anvil_of_destiny")
end

function OnModPostInit()
	if ModIsEnabled("grahamsperks") then
		--[[for graham's things: 
		adds reactions involving creepy polymorph, and statium
		adds creation and filler spells for balloons (stores gasses.)
		]]
		ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/Electrum/files/actions_grahamsperks.lua" )
		ModMaterialsFileAdd( "mods/Electrum/files/mats_grahamsperks.xml" ) 
		print("Electrum: added content from grahamsperks")
	end
	
	if ModIsEnabled("cool_spell") then
	--[[for OVERCAST:
	adds reaction to make oxidizing powder
	adds reaction to make toxic gold
	]]
	ModMaterialsFileAdd( "mods/Electrum/files/mats_cool_spell.xml" ) 
	print("Electrum: added content from cool_spell")
	end
	
	
end


function OnWorldInitialized()
	print("Electrum: beginning parsing of materials.xml")
	local txt=ModTextFileGetContent("data/materials.xml")
	if txt then
		local _NUM_MATS,_NUM_TAGS =0,0
		
		material_data=parse_materials_xml(txt)
		local dump=""
		local listall=""
		for i,v in pairs(material_data) do
			if should_material_be_blacklisted(i,v) then
				material_data[i]=nil
			else
				dump=dump..i.."\x03"..table.concat(v,"\x1F").."\x04"
				listall=listall..i.."\x1F"
			end
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
	else
		print("Electrum: failed to parse materials!")
	end
end



function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created

	--EntitySetDamageFromMaterial(player_entity,"el_aqua-regia",".001") -- 1/5th as potent as acid.
	--this is commented out because i'd like a way to apply it more universally.
end

--print("Example mod init done")