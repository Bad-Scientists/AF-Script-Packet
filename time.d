/*
 *	Engine function that returns current world time from zCSkyControler_Outdoor
 */
func int zCSkyControler_Outdoor_GetTime () {
	//0x005BC7A0 public: virtual float __thiscall zCSkyControler_Outdoor::GetTime(void)const
	const int zCSkyControler_Outdoor__GetTime_G1 = 6014880;

	//0x005E66F0 public: virtual float __thiscall zCSkyControler_Outdoor::GetTime(void)const
	const int zCSkyControler_Outdoor__GetTime_G2 = 6186736;

	if (!MEM_World.skyControlerOutdoor) { return FLOATNULL; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (MEM_World.skyControlerOutdoor), MEMINT_SwitchG1G2 (zCSkyControler_Outdoor__GetTime_G1, zCSkyControler_Outdoor__GetTime_G2));
		call = CALL_End ();
	};

	return +retVal;
};

/*
 *	Engine function that returns current world time from zCSkyControler_Indoor
 */
func int zCSkyControler_Indoor_GetTime () {
	//0x005B7F80 public: virtual float __thiscall zCSkyControler_Indoor::GetTime(void)const
	const int zCSkyControler_Indoor__GetTime_G1 = 5996416;

	//0x005DF560 public: virtual float __thiscall zCSkyControler_Indoor::GetTime(void)const
	const int zCSkyControler_Indoor__GetTime_G2 = 6157664;

	if (!MEM_World.skyControlerIndoor) { return FLOATNULL; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (MEM_World.skyControlerIndoor), MEMINT_SwitchG1G2 (zCSkyControler_Indoor__GetTime_G1, zCSkyControler_Indoor__GetTime_G2));
		call = CALL_End ();
	};

	return +retVal;
};

//G1
//0x008CE9E0 private: static class zCClassDef zCSkyControler::classDef
//0x008CEAD0 private: static class zCClassDef zCSkyControler_Mid::classDef
//0x008CEBB8 protected: static class zCSkyControler * zCSkyControler::s_activeSkyControler

//G2
//0x0099AB40 private: static class zCClassDef zCSkyControler::classDef
//0x0099ABB0 private: static class zCClassDef zCSkyControler_Mid::classDef
//0x0099AC8C protected: static class zCSkyControler * zCSkyControler::s_activeSkyControler

func int Hlp_Is_zCSkyControler_Outdoor (var int ptr) {
	//0x008CEA60 private: static class zCClassDef zCSkyControler_Outdoor::classDef
	const int zCSkyControler_Outdoor__classDef_G1 = 9235040;

	//0x0099ACD8 private: static class zCClassDef zCSkyControler_Outdoor::classDef
	const int zCSkyControler_Outdoor__classDef_G2 = 10071256;

	return MEM_CheckInheritance(ptr, MEMINT_SwitchG1G2 (zCSkyControler_Outdoor__classDef_G1, zCSkyControler_Outdoor__classDef_G2));
};

func int Hlp_Is_zCSkyControler_Indoor (var int ptr) {
	//0x008CEB48 private: static class zCClassDef zCSkyControler_Indoor::classDef
	const int zCSkyControler_Indoor__classDef_G1 = 9235272;

	////0x0099AC20 private: static class zCClassDef zCSkyControler_Indoor::classDef
	const int zCSkyControler_Indoor__classDef_G2 = 10071072;

	return MEM_CheckInheritance(ptr, MEMINT_SwitchG1G2 (zCSkyControler_Indoor__classDef_G1, zCSkyControler_Indoor__classDef_G2));
};

/*
 *	Function calculates hour from float time
 */
func int GetTime_GetHour (var int timeF) {
	var int hh;
	hh = mulf (timeF, mkf (24));
	hh = (truncf (hh) + 12) % 24;
	return hh; //int
};

/*
 *	Function calculates minute from float time
 */
func int GetTime_GetMinute (var int timeF) {
	var int mm;
	mm = mulf (timeF, mkf (24 * 60));
	mm = truncf (mm) % (24 * 60);
	mm = mm % 60;
	return mm; //int
};

func int Wld_GetHour () {
	var int time; time = -1;

	if (!MEM_World.activeSkyControler) { return -1; };

	if (Hlp_Is_zCSkyControler_Outdoor (MEM_World.activeSkyControler)) {
		time = zCSkyControler_Outdoor_GetTime ();
	} else

	if (Hlp_Is_zCSkyControler_Indoor (MEM_World.activeSkyControler)) {
		time = zCSkyControler_Indoor_GetTime ();
	};

	return +GetTime_GetHour (time);
};

func int Wld_GetMinute () {
	var int time; time = -1;

	if (!MEM_World.activeSkyControler) { return -1; };

	if (Hlp_Is_zCSkyControler_Outdoor (MEM_World.activeSkyControler)) {
		time = zCSkyControler_Outdoor_GetTime ();
	} else

	if (Hlp_Is_zCSkyControler_Indoor (MEM_World.activeSkyControler)) {
		time = zCSkyControler_Indoor_GetTime ();
	};

	return +GetTime_GetMinute (time);
};

func int Wld_GetTime () {
	var int h;
	h = Wld_GetHour ();
	h = h * 60 + Wld_GetMinute ();
	h = h + Wld_GetDay () * 24 * 60;

	return h;
};
