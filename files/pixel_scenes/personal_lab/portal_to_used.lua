function portal_teleport_used( from_x, from_y, to_x, to_y )

local entity_id = GetUpdatedEntityID()
if not entity_id  or entity_id==0 then  return end

local from_x,from_y=EntityGetTransform(entity_id) -- seriously?

print("electrum: teleported to PL from:",from_x,from_y)

local x=GlobalsSetValue("ELECTRUM_personallab_enter_x",from_x)
local y=GlobalsSetValue("ELECTRUM_personallab_enter_y",from_y)
end