func void oCGame_TriggerChangeLevel (var string levelName, var string waypoint) {
	//0x0063D480 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G1 = 6542464;

	//0x006C7AF0 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G2 = 7109360;

	CALL_zStringPtrParam (waypoint);
	CALL_zStringPtrParam (levelName);
	CALL__thiscall (_@(MEM_Game), MEMINT_SwitchG1G2 (oCGame__TriggerChangeLevel_G1, oCGame__TriggerChangeLevel_G2));
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
