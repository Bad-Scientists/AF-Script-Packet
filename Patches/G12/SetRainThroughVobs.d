/*
 *	Created by Showdown & Lehona
 *	Original post: https://forum.worldofplayers.de/forum/threads/1299679-Skriptpaket-Ikarus-4/page11?p=24735929&viewfull=1#post24735929
 *	I just added G1 address
 */

/*
Usage - call from Init_Global after Ikarus initialization

func void Init_Global () {
	//Ikarus initialization
	MEM_InitAll();

	//Turn off raining through vobs (why would this be enabled?)
	G12_SetRainThroughVobs (FALSE);
};

*/

func void G12_SetRainThroughVobs (var int bool) {
	const int Raincheck_G1 = 6000805;
	const int Raincheck_G2 = 6169210;

	MemoryProtectionOverride (MEMINT_SwitchG1G2(Raincheck_G1, Raincheck_G2), 4);

//enum zTTraceRayFlags {
	const int zTRACERAY_VOB_IGNORE_NO_CD_DYN = 1 << 0;
	const int zTRACERAY_VOB_IGNORE = 1 << 1;
	const int zTRACERAY_VOB_BBOX = 1 << 2;
	const int zTRACERAY_VOB_OBB = 1 << 3;
	const int zTRACERAY_STAT_IGNORE = 1 << 4;
	const int zTRACERAY_STAT_POLY = 1 << 5;
	const int zTRACERAY_STAT_PORTALS = 1 << 6;
	const int zTRACERAY_POLY_NORMAL = 1 << 7;
	const int zTRACERAY_POLY_IGNORE_TRANSP = 1 << 8;
	const int zTRACERAY_POLY_TEST_WATER = 1 << 9;
	const int zTRACERAY_POLY_2SIDED = 1 << 10;
	const int zTRACERAY_VOB_IGNORE_CHARACTER = 1 << 11;
	const int zTRACERAY_FIRSTHIT = 1 << 12;
	const int zTRACERAY_VOB_TEST_HELPER_VISUALS = 1 << 13;

	//G2A only!
	const int zTRACERAY_VOB_IGNORE_PROJECTILES = 1 << 14;
//};

	if (!bool) {
		//New traceray flags - don't ignore vobs
		//224 zTRACERAY_STAT_POLY | zTRACERAY_POLY_NORMAL | zTRACERAY_POLY_TEST_WATER | zTRACERAY_STAT_PORTALS
		MEM_WriteInt (MEMINT_SwitchG1G2 (Raincheck_G1, Raincheck_G2), zTRACERAY_STAT_POLY | zTRACERAY_POLY_NORMAL | zTRACERAY_POLY_TEST_WATER | zTRACERAY_STAT_PORTALS);
	} else {
		//Original traceray flags - raining through vobs
		//226 zTRACERAY_STAT_POLY | zTRACERAY_VOB_IGNORE | zTRACERAY_POLY_NORMAL | zTRACERAY_POLY_TEST_WATER | zTRACERAY_STAT_PORTALS
		MEM_WriteInt (MEMINT_SwitchG1G2 (Raincheck_G1, Raincheck_G2), zTRACERAY_STAT_POLY | zTRACERAY_VOB_IGNORE | zTRACERAY_POLY_NORMAL | zTRACERAY_POLY_TEST_WATER | zTRACERAY_STAT_PORTALS);
	};
};
