/*
 *	Debug textures
 */
const string DEBUGTEXTURES_FONT = "FONT_OLD_10_WHITE.TGA";
const int DEBUGTEXTURES_RAY_DIST = 2000;

var int hView__DebugTextures;

var int debugTextures_Enabled;

/*
 *	Function positions view on screen (as per wld 3D position)
 */
func void DisplayTextureName__DebugTextures (var int posPtr, var string texts, var int color) {
	var int X;
	var int Y;

	var string text;
	var int linesCount; linesCount = STR_SplitCount (texts, Print_LineSeperator);

	//Convert 3D coordinates in the world to screen coordinates
	Pos_ToScreenXYF (posPtr, _@ (X), _@ (Y));

	X = RoundF (AddF (X, FLOATHALF));
	Y = RoundF (AddF (Y, FLOATHALF));

	var int viewWidth; viewWidth = 0;
	var int fontHeight; fontHeight = Print_GetFontHeight (DEBUGTEXTURES_FONT);

	repeat (i, linesCount); var int i;
		text = STR_Split (texts, Print_LineSeperator, i);

		var int vw; vw = Print_GetStringWidth (text, DEBUGTEXTURES_FONT);

		if (vw > viewWidth) {
			viewWidth = vw;
		};
	end;

	var int fh; fh = Print_GetFontHeight (DEBUGTEXTURES_FONT);

	viewWidth = Print_ToVirtual (viewWidth, PS_X);
	fontHeight = Print_ToVirtual (fontHeight, PS_Y);

	X = Print_ToVirtual (X, PS_X);
	Y = Print_ToVirtual (Y, PS_Y);

	Y = Y - (fontHeight * linesCount);

	X = clamp (X, 0, PS_VMax - (viewWidth / 2));
	Y = clamp (Y, 0, PS_VMax - (fontHeight * linesCount));

	//Update view

	View_Open (hView__DebugTextures);
	View_MoveTo (hView__DebugTextures, X - (viewWidth / 2), Y);
	View_Resize (hView__DebugTextures, viewWidth, (fontHeight * linesCount) + linesCount);

	View_SetTextMargin (hView__DebugTextures, texts, 0);
};

