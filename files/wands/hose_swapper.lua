dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")
dofile("data/scripts/gun/gun_actions.lua")


local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )


nearby_spells=EntityGetInRadiusWithTag(x,y,24,"card_action")
local spellto_swap
for i=1,#nearby_spells do
	local spe=nearby_spells[i]
	if (not EntityHasTag(spe,"ELECTRUM_hose_swaped_before")) and EntityGetRootEntity(spe)==spe then --make sure it won't endlessly loop swapping the spell
		local iac=EntityGetFirstComponentIncludingDisabled(spe,"ItemActionComponent")
		if iac and iac~=0 then
			local spell_id=ComponentGetValue2(iac,"action_id")
			local match
			for i=1,#actions do
				local action=actions[i]
				if action.id==spell_id then
					match=action
					break
				end
			end
			
			if match and match.type==ACTION_TYPE_MATERIAL and match.id:find("MATERIAL_") then
				spellto_swap=spe
				break
			end
			
		end
	end
end

if not spellto_swap then return end

local storedspellentity=(EntityGetAllChildren(entity_id,"card_action") or {})[1]
if storedspellentity then 
	EntityRemoveFromParent(storedspellentity)
	EntitySetComponentsWithTagEnabled(storedspellentity,"enabled_in_world",true)
	EntitySetComponentsWithTagEnabled(storedspellentity,"item_unidentified",false)
	EntitySetTransform(storedspellentity,x+math.random(-12,12),y-12)
	EntityAddTag(storedspellentity,"ELECTRUM_hose_swaped_before")
	EntityAddComponent2(storedspellentity,"LuaComponent",{remove_after_executed=true,execute_every_n_frame=-1,script_item_picked_up="mods/Electrum/files/wands/hose_spell_pickup.lua"})
end

local x2,y2 = EntityGetTransform( spellto_swap )
local fxe=EntityLoad("data/entities/particles/image_emitters/potion_effect.xml", (x+x2)/2, (y+y2)/2)
if fxe then
	local ac=EntityGetFirstComponentIncludingDisabled(fxe,"AudioComponent")
	ComponentSetValue2(ac,"file","data/audio/Desktop/projectiles.bank")
	ComponentSetValue2(ac,"event_root","player_projectiles/all_seeing_eye")
end

EntityAddChild(entity_id,spellto_swap)
EntitySetComponentsWithTagEnabled(spellto_swap,"enabled_in_world",false)
