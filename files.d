/*
 *	File functions
 */

/*
 *	zCOption_ChangeDir
 */
func void zCOption_ChangeDir(var int optionPath) {
	//0x00869694 class zCOption * zoptions
	const int zoptions_addr_G1 = 8820372;

	//0x008CD988 class zCOption * zoptions
	const int zoptions_addr_G2 = 9230728;

	//0x0045FB00 public: void __thiscall zCOption::ChangeDir(enum zTOptionPaths)
	const int zCOption__ChangeDir_G1 = 4586240;

	//0x00465160 public: void __thiscall zCOption::ChangeDir(enum zTOptionPaths)
	const int zCOption__ChangeDir_G2 = 4608352;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zoptionsPtr; zoptionsPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zoptions_addr_G1, zoptions_addr_G2));

		//zoptions->ChangeDir(DIR_PRESETS);
		CALL_IntParam(_@(optionPath));
		CALL__thiscall(_@(zoptionsPtr), MEMINT_SwitchG1G2(zCOption__ChangeDir_G1, zCOption__ChangeDir_G2));

		call = CALL_End();
	};
};

/*
 *	zCOption_GetDirString
 */
func string zCOption_GetDirString(var int optionPath) {
	//0x00869694 class zCOption * zoptions
	const int zoptions_addr_G1 = 8820372;

	//0x008CD988 class zCOption * zoptions
	const int zoptions_addr_G2 = 9230728;

	//0x0045FC00 public: class zSTRING & __thiscall zCOption::GetDirString(enum zTOptionPaths)
	const int zCOption__GetDirString_G1 = 4586496;

	//0x00465260 public: class zSTRING & __thiscall zCOption::GetDirString(enum zTOptionPaths)
	const int zCOption__GetDirString_G2 = 4608608;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zoptionsPtr; zoptionsPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zoptions_addr_G1, zoptions_addr_G2));

		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(optionPath));
		CALL__thiscall(_@(zoptionsPtr), MEMINT_SwitchG1G2(zCOption__GetDirString_G1, zCOption__GetDirString_G2));
		call = CALL_End();
	};

	if (retVal) {
		return MEM_ReadString(retVal);
	};

	return STR_EMPTY;
};

