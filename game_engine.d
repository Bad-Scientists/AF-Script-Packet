func void oCGame_TriggerChangeLevel (var string levelName, var string waypoint) {
	//0x0063D480 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G1 = 6542464;

	//0x006C7AF0 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G2 = 7109360;

	waypoint = STR_Upper (waypoint);
	levelName = STR_Upper (levelName);

	//Safety check - game crashes if you try to trigger change to current world
	var string thisLevelName; thisLevelName = oCWorld_GetWorldFilename ();

	if (Hlp_StrCmp (thisLevelName, levelName)) {
		oCNpc_BeamTo (hero, waypoint);
	} else {
		CALL_zStringPtrParam (waypoint);
		CALL_zStringPtrParam (levelName);
		CALL__thiscall (_@(MEM_Game), MEMINT_SwitchG1G2 (oCGame__TriggerChangeLevel_G1, oCGame__TriggerChangeLevel_G2));
	};
};

/*
	enum oHEROSTATUS {
		oHERO_STATUS_STD, 0
		oHERO_STATUS_THR, 1
		oHERO_STATUS_FGT  2
	};
*/

/*
 *	Function tells us whether player is being attacked
 */
func int oCGame_GetHeroStatus () {
	//0x00638B60 public: enum oHEROSTATUS __thiscall oCGame::GetHeroStatus(void)
	const int oCGame__GetHeroStatus_G1 = 6523744;

	//0x006C2D10 public: enum oHEROSTATUS __thiscall oCGame::GetHeroStatus(void)
	const int oCGame__GetHeroStatus_G2 = 7089424;

	var int ptr; ptr = _@ (MEM_Game);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCGame__GetHeroStatus_G1, oCGame__GetHeroStatus_G2));
		call = CALL_End ();
	};

	return CALL_RetValAsInt ();
};

/*
 *	Function updates attitudes of all Npcs
 */
func void oCGame_InitNpcAttitudes () {
	//0x0063BD00 public: void __thiscall oCGame::InitNpcAttitudes(void)
	const int oCGame__InitNpcAttitudes_G1 = 6536448;

	//0x006C61D0 public: void __thiscall oCGame::InitNpcAttitudes(void)
	const int oCGame__InitNpcAttitudes_G2 = 7102928;

	var int ptr; ptr = _@ (MEM_Game);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCGame__InitNpcAttitudes_G1, oCGame__InitNpcAttitudes_G2));
		call = CALL_End ();
	};
};

/*
 *	Function returns game_mode
 */
func int oCNpc_Get_Game_Mode () {
	//0x008DBC24 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G1 = 9288740;

	//0x00AB27D0 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G2 = 11216848;

	return + MEM_ReadInt (MEMINT_SwitchG1G2 (oCNpc__game_mode_G1, oCNpc__game_mode_G2));
};

/*
 *	Function updates game_mode
 */
func void oCNpc_Set_Game_Mode (var int newMode) {
	//0x008DBC24 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G1 = 9288740;

	//0x00AB27D0 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G2 = 11216848;

	MEM_WriteInt (MEMINT_SwitchG1G2 (oCNpc__game_mode_G1, oCNpc__game_mode_G2), newMode);
};
