local entity_id = GetUpdatedEntityID()
if not entity_id  or entity_id==0 then return end --this is here to prevent crashes since noita seems to have a weird habit sometimes where it phantom casts the spell upon loading. the resulting entity will then go out of bounds and that causes an error. i hope this works. it's annyoing.

local x, y = EntityGetTransform(entity_id)
if x and y then
EntityLoad("data/entities/items/pickup/potion_empty.xml",x,y)
end
