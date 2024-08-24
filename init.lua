-- all functions below are optional and can be left out
--taken from graham's mod code. trusting their shit to work :clueless:
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations then
	translations = translations .. (ModTextFileGetContent( "mods/Electrum/text.csv" ) or "")
	translations = translations:gsub("\r\n","\n") -- why are we removing carriage return?
	translations = translations:gsub("\n\n","\n")
	ModTextFileSetContent( "data/translations/common.csv", translations )
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
		</Entity>
		]])
	ModTextFileSetContent("data/entities/animals/boss_centipede/ending/ending_sampo_spot_mountain.xml", content)
end



local content = ModTextFileGetContent("data/scripts/buildings/forge_item_convert.lua")
local append =ModTextFileGetContent("mods/Electrum/files/forge_item_convert.lua")
if content and append then
	content = content:gsub("if converted then", append.."\nif converted then")
	ModTextFileSetContent("data/scripts/buildings/forge_item_convert.lua", content)
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

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	--EntitySetDamageFromMaterial(player_entity,"el_aqua-regia",".001") -- 1/5th as potent as acid.
	--this is commented out because i'd like a way to apply it more universally.
end

--print("Example mod init done")