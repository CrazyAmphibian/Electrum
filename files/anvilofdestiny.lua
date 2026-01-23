print("ELECTRUM:: ANIL OF DESTINY")

--blood mix gives the effects of both, so naturally, include both effects.
append_effect("el_bloodmix", function() end)
add_spells_to_effect("el_bloodmix", { "MIST_BLOOD", "MATERIAL_BLOOD", "TOUCH_BLOOD", "CRITICAL_HIT", "BLOOD_TO_ACID", "CLOUD_BLOOD", "HITFX_CRITICAL_BLOOD", "CURSED_ORB", "BLOOD_MAGIC", "CLIPPING_SHOT", "X_RAY", "MATTER_EATER", "LUMINOUS_DRILL", "LASER_LUMINOUS_DRILL", "LANCE", "DIGGER", "POWERDIGGER", "BLACK_HOLE", "ALL_BLACKHOLES" })


--the namesake material will give the original spells. very cool.
append_effect("el_electrum", function() end)
add_spells_to_effect("el_electrum",{"EL_FLASK_SUMMON","EL_POUCH_SUMMON","EL_FLASK_FILL","EL_POUCH_FILL"})
if ModIsEnabled("grahamsperks") then
add_spells_to_effect("el_electrum",{"EL_BALOON_SUMMON","EL_BALLOON_FILL"})
end

--fitting. anti-polymorph gives you purification.
append_effect("el_antipoly_liquid", function() end)
add_spells_to_effect("el_antipoly_liquid",{"EL_PURIFYBOLT","EL_SPLITBOLT","EL_TRANSMUTEBOLT"})


--hot chocolate makes you safer, so why not spells that make other spells safer?
append_effect("el_cocoa", function() end)
add_spells_to_effect("el_cocoa",{"EL_MATERIAL_CAST","SUPER_TELEPORT_CAST","TELEPORT_CAST","LONG_DISTANCE_CAST"})

--focused around construction
append_effect("el_metalmakerjuice", function() end)
add_spells_to_effect("el_metalmakerjuice",{"TEMPORARY_PLATFORM","TEMPORARY_PLATFORM","MATTER_EATER","CLIPPING_SHOT"})

--alchemical
local alchlist={"HITFX_EXPLOSION_ALCOHOL","HITFX_EXPLOSION_SLIME","HITFX_TOXIC_CHARM","HITFX_CRITICAL_BLOOD","HITFX_BURNING_CRITICAL_HIT","HITFX_CRITICAL_OIL","HITFX_CRITICAL_WATER"}
append_effect("el_stable", function() end)
add_spells_to_effect("el_stable",alchlist)
append_effect("el_unstable", function() end)
add_spells_to_effect("el_unstable",alchlist)
append_effect("el_chaotic", function() end)
add_spells_to_effect("el_chaotic",alchlist)


append_effect("el_staticlite", function() end)
add_spells_to_effect("el_staticlite",{"QUANTUM_SPLIT","LINE_ARC","CHAOTIC_ARC","SWAPPER_PROJECTILE"})