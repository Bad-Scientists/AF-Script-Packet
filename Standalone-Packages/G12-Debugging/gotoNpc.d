/*
 *	Simple debugging feature that allows us teleportation to NPC by their global variables / using npc names
 *	For example define your own variable, or simply use NPCs name:
 *	  var C_NPC FriendDiego; FriendDiego = Hlp_GetNpc (PC_Thief);
 *	We can use console command:
 *	  goto npc FriendDiego
 *	  goto npc Diego
 */

func void PC_BeamToNpc (var int npcInstance) {
	var oCNpc npc;
	var int pos[3];

	npc = Hlp_GetNpc (npcInstance);
	if (!Hlp_IsValidNPC (npc)) { return; };

	//Default position - players position
	if (zCVob_GetPositionWorldToPos (_@ (hero), _@ (pos))) {
		//...
	};

	//Get NPC state
	var int statePtr; statePtr = NPC_GetNPCState (npc);
	if (statePtr) {
		var oCNPC_States state; state = _^ (statePtr);

		//Get routine position
		if (state.hasRoutine) {
			var int posPtr; posPtr = oCRtnManager_GetRoutinePos (npc);
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

	var int ptr; ptr = MEM_GetSymbolByIndex (Hlp_GetInstanceID (npc));

	if (ptr) {
		var zCPar_Symbol symb; symb = _^ (ptr);
		PrintS (symb.name);

		if (STR_Len (symb.name)) {
			//Seems like oCNpc::Enable will spawn NPC (?) :yuppi:
			oCNpc_Enable (npc, _@ (pos));
			oCNPC_BeamTo (hero, symb.name);
		};
	};
};

func string CC_GotoNpc (var string param) {
	param = STR_Trim (param, " ");
	param = STR_Upper (param);

	var int count; count = STR_SplitCount (param, " ");
	var string objectName; objectName = "";

	if (count > 0) {
		objectName = STR_Split (param, " ", 0);
		objectName = STR_Trim (objectName, " ");
		objectName = STR_Upper (objectName);
	};

	if (STR_Len (objectName)) {
		var oCNpc npc;

		//Get vob
		var int ptr; ptr = MEM_SearchVobByName (objectName);

		if (ptr) {
			oCNPC_BeamTo (hero, objectName);
			return "Vob found.";
		};

		//Get variable name
		var int symbID; symbID = MEM_GetSymbolIndex (objectName);

		if (symbID > -1) {
			npc = Hlp_GetNpc (symbID);

			if (Hlp_IsValidNpc (npc)) {
				PC_BeamToNpc (npc);
				return "Npc found.";
			};
		} else {
			//Loop through list of Npcs and search by name
			var int listPtr;

			listPtr = MEM_World_Get_voblist_npcs ();

			ptr = 0;

			var zCListSort list;

			while (listPtr);
				list = _^ (listPtr);
				if (list.data) {
					if (Hlp_Is_oCNpc (list.data)) {
						npc = _^ (list.data);
						if (Hlp_IsValidNPC (npc)) {
							if (Hlp_StrCmp (STR_Upper (npc.name), objectName)) {
								PC_BeamToNpc (npc);
								return "Npc found.";
							};
						};
					};
				};

				listPtr = list.next;
			end;
		};
	};

	return "Vob/Npc not found.";
};

func void CC_GotoNpc_Init () {
	CC_Register (CC_GotoNpc, "goto npc", "Will teleport player to specific npc.");
};
