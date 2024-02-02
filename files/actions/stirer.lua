local spellent = GetUpdatedEntityID()
if not spellent  or spellent==0 then return end

EntityInflictDamage( spellent, 1/0, "DAMAGE_PHYSICS_BODY_DAMAGED", "", "NONE", 0, 0)
--so it turns out you need a DamageModelComponent for this to work. ok.