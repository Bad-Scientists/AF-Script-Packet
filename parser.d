/*
 *	zCMenu_GetParser
 *	 - returns menu parser
 */
func int zCMenu_GetParser () {
	//0x004CE530 public: static class zCParser * __cdecl zCMenu::GetParser(void)
	const int zCMenu__GetParser_G1 = 5039408;

	//0x004DB130 public: static class zCParser * __cdecl zCMenu::GetParser(void)
	const int zCMenu__GetParser_G2 = 5091632;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__cdecl(MEMINT_SwitchG1G2(zCMenu__GetParser_G1, zCMenu__GetParser_G2));
		call = CALL_End ();
	};

	return +retVal;
};

/*
 *	zCParser_GetSymbol
 *	 - returns parser symbol
 */
func int zCParser_GetSymbol(var int parserPtr, var string symbolName) {
	//0x006EA520 public: class zCPar_Symbol * __thiscall zCParser::GetSymbol(class zSTRING const &)
	const int zCParser__GetSymbol_G1 = 7251232;

	//0x007938D0 public: class zCPar_Symbol * __thiscall zCParser::GetSymbol(class zSTRING const &)
	const int zCParser__GetSymbol_G2 = 7944400;

	if (!parserPtr) { return 0; };

	CALL_zStringPtrParam(symbolName);
	CALL__thiscall(parserPtr, MEMINT_SwitchG1G2(zCParser__GetSymbol_G1, zCParser__GetSymbol_G2));
	return CALL_RetValAsPtr ();
};

/*
 *	zCParser_AutoCompletion
 *	 - default automcompletion used by console (reading symbol table)
 */
func int zCParser_AutoCompletion (var int parserPtr, var int wordPtr) {
	//0x006EB440 public: int __thiscall zCParser::AutoCompletion(class zSTRING &)
	const int zCParser__AutoCompletion_G1 = 7255104;

	//0x00794950 public: int __thiscall zCParser::AutoCompletion(class zSTRING &)
	const int zCParser__AutoCompletion_G2 = 7948624;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_PtrParam(_@(wordPtr));
		CALL__thiscall(_@(parserPtr), MEMINT_SwitchG1G2 (zCParser__AutoCompletion_G1, zCParser__AutoCompletion_G2));
		call = CALL_End();
	};

	return +retVal;
};
