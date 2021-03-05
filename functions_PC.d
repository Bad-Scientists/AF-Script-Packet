/*
 *	Author: Sektenspinner
 *	Original post: https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page13?p=14886885#post14886885
 *	Added support for G1
 */

func void PC_SetTurnSpeed (var int f)
{
	//007D1110  .rdata    Debug data           __real@3dcccccd
	const int G1_HeroTurnSpeedAdr = 8196368;

	//0x0082F330 __real@3dcccccd 
	const int G2_HeroTurnSpeedAdr = 8196368;

	MemoryProtectionOverride (MEMINT_SwitchG1G2 (G1_HeroTurnSpeedAdr, G2_HeroTurnSpeedAdr), 4);
	MEM_WriteInt (MEMINT_SwitchG1G2 (G1_HeroTurnSpeedAdr, G2_HeroTurnSpeedAdr), f);
};
