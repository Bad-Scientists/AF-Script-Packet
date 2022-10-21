
  
# AF Script Packet status: WIP  
  
Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)  
  
Credits: This is a collection of many scripts from the entire Gothic community. None of this would be possible without Ikarus/LeGo and without amazing modders willing to share their amazing works & ideas.  
  
Thanks to: Sektenspinner, Lehona, Gottfried, Szapp (mud-freak), Neconspictor, OrcWarrior (PL), Dalai Zoll, Cryp18Struct, L-Titan (Gelaos) and many more (we will try to keep list up to date :) )  
  
Special thanks goes to: helpo1 :crown: & Kaiser, who endlessly debugged many features :sparkles:  
  
This Script Packet aims to consolidate as many useful functions as possible with the main goal being giving modders extensive feature set that they can enable by calling a single innit function. Future plans include adding wiki with examples explaining all the features.  
  
## Requirements: script-packets Ikarus (1.2.2 from master branch) and LeGo (2.8.1)  
<details><summary>AFSP Initialization</summary>  
  
1. Make sure both **Ikarus** and **LeGo** are parsed from your `Gothic.src` file.  
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.  
1. **G1** users will have to add function `Init_Global();` into their Startup.d file (as it is not there by default). Call `Init_Global ();` from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions).  
  
1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**.  
    * G1: `AF-Script-Packet\_headers_G1_All.src`  
    * G2A: `AF-Script-Packet\_headers_G2_All.src`  
</details>  
  
## G1 Weapon stacking / splitting  
 - Emulates G2A inventory behavior for weapons in G1 --> Stackable weapons (with flags | ITEM_MULTI) will be split into their own inventory slot when equipped.  
  
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
   - Ore is exchanged automatically.  
   - You can easily control selling & buying multiplier and define item-specific rules separately for every NPC. Example being that Wolf will buy furs from you for 100% of the item value.  
   - You can easily prevent selling items to NPC, like Huno not buying anything but weapons from you.  
  
<details><summary>Init</summary>  
  
1. Call `G1_EnhancedTrading_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1 Enhanced Pick Locking  
 - Package emulates G2A behavior for PickLocking:  
  
   - If players' NPC_TALENT_PICKLOCK level is 0,  he cannot interact with locked doors & chests.  
   - If oCMobLockable requires special key that is not in hero's invntory, he cannot interact with locked doors or chests. This interaction won't break any picklocks.  
   - If players NPC_TALENT_PICKLOCK level > 0 BUT does not have pickLocks, he will not be able to interact with locked doors/chests.  
   - If player has key that can open doors/chests, he can interact with the object without NPC_TALENT_PICKLOCK.  
   - The pickLock failrate (breaking) is based on players' dexterity. Higher the stat, lower the chance to break picklocks. Default minimum failrate is 10%.  
   - Hero will say whether he needs to learn skill, get picklocks, or specific key.  
  
<details><summary>Init</summary>  
  
1. Call `G1_EnhancedPickLocking_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1 Player Map  
 - Improved Map handling on key 'M':  
   - Player's animation will not be reset if he does not have map. This removes exploit in which pressing M would allow you to jump in air.  
   - You can easily control which map will be displayed in what circumstances.  
   - If there is no map preference defined, then the script will re-open last opened map.  
   - If player did not open any map yet, the script will try to open: ITWRWORLDMAP_ORC. If there is no such item in the inventory,  ITWRWORLDMAP will follow. If none of those are in the inventory, first available map in inventory is selected.  
  
<details><summary>Init</summary>  
  
1. Call `G1_PlayerMap_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1 Better Inventory Controls  
 - Enables better navigation in inventories:  
   - Use home/end keys to navigate to first/last item.  
   - Use page up/page down keys to scroll faster through inventory.  
  
 - Players inventory:  
   - Key `E` will put item to hand.  
   - Key `Q` will drop item (1 piece) from the inventory.  
   - Key `Left Alt` will drop all items from the inventory slot.  
  
 - All other inventories, such as looting NPCs, chests or while trading:  
   - Key `Q` quick loots items from the inventory, ending interaction with that inventory.  
   - Key `Left Ctrl` will move 1 piece to other opposite container.  
   - Key `Spacebar` will move 10 pieces to other opposite container.  
   - Key `Left Alt` will move All item pieces to other opposite container.  
  
<details><summary>Init</summary>  
  
1. Call `G1_BetterInventoryControls_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Enhanced Information Manager  
 - Package adds several features for dialogues (Information manager):  
   - Simple dialog color, font and text alignment control using dialog description.  
   - Answering system and Input fields.  
   - Spinner system.  
   - Dialog control with numeric keys (1 .. 9).  
   - Dialog overlays with which you can simply change color for specific words.  
  
