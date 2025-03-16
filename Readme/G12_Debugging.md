## G12 Debugging
 - we added several debugging features
 - in order to enable them you have to call their respective init functions from `Init_Global();` function in `Startup.d` file:

### Console commands:
  * legend: `<mandatory parameter>` `[optional parameter]`

  * `show AI` --> `G12_ConsoleHistory_Init();`
      *   will display AI of Npc in focus

  * `debug dialogues` --> `CC_DebugDialogues_Init();`
      * will give you access to all dialogues which are assigned to the Npc
      * will allow you to change dialogues to told/untold

	 There are 3 'modes':
	  * calling function with Npc if focus will allow you to debug dialogues associated with that Npc
	  * calling function with no Npc if focus will allow you to debug dialogues associated with hero
	  * calling function with Mob in focus will allow you to debug dialogues associated with mob

    [![G1&2 Debugging](https://img.youtube.com/vi/T0Dm3VQXX40/0.jpg)](https://www.youtube.com/watch?v=T0Dm3VQXX40)

	* `debug textures` --> `G12_DebugTextures_Init();`
      * will display polygon texture information

    [![G1&2 Debugging](https://img.youtube.com/vi/AvF2FuamDPM/0.jpg)](https://www.youtube.com/watch?v=AvF2FuamDPM)

  * `lock [PickLockStr] [KeyInstanceName]` & `unlock` --> `CC_UnLock_Init();`
      * `lock` Locks `oCMobLockable` object in focus with `[PickLockStr]` or `[KeyInstanceName]`
      * `unlock` Unlocks `oCMobLockable` object in focus
	  * use `-` as `[PickLockStr]` or `[KeyInstanceName]` if you don't want to update this parameter

  * `set routine <RoutineName>` & `show routine` --> `CC_SetRoutine_Init();`
      * `set routine <RoutineName>` changes routine of an Npc in focus to `<RoutineName>`
      * `show routine` displays routine of Npc in focus

  * `set sleepingMode` --> `CC_SetSleepingMode_Init();`
      * puts vob in focus into sleeping / awake mode

  * `create <ItemInstanceName> [qty]` --> `CC_Create_Init();`
      * creates specified amount of items in inventory of Npc in your focus or hero's inventory if no Npc is in focus

  * `goto npc <NpcName>` & `bring npc <NpcName>` --> `CC_GotoNpc_Init();`
      * `goto Npc <NpcName>` teleports player to Npc
      * `bring Npc <NpcName>` teleports Npc to player
	  * `<NpcName>` is Npc name or global `C_Npc` variable which points to Npc

  * `goto ZEN <ZenName> [StartVob]` --> `CC_GotoZEN_Init();`
      * triggers level change to specified zen and StartVob
      * this feature loads all `oCTriggerChangeLevel` objects by default and will register their zen names + starting vobs into console
      * if you do not specify starting vob, then the feature will use default starting vob (previously registered)
          * `goto zen OLDMINE.ZEN` will take you to `goto ZEN OLDMINE.ZEN ENTRANCE_OLDMINE_SURFACE` from G1 surface world
      * if you want you can specify different than default starting vob
          * `goto zen WORLD.ZEN OC1` will take you to waypoint `OC1` in front of the Old Camp

    [![G1&2 Debugging](https://img.youtube.com/vi/aP23vubB6Mc/0.jpg)](https://www.youtube.com/watch?v=aP23vubB6Mc)

  * `focus play ani <AniName>` & `focus play effect <VFXName>` --> `CC_FocusPlay_Init();`
      * `focus play ani <AniName>` plays specified animation on Npc in focus
      * `focus play effect <VFXName>` plays specified vfx effect on Npc in focus

  * `puppetMaster` --> `CC_PuppetMaster_Init();`
      * allows you to change position & rotation of model nodes on Npc

    [![G1&2 Debugging](https://img.youtube.com/vi/le2BhxYEG9Y/0.jpg)](https://www.youtube.com/watch?v=le2BhxYEG9Y)

  * `hold time` --> `CC_HoldTime_Init();`
      * 'freezes' time - hours and minutes will not advance

  * `print pos [objectName]` & `print trafo [objectName]` --> `CC_PrintPos_Init();`
      * `print pos [objectName]` prints position of object in focus in Daedalus format to zSpy so that it can be copy-pasted to the code
        *`const float pos_[objectName][3] = {x, y, z};`

      * `print trafo [objectName]` will print both rotation and position of object in focus in Daedalus format to zSpy so that it can be copy-pasted to the code
        * `const string descRot = "1.000394e-025 1.2990037e-042 0 0 1.4012985e-045 0 5.8889526e-039 3.9913184e-041 1.4314439e+019";`
        * `const string descPot = "1.7656361e-043 7.8472714e-044 -9.8679836e-032";`

   * Note: string descRot and descPos can be converted back to trafo using functions: `Vob_SetByDescriptionRot` and `Vob_SetByDescriptionPos`

### Features:

  * Console history --> `G12_ConsoleHistory_Init();`
      * keeps track of commands entered into console

 * `oCMobLockable_CheckLockValidity();` (no initialization required)
      * function traverses through all `oCMobLockable` objects and checks whether their pickLock string or key instances are valid

  * `oCRtnManager_RtnList_CheckValidity` (no initialization required)
      * function traverses through all active routines in routine manager and checks whether they are properly setup:
          * Checks if waypoint exists
          * Checks if 24h day cycle is complete
          * Checks if routines are not overlapping one another

  * `oCRtnManager_AllRoutines_CheckValidity` (no initialization required)
      * similar functionality as `oCRtnManager_RtnList_CheckValidity` except this one will traverse through all routines (might be performance heavy, will definitelly mess up routines)
