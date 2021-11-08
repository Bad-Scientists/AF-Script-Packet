func void oCMobInter_SendStateChange (var int mobPtr, var int fromState, var int toState) {
	//0x0067D8C0 protected: void __thiscall oCMobInter::SendStateChange(int,int)
	const int oCMobInter__SendStateChange_G1 = 6805696;

	//0x0071ED90 public: void __thiscall oCMobInter::SendStateChange(int,int)
	const int oCMobInter__SendStateChange_G2 = 7466384;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (toState));
		CALL_IntParam (_@ (fromState));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SendStateChange_G1, oCMobInter__SendStateChange_G2));
		call = CALL_End();
	};
};

func string oCMobInter_GetScemeName (var int mobPtr) {
	//0x0067C970 public: virtual class zSTRING __thiscall oCMobInter::GetScemeName(void)
	const int oCMobInter__GetScemeName_G1 = 6801776;

	//0x0071DBE0 public: virtual class zSTRING __thiscall oCMobInter::GetScemeName(void)
	const int oCMobInter__GetScemeName_G2 = 7461856;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return ""; };

	CALL_RetValIszString();

	CALL__thiscall (mobPtr, MEMINT_SwitchG1G2 (oCMobInter__GetScemeName_G1, oCMobInter__GetScemeName_G2));

	return CALL_RetValAszstring ();
};