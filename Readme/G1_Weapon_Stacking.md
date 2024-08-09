## G1 Weapon stacking / splitting
 - Emulates G2 NoTR inventory behavior for weapons in G1: Stackable weapons `ITEM_MULTI` will be split into their own inventory slot when equipped.
 - You <ins>should add to all your weapons</ins> `ITEM_MULTI` flag. Vanilla G1 has inventory limitation, if you have too many items in the inventory in separate slots they will cause Gothic to crash on load/save of the game.

    [![G1 Weapon stacking / splitting](https://img.youtube.com/vi/V3EHcfDa3GY/0.jpg)](https://www.youtube.com/watch?v=V3EHcfDa3GY)

Init function: `G1_WeaponStacking_Init();`
