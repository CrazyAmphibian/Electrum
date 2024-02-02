local entity_id = GetUpdatedEntityID()
if (not entity_id)  or entity_id==0 then return end

local x, y = EntityGetTransform(entity_id)
local newent=EntityLoad("data/entities/animals/wolf.xml",x,y)
local charm_component = GetGameEffectLoadTo( newent, "CHARM", true )
if charm_component ~= nil then
	--if charm_component~=0 then
	ComponentSetValue( charm_component, "frames", -1 )
	--end
end
