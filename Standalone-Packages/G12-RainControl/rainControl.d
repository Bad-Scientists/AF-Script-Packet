/*
 *	Rain control
 *	 - allows you to easily control when it is raining
 *	 - allows you to start / stop rain more immersively - with smooth rain fade-in - fade-out transition
 *
 *	Inspiration for code below came from Sektenspinner's post:
 *	Original post: https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page17?p=15187837&viewfull=1#post15187837
 */

/*
 *	Internal variables
 */
var int RainControl_StartH;
var int RainControl_StartM;
var int RainControl_EndH;
var int RainControl_EndM;

var int RainControl_DontRain;

var int RainControl_StartRainOverride;
var int RainControl_StopRainOverride;

/*
 *	Engine function that sets rain weight and duration (not yet compatible, hook _hook_zSkyCtrlOtdr_RenderSkyPre__RainControl overrides values without respecting this function)
 */
func void zCSkyControler_Outdoor_SetRainFXWeight (var int weightF, var int durationF) {
	//0x005C1090 public: void __thiscall zCSkyControler_Outdoor::SetRainFXWeight(float,float)
	const int zCSkyControler_Outdoor__SetRainFXWeight_G1 = 6033552;

	//0x005EB230 public: void __thiscall zCSkyControler_Outdoor::SetRainFXWeight(float,float)
	const int zCSkyControler_Outdoor__SetRainFXWeight_G2 = 6206000;

	if (!MEM_World.skyControlerOutdoor) { return; };

	CALL_FloatParam (durationF);
	CALL_FloatParam (weightF);
	CALL__thiscall (MEM_World.skyControlerOutdoor, MEMINT_SwitchG1G2 (zCSkyControler_Outdoor__SetRainFXWeight_G1, zCSkyControler_Outdoor__SetRainFXWeight_G2));
};

/*
 *	Internal function that calculates start & end hour & min for raining
 */
func void GetRainTime__RainControl () {
	RainControl_StartH = GetTime_GetHour (MEM_SkyController.rainFX_timeStartRain);
	RainControl_StartM = GetTime_GetMinute (MEM_SkyController.rainFX_timeStartRain);
	RainControl_EndH = GetTime_GetHour (MEM_SkyController.rainFX_timeStopRain);
	RainControl_EndM = GetTime_GetMinute (MEM_SkyController.rainFX_timeStopRain);
};

/*
 *	Function returns TRUE if it is raining
 */
func int Wld_IsRaining_G1 () {
	//this should work :)
	return (gf (MEM_SkyController.rainFX_outdoorRainFXWeight, FLOATNULL));
};

/*
 *	'Emulation' for G2 m_bDontRain
 */
func void Wld_SetDontRain (var int value) {
	RainControl_DontRain = value;
};

/*
 *	Function shuts off rain - no transition 24h
 */
func void Wld_SetRainOff () {
	MEM_SkyController.rainFX_timeStartRain = FLOATNULL;
	MEM_SkyController.rainFX_timeStopRain = FLOATNULL;

	GetRainTime__RainControl ();
	RainControl_StartRainOverride = FALSE;
	RainControl_StopRainOverride = TRUE;
};

/*
 *	Function starts heavy rain - no transition 24h
 */
func void Wld_SetRainOn () {
	MEM_SkyController.rainFX_timeStartRain = FLOATNULL;
	MEM_SkyController.rainFX_timeStopRain = FLOATONE;

	GetRainTime__RainControl ();
	RainControl_StartRainOverride = TRUE;
	RainControl_StopRainOverride = FALSE;
};

/*
 *	Function starts rain - with smooth transition
 */
