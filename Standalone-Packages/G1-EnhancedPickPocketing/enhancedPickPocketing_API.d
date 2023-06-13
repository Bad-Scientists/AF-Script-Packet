/*
//Copy these functions outside of the script packet - define your own rules for pickpocketing :)

func void EnhancedPickPocketing_EmptyInventory () {
	PrintScreen ("This one has empty pockets!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

func void EnhancedPickPocketing_TooFar () {
	PrintScreen ("You're too far away!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

func int C_PP_CanBePutToInventory (var C_NPC npc, var int itemPtr) {
	var oCItem itm; itm = _^ (itemPtr);

	if (Hlp_GetInstanceID (itm) == ItMiNugget) {
		//Do not allow to insert ItMiNuggets
		return FALSE;
	};

	return TRUE;
};

func int C_PP_CanBeStolenFromInventory (var C_NPC npc, var int itemPtr) {
	var oCItem itm; itm = _^ (itemPtr);

	if (Hlp_GetInstanceID (itm) == ItMiNugget) {
		//Do not allow to steal ItMiNuggets
		return FALSE;
	};

	return TRUE;
};
*/
