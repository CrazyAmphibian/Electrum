

table.insert( actions,
{
	id          = "EL_FLASK_SUMMON",
	name 		= "Potion Summoner",
	description = "Creates an empty potion in front of you for your use.",
	sprite 		= "mods/Electrum/files/actions/flask_summon.png",
	custom_xml_file = "mods/Electrum/files/actions/flask_summon_card.xml",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1,1",
	price = 80,
	mana = 100,
	max_uses = 3,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 150 --2.5 seconds
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/flask_summon.xml")
		
	end,
} )

table.insert( actions,
{
	id          = "EL_POUCH_SUMMON",
	name 		= "Pouch Summoner",
	description = "Creates an empty powder pouch in front of you for your use.",
	sprite 		= "mods/Electrum/files/actions/pouch_summon.png",
	custom_xml_file = "mods/Electrum/files/actions/pouch_summon_card.xml",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1,1",
	price = 80,
	mana = 100,
	max_uses = 3,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 150 --2.5 seconds
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/pouch_summon.xml")
		
	end,
} )




table.insert( actions,
{
	id          = "EL_FLASK_FILL",
	name 		= "Potion Filler",
	description = "Attempts to move nearby liquids into a newly-created potion.",
	sprite 		= "mods/Electrum/files/actions/flask_fill.png",
	custom_xml_file = "mods/Electrum/files/actions/flask_fill_card.xml",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "2,3,4,5,6,10",
	spawn_probability                 = ".5,1,.5,1,.75,.1",
	price = 80,
	mana = 100,
	max_uses = 1,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 300 --5 seconds
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/flask_fill.xml")
		
	end,
} )


table.insert( actions,
{
	id          = "EL_POUCH_FILL",
	name 		= "Pouch Filler",
	description = "Attempts to move nearby powders into a newly-created powder pouch.",
	sprite 		= "mods/Electrum/files/actions/pouch_fill.png",
	custom_xml_file = "mods/Electrum/files/actions/pouch_fill_card.xml",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "2,3,4,5,6,10",
	spawn_probability                 = ".5,1,.5,1,.75,.1",
	price = 80,
	mana = 100,
	max_uses = 1,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 300 --5 seconds
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/pouch_fill.xml")
		
	end,
} )


table.insert( actions,
{
	id          = "EL_STIRING",
	name 		= "Stirer",
	description = "Mixes all powders and liquids in a radius",
	sprite 		= "mods/Electrum/files/actions/stirer.png",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "2,3,4,5,6",
	spawn_probability                 = ".5,1,.5,1,.75",
	price = 90,
	mana = 20,
	max_uses = -1,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 6 --0.1 seconds
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/stirer.xml")
		
	end,
} )



table.insert( actions,
{
	id          = "EL_WOLF", --friend request, funny. pointless, too.
	name 		= "Summon Wolf",
	description = "Summons a friendly wolf for you to... something?",
	sprite 		= "mods/Electrum/files/actions/summon_wolf.png",
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,1,2,4",
	spawn_probability                 = ".5,.25,.1,.1",
	price = 50,
	mana = 35,
	max_uses = 5,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 60 --1 second
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/summon_wolf.xml")
		
	end,
} )



table.insert( actions,
{
	id          = "EL_MATERIAL_CAST", --like warp cast, but stops at anything
	name 		= "Material Cast",
	description = "Makes a spell immediately jump a long distance or until any material is reached",
	sprite 		= "mods/Electrum/files/actions/material_cast.png",
	type 		= ACTION_TYPE_UTILITY,
	related_projectiles	= {"mods/Electrum/files/actions/material_cast.xml"},
	spawn_level                       = "2,4,5,6", -- SUPER_TELEPORT_CAST
	spawn_probability                 = "0.2,0.6,0.8,0.8", -- SUPER_TELEPORT_CAST
	
	price = 50,
	mana = 35,
	max_uses = -1,
	action 		= function()
		add_projectile_trigger_death("mods/Electrum/files/actions/material_cast.xml", 1)
		c.fire_rate_wait = c.fire_rate_wait + 9
		c.spread_degrees = c.spread_degrees - 10

		
	end,
} )



--i can't seem to be able to get entity hit working. shelved for later.

