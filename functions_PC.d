/*
 *	Function PC_SetTurnSpeed
 *	Author: Sektenspinner
 *	Original post: https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page13?p=14886885#post14886885
 *	Added support for G1
 */

/*
 *	2021-09-22 updating hero's turning speed messes up light spell !!
 */

func void PC_SetTurnSpeed (var int f) {
	//0x007D1110 __real@3dcccccd
	const int G1_HeroTurnSpeedAdr = 8196368;

	//0x0082F330 __real@3dcccccd
	const int G2_HeroTurnSpeedAdr = 8581936;

	MemoryProtectionOverride (MEMINT_SwitchG1G2 (G1_HeroTurnSpeedAdr, G2_HeroTurnSpeedAdr), 4);
	MEM_WriteInt (MEMINT_SwitchG1G2 (G1_HeroTurnSpeedAdr, G2_HeroTurnSpeedAdr), f);
};

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