[More on this feature here](https://forum.worldofplayers.de/forum/threads/1571033-AFSP-ScriptPacket?p=26905995&viewfull=1#post26905995)  
  
<details><summary>Init</summary>  
  
1. Call `G12_EnhancedInfoManager_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Enhanced oCTriggerScript  
 - Package adds new features for oCTriggerScript objects:  
   - zCTrigger_bitfield_callEventFuncs flag will call additional event functions oCTriggerScript.scriptFunc + _OnTouch, _OnTrigger, _OnContact, _OnUnTouch.  
   - zCTrigger_bitfield_reactToOnContact flag is a custom event replacing _OnTouch & _OnTrigger events. It is repeatedly fired as long as there is any object in oCTriggerScript._zCVob_touchVobList_numInArray.  
  
 - You can find practical examples in `AF-Script-Packet\Standalone-Packages\G12-EnhancedoCTriggerScript\`:  
    1. `example_FirePlaceFireDamage.d` demonstrates how you can add oCTriggerScript objects to all fireplaces in your world that will burn every NPC that is in contact with such fireplace (_OnContact event).  
  
    [![G1&2 Enhanced oCTriggerScript](https://img.youtube.com/vi/7KYLjUITbi4/0.jpg)](https://www.youtube.com/watch?v=7KYLjUITbi4)  
  
    2. `example_FirePlaceSavingPolicy.d` demonstrates how you can add oCTriggerScript objects to all fireplaces in your world which will allow you to only save game near a fireplace. (_OnTouch, _OnUnTouch events).  
  
    [![G1&2 Enhanced oCTriggerScript](https://img.youtube.com/vi/U9IVhqSixW0/0.jpg)](https://www.youtube.com/watch?v=U9IVhqSixW0)  
  
<details><summary>Init</summary>  
  
1. Call `G12_EnhancedoCTriggerScript_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Enable Player States  
 - AI states that you can use on player character are hardcoded in the engine. Following states are used in vanilla:  
   * G1: `ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP, ZS_MAGICFEAR`  
   * G2: `ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_WHIRLWIND, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP`  
  
 - This package allows you to enable additional AI States without limitation.  
  
<details><summary>Init</summary>  
  
1. Call `G12_EnablePlayerStates_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Pick Lock Helper  
 - Simple feature that shows Pick Lock combination progress.  
  
    [![G1&2 Pick Lock Helper](https://img.youtube.com/vi/kdX9e3QlAbg/0.jpg)](https://www.youtube.com/watch?v=kdX9e3QlAbg)  
  
<details><summary>Init</summary>  
  
1. Call `G12_PickLockHelper_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Prevent Looting  
 - Simple feature that allows you to control which NPCs can be looted. This can be used to prevent players from looting merchants.  
  
<details><summary>Init</summary>  
  
1. Call `G12_PreventLooting_Init ();` from your `Init_Global();` function in `Startup.d` file.  
1. Requires LeGo flags: LeGo_HookEngine | LeGo_View, make sure you initialize them in your `LeGo_Init` function.  
</details>  
  
## G1&2 Sprint mode  
 - Enables simple sprint mode.  
   - Adds stamina bar right under the health bar.  
   - Depleting stamina bar will result in sprint being disabled together with 4 seconds cooldown period.  
   - Jumping and fighting consumes significant amount of stamina.   
   - Potions of speed disable stamina consumption with the potions still having the same effect.  
   - potions of speed have their own texture of stamina bar - you will see how much time is left from potion effect.  
  
    [![G1&2 Sprint mode](https://img.youtube.com/vi/x8N7AS1mawo/0.jpg)](https://www.youtube.com/watch?v=x8N7AS1mawo)  
  
<details><summary>Init</summary>  
  
1. Call `G12_SprintMode_Init ();` from your `Init_Global();` function in `Startup.d` file.  
1. Requires LeGo flags: LeGo_HookEngine | LeGo_FrameFunctions | LeGo_Bars, make sure you initialize them in your `LeGo_Init` function.  
1. Make sure you set stamina level when game begins in your `Startup_` function:  
  
```c++  
//[Sprint mode]  
PC_SprintModeStaminaMax = 80;  
PC_SprintModeStamina = PC_SprintModeStaminaMax;  
PC_SprintModeConsumeStamina = TRUE;  
```  
</details>  
  
## G1&2 Torch HotKey  
 - Simple feature for improving torches.  
   - Adds hotkey 'keyTorchToggleKey' for putting on and removing torch (`T` key by default).  
   - Fixes issue of disappearing torches in G2A:  
      * Number of torches will be stored prior game saving. When the game is loaded, script compares number of torches in players inventory. If there is a torch missing, it will be added back.  
      * Reinserts ItLsTorchBurning items to the world before level change and saving which fixes the bug of disappearing dropped torches.   
   - Compatible with sprint mode. It reapplies overlay HUMANS_SPRINT.MDS when torch is removed & equipped. 
   - Rekindles all vobs that were lit by player. List can be maintained in 'torchHotKey_API.d' file in array TORCH_ASC_MODELS [];  
   - Ctrl + 'keyTorchToggleKey' will put torch to right hand - you can throw torch away in G1 with with Union.  
  
<details><summary>Init</summary>  
  
1. Call `G12_TorchHotKey_Init ();` from your `Init_Global();` function in `Startup.d` file.  
1. Requires LeGo flags: LeGo_HookEngine | LeGo_Gamestate, make sure you initialize them in your `LeGo_Init` function.  
</details>  
  
## G1&2 No ammo print  
 - Simple feature that displays a message when you are out of ammo and attempting to put ranged weapon in hand.   
  
<details><summary>Init</summary>  
  
1. Call `G12_NoAmmoPrint_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Vob Transport  
 - Allows player to move, clone, delete or buy objects such as Vobs, Mobs, Items etc. in game. Hands down one of the coolest features :)  
  
    [![G1&2 Vob Transport](https://img.youtube.com/vi/S4mboOKGvHo/0.jpg)](https://www.youtube.com/watch?v=S4mboOKGvHo)  
  
<details><summary>Init</summary>  
  
1. Call `G12_VobTransport_Init ();` from your `Init_Global();` function in `Startup.d` file.  
1. Requires LeGo flags: LeGo_FrameFunctions | LeGo_View, make sure you initialize them in your `LeGo_Init` function.  
</details>  
  
## G1&2 Focus  
 - Slightly improved version of LeGo focusnames feature:  
   - Color of focus is changed:  
      * To orange if chest/mob is locked by special key, cannot be picklocked and player does not have key.  
      * To yellow if chest/mob is locked by special key and player does not have key but it can be picklocked.  
      * To yellow if chest/mob can be picklocked.  
   - Renames chests from MOBNAME_CHEST to MOBNAME_CHEST_EMPTY and crates from MOBNAME_CRATE to MOBNAME_CRATE_EMPTY when they are empty and vice versa.  
  
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
 - This feature 'replaces' original Gothic health and mana bars with LeGo bars where we can control textures, alpha values and when bars should be displayed.  
This feature adds 4 visualization options:  
   - Standard (same as in vanilla Gothic).  
   - Dynamic:  
      * Health bar is visible if player is hurt, in fight mode, in inventory or when health changes.  
      * Mana bar is visible in magic fight mode, in inventory or when mana changes.  
   - Always on.  
   - Only in the inventory.  
  
 - This also adds health & mana bar preview in combination with G12-InvItemPreview, adding additional texture which indicates how much health or mana item in inventory recovers.  
  
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
 - Spacer allows you to insert NPCs into the `.ZEN` world. The game will, however, not spawn them in the world by default, which can be solved with this simple hooked spawn function.  
  
    [![G1&2 Spacer spawn](https://img.youtube.com/vi/ytQtkdkwtv0/0.jpg)](https://www.youtube.com/watch?v=ytQtkdkwtv0)  
  
<details><summary>Init</summary>  
  
1. Call `G12_SpacerSpawn_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Fade away  
 - Gothic engine has, most likely unfinished, built-in feature - it is able to fade away dead NPCs and remove their bodies.  
  
    [![G1&2 Fade away](https://img.youtube.com/vi/0MdiT97w59c/0.jpg)](https://www.youtube.com/watch?v=0MdiT97w59c)  
  
<details><summary>Init</summary>  
  
1. Call `G12_FadeAway_Init ();` from your `Init_Global();` function in `Startup.d` file.  
2. Call `oCNPC_StartFadeAway (self);` on an NPC that you want to fade-away. (for example from ZS_Dead state, or whenever you want :smile:)  
</details>  
  
## G1&2 Despawn only if empty  
 - Prevents dead bodies from despawning. This feature replaces engine function `oCNPC::HasMissionItem` with its own version that returns `true` as soon as there is any item in the inventory. This way NPCs will not despawn.  
  
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
 - Allows you to insert 'new' perception functions to oCNPC.percList. Newly added perception functions are always active - called all the time.  
  
<details><summary>Init</summary>  
  
1. Call `G12_AddPerceptions_Init ();` from your `Init_Global();` function in `Startup.d` file.  
</details>  
  
## G1&2 Debugging  
- We added several debugging features. In order to enable them you have to call their respective init functions from `Init_Global();` function in `Startup.d` file:  
  
  * Console command `show AI`. Init with `CC_ShowAI_Init ();`  
     * Will display AI of NPC in focus.  
  * Console command `debug dialogues`. Init with `CC_DebugDialogues_Init ();`  
      * Will give you access to all dialogues which are assigned to the NPC.  
      * Will allow you to change dialogues to told/untold.  
  
    [![G1&2 Debugging](https://img.3.com/vi/T0Dm3VQXX40/0.jpg)](https://www.youtube.com/watch?v=T0Dm3VQXX40)  
  
  * Console command `unlock`. Init with `CC_UnLock_Init ();`  
      * Unlocks `oCMobLockable` object in focus.  
  * Console command `lock`. Init with `CC_UnLock_Init ();`  
      * Locks `oCMobLockable` object in focus.  
  * Console command `set routine`. Init with `CC_SetRoutine_Init();`  
      * Changes routine of NPC in focus.  
  * Console command `set sleepingMode`. Init with `CC_SetSleepingMode_Init();`  
      * Puts vob in focus into sleeping or awake mode.  
  * Function `oCMobLockable_CheckLockValidity`. (no initialization required)  
      * Traverses through all `oCMobLockable` objects and checks whether their pickLock string or key instances are valid.  
  * Function `oCRtnManager_RtnList_CheckValidity`. (no initialization required)  
      * Traverses through all active routines in routine manager and checks whether they are properly setup:  
          * Checks if waypoint exists.  
          * Checks if 24h day cycle is complete.  
          * Checks if routines are not overlapping one another.  
  * Function `oCRtnManager_AllRoutines_CheckValidity`. (no initialization required)  
      * Similar functionality as `oCRtnManager_RtnList_CheckValidity` except this one will traverse through all routines. (performance heavy)  
  * Console command `create itemInstanceName qty`.  Init with `CC_Create_Init ()`.  
      * Creates specified amount of items in inventory of NPC in your focus or inventory if no NPC is in focus  
  * Console command `goto NPC NPCName`. Init with `CC_GotoNPC_Init ()`.  
      * Teleports you directly to NPC. You can use NPC name or global C_NPC variable which points to NPC.  
  
    [![G1&2 Debugging](https://img.youtube.com/vi/aP23vubB6Mc/0.jpg)](https://www.youtube.com/watch?v=aP23vubB6Mc)  
  
  * Console command `goto ZEN zenName [startVob]`. Init with `CC_GotoZEN_Init ()`.  
      * Triggers level change to specified zen and starting vob.  
      * This feature loads all `oCTriggerChangeLevel` objects by default and will register their zen names and starting vobs into console.  
      * If you do not specify starting vob, then the feature will use default starting vob (previously registered):  
          * `goto zen oldmine.zen` will take you to `goto ZEN OLDMINE.ZEN ENTRANCE_OLDMINE_SURFACE` in Gothic 1 surface world.  
      * If you want you can specify different than default starting vob  
          * `goto zen world.zen OC1` will take you to waypoint `OC1` in front of the Old Camp.  
  * Console command `focus play ani aniName` and `focus play effect VFXname`. Init with `CC_FocusPlay_Init ()`.  
      * `focus play ani aniName` plays specified animation on NPC in focus.  
      * `focus play effectVFXName` plays specified effect on NPC in focus.  
  * Console command `puppetMaster`. Init with `CC_PuppetMaster_Init ()`.  
      * This feature allows you to change position & rotation of model nodes on NPC:  
  
    [![G1&2 Debugging](https://img.youtube.com/vi/le2BhxYEG9Y/0.jpg)](https://www.youtube.com/watch?v=le2BhxYEG9Y)  
  
  * Console command `hold time`. Init with `CC_HoldTime_Init ()`.  
      * 'Freezes' time - hours and minutes will not advance.  
  * Console commands `print pos [objectName]` and `print trafo [objectName]`. Init with `CC_PrintPos_Init ()`.  
      * `print pos [objectName]` prints position of object in focus in Daedalus format to zSpy so that it can be copy-pasted to the code: `const float pos_[objectName][3] = {x, y, z};`  
      * `print trafo [objectName]` will print both rotation and position of object in focus in Daedalus format to zSpy so that it can be copy-pasted to the code:  
        * `const string descRot = "1.000394e-025 1.2990037e-042 0 0 1.4012985e-045 0 5.8889526e-039 3.9913184e-041 1.4314439e+019";`  
        * `const string descPot = "1.7656361e-043 7.8472714e-044 -9.8679836e-032";`  
   * Note: string descRot and descPos can be converted back to trafo using functions: Vob_SetByDescriptionRot and Vob_SetByDescriptionPos.  
      * objectName does not have to be specified.