func void FrameFunction__DebugTextures () {
	if (!Hlp_IsValidNpc (hero)) { return; };

	//Get camera
	var zCVob camVob; camVob = _^ (MEM_Game._zCSession_camVob);

	var int startPos[3];

	//Get position of players head
	var int nodePosPtr; nodePosPtr = NPC_GetNodePositionWorld (hero, "BIP01 HEAD");
	CopyVector (nodePosPtr, _@ (startPos));
	MEM_Free (nodePosPtr);

	//Get facing vector from camera
	var int dir[3];
	TrfDirToVector (_@ (camVob.trafoObjToWorld), _@ (dir));

	MulVector (_@ (dir), mkf (DEBUGTEXTURES_RAY_DIST));

	var int endPos[3];

	AddVectors (_@ (endPos), _@ (startPos), _@ (dir));

	//Draw 'traceray' line
	zCLineCache_Line3D (_@ (startPos), _@ (endPos), RGBA (255, 255, 0, 255), 0);

	//MEM_World.showTraceRayLines = TRUE;

//-- Traceray nearest hit

	const int zCWorld__TraceRayNearestHit_G1 = 6243008; //0x5F42C0
	const int zCWorld__TraceRayNearestHit_G2 = 6429568; //0x621B80

//enum zTTraceRayFlags {
	const int zTRACERAY_VOB_IGNORE_NO_CD_DYN = 1 << 0;
	const int zTRACERAY_VOB_IGNORE = 1 << 1;
	const int zTRACERAY_VOB_BBOX = 1 << 2;
	const int zTRACERAY_VOB_OBB = 1 << 3;
	const int zTRACERAY_STAT_IGNORE = 1 << 4;
	const int zTRACERAY_STAT_POLY = 1 << 5;
	const int zTRACERAY_STAT_PORTALS = 1 << 6;
	const int zTRACERAY_POLY_NORMAL = 1 << 7;
	const int zTRACERAY_POLY_IGNORE_TRANSP = 1 << 8;
	const int zTRACERAY_POLY_TEST_WATER = 1 << 9;
	const int zTRACERAY_POLY_2SIDED = 1 << 10;
	const int zTRACERAY_VOB_IGNORE_CHARACTER = 1 << 11;
	const int zTRACERAY_FIRSTHIT = 1 << 12;
	const int zTRACERAY_VOB_TEST_HELPER_VISUALS = 1 << 13;

	//G2A only!
	const int zTRACERAY_VOB_IGNORE_PROJECTILES = 1 << 14;
//};

/*
	enum zTMat_Group {
		zMAT_GROUP_UNDEF,
		zMAT_GROUP_METAL,
		zMAT_GROUP_STONE,
		zMAT_GROUP_WOOD,
		zMAT_GROUP_EARTH,
		zMAT_GROUP_WATER,
		zMAT_NUM_MAT_GROUP
	};
*/

	const int flags = zTRACERAY_STAT_POLY | zTRACERAY_VOB_IGNORE_CHARACTER | zTRACERAY_VOB_IGNORE_NO_CD_DYN | zTRACERAY_POLY_NORMAL;

	const int ignoreList = 0;
	var int worldPtr; worldPtr = MEM_Game._zCSession_world;

	var int dirPtr; dirPtr = _@(dir);
	var int posPtr; posPtr = _@(startPos);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(flags));
		CALL_PtrParam(_@(ignoreList));
		CALL_PtrParam(_@(dirPtr));

		CALL__fastcall(_@(worldPtr), _@(posPtr), MEMINT_SwitchG1G2(zCWorld__TraceRayNearestHit_G1, zCWorld__TraceRayNearestHit_G2));
		call = CALL_End();
	};

	if (CALL_RetValAsInt()) && (MEM_World.foundHit) {
		if (MEM_World.foundPoly) {

			//const int lastPoly = 0;

			//if (lastPoly != MEM_World.foundPoly) {
				var int pos[3];

				//Draw vertex
				var zCPolygon poly; poly = _^ (MEM_World.foundPoly);

				var int polyNumVert; polyNumVert = poly.bitfield[0] & zCPolygon_bitfield_polyNumVert;

				repeat (i, polyNumVert); var int i;
					var int v1; v1 = 0;
					var int v2; v2 = 0;

					if (i == polyNumVert - 1) {
						v1 = MEM_ReadIntArray (poly.vertex, i);
						v2 = MEM_ReadIntArray (poly.vertex, 0);
					} else {
						v1 = MEM_ReadIntArray (poly.vertex, i);
						v2 = MEM_ReadIntArray (poly.vertex, i + 1);
					};

					if (v1 & v2) {
						var int pos1[3]; MEM_CopyBytes (v1, _@ (pos1), 12);
						var int pos2[3]; MEM_CopyBytes (v2, _@ (pos2), 12);

						zCLineCache_Line3D (_@ (pos1), _@ (pos2), RGBA (255, 128, 0, 255), 0);
					};
				end;

				//Draw center line
				zCPolygon_GetCenter (MEM_World.foundPoly, _@ (pos));

				var int posUp[3];

				posUp[0] = FLOATNULL;
				posUp[1] = mkf(20);
				posUp[2] = FLOATNULL;

				AddVectors (_@ (posUp), _@ (pos), _@ (posUp));
				zCLineCache_Line3D (_@ (pos), _@ (posUp), RGBA (255, 255, 255, 255), 0);

				//Display texture details
				if (poly.material) {
					var zCMaterial material; material = _^ (poly.material);

					var int rndAlphaBlendFunc;
					//TODO: is function zCRenderer_GetAlphaBlendFunc actually working with material??
					rndAlphaBlendFunc = zCRenderer_GetAlphaBlendFunc (poly.material);

					var string rndAlphaBlendFuncString;
					rndAlphaBlendFuncString = AlphaBlendFuncTypeToString (rndAlphaBlendFunc);

					if (material.texture) {
						var zCTexture texture; texture = _^ (material.texture);

						var string s;
						s = material._zCObject_objectName;
						s = ConcatStrings (s, Print_LineSeperator);
						s = ConcatStrings (s, texture._zCObject_objectName);
						s = ConcatStrings (s, Print_LineSeperator);
						s = ConcatStrings (s, rndAlphaBlendFuncString);

						DisplayTextureName__DebugTextures (_@ (posUp), s, RGBA (255, 255, 255, 255));
					};
				};

				//lastPoly = MEM_World.foundPoly;
			//};
		};
	};

	//MEM_World.showTraceRayLines = FALSE;
};

func void DebugTextures_Enable () {
	if (!Hlp_IsValidHandle (hView__DebugTextures)) {
		hView__DebugTextures = View_Create(0, 0, 0, 0);
		View_AddText (hView__DebugTextures, 0, 0, "", DEBUGTEXTURES_FONT);
	};

	FF_ApplyOnceExtGT (FrameFunction__DebugTextures, 0, -1);
};

func void DebugTextures_Disable () {
	View_Close (hView__DebugTextures);

	FF_Remove (FrameFunction__DebugTextures);
};

func string CC_DebugTextures (var string param) {
	debugTextures_Enabled = !debugTextures_Enabled;

	if (debugTextures_Enabled) {
		DebugTextures_Enable ();
		return "Textures debugging enabled.";
	};

	DebugTextures_Disable ();
	return "Textures debugging disabled.";
};

func void CC_DebugTextures_Init () {
	//Register console command
	CC_Register (CC_DebugTextures, "debug textures", "Display texture names.");
};
