/*
 *	Show AI
 *	- will display AI details for NPC in focus
 */

var int showAI_LastFocus;

func string CC_ShowAI (var string param) {
	var string msg;

	var oCNPC npc;
	var oCNPC her; her = Hlp_GetNPC (hero);

	if (Hlp_Is_oCNpc (showAI_LastFocus)) {
		npc = _^ (showAI_LastFocus);

		if (NPC_GetShowAI (npc)) {
			NPC_SetShowAI (npc, 0);
			msg = "Hiding AI info.";
			showAI_LastFocus = 0;
			return msg;
		};
	};

	showAI_LastFocus = 0;

	if (her.focus_vob) {
		showAI_LastFocus = her.focus_vob;

		if (Hlp_Is_oCNpc (showAI_LastFocus)) {
			npc = _^ (showAI_LastFocus);

			if (NPC_GetShowAI (npc)) {
				NPC_SetShowAI (npc, 0);
				msg = "Hiding AI info.";
			} else {
				NPC_SetShowAI (npc, 1);
				msg = GetSymbolName (Hlp_GetInstanceID (npc));
				msg = ConcatStrings (msg, STR_SPACE);
				msg = ConcatStrings (msg, NPC_GetRoutineName (npc));
				msg = ConcatStrings (msg, " show AI info.");
			};
		} else {
			msg = "hero.focus_vob is not an NPC.";
		};
	} else {
		msg = "Nothing in focus.";
	};

	return msg;
};

func void CC_ShowAI_Init () {
	CC_Register (CC_ShowAI, "show AI", "Show AI for NPC in focus.");
	//Reset last focus
	showAI_LastFocus = 0;
};
