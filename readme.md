# AF Script Packet status: WIP

Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)

Credits: We are using here many scripts sourced from great Gothic community. None of this would be possible without Ikarus/LeGo and of course without modders willing to share their amazing work/ideas.
Thank you: Sektenspinner, Lehona, Gottfried, Szapp (mud-freak), Neconspictor, OrcWarrior (PL), Dalai Zoll, Cryp18Struct, L-Titan (Gelaos) and many more (we will try to keep list up to date :) )

Special thanks goes to: helpo1 :crown: & Kaiser, who endlessly debugged many features :sparkles:

In this Script Packet we would like to consolidate as many useful functions as possible.
Main goal is to put together several useful features that any modder can simply enable by calling single init function.
In a future we will add wiki with examples explaining how to use each feature.

## Requirements: script-packets Ikarus (1.2.2 from master branch) and LeGo (2.8.1)
<details><summary>AFSP Initialization</summary>

1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. **G1** users will have to add function `Init_Global();` into their Startup.d file (it is not there by default). Call `Init_Global ();` from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions).

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.
    * G1: `AF-Script-Packet\_headers_G1_All.src`
    * G2A: `AF-Script-Packet\_headers_G2_All.src`
</details>

## G1 Weapon stacking / splitting
 - Emulates G2A inventory behaviour for weapons in G1 --> Stackable weapons (with flags | ITEM_MULTI) will be split into their own inventory slot when equipped.

    [![G1 Weapon stacking / splitting](https://img.youtube.com/vi/V3EHcfDa3GY/0.jpg)](https://www.youtube.com/watch?v=V3EHcfDa3GY)

<details><summary>Init</summary>

1. Call `G1_WeaponStacking_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1 Ever looming barrier
 - Hooks Barrier render function and prevents Barrier from disappearing completely.

    [![G1 Ever looming barrier](https://img.youtube.com/vi/ZEyFpN-f0Y8/0.jpg)](https://www.youtube.com/watch?v=ZEyFpN-f0Y8)

<details><summary>Init</summary>

1. Call `G1_BarrierEverlooming_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1 Enhanced Trading
 - Improves G1 trading:
   - ore is exchanged automatically
   - you can easily control selling/buying multiplier and define NPC/item-specific rules separately for every NPC. (for example Wolf can buy furs from you for 100% item value)
   - you can easily prevent selling items to NPC. (for example Huno will not buy from you anything but weapons)

<details><summary>Init</summary>

1. Call `G1_EnhancedTrading_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1 Enhanced Pick Locking
 - Package emulates G2A behaviour for PickLocking:

   - if players NPC_TALENT_PICKLOCK level is 0 then he can't interact with locked doors/chests.
   - if oCMobLockable requires special key only and he does not have it then he can't interact with locked doors/chests (won't break any picklocks).
   - if players NPC_TALENT_PICKLOCK level > 0 BUT does not have pickLocks he can't use interact with locked doors/chests.
   - if player has key that can open doors/chests then he can do so without NPC_TALENT_PICKLOCK.
   - pickLock failrate (breaking) is based on Players dexterity. Higher it is lower the chance to break picklocks is. (by default minimum failrate is 10%)
   - hero will say whether: he needs to learn skill, get picklocks or specific key.

<details><summary>Init</summary>

1. Call `G1_EnhancedPickLocking_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1 Player Map
 - Improved Map handling on key 'M':
   - player's animation will not be reset if he does not have map (this removes exploit in which pressing M would allow you to jump in air)
   - you can easily control which map will be displayed in what circumstances
   - if there is no map preferation defined, then script will re-open last opened map
   - if player didn't open any map yet, then script will try to open: ITWRWORLDMAP_ORC, if not in inventory then ITWRWORLDMAP. If none of these is in inventory then first available map in inventory.

<details><summary>Init</summary>

1. Call `G1_PlayerMap_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1 Better Inventory Controls
 - Enables better navigation in inventories:
   - use home/end keys to navigate to first/last item
   - use page up/page down keys to scroll faster through inventory

 - Players inventory:
   - key `E` will put item to hand
   - key `Q` will drop item (1 piece) from inventory
   - key `Left Alt` will drop All items from inventory slot

 - All other inventories, looting NPC, looting chests or in trading:
   - key `Q` quick loots items from chest / Npc. It will also end interaction with chest.
   - key `Left Ctrl` will move 1 piece to other oposite container
   - key `Spacebar` will move 10 pieces to other oposite container
   - key `Left Alt` will move All item pieces to other oposite container

<details><summary>Init</summary>

1. Call `G1_BetterInventoryControls_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Enhanced Information Manager
 - Package adds several features for dialogues (Information manager):
   - Simple dialog color/font/text alignment control - using dialog description.
   - Answering system / Input fields
   - Spinner system
   - Dialog control with numeric keys (1 .. 9)
   - Dialog overlays with which you can simply change color for specific words

[More on this feature here](https://forum.worldofplayers.de/forum/threads/1571033-AFSP-ScriptPacket?p=26905995&viewfull=1#post26905995)

<details><summary>Init</summary>

1. Call `G12_EnhancedInfoManager_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Enhanced oCTriggerScript
 - Package adds new features for oCTriggerScript objects:
   - zCTrigger_bitfield_callEventFuncs flag - which will cause call additional event functions: oCTriggerScript.scriptFunc + _OnTouch, _OnTrigger, _OnContact, _OnUnTouch
   - zCTrigger_bitfield_reactToOnContact flag - custom event replacing _OnTouch & _OnTrigger event. It is repeatedly fired as long as there is any object in oCTriggerScript._zCVob_touchVobList_numInArray.

 - In folder `AF-Script-Packet\Standalone-Packages\G12-EnhancedoCTriggerScript\` you can find practical examples:
    1. `example_FirePlaceFireDamage.d` demonstrates how you can add to all fireplaces in your world oCTriggerScript objects that will burn every NPC that is in contact with such fireplace. (_OnContact event)

    [![G1&2 Enhanced oCTriggerScript](https://img.youtube.com/vi/7KYLjUITbi4/0.jpg)](https://www.youtube.com/watch?v=7KYLjUITbi4)

    2. `example_FirePlaceSavingPolicy.d` demonstrates how you can add to all fireplaces in your world oCTriggerScript objects that will allow you to save game only nearby fireplace. (_OnTouch, _OnUnTouch events)

    [![G1&2 Enhanced oCTriggerScript](https://img.youtube.com/vi/U9IVhqSixW0/0.jpg)](https://www.youtube.com/watch?v=U9IVhqSixW0)

<details><summary>Init</summary>

1. Call `G12_EnhancedoCTriggerScript_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Enable Player States
 - AI states that you can use on Player are hardcoded in engine, in vanilla you can use following:
   * G1: `ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP, ZS_MAGICFEAR`
   * G2: `ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_WHIRLWIND, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP`

 - This package allows you to enable additional AI States. (without limitation)

<details><summary>Init</summary>

1. Call `G12_EnablePlayerStates_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Pick Lock Helper
 - Simple feature, that shows Pick Lock combination progress.

    [![G1&2 Pick Lock Helper](https://img.youtube.com/vi/kdX9e3QlAbg/0.jpg)](https://www.youtube.com/watch?v=kdX9e3QlAbg)

<details><summary>Init</summary>

1. Call `G12_PickLockHelper_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Prevent Looting
 - Simple feature, that allows you to control which NPC's can be looted. (for example prevent looting from traders)

<details><summary>Init</summary>

1. Call `G12_PreventLooting_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_HookEngine | LeGo_View, make sure you initialize them in your `LeGo_Init` function.
</details>

## G1&2 Sprint mode
 - Enables simple sprint mode
   - adds stamina bar right underneath health bar
   - when player is exhausted sprint mode is disabled with cool down of 4 seconds
   - jumping & fighting consumes stamina significantly
   - potions of speed disable stamina consumption (potions still have same effect)
   - potions of speed have their own texture of stamina bar - you will see how much time is left from potion effect

    [![G1&2 Sprint mode](https://img.youtube.com/vi/x8N7AS1mawo/0.jpg)](https://www.youtube.com/watch?v=x8N7AS1mawo)

<details><summary>Init</summary>

1. Call `G12_SprintMode_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_HookEngine | LeGo_FrameFunctions | LeGo_Bars, make sure you initialize them in your `LeGo_Init` function.
1. Make sure you setup stamina level when game begins (in your `Startup_` function):

```c++
//[Sprint mode]
PC_SprintModeStaminaMax = 80;
PC_SprintModeStamina = PC_SprintModeStaminaMax;
PC_SprintModeConsumeStamina = TRUE;
```
</details>

## G1&2 Torch HotKey
 - Simple feature, improving torches
   - adds hotkey 'keyTorchToggleKey' for putting on/removing torch (by default `T`)
   - fixes issue of disappearing torches in G2A:
      * Number of torches will be stored prior game saving. When game is loaded script will compare number of torches in players inventory, if there is torch missing it will add it back
      * reinserts to world ItLsTorchBurning items before saving (fixes bug of disappearing dropped torches) and before level change
   - compatible with sprint mode (reapplies overlay HUMANS_SPRINT.MDS when torch is removed/equipped)
   - will re-lit all mobs, that were previously lit by player (list can be maintained in file 'torchHotKey_API.d' in array TORCH_ASC_MODELS [];
   - Ctrl + 'keyTorchToggleKey' will put torch to right hand (with Union you can throw torch away in G1)

<details><summary>Init</summary>

1. Call `G12_TorchHotKey_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_HookEngine | LeGo_Gamestate, make sure you initialize them in your `LeGo_Init` function.
</details>

## G1&2 No ammo print
 - Simple feature, displays message when you are out of ammo and trying to put in hand ranged weapon

<details><summary>Init</summary>

1. Call `G12_NoAmmoPrint_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Vob Transport
 - Allows player to move/clone/delete or buy objects (Vobs, Mobs, Items etc.) in game. Hands down one of the coolest features :)

    [![G1&2 Vob Transport](https://img.youtube.com/vi/S4mboOKGvHo/0.jpg)](https://www.youtube.com/watch?v=S4mboOKGvHo)

<details><summary>Init</summary>

1. Call `G12_VobTransport_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Requires LeGo flags: LeGo_FrameFunctions | LeGo_View, make sure you initialize them in your `LeGo_Init` function.
</details>

## G1&2 Focus
 - Slightly improved version of LeGo focusnames feature:
   - color of focus is changed:
      * to orange if chest/mob is locked by special key, cannot be picklocked and player does not have key
      * to yellow if chest/mob is locked by special key and player does not have key, or can be picklocked
      * to yellow if chest/mob can be picklocked
   - renames chest from MOBNAME_CHEST to MOBNAME_CHEST_EMPTY and crates from MOBNAME_CRATE to MOBNAME_CRATE_EMPTY when they are empty and vice versa

<details><summary>Init</summary>

1. Call `G12_Focus_Init ();` from your `Init_Global();` function in `Startup.d` file.
1. Should not be used together with LeGo flag LeGo_Focusnames.
</details>

## G1&2 Inventory Item preview
 - This feature updates global variables `PC_ItemPreviewMana` and `PC_ItemPreviewHealth` with HP and Mana values read out of `oCItem.count[]` property using `oCItem.text[]` property to recognize relevant values.

<details><summary>Init</summary>

1. Call `G12_InvItemPreview_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Better Bars
 - This feature 'replaces' original Gothic health and mana bars with LeGo bars (with LeGo bars we can control textures, alpha values and when bars will be displayed)
This feature adds 4 visualisation options:
   - standard (same as in vanilla Gothic)
   - dynamic:
      * health bar is visible: if player is hurt, in fight mode, in inventory, when health changes
      * mana bar is visible: in magic fight mode, in inventory, when mana changes
   - always on
   - only in the inventory

 - In combination with G12-InvItemPreview it also adds health & mana bar preview - additional texture which indicates how much health/mana item in inventory will recover.

    [![G1&2 Better Bars](https://img.youtube.com/vi/4hbQxHU-Utw/0.jpg)](https://www.youtube.com/watch?v=4hbQxHU-Utw)

<details><summary>Init</summary>

1. Call `G12_BetterBars_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Log Dialogues
 - Simple feature that writes all dialogues as LOG_NOTE into player's log.

    [![G1&2 Log Dialogues](https://img.youtube.com/vi/RG1UBn53ZpY/0.jpg)](https://www.youtube.com/watch?v=RG1UBn53ZpY)

<details><summary>Init</summary>

1. Call `G12_LogDialogue_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Spacer spawn
 - Spacer allows you to insert NPCs into the `.ZEN` world. However game wont spawn them in the world. With this simple feature hooked spawn function will do just that.

    [![G1&2 Spacer spawn](https://img.youtube.com/vi/ytQtkdkwtv0/0.jpg)](https://www.youtube.com/watch?v=ytQtkdkwtv0)

<details><summary>Init</summary>

1. Call `G12_SpacerSpawn_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Fade away
 - Gothic engine has built-in most likely unfinished feature - it is able to fade away dead NPCs and remove their bodies.

    [![G1&2 Fade away](https://img.youtube.com/vi/0MdiT97w59c/0.jpg)](https://www.youtube.com/watch?v=0MdiT97w59c)

<details><summary>Init</summary>

1. Call `G12_FadeAway_Init ();` from your `Init_Global();` function in `Startup.d` file.
2. Call `oCNpc_StartFadeAway (self);` on an NPC that you want to fade-away. (for example from ZS_Dead state, or whenever you want :smile:)
</details>

## G1&2 Despawn only if empty
 - Prevents dead bodies from despawning. This feature replaces engine function `oCNpc::HasMissionItem` with its own version, which returns `true` as soon as there is any item in the inventory. This way Npc will not despawn.

<details><summary>Init</summary>

1. Call `G1_DespawnOnlyIfEmpty_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Rain Control
 - Allows you to fully control weather by adding several functions:
```c++
    void Wld_ResetWeather (); //resets weather overrides enabled by this feature.
    void Wld_SetWeatherType ([zTWEATHER_SNOW, zTWEATHER_RAIN]); //G2A only - sets weather type: snow or rain
    void Wld_ForceWeatherType ([zTWEATHER_SNOW, zTWEATHER_RAIN]); //G2A only - forces weather type: snow or rain
    void Wld_ForceWeatherType ([zTWEATHER_SNOW, zTWEATHER_RAIN]); //G2A only - forces weather type: snow or rain
    void Wld_SetDontRain (RainControl_DontRain); //if set to true - it will never rain
    void Wld_SetRainForever (RainControl_RainForever); //if set to true - it will always rain
    void Wld_SetRainOff (); //shuts off rain immediately
    void Wld_SetRainOn (); //turns on rain immediately
    void Wld_StartRain (newDuration); //fades in rain smoothly - for specified newDuration time (in minutes)
    void Wld_StopRain (); //fades out rain smoothly - within next 5 in-game minutes
    int Wld_SetRainTime (start_hr, start_min, end_hr, end_min) //if we are within specified time-range, then this function will turn on rain. Returns true if we are within time-range.
```
<details><summary>Init</summary>

1. Call `G12_RainControl_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Add Perceptions
 - allows you to insert 'new' perception functions to oCNpc.percList. Newly added perception functions are alwyas active - called all the time.

<details><summary>Init</summary>

1. Call `G12_AddPerceptions_Init ();` from your `Init_Global();` function in `Startup.d` file.
</details>

## G1&2 Debugging
- We have added several debugging features. In order to enable these call their respective init functions from `Init_Global();` function  in `Startup.d` file:

  * Console command `show AI`. Init with `CC_ShowAI_Init ();`
     * will display AI of NPC in focus.
  * Console command `debug dialogues`. Init with `CC_DebugDialogues_Init ();`
      * will give you access to all dialogues which are assigned to NPC.
      * also will allow you to change dialogues to told/untold.

    [![G1&2 Debugging](https://img.3.com/vi/T0Dm3VQXX40/0.jpg)](https://www.youtube.com/watch?v=T0Dm3VQXX40)

  * Console command `unlock`. Init with `CC_UnLock_Init ();`
      * will unlock `oCMobLockable` object in focus.
  * Console command `lock`. Init with `CC_UnLock_Init ();`
      * will lock `oCMobLockable` object in focus.
  * Console command `set routine`. Init with `CC_SetRoutine_Init();`
      * will change routine of NPC in focus.
  * Console command `set sleepingMode`. Init with `CC_SetSleepingMode_Init();`
      * will put vob in focus into sleeping mode/awake mode.
  * Function `oCMobLockable_CheckLockValidity`. (no initialization required)
      * traverses through all `oCMobLockable` objects and checks whether their pickLock string or key instances are valid.
  * Function `oCRtnManager_RtnList_CheckValidity`. (no initialization required)
      * traverses through all active routines in routine manager and checks whether they are properly setup:
          * checks if waypoint exists.
          * checks if 24h day cycle is complete.
          * checks if routines are not overlapping one another.
  * Function `oCRtnManager_AllRoutines_CheckValidity`. (no initialization required)
      * similar functionality as `oCRtnManager_RtnList_CheckValidity` however this one will traverse through all routines. (performance heavy)
  * Console command `create itemInstanceName qty`.  Init with `CC_Create_Init ()`.
      * will create specified amount of items in inventory of NPC in your focus / yours inventory (if no NPC is in focus)
  * Console command `goto npc npcName`. Init with `CC_GotoNpc_Init ()`.
      * will teleport you directly to Npc. You can use Npc name, but also global C_NPC variable, which points to Npc.

    [![G1&2 Debugging](https://img.youtube.com/vi/aP23vubB6Mc/0.jpg)](https://www.youtube.com/watch?v=aP23vubB6Mc)

  * Console command `goto ZEN zenName [startVob]`. Init with `CC_GotoZEN_Init ()`.
      * will trigger change level to specified zen and starting vob.
      * this feature will by default load all `oCTriggerChangeLevel` objects and will register their zen names and starting vobs into console.
      * if you do not specify starting vob, then feature will use default starting vob (previously registered):
          * `goto zen oldmine.zen` will take you to `goto ZEN OLDMINE.ZEN ENTRANCE_OLDMINE_SURFACE` in Gothic 1 surface world.
      * if you want you can specify different than default starting vob
          * `goto zen world.zen OC1` will take you to waypoint `OC1` in front of the Old Camp.
  * Console command `focus play ani aniName` and `focus play effect VFXname`. Init with `CC_FocusPlay_Init ()`.
      * `focus play ani aniName` will play specified animation on Npc in focus.
      * `focus play effectVFXName` will play specified effect on Npc in focus.
  * Console command `puppetMaster`. Init with `CC_PuppetMaster_Init ()`.
      * this feature allows you to change position & rotation of model nodes on Npc:

    [![G1&2 Debugging](https://img.youtube.com/vi/le2BhxYEG9Y/0.jpg)](https://www.youtube.com/watch?v=le2BhxYEG9Y)

  * Console command `hold time`. Init with `CC_HoldTime_Init ()`.
      * this feature will 'freeze' time - hours and minutes will not advance.
  * Console commands `print pos [objectName]` and `print trafo [objectName]`. Init with `CC_PrintPos_Init ()`.
      * `print pos [objectName]` will print to zSpy position of object in focus in Daedalus format that can be copy-pasted to the code: `const float pos_[objectName][3] = {x, y, z};`
      * `print trafo [objectName]` will print to zSpy both rotation and position of object in focus in Daedalus format that can be copy-pasted to the code:
        * `const string descRot = "1.000394e-025 1.2990037e-042 0 0 1.4012985e-045 0 5.8889526e-039 3.9913184e-041 1.4314439e+019";`
        * `const string descPot = "1.7656361e-043 7.8472714e-044 -9.8679836e-032";`
	* note: string descRot and descPos can be converted back to trafo using functions: Vob_SetByDescriptionRot and Vob_SetByDescriptionPos.
      * objectName does not have to be specified.
