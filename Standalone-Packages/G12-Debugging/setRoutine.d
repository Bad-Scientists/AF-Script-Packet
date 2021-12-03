func string CC_SetRoutine (var string newRtn) {
	var oCNPC her; her = Hlp_GetNPC (hero);

	if (!Hlp_Is_oCNpc (her.focus_vob)) { return "No NPC in focus."; };

	//Hmmm seems like parameter has extra leading space
	newRtn = STR_Trim (newRtn, " ");

	var C_NPC npc; npc = _^ (her.focus_vob);

	NPC_ClearAIQueue (npc);
	AI_StandUp (npc);

	Npc_ExchangeRoutine (npc, newRtn);
	AI_ContinueRoutine (npc);

	//0x006C6C10 public: class zSTRING __thiscall oCNpc_States::GetRoutineName(void)
	const int oCNpc_States__GetRoutineName_G1 = 7105552;

	//0x0076E180 public: class zSTRING __thiscall oCNpc_States::GetRoutineName(void)
	const int oCNpc_States__GetRoutineName_G2 = 7790976;

	//Here we have inconsistency with class declaration in G1/G2A - different naming, so we have to work with offset instead
	//oCNpc.state_vfptr	// 0x0470
	//oCNpc.state_vtbl	// 0x0588

	var int ptr; ptr = _@ (npc);
	var int offset; offset = MEMINT_SwitchG1G2 (1136, 1416);

	CALL_RetValIszString ();
	CALL__thiscall (ptr + offset, MEMINT_SwitchG1G2 (oCNpc_States__GetRoutineName_G1, oCNpc_States__GetRoutineName_G2));
	var string curRtn; curRtn = CALL_RetValAszstring ();

	//Function above returns routine in full format: RTN_ & routineName & _ID
	//In order to compare routines, we have to convert our newRtn to correct format as well
	newRtn = ConcatStrings ("RTN_", newRtn);
	newRtn = ConcatStrings (newRtn, "_");
	newRtn = ConcatStrings (newRtn, IntToString (npc.ID));

	var string msg;

	if (Hlp_StrCmp (newRtn, curRtn)) {
		msg = "Done. New routine: ";
		msg = ConcatStrings (msg, newRtn);
		return msg;
	};

	msg = ConcatStrings ("Routine ", newRtn);
	msg = ConcatStrings (newRtn, " does not exist.");

	return msg;
};

func void CC_SetRoutine_Init () {
	CC_Register (CC_SetRoutine, "set routine", "Change NPC routine.");
};
