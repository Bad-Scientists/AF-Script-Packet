/*
//Copy this function outside of the script packet - define your own states.
//If script-packet is updated in the future - your definition will be unaffected.

func int C_CanPlayerUseAIState (var string AIStateName) {
	//Default engine ZS states [do not change these]
	if (Hlp_StrCmp (AIStateName, "ZS_ASSESSMAGIC"))
	|| (Hlp_StrCmp (AIStateName, "ZS_ASSESSSTOPMAGIC"))
	|| (Hlp_StrCmp (AIStateName, "ZS_MAGICFREEZE"))
	|| (Hlp_StrCmp (AIStateName, "ZS_WHIRLWIND"))
	|| (Hlp_StrCmp (AIStateName, "ZS_SHORTZAPPED"))
	|| (Hlp_StrCmp (AIStateName, "ZS_ZAPPED"))
	|| (Hlp_StrCmp (AIStateName, "ZS_PYRO"))
	|| (Hlp_StrCmp (AIStateName, "ZS_MAGICSLEEP"))
	|| (Hlp_StrCmp (AIStateName, "ZS_MAGICBURN"))

	// Additional - add as many as you need ...
	|| (Hlp_StrCmp (AIStateName, "ZS_INVMANAGEMENT"))
	|| (Hlp_StrCmp (AIStateName, "ZS_PICKPOCKETING"))
	|| (Hlp_StrCmp (AIStateName, "ZS_TALK"))
	|| (Hlp_StrCmp (AIStateName, "ZS_PLAYERTALK"))
	{
		return TRUE;
	};

	return FALSE;
};
*/
