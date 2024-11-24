local text,file
file=ModTextFileGetContent("mods/Electrum/files/pixel_scenes/alchemist_house/scene_loader.xml")
	
	
text= ModTextFileGetContent( "data/biome/_pixel_scenes.xml" )

if text then
	text = string.gsub( text, '</mBufferedPixelScenes>', file.."\n</mBufferedPixelScenes>" )
	ModTextFileSetContent( "data/biome/_pixel_scenes.xml", text )
else
error("TEXT LOADING FAILED IN data/biome/_pixel_scenes.xml")
end

text= ModTextFileGetContent( "data/biome/_pixel_scenes_newgame_plus.xml" )
if text then
	text = string.gsub( text, '</mBufferedPixelScenes>', file.."\n</mBufferedPixelScenes>" )
	ModTextFileSetContent( "data/biome/_pixel_scenes_newgame_plus.xml", text )
else
error("TEXT LOADING FAILED IN data/biome/_pixel_scenes_newgame_plus.xml")
end
print("electrum: successfully pushed alchemist_house scene loader.")
--print(string.rep("@",500))
--LoadPixelScene("mods/Electrum/files/pixel_scenes/personal lab/scene.png","",100,100,"",true,false,{},50,false)
