print("electrum: spawned pixel scene personal_lab")






local base_x,base_y = 10000,50000

EntityLoad("mods/Electrum/files/pixel_scenes/personal_lab/portal_back.xml",base_x+52,base_y+25)

local shelf1x,shelf1y=39,157
local shelf1endx,shelf1endy=189,157


EntityLoad("mods/Electrum/files/wands/hose.xml",base_x+110,base_y+120)

for i=0,4 do

local x=shelf1x+base_x+(i*12)
local y=base_y+shelf1y

if x and y then
EntityLoad("data/entities/items/pickup/potion_empty.xml",x+10,y-4)
end

x=shelf1endx+base_x-(i*16)

local ent=EntityLoad("data/entities/items/pickup/powder_stash.xml",x-10,y-4)
--pouches start with shit in them, so let's fix that.

--get the inventory component
local comp=EntityGetFirstComponentIncludingDisabled(ent, "MaterialInventoryComponent")
--then get an array of its materials
local cv=ComponentGetValue2(comp,"count_per_material_type")
--then for each material we find:
for i=1, #cv do
	AddMaterialInventoryMaterial(ent, CellFactory_GetName(i-1) ,0) --remove however much material is in there.
end


end
