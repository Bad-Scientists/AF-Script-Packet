/*
 *	Moon phases
 *
 *	8 phases - I know this is incorrect when compared to how moon behaves in reality ... but let's not over-complicate moon-cycle phase calculation ... say moon moves to new phase every 3 days.
 *
 *	MEM_SkyController.masterTime (float)
 *	0.50 = 00:00
 *	0.75 = 06:00
 *	0.00 = 12:00
 *	0.25 = 18:00
 *
 *	19:45 moonrise	04:15 moonset
 *	05:20 sunrise	18:40 sunset
 */

var int moonPhase;
var int forceMoonPhaseUpdate;

func void Moon_SetTexture (var string textureName) {
	//Check mesh pointer
	if (!MEM_SkyController.Moon_mesh) { return; };

	//Get polygon pointer
	var int polyPtr; polyPtr = zCMesh_SharePoly (MEM_SkyController.Moon_mesh, 0);
	if (!polyPtr) { return; };

	var zCPolygon poly; poly = _^ (polyPtr);

	//Update material texture
	zCMaterial_SetTexture (poly.material, textureName);
};

func void _hook_zSkyCtrlOtdr_RenderSkyPre__MoonPhases () {
	const int updated = 0;

	var int currentPhase; currentPhase = Wld_GetDay ();
	if (currentPhase > 24) { currentPhase = currentPhase % 24; };

	currentPhase = currentPhase / 3;
	if (currentPhase < 1) { currentPhase = 1; };
	if (currentPhase > 8) { currentPhase = 1; };

	if (moonPhase != currentPhase) {
		moonPhase = currentPhase;
		updated = 0;
	};

	//Update only when texture should change
	if (updated) { return; };

	//Check mesh pointer
	if (!MEM_SkyController.Moon_mesh) { return; };

	//Update only if moon is not already visible! (during the day)
	if (!Hlp_Is_zCSkyControler_Outdoor (MEM_World.activeSkyControler)) { return; };

	//06:00 - 18:00 - allow texture update
	if (gf (MEM_SkyController.masterTime, divf (mkf (75), mkf (100))))
	|| (lf (MEM_SkyController.masterTime, divf (mkf (25), mkf (100))))
	|| (forceMoonPhaseUpdate) //or force it
	{
		forceMoonPhaseUpdate = FALSE;
	} else {
		return;
	};

	//Call 'API' function
	var int symbID; symbID = MEM_FindParserSymbol ("Moon_UpdateTexture");
	if (symbID != -1) {
		MEM_CallByID (symbID);
	};

	updated = 1;
};

func void G12_MoonPhases_Init () {
	const int once = 0;
	if (!once) {
		HookEngine (zCSkyControler_Outdoor__RenderSkyPre, 7, "_hook_zSkyCtrlOtdr_RenderSkyPre__MoonPhases");
		once = 1;
	};
};
