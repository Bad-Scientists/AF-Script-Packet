/*
 *	G12_SetMagBookTurnTime
 */
var int MAGBOOK_TURNTIME;

func void G12_SetMagBookTurnTime(var int newTurnTime) {
	//00472099 d8  35  dc       FDIV       dword ptr [DAT_007d1edc ]
	//         1e  7d  00
	const int oCMag_Book__DoTurn_MAG_SELECT_TIME_addr_G1 = 4661401;

	//00478d59 d8  35  60       FDIV       dword ptr [DAT_00830060 ]
	//         00  83  00
	const int oCMag_Book__DoTurn_MAG_SELECT_TIME_addr_G2 = 4689241;

	MAGBOOK_TURNTIME = mkf(newTurnTime);	

	var int addr; addr = MEMINT_SwitchG1G2(oCMag_Book__DoTurn_MAG_SELECT_TIME_addr_G1, oCMag_Book__DoTurn_MAG_SELECT_TIME_addr_G2) + 2;
	MemoryProtectionOverride(addr, 4);
	MEM_WriteInt(addr, _@(MAGBOOK_TURNTIME)); //original value 250
};

