# AF Script Packet status: WIP

Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)

Credits: We are using here many scripts sourced from great Gothic community. None of this would be possible without Ikarus/LeGo and of course without modders willing to share their amazing work/ideas.
Thank you: Sektenspinner, Lehona, Gottfried, Szapp (mud-freak), Neconspictor, OrcWarrior (PL), Dalai Zoll and many more (we will try to keep list up to date :) )

In this Script Packet we would like to consolidate as many useful functions as possible.
Main goal is to put together several useful features that any modder can simply enable by calling single init function.
In a future we will add wiki with examples explaining how to use each feature.

## Features available so far - in case of all of them you need both Ikarus (1.2.2) and LeGo (2.7.1):
1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.

### Gothic 1 Weapon stacking / splitting
Emulates G2A inventory behaviour for weapons in G1 --> Stackable weapons (with flags | ITEM_MULTI) will be split into their own inventory slot when equipped.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_WeaponStacking.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_WeaponStacking_Init ();`.

### Gothic 1 Ever looming barrier
Hooks Barrier render function and prevents Barrier from disappearing completely.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_BarrierEverlooming.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_BarrierEverlooming_Init ();`.

### Gothic 1 Enhanced Trading 
Improves G1 trading:
 - ore is exchanged automatically 
 - you can easily control selling/buying multiplier and define NPC/item-specific rules separately for every NPC. (for example Wolf can buy furs from you for 100% item value)
 - you can easily prevent selling items to NPC. (for example Huno will not buy from you anything but weapons)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedTrading.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_EnhancedTrading_Init ();`.

### Gothic 1 Enhanced Pick Locking
Package emulates G2A behaviour for PickLocking:
 - if players NPC_TALENT_PICKLOCK level is 0 then he can't interact with locked doors/chests.
 - if oCMobLockable requires special key only and he does not have it then he can't interact with locked doors/chests (won't break any picklocks).
 - if players NPC_TALENT_PICKLOCK level > 0 BUT does not have pickLocks he can't use interact with locked doors/chests.
 - if player has key that can open doors/chests then he can do so without NPC_TALENT_PICKLOCK.
 - pickLock failrate (breaking) is based on Players dexterity. Higher it is lower the chance to break picklocks is. (by default minimum failrate is 10%)
 - hero will say whether: he needs to learn skill, get picklocks or specific key.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedPickLocking.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_EnhancedPickLocking_Init ();`.

### Gothic 1 Player Map
Improved Map handling when pressing 'M':
 - player's animation will not be reset if he does not have map (this removes exploit in which pressing M would allow you to jump in air)
 - you can easily control which map will be displayed in what circumstances
 - if there is no map preferation defined, then script will re-open last opened map
 - if player didn't open any map yet, then script will try to open: ITWRWORLDMAP_ORC, if not in inventory then ITWRWORLDMAP. If none of these is in inventory then first available map in inventory.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_PlayerMap.src`
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G1_PlayerMap_Init ();`.

### Gothic 1 & 2 Enhanced Information Manager
Package adds several features for dialogues (Information manager):
 - Simple dialog color/font/text alignment control - using dialog description.
 - Answering system
 - Spinner system
 - Dialog control with numeric keys (1 .. 9)

   [More on this feature here](https://forum.worldofplayers.de/forum/threads/1532719-G1-G2-Simple-dialogs-font-change-and-color-change?highlight=simple)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedInfoManager.src` for G1
    * `AF-Script-Packet\_headers_G2_EnhancedInfoManager.src` for G2A
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G12_EnhancedInfoManager_Init ();`.

### Gothic 1 & 2 Enhanced oCTriggerScript
Package adds new features for oCTriggerScript objects:
 - zCTrigger_bitfield_callEventFuncs flag - which will cause call additional event functions: oCTriggerScript.scriptFunc + _OnTouch, _OnTrigger, _OnContact, _OnUnTouch 
 - zCTrigger_bitfield_reactToOnContact flag - custom event replacing _OnTouch & _OnTrigger event. It is repeatedly fired as long as there is any object in oCTriggerScript._zCVob_touchVobList_numInArray.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedoCTriggerScript.src` for G1
    * `AF-Script-Packet\_headers_G2_EnhancedoCTriggerScript.src` for G2A
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G12_EnhancedoCTriggerScript_Init ();`.

In a folder `AF-Script-Packet\Standalone-Packages\G12-EnhancedoCTriggerScript\` you can find practical examples:
1. `example_FirePlaceFireDamage.d` demonstrates how you can add to all fireplaces in your world oCTriggerScript objects that will burn every NPC that is in contact with such fireplace. (_OnContact event)

    [![Gothic FirePlace zCTrigger FireDamage](https://img.youtube.com/vi/7KYLjUITbi4/0.jpg)](https://www.youtube.com/watch?v=7KYLjUITbi4)
2. `example_FirePlaceSavingPolicy.d` demonstrates how you can add to all fireplaces in your world oCTriggerScript objects that will allow you to save game only nearby fireplace. (_OnTouch, _OnUnTouch events)

    [![Gothic FirePlace zCTrigger FireDamage](https://img.youtube.com/vi/U9IVhqSixW0/0.jpg)](https://www.youtube.com/watch?v=U9IVhqSixW0)

### Gothic 1 & 2 Enable Player States
AI states that you can use on Player are hardcoded in engine, in vanilla you can use following:
Gothic 1: ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP, ZS_MAGICFEAR
Gothic 2: ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_WHIRLWIND, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP

This package allows you to enable additional AI States. (without limitation)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnablePlayerStates.src` for G1
    * `AF-Script-Packet\_headers_G2_EnablePlayerStates.src` for G2A
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G12_EnablePlayerStates_Init ();`.

### Gothic 1 & 2 Pick Lock Helper

Simple feature, that shows Pick Lock combination progress.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_PickLockHelper.src` for G1
    * `AF-Script-Packet\_headers_G2_PickLockHelper.src` for G2A
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G12_PickLockHelper_Init ();`.

    [![Gothic 1 & 2 Pick Lock Helper](https://img.youtube.com/vi/kdX9e3QlAbg/0.jpg)](https://www.youtube.com/watch?v=kdX9e3QlAbg)

### Gothic 1 & 2 Prevent Looting

Simple feature, that allows you to control which NPC's can be looted. (for example prevent looting from traders)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_PreventLooting.src` for G1
    * `AF-Script-Packet\_headers_G2_PreventLooting.src` for G2A
1. Update file `_work\data\Scripts\Content\Story\Statup.d` - find function `INIT_Global()`. If you do not have `INIT_Global()` function, create it and call it from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions). In `INIT_Global()` call `G12_PreventLooting_Init ();`.
