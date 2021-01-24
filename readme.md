# AF Script Packet status: WIP

Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)

Credits: We are using here many scripts sourced from great Gothic community. None of this would be possible without Ikarus/LeGo and of course without modders willing to share their amazing work/ideas.
Thank you: Sektenspinner, Lehona, Gottfried, Szapp (mud-freak), Neconspictor, OrcWarrior (PL) and many more (we will try to keep list up to date :) )

In this Script Packet we would like to consolidate as many useful functions as possible.
Main goal is to put together several useful features that any modder can simply enable by calling single init function.
In a future we will add wiki with more examples on how to use each feature.

## Features available so far:

### Gothic 1 Weapon stacking / splitting
Emulates G2A inventory behaviour for weapons in G1 --> Stackable weapons (with flags | ITEM_MULTI) will be split into their own inventory slot when equipped.
1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_WeaponStacking.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_WeaponStacking_Init ();`.

### Gothic 1 Ever looming barrier
Hooks Barrier render function and prevents Barrier from disappearing completely.
1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_BarrierEverlooming.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_Barrier_Everlooming_Init ();`.

### Gothic 1 Enhanced Trading 
Improves G1 trading:
 - ore is exchanged automatically 
 - you can easily control selling/buying multiplier and define NPC/item-specific rules separately for every NPC. (for example Wolf can buy furs from you for 100% item value)
 - you can easily prevent selling items to NPC. (for example Huno will not buy from you anything but weapons)

1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedTrading.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_EnhancedTrading_Init ();`.

### Gothic 1 & 2 Enhanced Information Manager
Package adds several features for dialogues (Information manager):
 - Simple dialog color/font/text alignment control - using dialog description.
 - Answering system
 - Spinner system
 - Dialog control with numeric keys (1 .. 9)

   [More on this feature here](https://forum.worldofplayers.de/forum/threads/1532719-G1-G2-Simple-dialogs-font-change-and-color-change?highlight=simple)

1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedInfoManager.src` for G1
    * `AF-Script-Packet\_headers_G2_EnhancedInfoManager.src` for G2A
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G12_EnhancedInfoManager_Init ();`.
