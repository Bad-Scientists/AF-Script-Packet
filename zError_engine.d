func void zERROR__SetFilterLevel(var int zErrorLevel)
{
	//008699D8  .data     Debug data           ?zerr@@3VzERROR@@A
	const int zERROR__zerr_G1 = 8821208;
	//0x008CDCD0 class zERROR zerr
	const int zERROR__zerr_G2 = 9231568;
	
	var int zerrPtr;
	zerrPtr = MEMINT_SwitchG1G2(zERROR__zerr_G1, zERROR__zerr_G2);
	
	var zERROR zerr;
	zerr = _^(zerrPtr);
	
	//00449680  .text     Debug data           ?SetFilterLevel@zERROR@@QAEXH@Z
	const int zERROR__SetFilterLevel_G1 = 4494976;
	//0x0044DDA0 public: void __thiscall zERROR::SetFilterLevel(int)
	const int zERROR__SetFilterLevel_G2 = 4513184;
	
	CALL_IntParam (zErrorLevel);
	CALL__thiscall (zerr, MEMINT_SwitchG1G2 (zERROR__SetFilterLevel_G1, zERROR__SetFilterLevel_G2));
};