func void Wld_StartRain () {
	var int currentTime; currentTime = zCSkyControler_Outdoor_GetTime ();

	var int deltaFadeIn; deltaFadeIn = subF (currentTime, MEM_SkyController.rainFX_timeStartRain);
	var int deltaFadeOut; deltaFadeOut = subF (MEM_SkyController.rainFX_timeStopRain, currentTime);

	var int duration; duration = subF (MEM_SkyController.rainFX_timeStopRain, MEM_SkyController.rainFX_timeStartRain);

	var int offsetStart;
	var int offsetEnd;

	var int percentage;

	var int fadeInOut; fadeInOut = FALSE;

	if (duration != FLOATNULL) {
		if (Wld_IsRaining_G1 ()) {
			//Are we fading-in?
			percentage = divF (deltaFadeIn, duration);
			if lef (percentage, castToIntF (0.2)) {
				MEM_Info ("Wld_StartRain: rain was fading-in ... extending end time by 60 mins");

				//Ratio for actual percentage
				offsetStart = mulf (mkf (60), percentage);
				offsetEnd = subf (mkf (60), offsetStart);
				fadeInOut = TRUE;
			} else {
				//Are we fading-out?
				percentage = divF (deltaFadeOut, duration);
				if lef (percentage, castToIntF (0.2)) {
					MEM_Info ("Wld_StartRain: rain was fading out ... extending end time by 60 mins");

					//Flipped ratio for actual percentage
					offsetStart = mulf (mkf (60), percentage);
					offsetEnd = subf (mkf (60), offsetStart);
					fadeInOut = TRUE;
				};
			};
		};
	};

	if (!fadeInOut) {
		MEM_Info ("Wld_StartRain: set raining for 60 mins ...");

		//Additional 1 hour
		offsetStart = FLOATNULL;
		offsetEnd = mkf (60);
	};

	//Extend rain
	var int start_float; start_float = subf (currentTime, divf (offsetStart, mkf (24 * 60)));
	var int end_float; end_float = addf (currentTime, divf (offsetEnd, mkf (24 * 60)));

	MEM_SkyController.rainFX_timeStartRain = start_float;
	MEM_SkyController.rainFX_timeStopRain = end_float;

	//Temporarily override rain setup
	RainControl_StartRainOverride = TRUE;
	RainControl_StopRainOverride = FALSE;

	GetRainTime__RainControl ();
};

/*
 *	Function stops rain - with smooth transition
 */
func void Wld_StopRain () {
	if (MEM_SkyController.rainFX_outdoorRainFXWeight == FLOATNULL) { return; };

	//As per notes from Sektenspinner:
	//https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page17?p=15185064&viewfull=1#post15185064
	//Incidentally, it is the first 20% and the last 20% of the time in which the rain is faded in or out.

	//-->
	//What we want is a nice transition when turning off the rain, at the same time we want stop rain fairly quickly

	//Here is the idea ... when we call Wld_StopRain we will change both values:
	//	rainFX_timeStopRain	to current time + 5 minutes (ingame)
	//	rainFX_timeStartRain	to current time - 15 minutes (ingame)

	//This gives us buffer 25% --> fade out transition is smooth

	//Problem: when it is not fully raining (rainFX_outdoorRainFXWeight <> FLOATONE) then transition is not smooth anymore
	//1. figure out whether we are fading in or out
	var int currentTime; currentTime = zCSkyControler_Outdoor_GetTime ();

	var int deltaFadeIn; deltaFadeIn = subF (currentTime, MEM_SkyController.rainFX_timeStartRain);
	var int deltaFadeOut; deltaFadeOut = subF (MEM_SkyController.rainFX_timeStopRain, currentTime);

	var int duration; duration = subF (MEM_SkyController.rainFX_timeStopRain, MEM_SkyController.rainFX_timeStartRain);

	//Prevent division by 0
	if (duration == FLOATNULL) {
		return;
	};

	//2. Figure out best ratio for shutting rain off ...
	var int offsetStart;
	var int offsetEnd;

	var int percentage;

	//Are we fading-in?
	percentage = divF (deltaFadeIn, duration);
	if lef (percentage, castToIntF (0.2)) {
		MEM_Info ("Wld_StopRain: rain fading in ... flipping fade-in to fade-out, shutting off rain in next 4 minutes");

		//Flipped ratio for actual percentage
		offsetEnd = mulf (mkf (20), percentage);
		offsetStart = subf (mkf (20), offsetEnd);
	} else {
		//Are we fading-out?
		percentage = divF (deltaFadeOut, duration);
		if lef (percentage, castToIntF (0.2)) {
			MEM_Info ("Wld_StopRain: rain fading out ... shutting off rain in next 4 minutes");

			//Flipped ratio for actual percentage
			offsetEnd = mulf (mkf (20), percentage);
			offsetStart = subf (mkf (20), offsetEnd);
		} else {
			MEM_Info ("Wld_StopRain: Heavy rain ... shutting off rain in next 5 minutes");

			//ratio exactly 25%
			offsetStart = mkf (15);
			offsetEnd = mkf (5);
		};
	};

	//Temporarily override rain setup
	RainControl_StopRainOverride = TRUE;
	RainControl_StartRainOverride = FALSE;

	GetRainTime__RainControl ();

	//Calculate new offset for smooth rain shutdown
	var int start_float; start_float = subf (currentTime, divf (offsetStart, mkf (24 * 60)));
	var int end_float; end_float = addf (currentTime, divf (offsetEnd, mkf (24 * 60)));

	MEM_SkyController.rainFX_timeStartRain = start_float;
	MEM_SkyController.rainFX_timeStopRain = end_float;
};

