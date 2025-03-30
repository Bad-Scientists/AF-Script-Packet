func int zCOption_New() {
	// sizeof 280h
	const int sizeOf_zCOption_G1 = 640;

	// sizeof 298h
	const int sizeOf_zCOption_G2 = 664;

	var int ptr; ptr = MEM_Alloc(MEMINT_SwitchG1G2(sizeOf_zCOption_G1, sizeOf_zCOption_G2));
	return ptr;
};

func int zCOption_Create() {
	//0x0045ADD0 public: __thiscall zCOption::zCOption(void)
	const int zCOption__zCOption_G1 = 4566480;

	//0x00460350 public: __thiscall zCOption::zCOption(void)
	const int zCOption__zCOption_G2 = 4588368;

	var int ptr; ptr = zCOption_New();
	if (!ptr) { return 0; };

	CALL__thiscall(ptr, MEMINT_SwitchG1G2(zCOption__zCOption_G1, zCOption__zCOption_G2));

	return + ptr;
};
