func string CC_ShowRoutine (var string newRtn) {
	var oCNPC her; her = Hlp_GetNPC (hero);

	if (!Hlp_Is_oCNpc (her.focus_vob)) { return "No NPC in focus."; };

	var C_NPC npc; npc = _^ (her.focus_vob);
	var string curRtn; curRtn = NPC_GetRoutineName (npc);
	return curRtn;
};

func string CC_SetRoutine (var string newRtn) {
	var oCNPC her; her = Hlp_GetNPC (hero);

	if (!Hlp_Is_oCNpc (her.focus_vob)) { return "No NPC in focus."; };

	//Hmmm seems like parameter has extra leading space
	newRtn = STR_TrimChar (newRtn, CHR_SPACE);

	var C_NPC npc; npc = _^ (her.focus_vob);

	NPC_ClearAIQueue (npc);
	AI_StandUp (npc);

	Npc_ExchangeRoutine (npc, newRtn);
	AI_ContinueRoutine (npc);

	var string curRtn; curRtn = NPC_GetRoutineName (npc);

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
	CC_Register (CC_ShowRoutine, "show routine", "Display NPC routine.");
	CC_Register (CC_SetRoutine, "set routine", "Change NPC routine.");
};
