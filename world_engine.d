func string oCWorld_GetWorldFilename () {
	//0063B680  .text     Debug data           ?GetWorldFilename@oCWorld@@QAE?AVzSTRING@@XZ
	const int oCWorld__GetWorldFilename_G1 = 6534784;
	
	//0x0068DE60 public: class zSTRING __thiscall oCWorld::GetWorldFilename(void)
	const int oCWorld__GetWorldFilename_G2 = 6872672;

	CALL_RetValIszString ();
	CALL__thiscall (_@(MEM_World), MEMINT_SwitchG1G2 (oCWorld__GetWorldFilename_G1, oCWorld__GetWorldFilename_G2));
	return CALL_RetValAszstring ();
};
