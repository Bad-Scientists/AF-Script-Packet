/*
 *	G1 default display dialogue distance is 500 in-game cm ... that's not enough - very often subtitles are disappearing because of that
 *	 - this simple 'patch' will override dialogue distance with new value
 */

/*
Usage - call from Init_Global after Ikarus initialization

func void Init_Global () {
	//Ikarus initialization
	MEM_InitAll();

	//Update display dialogue distance. Default G1 500
	G12_SetDisplayDialogueDistance (1500);
};

*/

var int MAX_DISPLAYDIALOGUEDISTANCE;

func int G12_GetDefaultDialogueDistance () { //int
	//006b2a07 + 2
	const int EV_PlaySound_DisplayDialogueDist_Addr_G1 = 7023111;

	//00758740 + 2
	const int EV_PlaySound_DisplayDialogueDist_Addr_G2 = 7702336;

	var int addr; addr = MEMINT_SwitchG1G2 (EV_PlaySound_DisplayDialogueDist_Addr_G1, EV_PlaySound_DisplayDialogueDist_Addr_G2) + 2;
	var int dist; dist = MEM_ReadInt (MEM_ReadInt (addr));

	dist = sqrtf (dist);

	return + roundF (dist);
};

func void G12_SetDisplayDialogueDistance (var int newDistance) { //int
	//006b2a07 + 2
	const int EV_PlaySound_DisplayDialogueDist_Addr_G1 = 7023111;

	//00758740 + 2
	const int EV_PlaySound_DisplayDialogueDist_Addr_G2 = 7702336;

	var int addr; addr = MEMINT_SwitchG1G2 (EV_PlaySound_DisplayDialogueDist_Addr_G1, EV_PlaySound_DisplayDialogueDist_Addr_G2) + 2;

	MAX_DISPLAYDIALOGUEDISTANCE = mkf (newDistance * newDistance);

	//Override with pointer of our own variable
	MemoryProtectionOverride (addr, 4);
	MEM_WriteInt (addr, _@ (MAX_DISPLAYDIALOGUEDISTANCE));
};
