func int zERROR_GetFilterLevel () {
	//0x008699D8 class zERROR zerr
	const int zerr_G1 = 8821208;
	//0x008CDCD0 class zERROR zerr
	const int zerr_G2 = 9231568;

	var int zerr; zerr = MEMINT_SwitchG1G2 (zerr_G1, zerr_G2);

	//0x0057E350 public: int __thiscall zERROR::GetFilterLevel(void)
	const int zERROR__GetFilterLevel_G1 = 5759824;
	//0x0059D130 public: int __thiscall zERROR::GetFilterLevel(void)
	const int zERROR__GetFilterLevel_G2 = 5886256;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (zerr), MEMINT_SwitchG1G2 (zERROR__GetFilterLevel_G1, zERROR__GetFilterLevel_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void zERROR_SetFilterLevel (var int errorLevel) {
	//0x008699D8 class zERROR zerr
	const int zerr_G1 = 8821208;
	//0x008CDCD0 class zERROR zerr
	const int zerr_G2 = 9231568;

	var int zerr; zerr = MEMINT_SwitchG1G2 (zerr_G1, zerr_G2);

	//0x00449680 public: void __thiscall zERROR::SetFilterLevel(int)
	const int zERROR__SetFilterLevel_G1 = 4494976;
	//0x0044DDA0 public: void __thiscall zERROR::SetFilterLevel(int)
	const int zERROR__SetFilterLevel_G2 = 4513184;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (errorLevel));
		CALL__thiscall (_@ (zerr), MEMINT_SwitchG1G2 (zERROR__SetFilterLevel_G1, zERROR__SetFilterLevel_G2));
		call = CALL_End();
	};
};

func int zERROR_SearchForSpy () {
	//0x008699D8 class zERROR zerr
	const int zerr_G1 = 8821208;
	//0x008CDCD0 class zERROR zerr
	const int zerr_G2 = 9231568;

	var int zerr; zerr = MEMINT_SwitchG1G2 (zerr_G1, zerr_G2);

	//0x00449EB0 public: bool __thiscall zERROR::SearchForSpy(void)
	const int zERROR__SearchForSpy_G1 = 4497072;
	//0x0044E640 public: bool __thiscall zERROR::SearchForSpy(void)
	const int zERROR__SearchForSpy_G2 = 4515392;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (zerr), MEMINT_SwitchG1G2 (zERROR__SearchForSpy_G1, zERROR__SearchForSpy_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void zSpy_Info (var string s) {
	//Backup error level
	var int errorLevel; errorLevel = zERROR_GetFilterLevel ();
	//Set error level to 1 (minimum)
	if (errorLevel < 1) {
		zERROR_SetFilterLevel (1);
	};

	MEM_Info (s);

	//Restore error level
	if (errorLevel < 1) {
		zERROR_SetFilterLevel (errorLevel);
	};
};
