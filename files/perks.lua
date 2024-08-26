print("Electrum: loading perks.")


table.insert(perk_list,{

id="EL_PERSONAL_LAB",
ui_name="$el_perkname_alchemylab",
ui_description ="$el_perkdesc_alchemylab",

 ui_icon = "mods/Electrum/files/perks/personal_lab__UI.png",

    perk_icon = "mods/Electrum/files/perks/personal_lab.png",
	stackable = STACKABLE_NO,
    usable_by_enemies = false,
    not_in_default_perk_pool = false,
    func = function( entity_perk_item, entity_who_picked, item_name )
		print("Electrum: picked up perk.")
		local x,y=EntityGetTransform(entity_who_picked)
		
		--make one at the mountian altar
		local backupportal=EntityLoad("mods/Electrum/files/perks/portal_to_lab.xml",x,y)
		EntitySetTransform(backupportal,860,-1220,0,1,1)
		
		--make one above where the perk was picked up, since it won't load in to the current one.
		--local newportal=EntityLoad("mods/Electrum/files/perks/portal_to_lab.xml",x,y-48)
		GamePrintImportant("You hear a portal opening behind you.","It hums in unison with several others.")
    end
	
	
})