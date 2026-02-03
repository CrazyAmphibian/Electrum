dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

AddGunAction( entity_id, "EL_ALCHEMYDAMAGEPLUS" )
AddGunAction( entity_id, "EL_ALCHEMYBUCKSHOT" )

AddGunAction( entity_id, "EL_ALCHEMYDAMAGEPLUS" )
AddGunAction( entity_id, "EL_ALCHEMYBUCKSHOT" )

AddGunAction( entity_id, "EL_ALCHEMYDAMAGEPLUS" )
AddGunAction( entity_id, "EL_ALCHEMYBUCKSHOT" )


AddGunActionPermanent( entity_id, "HITFX_CRITICAL_OIL" )

if ModIsEnabled("grahamsperks") then
	AddGunActionPermanent( entity_id, "GRAHAM_TOXIC_CRIT" )
else
	AddGunActionPermanent( entity_id, "HITFX_CRITICAL_OIL" )
end
