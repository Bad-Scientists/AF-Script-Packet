/*
 *	Simple debugging feature that allows us teleportation to NPC by their global variables.
 *	For example:
 *	  var C_NPC Diego; Diego = Hlp_GetNpc (PC_Thief);
 *	We can use console command:
 *	  goto npc Diego
 */
func string CC_GotoNpc (var string param) {
	var int count; count = STR_SplitCount (param, " ");
	var string objectName; objectName = "";

	if (count > 1) {
		objectName = STR_Split (param, " ", 1);
		objectName = STR_Trim (objectName, " ");
		objectName = STR_Upper (objectName);
	};

	if (STR_Len (objectName)) {
		var int ptr; ptr = MEM_SearchVobByName (objectName);

		if (ptr) {
			oCNPC_BeamTo (hero, objectName);
			return "Vob found.";
		};

		var int symbID; symbID = MEM_GetSymbolIndex (objectName);

		if (symbID > -1) {
			var oCNpc npc; npc = Hlp_GetNpc (symbID);

			if (Hlp_IsValidNpc (npc)) {
				ptr = MEM_GetSymbolByIndex (Hlp_GetInstanceID (npc));

				if (ptr) {
					var zCPar_Symbol symb; symb = _^ (ptr);

					PrintS (symb.name);

					if (STR_Len (symb.name)) {
						//--> Force NPC spawn
						var int pos[3];

						//Default position - players position
						var int posPtr;
						posPtr = zCVob_GetPositionWorld (_@ (hero));
						MEM_CopyBytes (posPtr, _@ (pos), 12);
						MEM_Free (posPtr);

						//Get NPC state
						var int statePtr; statePtr = NPC_GetNPCState (npc);
						if (statePtr) {
							var oCNPC_States state; state = _^ (statePtr);

							//Get routine position
							if (state.hasRoutine) {
								posPtr = oCRtnManager_GetRoutinePos (npc);
								MEM_CopyBytes (posPtr, _@ (pos), 12);
								MEM_Free (posPtr);
							} else {
								//Update AI state position
								if (!state.aiStateDriven) {
									//Update aiStateDriven - to kick in ai state
									state.aiStateDriven = 1;

									//Update ai position
									npc.state_aiStatePosition[0] = npc._zCVob_trafoObjToWorld[3];
									npc.state_aiStatePosition[1] = npc._zCVob_trafoObjToWorld[7];
									npc.state_aiStatePosition[2] = npc._zCVob_trafoObjToWorld[11];
								};

								//Get AI state position
								MEM_CopyBytes (_@ (npc.state_aiStatePosition), _@ (pos), 12);
							};
						};

						//Seems like oCNpc::Enable will spawn NPC (?) :yuppi:
						oCNpc_Enable (npc, _@ (pos));
						oCNPC_BeamTo (hero, symb.name);
						//<--

						return "Npc found.";
					};
				};
			};
		};
	};

	return "Vob/Npc not found.";
};

func void CC_GotoNpc_Init () {
	CC_Register (CC_GotoNpc, "goto npc", "Will teleport player to specific npc.");
};
