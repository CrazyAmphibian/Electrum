local entity_id = GetUpdatedEntityID()
if not entity_id  or entity_id==0 then  return end


local x=GlobalsGetValue("ELECTRUM_personallab_enter_x") or 780 --default to the altar
local y=GlobalsGetValue("ELECTRUM_personallab_enter_y") or -1190


local tp=EntityGetFirstComponentIncludingDisabled(entity_id, "TeleportComponent")

if tp and tp~=0 then
ComponentSetValue2(tp,"target",(tonumber(x) or 780) ,(tonumber(y) or -1190)+28 )
end