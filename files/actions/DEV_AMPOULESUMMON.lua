local entity_id = GetUpdatedEntityID()
if not entity_id  or entity_id==0 then return end

local x, y = EntityGetTransform(entity_id)
if x and y then
EntityLoad("mods/Electrum/files/entities/items/ampoule.xml",x,y)
end
