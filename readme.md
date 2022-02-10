# AF Script Packet status: WIP

Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)

Credits: We are using here many scripts sourced from great Gothic community. None of this would be possible without Ikarus/LeGo and of course without modders willing to share their amazing work/ideas.
Thank you: Sektenspinner, Lehona, Gottfried, Szapp (mud-freak), Neconspictor, OrcWarrior (PL), Dalai Zoll, Cryp18Struct and many more (we will try to keep list up to date :) )

Special thanks goes to: helpo1 :crown:, who endlessly debugged many features, even when we asked him not to.

In this Script Packet we would like to consolidate as many useful functions as possible.
Main goal is to put together several useful features that any modder can simply enable by calling single init function.
In a future we will add wiki with examples explaining how to use each feature.

## Features available so far - in case of all of them you need both Ikarus (1.2.2) and LeGo (2.8.1):
1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. Gothic 1 users will have to add function `Init_Global();` into their Startup.d file (it is not there by default). Call `Init_Global ();` from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions).

### Gothic 1 Weapon stacking / splitting
Emulates G2A inventory behaviour for weapons in G1 --> Stackable weapons (with flags | ITEM_MULTI) will be split into their own inventory slot when equipped.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_WeaponStacking.src`
1. Call `G1_WeaponStacking_Init ();` from your `Init_Global();` function in `Startup.d` file.

    [![Gothic 1 Weapon stacking / splitting](https://img.youtube.com/vi/V3EHcfDa3GY/0.jpg)](https://www.youtube.com/watch?v=V3EHcfDa3GY)

### Gothic 1 Ever looming barrier
Hooks Barrier render function and prevents Barrier from disappearing completely.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_BarrierEverlooming.src`
1. Call `G1_BarrierEverlooming_Init ();` from your `Init_Global();` function in `Startup.d` file.

    [![Gothic 1 Ever looming barrier](https://img.youtube.com/vi/ZEyFpN-f0Y8/0.jpg)](https://www.youtube.com/watch?v=ZEyFpN-f0Y8)

### Gothic 1 Enhanced Trading
Improves G1 trading:
 - ore is exchanged automatically
 - you can easily control selling/buying multiplier and define NPC/item-specific rules separately for every NPC. (for example Wolf can buy furs from you for 100% item value)
 - you can easily prevent selling items to NPC. (for example Huno will not buy from you anything but weapons)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedTrading.src`
1. Call `G1_EnhancedTrading_Init ();` from your `Init_Global();` function in `Startup.d` file.

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
1. Call `G1_EnhancedPickLocking_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 Player Map
Improved Map handling when pressing 'M':
 - player's animation will not be reset if he does not have map (this removes exploit in which pressing M would allow you to jump in air)
 - you can easily control which map will be displayed in what circumstances
 - if there is no map preferation defined, then script will re-open last opened map
 - if player didn't open any map yet, then script will try to open: ITWRWORLDMAP_ORC, if not in inventory then ITWRWORLDMAP. If none of these is in inventory then first available map in inventory.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_PlayerMap.src`
1. Call `G1_PlayerMap_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 Quick Loot
Allows you to quickly loot items from chests and dead NPCs by pressing Alt key
 - transfers items from dead NPC to players inventory, closes inventory
 - transfers items from chest to players inventory, closes inventory, ends interaction with chest

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_QuickLoot.src`
1. Call `G1_QuickLoot_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 Better Inventory Controls
Enables better navigation in inventories
 - use home/end keys to navigate to first/last item
 - use page up/page down keys to scroll faster through inventory
 - special move key (Alt) + key Up will put item to hand
 - special move key (Alt) + key Down will drop item (1 piece) from inventory

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_BetterInventoryControls.src`
1. Call `G1_BetterInventoryControls_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 & 2 Enhanced Information Manager
Package adds several features for dialogues (Information manager):
 - Simple dialog color/font/text alignment control - using dialog description.
 - Answering system
 - Spinner system
 - Dialog control with numeric keys (1 .. 9)
 - Dialog overlays through which you can simply change color for specific words

   [More on this feature here](https://forum.worldofplayers.de/forum/threads/1532719-G1-G2-Simple-dialogs-font-change-and-color-change?highlight=simple)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedInfoManager.src` for G1
    * `AF-Script-Packet\_headers_G2_EnhancedInfoManager.src` for G2A
1. Call `G12_EnhancedInfoManager_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 & 2 Enhanced oCTriggerScript
Package adds new features for oCTriggerScript objects:
 - zCTrigger_bitfield_callEventFuncs flag - which will cause call additional event functions: oCTriggerScript.scriptFunc + _OnTouch, _OnTrigger, _OnContact, _OnUnTouch
 - zCTrigger_bitfield_reactToOnContact flag - custom event replacing _OnTouch & _OnTrigger event. It is repeatedly fired as long as there is any object in oCTriggerScript._zCVob_touchVobList_numInArray.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_EnhancedoCTriggerScript.src` for G1
    * `AF-Script-Packet\_headers_G2_EnhancedoCTriggerScript.src` for G2A
1. Call `G12_EnhancedoCTriggerScript_Init ();` from your `Init_Global();` function in `Startup.d` file.

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
1. Call `G12_EnablePlayerStates_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 & 2 Pick Lock Helper

Simple feature, that shows Pick Lock combination progress.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_PickLockHelper.src` for G1
    * `AF-Script-Packet\_headers_G2_PickLockHelper.src` for G2A
1. Call `G12_PickLockHelper_Init ();` from your `Init_Global();` function in `Startup.d` file.

    [![Gothic 1 & 2 Pick Lock Helper](https://img.youtube.com/vi/kdX9e3QlAbg/0.jpg)](https://www.youtube.com/watch?v=kdX9e3QlAbg)

### Gothic 1 & 2 Prevent Looting
Simple feature, that allows you to control which NPC's can be looted. (for example prevent looting from traders)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_PreventLooting.src` for G1
    * `AF-Script-Packet\_headers_G2_PreventLooting.src` for G2A
1. Call `G12_PreventLooting_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_HookEngine | LeGo_View, make sure you initialize them in your `LeGo_Init` function.

### Gothic 1 & 2 Sprint mode
Enables simple sprint mode
 - adds stamina bar right underneath health bar
 - when player is exhausted sprint mode is disabled with cool down of 4 seconds
 - jumping & fighting consumes stamina significantly
 - potions of speed disable stamina consumption (potions still have same effect)
 - potions of speed have their own texture of stamina bar - you will see how much time is left from potion effect

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_SprintMode.src` for G1
    * `AF-Script-Packet\_headers_G2_SprintMode.src` for G2A
1. Call `G12_SprintMode_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_HookEngine | LeGo_FrameFunctions | LeGo_Bars, make sure you initialize them in your `LeGo_Init` function.
1. Make sure you setup stamina level when game begins (in your `Startup_` function):

    [![Gothic 1 & 2 Sprint mode](https://img.youtube.com/vi/x8N7AS1mawo/0.jpg)](https://www.youtube.com/watch?v=x8N7AS1mawo)

```c++
	//[Sprint mode]
	PC_SprintModeStaminaMax = 80;
	PC_SprintModeStamina = PC_SprintModeStaminaMax;
	PC_SprintModeConsumeStamina = TRUE;
```

### Gothic 1 & 2 Torch HotKey
Simple feature, improving torches
 - adds hotkey 'keyTorchToggleKey' for putting on/removing torch (by default `T`)
 - fixes issue of disappearing torches in G2A:
    * Number of torches will be stored prior game saving. When game is loaded script will compare number of torches in players inventory, if there is torch missing it will add it back
    * reinserts to world ItLsTorchBurning items before saving (fixes bug of disappearing dropped torches) and before level change
 - compatible with sprint mode (reapplies overlay HUMANS_SPRINT.MDS when torch is removed/equipped)
 - will re-lit all mobs, that were previously lit by player (list can be maintained in file 'torchHotKey_API.d' in array TORCH_ASC_MODELS [];
 - Ctrl + 'keyTorchToggleKey' will put torch to right hand (with Union you can throw torch away in G1)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_TorchHotKey.src` for G1
    * `AF-Script-Packet\_headers_G2_TorchHotKey.src` for G2A
1. Call `G12_TorchHotKey_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_HookEngine | LeGo_Gamestate, make sure you initialize them in your `LeGo_Init` function.

### Gothic 1 & 2 No ammo print
Simple feature, displays message when you are out of ammo and trying to put in hand ranged weapon

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_NoAmmoPrint.src` for G1
    * `AF-Script-Packet\_headers_G2_NoAmmoPrint.src` for G2A
1. Call `G12_NoAmmoPrint_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 & 2 Vob Transport
Allows player to move/clone/delete or buy objects (Vobs, Mobs, Items etc.) in game. Hands down one of the coolest features :)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_VobTransport.src` for G1
    * `AF-Script-Packet\_headers_G2_VobTransport.src` for G2A
1. Call `G12_VobTransport_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_FrameFunctions | LeGo_View, make sure you initialize them in your `LeGo_Init` function.

    [![Gothic 1 & 2 Vob Transport](https://img.youtube.com/vi/S4mboOKGvHo/0.jpg)](https://www.youtube.com/watch?v=S4mboOKGvHo)

### Gothic 1 & 2 Focus
Slightly improved version of LeGo focusnames feature:
 - color of focus is changed:
    * to orange if chest/mob is locked by special key, cannot be picklocked and player does not have key
    * to yellow if chest/mob is locked by special key and player does not have key, or can be picklocked
    * to yellow if chest/mob can be picklocked
 - renames chest from MOBNAME_CHEST to MOBNAME_CHEST_EMPTY and crates from MOBNAME_CRATE to MOBNAME_CRATE_EMPTY when they are empty and vice versa

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_Focus.src` for G1
    * `AF-Script-Packet\_headers_G2_Focus.src` for G2A
1. Call `G12_Focus_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Should not be used together with LeGo flag LeGo_Focusnames.

### Gothic 1 & 2 Inventory Item preview
This feature updates global variables `PC_ItemPreviewMana` and `PC_ItemPreviewHealth` with HP and Mana values read out of `oCItem.count[]` property using `oCItem.text[]` property to recognize relevant values.
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_InvItemPreview.src` for G1
    * `AF-Script-Packet\_headers_G2_InvItemPreview.src` for G2A
1. Call `G12_InvItemPreview_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 & 2 Better Bars
This feature 'replaces' original Gothic health and mana bars with LeGo bars (with LeGo bars we can control textures, alpha values and when bars will be displayed)
By default this feature adds 3 visualisation options for new bars:
 - standard (same as in vanilla Gothic)
 - dynamic:
    * health bar is visible: if player is hurt, in fight mode, in inventory, when health changes
    * mana bar is visible: in magic fight mode, in inventory, when mana changes
 - always on

In combination with G12-InvItemPreview it also adds health & mana bar preview - additional texture which indicates how much health/mana item in inventory will recover.

    [![Gothic 1 & 2 Better Bars](https://img.youtube.com/vi/4hbQxHU-Utw/0.jpg)](https://www.youtube.com/watch?v=4hbQxHU-Utw)

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_BetterBars.src` for G1
    * `AF-Script-Packet\_headers_G2_BetterBars.src` for G2A
1. Call `G12_BetterBars_Init ();` from your `Init_Global();` function in `Startup.d` file.

### Gothic 1 & 2 Log Dialogues
Simple feature that writes all dialogues as LOG_NOTE into player's log.

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_LogDialogue.src` for G1
    * `AF-Script-Packet\_headers_G2_LogDialogue.src` for G2A
1. Call `G12_LogDialogue_Init ();` from your `Init_Global();` function in `Startup.d` file.

    [![Gothic 1 & 2 Log Dialogues](https://img.youtube.com/vi/RG1UBn53ZpY/0.jpg)](https://www.youtube.com/watch?v=RG1UBn53ZpY)

### Gothic 1 & 2 Debugging
Several debugging features:
1. Console command `show AI`
    * will display AI of NPC in focus.
1. Console command `debug dialogues`
    * will give you access to all dialogues which are assigned to NPC.
    * also will allow you to change dialogues to told/untold.
1. Console command `unlock`
    * will unlock `oCMobLockable` object in focus.
1. Console command `lock`
    * will lock `oCMobLockable` object in focus.
1. Console command `set routine`
    * will change routine of NPC in focus.
1. Console command `set sleepingMode`
    * will put vob in focus into sleeping mode/awake mode.
1. Function `oCMobLockable_CheckLockValidity`
    * traverses through all `oCMobLockable` objects and checks whether their pickLock string or key instances are valid.
1. Function `oCRtnManager_RtnList_CheckValidity`
    * traverses through all active routines in routine manager and checks whether they are properly setup:
        * checks if waypoint exists.
        * checks if 24h day cycle is complete.
        * checks if routines are not overlapping one another.
1. Function `oCRtnManager_AllRoutines_CheckValidity`


In order to enable these:
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * `AF-Script-Packet\_headers_G1_Debugging.src` for G1
    * `AF-Script-Packet\_headers_G2_Debugging.src` for G2A
1. Call `CC_ShowAI_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Call `CC_DebugDialogues_Init ();` from your `Init_Global();` function in `Startup.d` file.

    [![Gothic 1 & 2 Debugging](https://img.youtube.com/vi/T0Dm3VQXX40/0.jpg)](https://www.youtube.com/watch?v=T0Dm3VQXX40)
