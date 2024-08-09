/*
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

	//Call 'API' function
	const int symbID = 0;
	if (!symbID) {
		symbID = MEM_FindParserSymbol ("MOON_CALCMOONPHASE");
	};

	if (symbID != -1) {
		MEM_CallByID (symbID);
	};

	var int lastMoonPhase;

	if (lastMoonPhase != moonPhase) {
		lastMoonPhase = moonPhase;
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
	const int symbID2 = 0;

	if (!symbID2) {
		symbID2 = MEM_FindParserSymbol ("MOON_UPDATETEXTURE");
	};

	if (symbID2 != -1) {
		MEM_CallByID (symbID2);
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
