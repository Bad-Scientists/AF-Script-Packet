/*
 *	Simple debugging feature that allows us teleportation to NPC by their global variables / using npc names
 *	For example define your own variable, or simply use NPCs name:
 *	  var C_NPC FriendDiego; FriendDiego = Hlp_GetNpc (PC_Thief);
 *	We can use console command:
 *	  goto npc FriendDiego
 *	  goto npc Diego
 */

func string CC_GotoNpc (var string param) {
	param = STR_Trim (param, " ");
	param = STR_Upper (param);

	var string objectName;
	objectName = param;

	if (STR_Len (objectName)) {
		var oCNpc npc;

		//Get vob
		var int ptr; ptr = MEM_SearchVobByName (objectName);

		if (ptr) {
			oCNpc_BeamTo (hero, objectName);
			return "Vob found.";
		};

		//Get variable name
		var int symbID; symbID = MEM_GetSymbolIndex (objectName);

		if (symbID > -1) {
			npc = Hlp_GetNpc (symbID);

			if (Hlp_IsValidNpc (npc)) {
				PrintS (GetSymbolName (Hlp_GetInstanceID (npc)));
				NPC_TeleportToNpc (hero, npc);
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
							if (Hlp_StrCmp (STR_Trim (STR_Upper (npc.name), " "), objectName)) {
								PrintS (GetSymbolName (Hlp_GetInstanceID (npc)));
								NPC_TeleportToNpc (hero, npc);
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
