/*
 *	PC_PutInSleepingMode will freeze player in place (he will not move)
 */
func void PC_PutInSleepingMode () {
	if (!Hlp_IsValidNPC (hero)) { return; };

	var oCNpc her; her = Hlp_GetNpc (hero);
	her._zCVob_bitfield[2] = (her._zCVob_bitfield[2] & ~ zCVob_bitfield2_sleepingMode) | 0;
	NPC_ClearAIQueue (hero);
};

/*
 *	PC_RemoveFromSleepingMode will unfreeze player
 */
func void PC_RemoveFromSleepingMode () {
	if (!Hlp_IsValidNPC (hero)) { return; };

	var oCNpc her; her = Hlp_GetNpc (hero);
	her._zCVob_bitfield[2] = (her._zCVob_bitfield[2] & ~ zCVob_bitfield2_sleepingMode) | 1;
	NPC_ClearAIQueue (hero);
};
