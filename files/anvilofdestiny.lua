print("ELECTRUM:: ANIL OF DESTINY")

--blood mix gives the effects of both, so naturally, include both effects.
append_effect("el_bloodmix", function() end)
add_spells_to_effect("el_bloodmix", { "MIST_BLOOD", "MATERIAL_BLOOD", "TOUCH_BLOOD", "CRITICAL_HIT", "BLOOD_TO_ACID", "CLOUD_BLOOD", "HITFX_CRITICAL_BLOOD", "CURSED_ORB", "BLOOD_MAGIC", "CLIPPING_SHOT", "X_RAY", "MATTER_EATER", "LUMINOUS_DRILL", "LASER_LUMINOUS_DRILL", "LANCE", "DIGGER", "POWERDIGGER", "BLACK_HOLE", "ALL_BLACKHOLES" })


--the namesake material will give the original spells. very cool.
append_effect("el_electrum", function() end)
add_spells_to_effect("el_electrum",{"EL_STIRING","EL_FLASK_SUMMON","EL_POUCH_SUMMON","EL_FLASK_FILL","EL_POUCH_FILL"})
if ModIsEnabled("grahamsperks") then
add_spells_to_effect("el_electrum",{"EL_BALOON_SUMMON","EL_BALLOON_FILL"})
end

--fitting. anti-polymorph gives you purification.
append_effect("el_antipoly_liquid", function() end)
add_spells_to_effect("el_antipoly_liquid",{"EL_PURIFYBOLT"})


--hot chocolate makes you safer, so why not spells that make other spells safer?
append_effect("el_cocoa", function() end)
add_spells_to_effect("el_cocoa",{"EL_MATERIAL_CAST","SUPER_TELEPORT_CAST","TELEPORT_CAST","LONG_DISTANCE_CAST"})

