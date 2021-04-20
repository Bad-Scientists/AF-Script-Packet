func void oCGame_TriggerChangeLevel (var string levelName, var string waypoint) {
	//0063D480  .text     Debug data           ?TriggerChangeLevel@oCGame@@UAEXABVzSTRING@@0@Z
	const int oCGame__TriggerChangeLevel_G1 = 6542464;

	//0x006C7AF0 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
	const int oCGame__TriggerChangeLevel_G2 = 7109360;

	CALL_zStringPtrParam (waypoint);
	CALL_zStringPtrParam (levelName);
	CALL__thiscall (_@(MEM_Game), MEMINT_SwitchG1G2 (oCGame__TriggerChangeLevel_G1, oCGame__TriggerChangeLevel_G2));
};
