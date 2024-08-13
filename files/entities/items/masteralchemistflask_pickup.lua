print("%%called")
function item_pickup(ent_id)
print"picked UP!"
EntityAddTag(ent_id,"forgeable") --to prevent looping FX
end