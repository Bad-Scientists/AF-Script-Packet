/*
 *	Moon phases
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (define your own logic and textures)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

var int overrideMoonPhase;

//API function
func void Moon_CalcMoonPhase() {
	if (overrideMoonPhase) { return; };

	var int currentPhase; currentPhase = Wld_GetDay();
	if (currentPhase > 24) { currentPhase = currentPhase % 24; };

	currentPhase = currentPhase / 3;
	if (currentPhase < 1) { currentPhase = 1; };
	if (currentPhase > 9) { currentPhase = 1; };

	moonPhase = currentPhase;
};

//API function
func void Moon_UpdateTexture() {
	if (moonPhase == 1) { Moon_SetTexture("Moon_Phase1_WaxingCrescent.tga"); };
	if (moonPhase == 2) { Moon_SetTexture("Moon_Phase2_FirstQuarter.tga"); };
	if (moonPhase == 3) { Moon_SetTexture("Moon_Phase3_WaxingGibous.tga"); };
	if (moonPhase == 4) { Moon_SetTexture("Moon_Phase4_FullMoon.tga"); };
	if (moonPhase == 5) { Moon_SetTexture("Moon_Phase5_WaningGibous.tga"); };
	if (moonPhase == 6) { Moon_SetTexture("Moon_Phase6_LastQuarter.tga"); };
	if (moonPhase == 7) { Moon_SetTexture("Moon_Phase7_WaningCrescent.tga"); };
	if (moonPhase == 8) { Moon_SetTexture("Moon_Phase8_NewMoon.tga"); };

	if (moonPhase == 9) { Moon_SetTexture("Moon_Trollface.tga"); };
};
