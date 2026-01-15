Welcome to **Electrum**, a Noita mod.

Electrum is focused on the alchemy side of the game, and aims to make the it both less tedious, and more rewarding.


## Contributing

### bugs
bugs can be reported by opening an issue and using the bug report template. please be as descriptive as possible. images or video can do wonders. if you're using other mods, they may be relevant.

### requests
features requests can be done by opening an issue and using the feature request template. You can also open a blank issue if your aim is a more general discussion about the design. Overall, your feature should seek to solve a problem (be it fun or balance) in a reasonable way. Please keep feature requests limited to 1 set of features per request. you can always open more, and it helps a lot with organization.

### additions
If you want to make changes to the mod, you first need to fork the repository, make changes on your branch, then open a pull request with those changes. Make sure to keep to the template. Features should be atomic, meaning they should only affect 1 thing at a time. if your PR changes several things at once, it will be closed. Additionally, the bare minimum of coding standards are expected. your code should be readable and easy to change later. comments are appreciated, but are not required.


## For other modders

### how do i destroy the Mestarialkemistipullo/Stasis beaker?
First you must delete the `LuaComponent`s, then call `EntityKill`. you may want to empty the inventory components first.

### how do i add a material to the material gathering quest?
If your material is tagged with `[alchemy]`, `[magic_liquid]`, or `[chaotic_transmutation]`, it will automatically be added. you can also add the tag `[electrum_rewarding]` as well, or directly modify `files/temple_altar_alchemymaterialreward.lua` to add the material there, if you wish for the material to drop spells other than the standard spell pool.

### how do i add a spell reward to the material gathering quest?
locate `files/temple_altar_alchemymaterialreward.lua` and add a value to `_STDSPELLPOOL` or `_SPECIALREWARDSPELLPOOL`. if you wish to override a material's reward, you will have to modify the material's value in `_REWARDPOOL`, which associates a material name with spell list.

### how do i disallow materials from being used by the mod?
apply the `[electrum_ignored]` tag to your material. this will stop it from showing up in automatic material quest generation, transmutation bolt, and material quest reward chests. Box2D materials are also ignored as well. the `[catastrophic]` tag added from graham's things similarly will also result in a material being ignored
