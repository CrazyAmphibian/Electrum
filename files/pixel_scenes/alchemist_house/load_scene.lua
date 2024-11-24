print("electrum: spawned pixel scene alchemist house")






local base_x,base_y = -15950,140

--EntityLoad("mods/Electrum/files/pixel_scenes/alchemist_house/portal_back.xml",base_x+52,base_y+25)

EntityLoad("data/entities/props/furniture_bed.xml",base_x+20,base_y+40)
EntityLoad("data/entities/props/furniture_dresser.xml",base_x+48,base_y+40)
EntityLoad("data/entities/props/physics_chair_1.xml",base_x+15,base_y+75)
EntityLoad("data/entities/props/furniture_wood_table.xml",base_x+37,base_y+75)
EntityLoad("data/entities/props/physics_chair_2.xml",base_x+58,base_y+75)


EntityLoad("mods/Electrum/files/entities/items/book_alchemist_house.xml",base_x+85,base_y+75)

EntityLoad("mods/Electrum/files/pixel_scenes/alchemist_house/potion_looker.xml",base_x+77,base_y+77)


local bev1=EntityLoad("data/entities/items/pickup/potion_empty.xml",base_x+105,base_y+50)
AddMaterialInventoryMaterial(bev1, "sima" ,250)
local bev2=EntityLoad("data/entities/items/pickup/potion_empty.xml",base_x+105,base_y+32)
AddMaterialInventoryMaterial(bev2, "sima" ,1000)

local yummers=EntityLoad("data/entities/items/pickup/potion_empty.xml",base_x+37,base_y+70)
AddMaterialInventoryMaterial(yummers, "porridge" ,750)





