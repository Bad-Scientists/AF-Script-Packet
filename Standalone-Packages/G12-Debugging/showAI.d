/*
 *	Show AI
 *	- will display AI details for NPC in focus
 */

func string CC_ShowAI (var string param) {
	var string msg;

	var oCNPC npc;
	var oCNPC her; her = Hlp_GetNPC (hero);

	const int lastFocus = 0;

	if (Hlp_Is_oCNpc (lastFocus)) {
		npc = _^ (lastFocus);

		if (NPC_GetShowAI (npc)) {
			NPC_SetShowAI (npc, 0);
			msg = "Hiding AI info.";
			lastFocus = 0;
			return msg;
		};
	};

	lastFocus = 0;

	if (her.focus_vob) {
		lastFocus = her.focus_vob;

		if (Hlp_Is_oCNpc (lastFocus)) {
			npc = _^ (lastFocus);

			if (NPC_GetShowAI (npc)) {
				NPC_SetShowAI (npc, 0);
				msg = "Hiding AI info.";
			} else {
				NPC_SetShowAI (npc, 1);
				msg = ConcatStrings (npc.Name, " show AI info.");
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
};
