/*
 *	Here you can specify what states are allowed for player
 */
func int CanPlayerUseAIState (var string AIStateName) {
	if (Hlp_StrCmp (AIStateName, "ZS_WHIRLWIND"))
	|| (Hlp_StrCmp (AIStateName, "ZS_INVMANAGEMENT"))
	|| (Hlp_StrCmp (AIStateName, "ZS_PICKPOCKETING")) {
		return TRUE;
	};

	return FALSE;
};
