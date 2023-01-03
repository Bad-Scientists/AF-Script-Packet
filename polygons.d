func void zCPolygon_GetCenter (var int polyPtr, var int targetPosPtr) {
	//0x00598870 public: class zVEC3 __thiscall zCPolygon::GetCenter(void)
	const int zCPolygon__GetCenter_G1 = 5867632;

	//0x005BA2F0 public: class zVEC3 __thiscall zCPolygon::GetCenter(void)
	const int zCPolygon__GetCenter_G2 = 6005488;

	if (!polyPtr) { return; };

	//CALL_RetValIsStruct only supported in disposable calls
	CALL_RetValIsStruct (12);
	CALL__thiscall (polyPtr, MEMINT_SwitchG1G2 (zCPolygon__GetCenter_G1, zCPolygon__GetCenter_G2));
	var int posPtr; posPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (posPtr, targetPosPtr, 12);
	MEM_Free (posPtr);
};
