func void oCMobInter_SendStateChange (var int mobPtr, var int fromState, var int toState)
{
	//0x0067D8C0 protected: void __thiscall oCMobInter::SendStateChange(int,int) 
	const int oCMobInter__SendStateChange_G1 = 6805696;
	
	//0x0071ED90 public: void __thiscall oCMobInter::SendStateChange(int,int)
	const int oCMobInter__SendStateChange_G2 = 7466384;

	if (!mobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (toState));
		CALL_IntParam (_@ (fromState));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SendStateChange_G1, oCMobInter__SendStateChange_G2));
		call = CALL_End();
	};
};
