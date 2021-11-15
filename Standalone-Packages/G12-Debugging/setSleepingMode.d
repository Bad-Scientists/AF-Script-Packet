func string CC_SetSleepingMode (var string param) {
	var oCNPC her; her = Hlp_GetNPC (hero);

	if (!her.focus_vob) { return "Nothing in focus."; };

	var int vobPtr; vobPtr = her.focus_vob;
	var int isSleeping; isSleeping = zCVob_IsSleeping (vobPtr);

	isSleeping = !isSleeping;

	zCVob_SetSleeping (vobPtr, isSleeping);

	if (!isSleeping) {
		return "Vob set to 'awake' mode.";
	};

	return "Vob set to 'sleeping' mode. ";
};

func void CC_SetSleepingMode_Init () {
	CC_Register (CC_SetSleepingMode, "set sleepingMode", "Toggle vob sleeping mode.");
};