/*
 *	Wld_SetRainTime
 *	 - slightly modified version of Sektenspinner's function StartRain_Time
 *	   original post: https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page17?p=15187837&viewfull=1#post15187837
 *
 *	 - rain start & end time is updated only when we are in specified time-slot
 *	 - function returns TRUE if rain time was updated
 */
func int Wld_SetRainTime (var int start_hr, var int start_min, var int end_hr, var int end_min) {
	if (Wld_IsTime (start_hr, start_min, end_hr, end_min)) {
		start_hr = (start_hr + 12) % 24;
		end_hr   = (end_hr   + 12) % 24;

		if (start_hr > end_hr) {
			MEM_Info ("Wld_SetRainTime: Rain at 12 noon is not possible!");
			return FALSE;
		};

		/* 24 Stunden auf Bereich 0 bis 1 runterskalieren (float) */
		var int start_float; var int end_float;
		start_float = divf(mkf(start_hr*60 + start_min), mkf(24*60));
		end_float   = divf(mkf(end_hr  *60 + end_min)  , mkf(24*60));

		MEM_SkyController.rainFX_timeStartRain = start_float;
		MEM_SkyController.rainFX_timeStopRain = end_float;
		return TRUE;
	};

	return FALSE;
};

/*
 *	Main hook that sets up rain start time - end time
 */
func void _hook_zSkyCtrlOtdr_RenderSkyPre__RainControl () {
	/*
	 *	Dont rain flag
	 */

	//Emulation for G2 m_bDontRain (we don't have that one in G1)
	if (RainControl_DontRain) {
		Wld_SetRainOff ();
		return;
	};

	 /*
	 *	Override - start rain
	 */
	if (RainControl_StartRainOverride) {
		//Do not setup new time ...
		if (Wld_IsTime (RainControl_StartH, RainControl_StartM, RainControl_EndH, RainControl_EndM)) {
			return;
		} else {
			RainControl_StartRainOverride = FALSE;
		};
	};

	/*
	 *	Override - stop rain
	 */
	if (RainControl_StopRainOverride) {
		//Do not setup new time ...
		if (Wld_IsTime (RainControl_StartH, RainControl_StartM, RainControl_EndH, RainControl_EndM)) {
			return;
		} else {
			RainControl_StopRainOverride = FALSE;
		};
	};

	/*
	 *	Dynamic rain setup - adjust as you need!
	 */
	if (Wld_SetRainTime (04, 30, 05, 30)) {
	} else if (Wld_SetRainTime (09, 30, 10, 30)) {
	} else if (Wld_SetRainTime (12, 30, 13, 30)) {
	} else if (Wld_SetRainTime (16, 30, 17, 30)) {
	} else if (Wld_SetRainTime (19, 30, 20, 30)) {
	};
};

func void G12_RainControl_Init () {
	const int once = 0;
	if (!once) {
		HookEngine (zCSkyControler_Outdoor__RenderSkyPre, 7, "_hook_zSkyCtrlOtdr_RenderSkyPre__RainControl");
		once = 1;
	};
};
