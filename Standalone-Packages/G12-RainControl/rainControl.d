/*
 *	Rain control
 *
 *	 - allows you to easily control when it is raining
 *	 - allows you to start / stop rain more immersively - with smooth rain fade-in - fade-out transition
 *	 - allows you to change weather type (G2A only)
 *
 *	Required additional LeGo flags: LeGo_Gamestate
 *
 *	Inspiration for code below came from Sektenspinner's post:
 *	Original post: https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page17?p=15187837&viewfull=1#post15187837
 */

const int zTWEATHER_SNOW = 0;
const int zTWEATHER_RAIN = 1;

/*
 *	Internal variables
 */
var int RainControl_StartH;
var int RainControl_StartM;
var int RainControl_EndH;
var int RainControl_EndM;

var int RainControl_DontRain;
var int RainControl_RainForever;

var int RainControl_StartRainOverride;
var int RainControl_StopRainOverride;

var int RainControl_WeatherType;
var int RainControl_WeatherOverride;

var int RainControl_WeatherTypeFirstInit;
/*
 *	Engine function that sets rain weight and duration (not yet compatible, hook _hook_zSkyCtrlOtdr_RenderSkyPre__RainControl overrides values without taking into consideration this function)
 */
func void zCSkyControler_Outdoor_SetRainFXWeight (var int weightF, var int durationF) {
	//0x005C1090 public: void __thiscall zCSkyControler_Outdoor::SetRainFXWeight(float,float)
	const int zCSkyControler_Outdoor__SetRainFXWeight_G1 = 6033552;

	//0x005EB230 public: void __thiscall zCSkyControler_Outdoor::SetRainFXWeight(float,float)
	const int zCSkyControler_Outdoor__SetRainFXWeight_G2 = 6206000;

	if (!MEM_World.skyControlerOutdoor) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (durationF));
		CALL_FloatParam (_@ (weightF));
		CALL__thiscall (_@ (MEM_World.skyControlerOutdoor), MEMINT_SwitchG1G2 (zCSkyControler_Outdoor__SetRainFXWeight_G1, zCSkyControler_Outdoor__SetRainFXWeight_G2));

		call = CALL_End();
	};
};

/*
 *	Engine function that sets weather type
 */
func void zCSkyControler_Outdoor_SetWeatherType (var int weatherType) {
	//G1 does not have weather types
	const int zCSkyControler_Outdoor__SetWeatherType_G1 = 0;

	//0x005EB830 public: virtual void __thiscall zCSkyControler_Outdoor::SetWeatherType(enum zTWeather)
	const int zCSkyControler_Outdoor__SetWeatherType_G2 = 6207536;

	if (!MEM_World.skyControlerOutdoor) { return; };

	//Don't do anything in G1
	if (MEMINT_SwitchG1G2 (1, 0)) {	return;	};

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (weatherType));
		CALL__thiscall (_@ (MEM_World.skyControlerOutdoor), MEMINT_SwitchG1G2 (zCSkyControler_Outdoor__SetWeatherType_G1, zCSkyControler_Outdoor__SetWeatherType_G2));

		call = CALL_End();
	};
};

/*
 *	Engine function that sets weather type
 */
func void zCOutdoorRainFX_SetWeatherType (var int weatherType) {
	//G1 does not have weather types
	const int zCOutdoorRainFX__SetWeatherType_G1 = 0;

	//0x005E1570 public: void __thiscall zCOutdoorRainFX::SetWeatherType(enum zTWeather)
	const int zCOutdoorRainFX__SetWeatherType_G2 = 6165872;

	if (!MEM_SkyController.rainFX_outdoorRainFX) { return; };

	//Don't do anything in G1
	if (MEMINT_SwitchG1G2 (1, 0)) {	return;	};

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (weatherType));
		CALL__thiscall (_@ (MEM_SkyController.rainFX_outdoorRainFX), MEMINT_SwitchG1G2 (zCOutdoorRainFX__SetWeatherType_G1, zCOutdoorRainFX__SetWeatherType_G2));

		call = CALL_End();
	};
};

