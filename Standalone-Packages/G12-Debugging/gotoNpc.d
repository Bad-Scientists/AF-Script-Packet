/*
 *	Simple debugging feature that allows us teleportation to NPC by their global variables.
 *	For example:
 *	  var C_NPC Diego; Diego = Hlp_GetNpc (PC_Thief);
 *	We can use console command:
 *	  goto npc Diego
 *	There is a caveat though - NPC has to be already **spawned** into the world, otherwise player will be beamed to position 0 0 0
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
			var C_NPC npc; npc = Hlp_GetNpc (symbID);

			if (Hlp_IsValidNpc (npc)) {
				ptr = MEM_GetSymbolByIndex (Hlp_GetInstanceID (npc));

				if (ptr) {
					var zCPar_Symbol symb; symb = _^ (ptr);

					PrintS (symb.name);

					if (STR_Len (symb.name)) {
						oCNPC_BeamTo (hero, symb.name);
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