table.insert( actions,
{
	id          = "EL_PURIFYBOLT",
	name 		= "Purification Bolt",
	description = "Removes all non-majority materials from an entity",
	sprite 		= "mods/Electrum/files/actions/purification_bolt.png",
	type 		= ACTION_TYPE_PROJECTILE,
	related_projectiles	= {"mods/Electrum/files/actions/purification_bolt.xml"},
	spawn_level                       = "2,4,5,6",
	spawn_probability                 = "0.1,0.3,0.4,0.4", 
	
	price = 100,
	mana = 50,
	max_uses = -1,
	action 		= function()
		add_projectile_trigger_death("mods/Electrum/files/actions/purification_bolt.xml", 1)
		c.fire_rate_wait = c.fire_rate_wait + 120 --2 seconds
		c.spread_degrees = c.spread_degrees - 5

		
	end,
} )


if not ModIsEnabled("material_spells") then --material spawner spells.


table.insert( actions,{
	id          = "EL_TOUCH_COPPER",
		name 		= "Touch of Copper",
		description = "Transmutes everything in a short radius into copper, including walls, creatures... and you",
		sprite 		= "mods/Electrum/files/actions/touch_copper.png",
		--related_projectiles	= {"mods/Electrum/files/actions/touch_copper.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_WATER
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.4", -- TOUCH_WATER
		price = 450,
		mana = 300,
		max_uses    = 5, 
		action 		= function()
		c.fire_rate_wait=c.fire_rate_wait+1
			add_projectile("mods/Electrum/files/actions/touch_copper.xml")
		end,
})


table.insert( actions,{
		id          = "EL_TOUCH_SILVER",
		name 		= "Touch of Silver",
		description = "Transmutes everything in a short radius into silver, including walls, creatures... and you",
		sprite 		= "mods/Electrum/files/actions/touch_silver.png",
		related_projectiles	= {"mods/Electrum/files/actions/touch_silver.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_GOLD
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.5", -- TOUCH_GOLD
		price = 480,
		mana = 300,
		max_uses    = 1,
		never_unlimited = true,
		action 		= function()
			add_projectile("mods/Electrum/files/actions/touch_silver.xml")
		end,
})




	table.insert( actions,{
		id          = "EL_SEA_SLIME",
		name 		= "Sea of Slime",
		description = "Summons a large body of sticky slime below the caster",
		sprite 		= "mods/Electrum/files/actions/sea_slime.png",
		related_projectiles	= {"mods/Electrum/files/actions/sea_slime.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,4,5,6", -- SEA_OIL
		spawn_probability                 = "0.3,0.5,0.6,0.3", -- SEA_OIL
		price = 350,
		mana = 140,
		max_uses = 3,
		action 		= function()
			add_projectile("mods/Electrum/files/actions/sea_slime.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	})
	
	
table.insert( actions,{
	id          = "EL_TOUCH_SALT",
		name 		= "Touch of Salt",
		description = "Transmutes everything in a short radius into salt, including walls, creatures... and you",
		sprite 		= "mods/Electrum/files/actions/touch_salt.png",
		--related_projectiles	= {"mods/Electrum/files/actions/touch_copper.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_WATER
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.4", -- TOUCH_WATER
		price = 450,
		mana = 300,
		max_uses    = 5, 
		action 		= function()
		c.fire_rate_wait=c.fire_rate_wait+1
			add_projectile("mods/Electrum/files/actions/touch_salt.xml")
		end,
})



	table.insert( actions,{
		id          = "EL_SEA_WORM_ATTRACTOR", 
		name 		= "Sea of Worm Pheromone",
		description = "Summons a large body of worm-attracting liquid below the caster.",
		sprite 		= "mods/Electrum/files/actions/sea_worm_attractor.png",
		related_projectiles	= {"mods/Electrum/files/actions/sea_worm_attractor.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "0,4,5,6", -- SEA_ACID
		spawn_probability                 = "0.2,0.2,0.4,0.5", -- SEA_ACID
		price = 350,
		mana = 140,
		max_uses = 3,
		action 		= function()
			add_projectile("mods/Electrum/files/actions/sea_worm_attractor.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	})




	table.insert( actions,{
		id          = "EL_MATERIAL_ACCELERATIUM",
		name 		= "Acceleratium",
		description = "Transmute drops of acceleratium from nothing",
		sprite 		= "mods/Electrum/files/actions/material_acceleratium.png",
		related_projectiles	= {"mods/Electrum/files/actions/material_acceleratium.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "2,3,4,5,6", -- MATERIAL_CEMENT
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_CEMENT
		price = 100,
		max_uses = 100,
		mana = 0,
		sound_loop_tag = "sound_spray",
		action 		= function()
			add_projectile("mods/Electrum/files/actions/material_acceleratium.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
		end,
	})

	table.insert( actions,{
		id          = "EL_MATERIAL_POLYMORPH",
		name 		= "Polymorphine",
		description = "Transmute drops of polymorphine from nothing",
		sprite 		= "mods/Electrum/files/actions/material_polymorph.png",
		related_projectiles	= {"mods/Electrum/files/actions/material_polymorph.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "2,3,4,5,6", -- MATERIAL_CEMENT
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_CEMENT
		price = 100,
		max_uses = 100,
		mana = 0,
		sound_loop_tag = "sound_spray",
		action 		= function()
			add_projectile("mods/Electrum/files/actions/material_polymorph.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
		end,
	})





end --end of new material spawner spells

















	table.insert( actions,{
		id          = "EL_TOUCH_AIR",
		name 		= "Touch of Air",
		description = "Transmutes everything in a short radius into air, including walls, creatures... and you",
		sprite 		= "mods/Electrum/files/actions/touch_air.png",
		related_projectiles	= {"mods/Electrum/files/actions/touch_air.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_SMOKE
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.4", -- TOUCH_SMOKE
		price = 350,
		mana = 230,
		max_uses    = 5, 
		action 		= function()
			add_projectile("mods/Electrum/files/actions/touch_air.xml")
		end,
	})
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		table.insert( actions,{
		id          = "EL_UPSILON",
		name 		= "Upsilon",
		description = "Casts a copy of all material-type spells in the current wand",
		sprite 		= "mods/Electrum/files/actions/upsilon.png",
		spawn_requires_flag = "card_unlocked_duplicate",
		type 		= ACTION_TYPE_OTHER,
		recursive	= true,
		spawn_level                       = "5,6,10", -- MANA_REDUCE
		spawn_probability                 = "0.1,0.2,1", -- MANA_REDUCE
		price = 500,
		mana = 100,
			action 		= function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 50
			
			local firerate = c.fire_rate_wait
			local reload = current_reload_time
			local mana_ = mana
			
			if ( discarded ~= nil ) then --... the devs do know that you don't need ~= nil if the type isn't a bool, right? whatever, keeping it there for the sake of consistnecy.
				for i,data in ipairs( discarded ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true
						data.action( rec )
						dont_draw_actions = false
					end
				end
			end
			
			if ( hand ~= nil ) then
				for i,data in ipairs( hand ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true
						data.action( rec )
						dont_draw_actions = false
					end
				end
			end
			
			if ( deck ~= nil ) then
				for i,data in ipairs( deck ) do
					local rec = check_recursion( data, recursion_level )
					if ( data ~= nil ) and ( data.type == ACTION_TYPE_MATERIAL ) and ( rec > -1 ) then
						dont_draw_actions = true
						data.action( rec )
						dont_draw_actions = false
					end
				end
			end
			
			c.fire_rate_wait = firerate
			current_reload_time = reload
			mana = mana_
		end,
	})
	
	
	







table.insert( actions,{
		id          = "EL_WORM_SHOTGUN",
		name 		= "Scatterworm",
		description = "Surely this will be useful.",
		spawn_requires_flag = "card_unlocked_exploding_deer",
		sprite 		= "mods/Electrum/files/actions/worm_shotgun.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/exploding_deer_unidentified.png",
		related_projectiles	= {"mods/Electrum/files/actions/worm_shotgun.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "3,4,5,6,10", -- EXPLODING_DEER
		spawn_probability                 = "0.6,0.8,0.6,0.4,0.3", -- EXPLODING_DEER
		price = 150,
		mana = 75,
		action 		= function()
			for i=1,3 do
				add_projectile("mods/Electrum/files/actions/worm_shotgun.xml")
			end
			c.fire_rate_wait = c.fire_rate_wait + 6
			current_reload_time = current_reload_time + 15
			c.spread_degrees = c.spread_degrees + 30
		end,
	})


if DebugGetIsDevBuild() then --debug, only spawn in dev build.

table.insert( actions,
{
	id          = "EL_DEV_MASTERALCHEMISTFLASKSUMMON",
	name 		= "DEV FLASK",
	description = "DEVELOPER SPELL",
	sprite 		= "mods/Electrum/files/actions/DEV_MASTERALCHEMISTFLASKSUMMON.png",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "", --this shouldn't ever spawn.
	spawn_probability                 = "",
	price = 0,
	mana = 0,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 300
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/DEV_MASTERALCHEMISTFLASKSUMMON.xml")
		
	end,
} )


table.insert( actions,
{
	id          = "EL_DEV_AMPOULESUMMON",
	name 		= "DEV AMPOULE",
	description = "DEVELOPER SPELL",
	sprite 		= "mods/Electrum/files/actions/DEV_AMPOULESUMMON.png",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "", --this shouldn't ever spawn.
	spawn_probability                 = "",
	price = 0,
	mana = 0,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 300
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/DEV_AMPOULESUMMON.xml")
		
	end,
} )





end



table.insert( actions,
{
	id          = "EL_SPLITBOLT",
	name 		= "Splitting Bolt",
	description = "Moves all non-majority materials from an entity into new, separate potions.",
	sprite 		= "mods/Electrum/files/actions/splitting_bolt.png",
	type 		= ACTION_TYPE_PROJECTILE,
	related_projectiles	= {"mods/Electrum/files/actions/splitting_bolt.xml"},
	spawn_level                       = "2,4,5,6,10",
	spawn_probability                 = "0.1,0.3,0.3,0.3,.5", 
	
	price = 250,
	mana = 100,
	max_uses = 3,
	action 		= function()
		add_projectile_trigger_death("mods/Electrum/files/actions/splitting_bolt.xml", 1)
		c.fire_rate_wait = c.fire_rate_wait + 240 --4 seconds
		c.spread_degrees = c.spread_degrees - 5

		
	end,
} )



table.insert( actions,
{
	id          = "EL_NEW_AMPOULE",
	name 		= "Create Ampoule",
	description = "Creates a fragile, sealed ampoule containing materials around where the spell is cast.",
	sprite 		= "mods/Electrum/files/actions/new_ampoule.png",
	custom_xml_file = "mods/Electrum/files/actions/new_ampoule_card.xml",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "2,3,4,5,6,10",
	spawn_probability                 = ".5,1,.5,1,.75,.1",
	price = 80,
	mana = 80,
	max_uses = 5,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 180 --3 seconds
		if reflecting then return end
		add_projectile("mods/Electrum/files/actions/new_ampoule.xml")
		
	end,
} )



table.insert( actions,
{
	id          = "EL_ALCHEMISTHIISI_ATTACK",
	name 		= "Aggressive Flask",
	related_projectiles	= {"data/entities/items/pickup/potion_aggressive.xml"},
	description = "Launches a potion with a random material in it!",
	sprite 		= "mods/Electrum/files/actions/alchemisthiisi_attack.png",
	custom_xml_file = "mods/Electrum/files/actions/alchemisthiisi_cardaction.xml", --"data/entities/misc/custom_cards/summon_rock.xml", 
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "2,3,4,5,10",
	spawn_probability                 = ".75,1,.75,1,.15",
	price = 125,
	mana = 100,
	max_uses = 10,
	action 		= function()
		
		c.fire_rate_wait = c.fire_rate_wait + 120 --2 seconds
		add_projectile("data/entities/items/pickup/potion_aggressive.xml")
		--if reflecting then return end
		--[[
		local casterent = GetUpdatedEntityID()
	
		
		if (not casterent) or casterent==0 then return end --the game casts it upon loading a world, but that will crash the game. ain't that a bitch.
		local x,y = EntityGetTransform(casterent)
		
		
		local potion=EntityLoad("data/entities/items/pickup/potion_aggressive.xml",x,y-4)
		if not potion then return end
		
		local aicomp=EntityGetFirstComponentIncludingDisabled(casterent,"ControlsComponent")
		if not aicomp then print("cannot find controller component") return end
		local aimx,aimy=ComponentGetValue2(aicomp,"mAimingVector")
		local ang=math.atan2(aimx,aimy)
		
		local throwforce=300
		
		PhysicsApplyForce(potion,throwforce*math.sin(ang),throwforce*math.cos(ang))
		]]
	end,
} )



