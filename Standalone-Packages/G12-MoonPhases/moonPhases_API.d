/*
//Copy these functions outside of the script packet - define your own rules and textures :)
var int overrideMoonPhase;

func void testMoonPhase () {
	moonPhase += 1;

	if (moonPhase > 9) {
		moonPhase = 1;
	};

	forceMoonPhaseUpdate = TRUE;
	overrideMoonPhase = TRUE;
};

func void Moon_CalcMoonPhase () {
	if (overrideMoonPhase) { return; };

	var int currentPhase; currentPhase = Wld_GetDay ();
	if (currentPhase > 24) { currentPhase = currentPhase % 24; };

	currentPhase = currentPhase / 3;
	if (currentPhase < 1) { currentPhase = 1; };
	if (currentPhase > 9) { currentPhase = 1; };

	moonPhase = currentPhase;
};

func void Moon_UpdateTexture () {
	if (moonPhase == 1) { Moon_SetTexture ("Moon_Phase1_WaxingCrescent.tga"); };
	if (moonPhase == 2) { Moon_SetTexture ("Moon_Phase2_FirstQuarter.tga"); };
	if (moonPhase == 3) { Moon_SetTexture ("Moon_Phase3_WaxingGibous.tga"); };
	if (moonPhase == 4) { Moon_SetTexture ("Moon_Phase4_FullMoon.tga"); };
	if (moonPhase == 5) { Moon_SetTexture ("Moon_Phase5_WaningGibous.tga"); };
	if (moonPhase == 6) { Moon_SetTexture ("Moon_Phase6_LastQuarter.tga"); };
	if (moonPhase == 7) { Moon_SetTexture ("Moon_Phase7_WaningCrescent.tga"); };
	if (moonPhase == 8) { Moon_SetTexture ("Moon_Phase8_NewMoon.tga"); };

	if (moonPhase == 9) { Moon_SetTexture ("Moon_Trollface.tga"); };
};

//Function created by Sektenspinner
//Original post:
//https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page13?p=14841249&viewfull=1#post14841249
func void ScaleWorldTime (var int factor) {
    //worldTime += frameTime * (factor - 1);

    //Global instances have to be intialised!
    var int deltaT; //deltaT = MEM_Timer.frameTimeFloat;
	deltaT = mkf(2000);
    deltaT = mulf (deltaT, subf (factor, mkf (1)));

    MEM_WorldTimer.worldTime = addf (MEM_WorldTimer.worldTime, deltaT);
};

func void FF_TestTimeScale () {
	if (Wld_IsTime (04, 00, 19, 00)) {
		Wld_SetTime (20, 00);

		var int i; i += 1;

		if (i > 1) {
			testMoonPhase ();
		};

	} else {
		ScaleWorldTime (mkf (3));
	};
};

func void TestMoonPhases () {
	FF_ApplyOnceExtGT (FF_TestTimeScale, 10, -1);
};
*/
