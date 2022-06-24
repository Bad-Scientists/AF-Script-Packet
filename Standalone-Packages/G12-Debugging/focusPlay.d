/*
 *	Focus Play Ani
 *	- will play animation on focused NPC
 */
func string CC_FocusPlayAni (var string param) {
	param = STR_Trim (param, " ");
	param = STR_Upper (param);

	var oCNpc npc;
	var oCNpc her; her = Hlp_GetNpc (hero);

	if (!Hlp_Is_oCNpc (her.focus_vob)) {
		return "No NPC in the focus.";
	};

	npc = _^ (her.focus_vob);

	var string aniName; aniName = "";

	var int count; count = STR_SplitCount (param, " ");
	if (count > 0) {
		aniName = STR_Split (param, " ", 0);
		aniName = STR_Trim (aniName, " ");
	};

	if (!STR_Len (aniName)) {
		return "No animation specified.";
	};

	var int aniFrame; aniFrame = FLOATNULL;
	var string aniFrameS; aniFrameS = "";

	if (count > 1) {
		aniFrameS = STR_Split (param, " ", 1);
		aniFrameS = STR_Trim (aniFrameS, " ");
		aniFrame = STR_ToFloat (aniFrameS);
	};

	if (!STR_Len (aniFrameS)) {
		Npc_ClearAIQueue (npc);
		AI_Wait (npc, 10);
		Npc_PlayAni (npc, aniName);
	} else {
		//Default ani dir - forward
		var int aniDir; aniDir = AniDir_Forward;

		//Play ani with Frame offset
		//TODO:
		NPC_StartAniWithFrameOffset(npc, aniName, aniFrame, aniDir);
	};

	var string msg;
	msg = ConcatStrings ("Animation ", aniName);
	msg = ConcatStrings (msg, " started.");

	return msg;
};

/*
 *	Focus Play Effect
 *	- will play effect on focused NPC
 */
func string CC_FocusPlayEffect (var string param) {
	param = STR_Trim (param, " ");
	param = STR_Upper (param);

	var oCNpc npc;
	var oCNpc her; her = Hlp_GetNpc (hero);

	if (!Hlp_Is_oCNpc (her.focus_vob)) {
		return "No NPC in the focus.";
	};

	npc = _^ (her.focus_vob);

	var string effectName; effectName = "";

	var int count; count = STR_SplitCount (param, " ");
	if (count > 0) {
		effectName = STR_Split (param, " ", 0);
		effectName = STR_Trim (effectName, " ");
	};

	if (!STR_Len (effectName)) {
		return "No effect specified.";
	};

	Wld_PlayEffect(effectName, npc, npc, 0, 0, 0, FALSE);

	var string msg;
	msg = ConcatStrings ("Effect ", effectName);
	msg = ConcatStrings (msg, " started.");

	return msg;
};

func void CC_FocusPlay_Init () {
	CC_Register (CC_FocusPlayAni, "focus play ani", "Plays animation on Npc in focus.");
	CC_Register (CC_FocusPlayEffect, "focus play effect", "Plays effect on Npc in focus.");
};
