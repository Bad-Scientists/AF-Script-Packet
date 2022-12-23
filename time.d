/*
 *	Engine function that returns time using oCWorldTimer
 */
func void oCWorldTimer_GetTime (var int hourPtr, var int minPtr) {
	//0x006D7BB0 public: void __thiscall oCWorldTimer::GetTime(int &,int &)
	const int oCWorldTimer__GetTime_G1 = 7175088;

	//0x00780DF0 public: void __thiscall oCWorldTimer::GetTime(int &,int &)
	const int oCWorldTimer__GetTime_G2 = 7867888;

	var int wldTimerPtr; wldTimerPtr = MEM_Game.wldTimer;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (minPtr));
		CALL_PtrParam (_@ (hourPtr));

		CALL__thiscall (_@ (wldTimerPtr), MEMINT_SwitchG1G2 (oCWorldTimer__GetTime_G1, oCWorldTimer__GetTime_G2));
		call = CALL_End();
	};
};

/*
 *	Engine function that sets up time
 */
func void oCWorldTimer_SetTime (var int hourPtr, var int minPtr) {
	//0x006D7C00 public: void __thiscall oCWorldTimer::SetTime(int,int)
	const int oCWorldTimer__SetTime_G1 = 7175168;

	//0x00780E40 public: void __thiscall oCWorldTimer::SetTime(int,int)
	const int oCWorldTimer__SetTime_G2 = 7867968;

	var int wldTimerPtr; wldTimerPtr = MEM_Game.wldTimer;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (minPtr));
		CALL_PtrParam (_@ (hourPtr));

		CALL__thiscall (_@ (wldTimerPtr), MEMINT_SwitchG1G2 (oCWorldTimer__SetTime_G1, oCWorldTimer__SetTime_G2));
		call = CALL_End();
	};
};

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
//	var int time; time = -1;
//
//	if (!MEM_World.activeSkyControler) { return -1; };
//
//	if (Hlp_Is_zCSkyControler_Outdoor (MEM_World.activeSkyControler)) {
//		time = zCSkyControler_Outdoor_GetTime ();
//	} else
//
//	if (Hlp_Is_zCSkyControler_Indoor (MEM_World.activeSkyControler)) {
//		time = zCSkyControler_Indoor_GetTime ();
//	};
//
//	return +GetTime_GetHour (time);

	var int hour; var int min;
	oCWorldTimer_GetTime (_@ (hour), _@ (min));
	return +hour;
};

func int Wld_GetMinute () {
//	var int time; time = -1;
//
//	if (!MEM_World.activeSkyControler) { return -1; };
//
//	if (Hlp_Is_zCSkyControler_Outdoor (MEM_World.activeSkyControler)) {
//		time = zCSkyControler_Outdoor_GetTime ();
//	} else
//
//	if (Hlp_Is_zCSkyControler_Indoor (MEM_World.activeSkyControler)) {
//		time = zCSkyControler_Indoor_GetTime ();
//	};
//
//	return +GetTime_GetMinute (time);

	var int hour; var int min;
	oCWorldTimer_GetTime (_@ (hour), _@ (min));
	return +min;
};

func int Wld_GetTime () {
	//var int h;
	//h = Wld_GetHour ();
	//h = h * 60 + Wld_GetMinute ();
	//h = h + Wld_GetDay () * 24 * 60;
	//return h;

	var int hour; var int min;
	oCWorldTimer_GetTime (_@ (hour), _@ (min));

	var int t; t = hour * 60 + min + (Wld_GetDay () * 24 * 60);
	return +t;
};
