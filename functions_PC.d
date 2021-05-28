/*
 *	Function PC_SetTurnSpeed
 *	Author: Sektenspinner
 *	Original post: https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page13?p=14886885#post14886885
 *	Added support for G1
 */

var int PC_DefaultTurnSpeed;

func void PC_SetTurnSpeed (var int f) {
	//0x007D1110 __real@3dcccccd
	const int G1_HeroTurnSpeedAdr = 8196368;

	//0x0082F330 __real@3dcccccd 
	const int G2_HeroTurnSpeedAdr = 8196368;

	MemoryProtectionOverride (MEMINT_SwitchG1G2 (G1_HeroTurnSpeedAdr, G2_HeroTurnSpeedAdr), 4);
	MEM_WriteInt (MEMINT_SwitchG1G2 (G1_HeroTurnSpeedAdr, G2_HeroTurnSpeedAdr), f);
};

func int PC_IsInState (var func f) {
	if (!Hlp_IsValidNPC (hero)) { return 0; };
	var oCNPC her; her = Hlp_GetNPC (hero);
	return ((MEM_FindParserSymbol (her.state_curState_name) == MEM_GetFuncID (f)) && (her.state_curState_valid));
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