/*
 *	Function reset's weather (hooked function will not update weather type, engine will update setup automatically)
 *
 *	Seems like all we have to do to 'reset' weather is to temporarily update hero's status - this will also update weather!
 */
func void Wld_ResetWeather () {
	//0x008DE508 protected: static enum oHEROSTATUS oCZoneMusic::s_herostatus
	const int oCZoneMusic__s_herostatus_G1 = 9299208;

	//0x009A4A20 protected: static enum oHEROSTATUS oCZoneMusic::s_herostatus
	const int oCZoneMusic__s_herostatus_G2 = 10111520;

	RainControl_DontRain = FALSE;
	RainControl_RainForever = FALSE;
	RainControl_WeatherOverride = FALSE;

	RainControl_StartRainOverride = FALSE;
	RainControl_StopRainOverride = FALSE;

	//Don't do anything in G1 (we don't need to do anything in G1 ...)
	//if (MEMINT_SwitchG1G2 (1, 0)) { return; };

	//Override status - this will force update
	MemoryProtectionOverride (MEMINT_SwitchG1G2 (oCZoneMusic__s_herostatus_G1, oCZoneMusic__s_herostatus_G2), 4);
	MEM_WriteInt (MEMINT_SwitchG1G2 (oCZoneMusic__s_herostatus_G1, oCZoneMusic__s_herostatus_G2), -1);
};

/*
 *	Function changes weather type (engine can override this at any time)
 */
func void Wld_SetWeatherType (var int weatherType) {
	//Engine function zCSkyControler_Outdoor_SetWeatherType does not allow us to change weather in the middle of the rain
	//Also function zCSkyControler_Outdoor_SetWeatherType seems to trigger snow effect immediately

	//zCOutdoorRainFX_SetWeatherType on the other hand allows us to change weather at any point, also it is not starting anything on its own

	//MEM_SkyController.rainFX_outdoorRainFXWeight = FLOATNULL;
	//zCSkyControler_Outdoor_SetWeatherType (weatherType);

	//Don't do anything in G1
	if (MEMINT_SwitchG1G2 (1, 0)) {	return;	};

	//In G1 we don't have property MEM_SkyController.m_enuWeather, that's why we have to work with offset here (in order to be able to compile scripts)
	//MEM_SkyController.m_enuWeather = weatherType;
	MEM_WriteInt (_@ (MEM_SkyController) + 48, weatherType);
	zCOutdoorRainFX_SetWeatherType (weatherType);
};

/*
 *	Function changes weather type - and instructs our hook to override weather type
 */
