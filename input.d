/*
 *	zCInput_GetFirstBindedLogicalKey
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
		CALL_PutRetValTo (_@(retVal));
		CALL_IntParam(_@(key));
		CALL__thiscall(zinputPtr, MEMINT_SwitchG1G2(zCInput__GetFirstBindedLogicalKey_G1, zCInput__GetFirstBindedLogicalKey_G2));
		call = CALL_End();
	};

	return + (retVal & 255);
};

/*
 *	zCInput_IsBinded
 */
func int zCInput_IsBinded (var int logicalID, var int key) {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C3050 public: int __thiscall zCInput::IsBinded(unsigned short,unsigned short)
	const int zCInput__IsBinded_G1 = 4993104;

	//0x004CC370 public: int __thiscall zCInput::IsBinded(unsigned short,unsigned short)
	const int zCInput__IsBinded_G2 = 5030768;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zinputPtr; zinputPtr = MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2);
		CALL_PutRetValTo (_@(retVal));
		CALL_IntParam(_@(key));
		CALL_IntParam(_@(logicalID));
		CALL__thiscall(zinputPtr, MEMINT_SwitchG1G2(zCInput__IsBinded_G1, zCInput__IsBinded_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCInput_ClearKeyBuffer
 */
func void zCInput_ClearKeyBuffer() {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C2950 public: virtual void __thiscall zCInput::ClearKeyBuffer(void)
	const int zCInput__ClearKeyBuffer_G1 = 4991312;

	//0x004CBC90 public: virtual void __thiscall zCInput::ClearKeyBuffer(void)
	const int zCInput__ClearKeyBuffer_G2 = 5029008;

	var int zinputPtr; zinputPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2));

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(zinputPtr), MEMINT_SwitchG1G2(zCInput__ClearKeyBuffer_G1, zCInput__ClearKeyBuffer_G2));
		call = CALL_End();
	};
};

/*
 *	zCInput_ResetRepeatKey
 */
func void zCInput_ResetRepeatKey(var int resetLastKey) {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C2910 public: virtual void __thiscall zCInput::ResetRepeatKey(int)
	const int zCInput__ResetRepeatKey_G1 = 4991248;

	//0x004CBC50 public: virtual void __thiscall zCInput::ResetRepeatKey(int)
	const int zCInput__ResetRepeatKey_G2 = 5028944;

	var int zinputPtr; zinputPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2));

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(resetLastKey));
		CALL__thiscall(_@(zinputPtr), MEMINT_SwitchG1G2(zCInput__ResetRepeatKey_G1, zCInput__ResetRepeatKey_G2));
		call = CALL_End();
	};
};

/*
 *	zCInput_Win32_GetToggled
 *	 - consecutive calls return FALSE
 */
func int zCInput_Win32_GetToggled(var int logicalID) {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C8630 public: virtual int __thiscall zCInput_Win32::GetToggled(unsigned short)
	const int zCInput_Win32__GetToggled_G1 = 5015088;

	//0x004D5020 public: virtual int __thiscall zCInput_Win32::GetToggled(unsigned short)
	const int zCInput_Win32__GetToggled_G2 = 5066784;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zinputPtr; zinputPtr = MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2);
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(logicalID));
		CALL__thiscall(zinputPtr, MEMINT_SwitchG1G2(zCInput_Win32__GetToggled_G1, zCInput_Win32__GetToggled_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCInput_Win32_ResetRepeatKey
 */
func void zCInput_Win32_ResetRepeatKey(var int resetLastKey) {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C8860 public: virtual void __thiscall zCInput_Win32::ResetRepeatKey(int)
	const int zCInput_Win32__ResetRepeatKey_G1 = 5015648;

	//0x004D5330 public: virtual void __thiscall zCInput_Win32::ResetRepeatKey(int)
	const int zCInput_Win32__ResetRepeatKey_G2 = 5067568;

	var int zinputPtr; zinputPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2));

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(resetLastKey));
		CALL__thiscall(_@(zinputPtr), MEMINT_SwitchG1G2(zCInput_Win32__ResetRepeatKey_G1, zCInput_Win32__ResetRepeatKey_G2));
		call = CALL_End();
	};
};

