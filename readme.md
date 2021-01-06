# AF Script Packet status: WIP

Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)

### Gothic 1 Weapon stacking
1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_WeaponStacking.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_WeaponStacking_Init ();`.
