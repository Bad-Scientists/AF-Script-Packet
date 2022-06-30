var int holdTime_On;

var int holdTime_Hour;
var int holdTime_Min;

func void _hook_zCWorld_AdvanceClock () {
	if (holdTime_On) {
		oCWorldTimer_SetTime (holdTime_Hour, holdTime_Min);
	};
};

func string CC_HoldTime (var string param) {
	holdTime_On = !holdTime_On;

	if (holdTime_On) {
		oCWorldTimer_GetTime (_@ (holdTime_Hour), _@ (holdTime_Min));
		return "Hold time - on.";
	};

	return "Hold time - off.";
};

func void CC_HoldTime_Init () {
	CC_Register (CC_HoldTime, "hold time", "Freezes time in place.");

	const int once = 0;
	if (!once) {
		//0x005F7A80 public: void __thiscall zCWorld::AdvanceClock(float)
		const int zCWorld__AdvanceClock_G1 = 6257280;

		//0x006260E0 public: void __thiscall zCWorld::AdvanceClock(float)
		const int zCWorld__AdvanceClock_G2 = 6447328;

		HookEngine (MEMINT_SwitchG1G2 (zCWorld__AdvanceClock_G1, zCWorld__AdvanceClock_G2), 10, "_hook_zCWorld_AdvanceClock");
		once = 1;
	};
};