/*
 *	zCInput_Win32_ClearKeyBuffer
 */
func void zCInput_Win32_ClearKeyBuffer() {
	//0x0086CCA0 class zCInput * zinput
	const int zinput_addr_G1 = 8834208;

	//0x008D1650 class zCInput * zinput
	const int zinput_addr_G2 = 9246288;

	//0x004C8AE0 public: virtual void __thiscall zCInput_Win32::ClearKeyBuffer(void)
	const int zCInput_Win32__ClearKeyBuffer_G1 = 5016288;

	//0x004D55D0 public: virtual void __thiscall zCInput_Win32::ClearKeyBuffer(void)
	const int zCInput_Win32__ClearKeyBuffer_G2 = 5068240;

	var int zinputPtr; zinputPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zinput_addr_G1, zinput_addr_G2));

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(zinputPtr), MEMINT_SwitchG1G2(zCInput_Win32__ClearKeyBuffer_G1, zCInput_Win32__ClearKeyBuffer_G2));
		call = CALL_End();
	};
};

/*
 *	zCInput_IsBindedToggled
 */
func int zCInput_IsBindedToggled(var int logicalID, var int key) {
	return + (zCInput_IsBinded(logicalID, key) && zCInput_Win32_GetToggled(logicalID));
};

/*
 *	zCInputCallback_SetHandleEventTop
 */
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

/*
 *	zCInputCallback_DoEvents
 */
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

/*
 *	zCInputCallback_SetKey **hack
 */
func void zCInputCallback_SetKey(var int key) {
	MEM_WriteInt(ESP + 4, key);
	EDI = key;
	MEM_WriteInt(ESP - 40, EDI);
};

/*
 *	zCInputCallback_GetEnableHandleEvent
 */
func int zCInputCallback_GetEnableHandleEvent(var int inputCallbackPtr) {
	//0x006FB970 public: int __thiscall zCInputCallback::GetEnableHandleEvent(void)
	const int zCInputCallback__GetEnableHandleEvent_G1 = 7321968;

	//0x007A5560 public: int __thiscall zCInputCallback::GetEnableHandleEvent(void)
	const int zCInputCallback__GetEnableHandleEvent_G2 = 8017248;

	if (!inputCallbackPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(inputCallbackPtr), MEMINT_SwitchG1G2(zCInputCallback__GetEnableHandleEvent_G1, zCInputCallback__GetEnableHandleEvent_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCInputCallback_SetEnableHandleEvent
 */
func void zCInputCallback_SetEnableHandleEvent(var int inputCallbackPtr, var int enabled) {
	//0x006FB8F0 public: void __thiscall zCInputCallback::SetEnableHandleEvent(int)
	const int zCInputCallback__SetEnableHandleEvent_G1 = 7321840;

	//0x007A54E0 public: void __thiscall zCInputCallback::SetEnableHandleEvent(int)
	const int zCInputCallback__SetEnableHandleEvent_G2 = 8017120;

	if (!inputCallbackPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(enabled));
		CALL__thiscall(_@(inputCallbackPtr), MEMINT_SwitchG1G2(zCInputCallback__SetEnableHandleEvent_G1, zCInputCallback__SetEnableHandleEvent_G2));
		call = CALL_End();
	};
};

/*
 *	GetCharFromDIK
 */
func int GetCharFromDIK(var int key, var int shift, var int alt) {
	//0x004C7590 char __cdecl GetCharFromDIK(char,char)
	const int GetCharFromDIK_G1 = 5010832;

	//0x004D2130 unsigned char __cdecl GetCharFromDIK(int,int,int)
	const int GetCharFromDIK_G2 = 5054768;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));

		if (MEMINT_SwitchG1G2(0, 1)) {
			CALL_IntParam(_@(alt));
		};

		CALL_IntParam(_@(shift));
		CALL_IntParam(_@(key));
		CALL__cdecl(MEMINT_SwitchG1G2(GetCharFromDIK_G1, GetCharFromDIK_G2));
		call = CALL_End();
	};

	if (retVal == -1) {
		return + retVal;
	};

	return + (retVal & 255);
};
