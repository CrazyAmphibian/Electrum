
local picked_statuses={
	"ELECTROCUTION",
	"ON_FIRE",
	"POISON",
	"BERSERK",
	"MOVEMENT_SLOWER",
	"DRUNK",
	"RADIOACTIVE",
	"OILED",
	"SLIMY",
	"WORM_ATTRACTOR",
	"FOOD_POISONING",
	"INTERNAL_FIRE",
	"INTERNAL_ICE",
	"JARATE",
	"MOVEMENT_SLOWER_2X",
	"CONFUSION",}
	--[[don't use the following effects because:
	WEAKNESS - it's just a flat 10x damage taken holy shit
	FROZEN - if you kick something frozen it does bighuge damage and basically instakills
	CHARM - this crashes the game if it is applied to kolmi
	]]
local picked_sprites={
	"data/ui_gfx/status_indicators/electrocution.png",
	"data/ui_gfx/status_indicators/on_fire.png",
	"data/ui_gfx/status_indicators/poisoned.png",
	"data/ui_gfx/status_indicators/berserk.png",
	"data/ui_gfx/status_indicators/ingestion_movement_slower.png",
	"data/ui_gfx/status_indicators/drunk.png",
	"data/ui_gfx/status_indicators/radioactive.png",
	"data/ui_gfx/status_indicators/oiled.png",
	"data/ui_gfx/status_indicators/slimy.png",
	"data/ui_gfx/status_indicators/worm_attractor.png",
	"data/ui_gfx/status_indicators/food_poisoning.png",
	"data/ui_gfx/status_indicators/internal_fire.png",
	"data/ui_gfx/status_indicators/ingestion_freezing.png",
	"data/ui_gfx/status_indicators/jarate.png",
	"data/ui_gfx/status_indicators/movement_slower.png",
	"data/ui_gfx/status_indicators/confusion.png",}

local entity = GetUpdatedEntityID()

if entity%2==1 then return end --only half the projectiles add an effect because noita effect code is fucked

SetRandomSeed(entity, GameGetFrameNum())
local pick=Random(1,#picked_statuses)
local EFFECT_TIME=120 --2 seconds

EntityAddComponent2(entity, "GameEffectComponent", {
	effect=picked_statuses[pick],
	frames=EFFECT_TIME,
})

EntityAddComponent2(entity, "UIIconComponent", {
	icon_sprite_file=picked_sprites[pick],
	display_above_head=true,
})