func void Wld_ForceWeatherType (var int weatherType) {
	//Don't do anything in G1
	if (MEMINT_SwitchG1G2 (1, 0)) {	return;	};

	RainControl_WeatherOverride = TRUE;
	RainControl_WeatherType = weatherType;
	Wld_SetWeatherType (weatherType);
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
 *	Function returns true if rain is fading in
 */
func int Wld_IsRainFadingIn () {
	if (!Wld_IsRaining_G1 ()) {
		return FALSE;
	};

	var int currentTime; currentTime = zCSkyControler_Outdoor_GetTime ();
	var int deltaFadeIn; deltaFadeIn = subF (currentTime, MEM_SkyController.rainFX_timeStartRain);
	var int duration; duration = subF (MEM_SkyController.rainFX_timeStopRain, MEM_SkyController.rainFX_timeStartRain);

	var int percentage;

	if (gf (duration, FLOATNULL)) {
		//Are we fading-in?
		percentage = divF (deltaFadeIn, duration);
		if lef (percentage, castToIntF (0.2)) {
			return TRUE;
		};
	};

	return FALSE;
};

/*
 *	Function returns true if rain is fading out
 */
func int Wld_IsRainFadingOut () {
	if (!Wld_IsRaining_G1 ()) {
		return FALSE;
	};

	if (Wld_IsRainFadingIn ()) {
		return FALSE;
	};

	var int currentTime; currentTime = zCSkyControler_Outdoor_GetTime ();
	var int deltaFadeOut; deltaFadeOut = subF (MEM_SkyController.rainFX_timeStopRain, currentTime);
	var int duration; duration = subF (MEM_SkyController.rainFX_timeStopRain, MEM_SkyController.rainFX_timeStartRain);

	var int percentage;

	if (gf (duration, FLOATNULL)) {
		//Are we fading-out?
		percentage = divF (deltaFadeOut, duration);
		if lef (percentage, castToIntF (0.2)) {
			return TRUE;
		};
	};

	return FALSE;
};

/*
 *	Emulation for G2 m_bDontRain, if set to true - hook will not allow raining
 */
func void Wld_SetDontRain (var int value) {
	RainControl_DontRain = value;
};

/*
 *	This flag will make sure rain will never stop - can be used with Wld_StartRain for smooth transition
 */
func void Wld_SetRainForever (var int value) {
	RainControl_RainForever = value;
};

/*
 *	Function shuts off rain - no transition 24h
 */
func void Wld_SetRainOff () {
	MEM_SkyController.rainFX_timeStartRain = FLOATNULL;
	MEM_SkyController.rainFX_timeStopRain = FLOATNULL;

	//Override for 24h
	RainControl_StartH = 00;
	RainControl_StartM = 00;
	RainControl_EndH = 23;
	RainControl_EndM = 59;

	RainControl_StartRainOverride = FALSE;
	RainControl_StopRainOverride = TRUE;

	//Stop sound (it would remain active for a moment)
	MEM_SkyController.rainFX_soundVolume = FLOATNULL;

	if (MEM_SkyController.rainFX_outdoorRainFX) {

		//0x005B8560 private: void __thiscall zCOutdoorRainFX::UpdateSound(float)
		const int zCOutdoorRainFX__UpdateSound_G1 = 5997920;

		//0x005E1350 private: void __thiscall zCOutdoorRainFX::UpdateSound(float)
		const int zCOutdoorRainFX__UpdateSound_G2 = 6165328;

		const int call = 0;
		if (CALL_Begin(call)) {
			CALL_FloatParam (_@ (FLOATNULL));
			CALL__thiscall (_@ (MEM_SkyController.rainFX_outdoorRainFX), MEMINT_SwitchG1G2 (zCOutdoorRainFX__UpdateSound_G1, zCOutdoorRainFX__UpdateSound_G2));
			call = CALL_End();
		};
	};
};

/*
 *	Function starts heavy rain - no transition 24h
 */
func void Wld_SetRainOn () {
	MEM_SkyController.rainFX_timeStartRain = FLOATNULL;
	MEM_SkyController.rainFX_timeStopRain = FLOATONE;

	//Override for 24h
	RainControl_StartH = 00;
	RainControl_StartM = 00;
	RainControl_EndH = 23;
	RainControl_EndM = 59;

	RainControl_StartRainOverride = TRUE;
	RainControl_StopRainOverride = FALSE;
};

/*
 *	Function starts rain - with smooth transition
 *	newDuration is integer - duration in minutes
 */
func void Wld_StartRain (var int newDuration) {
	//Default 60 minutes
	if (newDuration == 0) {
		newDuration = 60;
	};

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
				MEM_Info ("Wld_StartRain: rain was fading-in ... extending end time");

				//Ratio for actual percentage
				offsetStart = mulf (mkf (newDuration), percentage);
				offsetEnd = subf (mkf (newDuration), offsetStart);
				fadeInOut = TRUE;
			} else {
				//Are we fading-out?
				percentage = divF (deltaFadeOut, duration);
				if lef (percentage, castToIntF (0.2)) {
					MEM_Info ("Wld_StartRain: rain was fading out ... extending end time");

					//Flipped ratio for actual percentage
					offsetStart = mulf (mkf (newDuration), percentage);
					offsetEnd = subf (mkf (newDuration), offsetStart);
					fadeInOut = TRUE;
				};
			};
		};
	};

	if (!Wld_IsRaining_G1 ()) {
		//Start new rain
		offsetStart = FLOATNULL;
		offsetEnd = mkf (newDuration);
	} else
	if (!fadeInOut) {
		MEM_Info ("Wld_StartRain: set raining ...");

		//Add more time
		offsetStart = addf (mkf (newDuration), mulf (mkf (newDuration), castToIntF (0.2)));
		offsetEnd = mkf (newDuration);
	};

	//Extend rain
	var int start_float; start_float = subf (currentTime, divf (offsetStart, mkf (24 * 60)));
	var int end_float; end_float = addf (currentTime, divf (offsetEnd, mkf (24 * 60)));

	MEM_SkyController.rainFX_timeStartRain = start_float;
	MEM_SkyController.rainFX_timeStopRain = end_float;

	//Temporarily override rain setup
	RainControl_StartRainOverride = TRUE;
	RainControl_StopRainOverride = FALSE;

	//Call after updating timeStart/Stop to force override of previous time-range (by now extended time)
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
		MEM_Info ("Wld_StopRain: rain fading in ... flipping fade-in to fade-out, shutting off rain in next 5 minutes");

		//Flipped ratio for actual percentage
		offsetEnd = mulf (mkf (20), percentage);
		offsetStart = subf (mkf (20), offsetEnd);
	} else {
		//Are we fading-out?
		percentage = divF (deltaFadeOut, duration);
		if lef (percentage, castToIntF (0.2)) {
			MEM_Info ("Wld_StopRain: rain fading out ... shutting off rain in next 5 minutes");

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

	//Call before updating timeStart/Stop to force override of previous time-range
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
		end_hr   = (end_hr + 12) % 24;

		if (start_hr > end_hr) {
			MEM_Info ("Wld_SetRainTime: Rain at 12 noon is not possible!");
			return FALSE;
		};

		/* 24 Stunden auf Bereich 0 bis 1 runterskalieren (float) */
		var int start_float; var int end_float;
		start_float = divf(mkf(start_hr * 60 + start_min), mkf(24 * 60));
		end_float = divf(mkf(end_hr * 60 + end_min), mkf(24 * 60));

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
		if (Wld_IsRaining_G1 ()) {
			if (!RainControl_StopRainOverride) {
				Wld_StopRain ();
			};
		} else {
			Wld_SetRainOff ();
		};
		return;
	};

	/*
	 *	Override - weather type
	 */
	if (RainControl_WeatherOverride) {
		Wld_SetWeatherType (RainControl_WeatherType);
	};

	/*
	 *	Override - rain forever flag
	 */
	if (RainControl_RainForever) {
		//If it is already raining ...
		if (Wld_IsRaining_G1 ()) {
			if (MEM_SkyController.rainFX_timeStopRain != FLOATONE) {
				if (Wld_IsRainFadingOut ()) {
					//This way function will always extend rain time
					Wld_StartRain (0); //Default time - extend for another 60 minutes
				};
			};
		};
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
	 *	API rain setup
	 */
	const int symbID = 0;

	if (!symbID) {
		symbID = MEM_FindParserSymbol ("RainControl_SetupRain");
	};

	if (symbID != -1) {
		MEM_CallByID (symbID);
	};
};

func void _eventGameState__RainControl (var int state) {
	if (state == Gamestate_NewGame)
	|| (state == Gamestate_Loaded)
	{
		//Seems like this fixes issue with save/load of updated rain start/endtime - where rain drops would all fall down almost at the same time in 'waves'
		MEM_SkyController.initDone = FALSE;
	};
};

func void G12_RainControl_Init () {
	//Add listener for game state
	if (_LeGo_Flags & LeGo_Gamestate) {
		Gamestate_AddListener (_eventGameState__RainControl);
	} else {
		zSpy_Info("G12_RainControl_Init: warning this feature required LeGo_Gamestate flag to be enabled!");
	};

	//One-time weather setup (set to default rain)
	if (!RainControl_WeatherTypeFirstInit) {
		RainControl_WeatherType = zTWEATHER_RAIN;
		RainControl_WeatherTypeFirstInit = TRUE;
	};

	const int once = 0;
	if (!once) {
		HookEngine (zCSkyControler_Outdoor__RenderSkyPre, 7, "_hook_zSkyCtrlOtdr_RenderSkyPre__RainControl");
		once = 1;
	};
};
