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

