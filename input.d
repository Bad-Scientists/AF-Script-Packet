/*
 *
 */
func int zCInput_GetFirstBindedLogicalKey (var int key) {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C3270 public: unsigned short __thiscall zCInput::GetFirstBindedLogicalKey(unsigned short)
	const int zCInput__GetFirstBindedLogicalKey_G1 = 4993648;

	//0x004CC5D0 public: unsigned short __thiscall zCInput::GetFirstBindedLogicalKey(unsigned short)
	const int zCInput__GetFirstBindedLogicalKey_G2 = 5031376;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zinputPtr; zinputPtr = MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2);

		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam(_@(key));
		CALL__thiscall(zinputPtr, MEMINT_SwitchG1G2 (zCInput__GetFirstBindedLogicalKey_G1, zCInput__GetFirstBindedLogicalKey_G2));
		call = CALL_End();
	};

	return + (retVal & 255);
};


func void zCInputCallback_SetHandleEventTop(var int inputCallBackPtr) {
	//0x006FB880 public: void __thiscall zCInputCallback::SetHandleEventTop(void)
	const int zCInputCallback__SetHandleEventTop_G1 = 7321728;

	//0x007A5470 public: void __thiscall zCInputCallback::SetHandleEventTop(void)
	const int zCInputCallback__SetHandleEventTop_G2 = 8017008;

	if (!inputCallBackPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(inputCallBackPtr), MEMINT_SwitchG1G2(zCInputCallback__SetHandleEventTop_G1, zCInputCallback__SetHandleEventTop_G2));
		call = CALL_End();
	};
};

func int zCInputCallback_DoEvents(var int key) {
	//0x006FB9A0 public: static int __cdecl zCInputCallback::DoEvents(int)
	const int zCInputCallback__DoEvents_G1 = 7322016;

	//0x007A5590 public: static int __cdecl zCInputCallback::DoEvents(int)
	const int zCInputCallback__DoEvents_G2 = 8017296;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(key));
		CALL__cdecl(MEMINT_SwitchG1G2(zCInputCallback__DoEvents_G1, zCInputCallback__DoEvents_G2));
		call = CALL_End();
	};
};

func int GetCharFromDIK(var int key, var int shift, var int alt) {
	//0x004C7590 char __cdecl GetCharFromDIK(char,char)
	const int GetCharFromDIK_G1 = 5010832;

	//0x004D2130 unsigned char __cdecl GetCharFromDIK(int,int,int)
	const int GetCharFromDIK_G2 = 5054768;

	var int retVal;

	CALL_PutRetValTo(_@(retVal));

	if (MEMINT_SwitchG1G2(0, 1)) {
		CALL_IntParam(alt);
	};

	CALL_IntParam(shift);
	CALL_IntParam(key);
	CALL__cdecl(MEMINT_SwitchG1G2 (GetCharFromDIK_G1, GetCharFromDIK_G2));

	if (retVal == -1) {
		return + retVal;
	};

	return + (retVal & 255);
};

