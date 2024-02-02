

table.insert( actions,
{
	id          = "EL_BALOON_SUMMON",
	name 		= "Balloon Summoner",
	description = "Creates an empty balloon in front of you for your use.",
	sprite 		= "mods/Electrum/files/actions_grahamsperks/balloon_summon.png",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "0,1,2,3,4,5,6",
	spawn_probability                 = "1,1,1,1,1,1,1",
	price = 80,
	mana = 100,
	max_uses = 3,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 150 --2.5 seconds

		add_projectile("mods/Electrum/files/actions_grahamsperks/balloon_summon.xml")
		
	end,
} )



table.insert( actions,
{
	id          = "EL_BALLOON_FILL",
	name 		= "Balloon Filler",
	description = "Attempts to move nearby gasses into a newly-created balloon.",
	sprite 		= "mods/Electrum/files/actions_grahamsperks/balloon_fill.png",
	type 		= ACTION_TYPE_OTHER,
	spawn_level                       = "2,3,4,5,6",
	spawn_probability                 = ".5,1,.5,1,.75",
	price = 80,
	mana = 100,
	max_uses = 1,
	action 		= function()
		c.fire_rate_wait = c.fire_rate_wait + 300 --5 seconds

		add_projectile("mods/Electrum/files/actions_grahamsperks/balloon_fill.xml")
		
	end,
} )

