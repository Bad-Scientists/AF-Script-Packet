func void _eventOpenDeadNPC (var int dummyVariable) {
	if (!Hlp_Is_oCNPC (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);

	if (NPC_IsPlayer (slf)) {
		if (!Hlp_Is_oCNPC (slf.focus_vob)) { return; };

		var C_NPC oth; oth = _^ (slf.focus_vob);

		const int symbID = 0;
		var int retVal; retVal = 0;

		if (!symbID) {
			symbID = MEM_FindParserSymbol ("C_Npc_PreventLooting");
		};

		if (symbID != -1) {
			MEM_PushInstParam (oth);
			MEM_CallByID (symbID);
			retVal = MEM_PopIntResult ();
		};

		if (retVal) {
			oCNpc_SetFocusVob (slf, 0);
		};
	};
};

func void G12_PreventLooting_Init () {
	G12_OpenDeadNPCEvent_Init ();

	//HookEngine (oCNPC__OpenDeadNPC, MEMINT_SwitchG1G2 (7, 6), "_hook_oCNPC_OpenDeadNPC");
	OpenDeadNPCEvent_AddListener (_eventOpenDeadNPC);
};
