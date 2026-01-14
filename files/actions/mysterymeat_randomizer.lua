local mats={
	--{material, weight}
	{"meat",10},
	{"meat_done",5},
	{"meat_burned",2},
	{"meat_helpless",5},
	{"meat_frog",5},
	{"meat_cursed",2},
	{"meat_cursed_dry",2},
	{"meat_slime",2},
	{"meat_slime_green",1},
	{"meat_slime_orange",1},
	{"meat_slime_cursed",2},
	{"meat_confusion",2},
	{"meat_teleport",2},
	{"meat_fast",2},
	{"meat_polymorph_protection",1},
	}

local wtab={}
for i=1,#mats do
	for n=1,mats[i][2] do
		wtab[#wtab+1]=mats[i][1]
	end
end
local eid=GetUpdatedEntityID()
SetRandomSeed(eid, GameGetFrameNum())
local pick = wtab[Random(1,#wtab)]

local pisc=EntityGetFirstComponentIncludingDisabled(eid,"PhysicsImageShapeComponent")
ComponentSetValue2(pisc,"material",CellFactory_GetType(pick) )
