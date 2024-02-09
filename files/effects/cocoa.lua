
function damage_about_to_be_received( damage, x, y, ent_thats_responsible, crit_chance )
	local mult=.8

	local player = EntityGetParent(GetUpdatedEntityID())
	local damagemodel = EntityGetFirstComponent( player, "DamageModelComponent" )
	if not damagemodel then return damage*mult,crit_chance end
	
	mult=mult*(tonumber( ComponentGetValue2( damagemodel, "hp" ) )-damage*.8)/tonumber( ComponentGetValue2( damagemodel, "max_hp"))<=.5 and .75 or 1 --20% to 40% damage reduction under 1/2 health. operates like the brass beast from TF2, so if the hit would reduce you to that amount.

	--print("called about")
    return damage*mult, crit_chance
end



--why the fuck does this function not get called?
function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )

if projectile_thats_responsible then
		local proj=EntityGetFirstComponent(projectile_thats_responsible,"ProjectileComponent")
		if proj then
			local k=ComponentGetValue2(proj,"ConfigDamagesByType")
			--print(type(k),tostring(k))
		end
end

print("called")

end


