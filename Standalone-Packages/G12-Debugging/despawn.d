/*
 *	Despawn
 *	- will 'despawn' npc in focus
 */

func string CC_Despawn (var string param) {
	var oCNpc her; her = Hlp_GetNpc (hero);
	var int slfPtr; slfPtr = her.focus_vob;

	if (!Hlp_Is_oCNpc(slfPtr)) {
		return "Focus_vob is not an NPC.";
	};

	var oCNpc slf; slf = _^(slfPtr);

	//Remove as enemy ... if any Npc has this npc as enemy then game would crash (there is no safety check in engine)
	var int i; i = 0;
	var int loop; loop = MEM_World.activeVobList_numInArray;

	while (i < loop);
		var int ptr; ptr = MEM_ReadIntArray(MEM_World.activeVobList_array, i);

		if (Hlp_Is_oCNpc (ptr)) {
			var oCNpc npc; npc = _^ (ptr);
			if (Hlp_IsValidNPC (npc)) {
				if (npc.enemy == slfPtr) {
					//Remove enemy
					oCNpc_SetEnemy(npc, 0);

					//Remove hitTarget
					if (npc.aniCtrl) {
						var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (npc.aniCtrl);
						aniCtrl.hitTarget = 0;
					};
				};
			};
		};

		i += 1;
	end;

	//Stop all effects
	//var int retVal; retVal = Wld_StopEffect_Ext (STR_EMPTY, 0, slf, TRUE);

	//Remove routines
	oCRtnManager_RemoveRoutine(slfPtr);

	//Remove from focus
	oCNpc_SetFocusVob(her, 0);

	//Clear event manager
	oCNpc_ClearEM(slf);

	var string s; s = ConcatStrings(GetSymbolName(Hlp_GetInstanceID(slf)), " despawned.");

	//Delete npc
	oCSpawnManager_DeleteNpc(slfPtr);
	return s;
};

func void CC_Despawn_Init () {
	CC_Register(CC_Despawn, "despawn", "Will despawn Npc in focus.");
};
