local entity_id = GetUpdatedEntityID()
if not entity_id  or entity_id==0 then return end
local x, y = EntityGetTransform(entity_id)
EntityLoad("mods/grahamsperks/files/pickups/balloon.xml",x,y)