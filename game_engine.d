func void oCGame_TriggerChangeLevel (var string levelName, var string vobName) {
	//0x0063D480 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G1 = 6542464;

	//0x006C7AF0 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G2 = 7109360;

	vobName = STR_Upper (vobName);
	levelName = STR_Upper (levelName);

	//Safety check - game crashes if you try to trigger change to current world
	var string thisLevelName; thisLevelName = oCWorld_GetWorldFilename ();

	if (Hlp_StrCmp (thisLevelName, levelName)) {
		if (STR_Len (vobName)) {
			Npc_BeamToKeepQueue (hero, vobName);
		};
	} else {
		CALL_zStringPtrParam (vobName);
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
 *	Function returns TRUE if chapter is yet to be introduced
 */
func int CGameManager_GetChapterIntroduce()
{
	//0085e9e0
	const int s_chapter_introduce_addr_G1 = 8776160;

	//008c2954
	const int s_chapter_introduce_addr_G2 = 9185620;

	return + MEM_ReadByte(MEMINT_SwitchG1G2(s_chapter_introduce_addr_G1, s_chapter_introduce_addr_G2));
};
