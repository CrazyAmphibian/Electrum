dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/gun/gun_actions.lua" )
dofile_once( "data/scripts/game_helpers.lua" )

-------------------------------------------------------------------------------

function make_random_card( x, y )
	-- this does NOT call SetRandomSeed() on purpouse. 
	-- SetRandomSeed( x, y )

	local item = ""
	local valid = false

	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then
				valid = true
			end

			-- 
			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end
			
		else
			valid = true
		end
	end


	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

function chest_load_gold_entity( entity_filename, x, y, remove_timer )
	local eid = load_gold_entity( entity_filename, x, y, remove_timer )
	local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

	-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
	if item_comp ~= nil then
		if( ComponentGetValue2( item_comp, "auto_pickup") ) then
			ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
		end
	end
end

-------------------------------------------------------------------------------


local function get_rewards(x,y,entityid)
	local rng=Random(0,10)
	
	if rng==0 then --roll additional loot
		get_rewards(x,y,entityid)
		get_rewards(x,y,entityid)
		get_rewards(x,y,entityid)
	elseif rng==1 then --roll additional loot
		get_rewards(x,y,entityid)
		get_rewards(x,y,entityid)
	elseif rng==2 then --gold
		for i=1,Random(3,9) do
			chest_load_gold_entity( "data/entities/items/pickup/goldnugget_1000.xml", x + Random(-10,10), y - 4 + Random(-10,5) )
		end
		for i=1,Random(5,15) do
			chest_load_gold_entity( "data/entities/items/pickup/goldnugget_200.xml", x + Random(-10,10), y - 4 + Random(-10,5) )
		end
	elseif rng==3 or rng==4 then --spell refresher/heart
		if Random(1,4)==1 then --25% chance to be a refresher
			EntityLoad("data/entities/items/pickup/spell_refresh.xml",x,y)
		else
			rng=Random(1,5)
			if rng==1 or rng==2 then --40%
				EntityLoad("data/entities/items/pickup/heart_fullhp.xml",x,y)
			else --60%
				EntityLoad("data/entities/items/pickup/heart_better.xml",x,y)
			end
		end
	elseif rng==5 or rng==6 then --pouch/potion
		local nent=EntityLoad(Random(1,3)==1 and "data/entities/items/pickup/powder_stash.xml" or "data/entities/items/pickup/potion_empty.xml",x,y) --33% chance to be a pouch
		local MIC=EntityGetFirstComponentIncludingDisabled(nent, "MaterialInventoryComponent")
		local fillcv=ComponentGetValue2(MIC,"count_per_material_type")
		for i=1, #fillcv do
			AddMaterialInventoryMaterial(nent, CellFactory_GetName(i-1) ,-fillcv[i]*0) --remove however much material is in there.
		end

		local selectedmaterial
		rng=Random(1,4)
		if rng==1 then --truly random material (25%)
			local matdb=GlobalsGetValue("ELECTRUM_MATERIALS_DATABASE_LISTALL")
			local allmat={}
			for m in matdb:gmatch("[^\x1F]+") do
				allmat[#allmat+1]=m
			end
			selectedmaterial=allmat[Random(1,#allmat)]
		elseif rng<=2 then -- alchemy (25%)
			local matdb=GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_[alchemy]")
			local allmat={}
			for m in matdb:gmatch("[^\x1F]+") do
				allmat[#allmat+1]=m
			end
			selectedmaterial=allmat[Random(1,#allmat)]
		elseif rng<=3 then --magic_liquid (25%)
			local matdb=GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_[magic_liquid]")
			local allmat={}
			for m in matdb:gmatch("[^\x1F]+") do
				allmat[#allmat+1]=m
			end
			selectedmaterial=allmat[Random(1,#allmat)]
		else --chaotic_transmutation (25%)
			local matdb=GlobalsGetValue("ELECTRUM_MATERIAL_DATABASE_TAG_[chaotic_transmutation]")
			local allmat={}
			for m in matdb:gmatch("[^\x1F]+") do
				allmat[#allmat+1]=m
			end
			selectedmaterial=allmat[Random(1,#allmat)]
		end
		AddMaterialInventoryMaterial(nent, selectedmaterial ,1000)
	elseif rng==7 or rng==8 then --wand
		rng=Random(1,10)
		if rng==1 then --10%
			EntityLoad("data/entities/items/wand_unshuffle_04.xml",x,y)
		elseif rng==2 then --10%
			EntityLoad("data/entities/items/wand_level_04.xml",x,y)
		elseif rng<=6 then --40%
			EntityLoad("data/entities/items/wand_unshuffle_03.xml",x,y)
		else--40%
			EntityLoad("data/entities/items/wand_level_03.xml",x,y)
		end
	elseif rng==9 or rng==10 then --misc item
		rng=Random(1,3)
		if rng==1 then --elemental stone
			if Random(1,6)==1 then --10% for poopstone
				local p={"data/entities/items/pickup/poopstone.xml",}
				
				if ModIsEnabled("grahamsperks") then
					p[#p+1]="mods/grahamsperks/files/pickups/soapstone.xml"
				end
			
				EntityLoad(p[Random(1,#p)],x,y)
			else
				local p={"data/entities/items/pickup/thunderstone.xml","data/entities/items/pickup/brimstone.xml","data/entities/items/pickup/waterstone.xml","data/entities/items/pickup/stonestone.xml",}

				EntityLoad(p[Random(1,#p)],x,y)
			end
		elseif rng==2  then --runestone
			local p={"data/entities/items/pickup/runestones/runestone_disc.xml","data/entities/items/pickup/runestones/runestone_fireball.xml","data/entities/items/pickup/runestones/runestone_laser.xml","data/entities/items/pickup/runestones/runestone_lava.xml","data/entities/items/pickup/runestones/runestone_metal.xml","data/entities/items/pickup/runestones/runestone_null.xml","data/entities/items/pickup/runestones/runestone_slow.xml",}
			
			if ModIsEnabled("grahamsperks") then
				p[#p+1]="mods/grahamsperks/data/entities/items/pickup/runestones/runestone_graham_phase.xml"
			end    
			
			EntityLoad(p[Random(1,#p)],x,y)
		else --kammi/eye/moon/die/mcguffin
			local p={"data/entities/items/pickup/broken_wand.xml","data/entities/items/pickup/evil_eye.xml","data/entities/items/pickup/gourd.xml","data/entities/items/pickup/moon.xml","data/entities/items/pickup/safe_haven.xml",}
			
			if HasFlagPersistent( "card_unlocked_duplicate" ) then
				if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) then
					p[#p+1]="data/entities/items/pickup/physics_greed_die.xml"
				else
					p[#p+1]="data/entities/items/pickup/physics_die.xml"
				end
				
				if ModIsEnabled("grahamsperks") then
					p[#p+1]="mods/grahamsperks/files/pickups/lovely_die.xml"
				end
			end
			
			if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) then
				p[#p+1]="data/entities/items/pickup/physics_gold_orb_greed.xml"
			else
				p[#p+1]="data/entities/items/pickup/physics_gold_orb.xml"
			end
			
			if ModIsEnabled("grahamsperks") then
				p[#p+1]="mods/grahamsperks/files/pickups/cybereye.xml"
				p[#p+1]="mods/grahamsperks/files/pickups/safe.xml"
			end
			
			EntityLoad(p[Random(1,#p)],x,y)
		end
	end
end




function on_open( entity_item )
	local x, y = EntityGetTransform( entity_item )
	SetRandomSeed( x+y, (tonumber(GlobalsGetValue("Electrum_alchemyspellrandomcalls")) or 0)+StatsGetValue("world_seed") )

	get_rewards(x,y,entity_item)

	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)
end

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "$log_chest", "" )
	-- GameTriggerMusicCue( "item" )

	--if (remove_entity == false) then
	--	EntityLoad( "data/entities/misc/chest_random_dummy.xml", x, y )
	--end

	on_open( entity_item )
	
	EntityKill( entity_item )
end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
	
	on_open( entity_item )

	edit_component( entity_item, "ItemComponent", function(comp,vars)
		EntitySetComponentIsEnabled( entity_item, comp, false )
	end)
	
	EntityKill( entity_item )
end