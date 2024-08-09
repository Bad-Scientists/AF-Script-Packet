/*
 *	Enable player states
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (define your own ZS states)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

func int C_CanPlayerUseAIState(var string AIStateName) {
	//Default engine ZS states [do not change these]
	if (Hlp_StrCmp(AIStateName, "ZS_ASSESSMAGIC"))
	|| (Hlp_StrCmp(AIStateName, "ZS_ASSESSSTOPMAGIC"))
	|| (Hlp_StrCmp(AIStateName, "ZS_MAGICFREEZE"))
	|| (Hlp_StrCmp(AIStateName, "ZS_SHORTZAPPED"))
	|| (Hlp_StrCmp(AIStateName, "ZS_ZAPPED"))
	|| (Hlp_StrCmp(AIStateName, "ZS_PYRO"))
	|| (Hlp_StrCmp(AIStateName, "ZS_MAGICSLEEP"))
	|| (Hlp_StrCmp(AIStateName, "ZS_MAGICBURN"))

	// Additional - add as many as you need ...
	|| (Hlp_StrCmp(AIStateName, "ZS_MAGICFEAR")) //G1 vanilla only
	|| (Hlp_StrCmp(AIStateName, "ZS_WHIRLWIND")) //G2 NoTR vanilla only

	|| (Hlp_StrCmp(AIStateName, "ZS_PC_CONTROLLING")) //G1 oversight - fix it :)
	{
		return TRUE;
	};

	return FALSE;
};

