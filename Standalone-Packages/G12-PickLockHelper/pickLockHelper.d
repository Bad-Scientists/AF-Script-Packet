/*
 *	Requires LeGo flags: LeGo_HookEngine | LeGo_View
 */

//-- Internal variables --

var int _pickLockHelper_ShowFailedAttempt;

var string _pickLockHelper_FontName;
var string _pickLockHelper_FrameTex;

var int _pickLockHelper_Alpha;

var string _pickLockHelper_LeftKey;
var string _pickLockHelper_RightKey;

var int _pickLockHelper_PPosX;
var int _pickLockHelper_PPosY;

var int _pickLockHelper_VPosX;
var int _pickLockHelper_VPosY;

var int _pickLockHelper_WidthPxl;

//Constant tracking last mob
const int pickLockHelper_LastMob = 0;

//Last and Current PickLock combinations
var string pickLockHelper_LastCombination;
var string pickLockHelper_CurrentCombination;
var string pickLockHelper_LastKey;
var int pickLockHelper_LastKeyPos;

//View handles
var int hPickLockHelper_Frame;
var int hPickLockHelper_LastCombination;
var int hPickLockHelper_CurrentCombination;
var int hpickLockHelper_LastKey;

/*
 *
 */

func int PickLockHelper_GetPosX () {
	//Recalculate size and positions
	var int scaleF; scaleF = _getInterfaceScaling ();

	var int fontHeight; fontHeight = Print_GetFontHeight (_pickLockHelper_FontName);
	fontHeight = Print_ToVirtual (fontHeight, PS_Y);

	var int viewWidth;
	viewWidth = Print_ToVirtual(_pickLockHelper_WidthPxl, PS_X);
	viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

	//--- calculate if not specified
	var int posX;
	if (_pickLockHelper_PPosX == -1) {
		//txt.posX = (PS_VMax - Print_ToVirtual(Print_GetStringWidth(text, font), PS_X)) / 2;
		posX = (PS_VMax - viewWidth) / 2;
	} else {
		posX = Print_ToVirtual (_pickLockHelper_PPosX, PS_X);
	};

	if (_pickLockHelper_VPosX > -1) {
		posX = _pickLockHelper_VPosX;
	};

	//Position does not have to be 'scaled'
	//posX = roundf (mulf (mkf (posX), scaleF));

	return posX;
};

func int PickLockHelper_GetPosY () {
	var int fontHeight; fontHeight = Print_GetFontHeight (_pickLockHelper_FontName);
	fontHeight = Print_ToVirtual (fontHeight, PS_Y);

	var int spaceWidth; spaceWidth = Print_GetStringWidth (" ", _pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	var int posY;
	if (_pickLockHelper_PPosY == -1) {
		//txt.posY = (PS_VMax - Print_ToVirtual(Print_GetFontHeight(font), PS_Y)) / 2;
		posY = (PS_VMax / 2 - fontHeight / 2);
	} else {
		posY = Print_ToVirtual (_pickLockHelper_PPosY, PS_Y);
	};

	if (_pickLockHelper_VPosY > -1) {
		posY = _pickLockHelper_VPosY;
	};

	//Position does not have to be 'scaled'
	//posY = roundf (mulf (mkf (posY), scaleF));

	return posY;
};

func void PickLockHelper_Show () {
	var int spaceWidth; spaceWidth = Print_GetStringWidth (" ", _pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	var int scaleF; scaleF = _getInterfaceScaling ();

	var int fontHeight; fontHeight = Print_GetFontHeight (_pickLockHelper_FontName);
	fontHeight = Print_ToVirtual (fontHeight, PS_Y);

	var int viewWidth;
	viewWidth = Print_ToVirtual(_pickLockHelper_WidthPxl, PS_X);
	viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

	var int posX; posX = PickLockHelper_GetPosX ();
	var int posY; posY = PickLockHelper_GetPosY ();

	if (!Hlp_IsValidHandle (hPickLockHelper_Frame)) {
		hPickLockHelper_Frame = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_SetTexture (hPickLockHelper_Frame, _pickLockHelper_FrameTex);
		View_SetAlpha (hPickLockHelper_Frame, _pickLockHelper_Alpha);
	};

	View_Open (hPickLockHelper_Frame);
	View_MoveTo (hPickLockHelper_Frame, posX, posY);
	View_Resize (hPickLockHelper_Frame, viewWidth, fontHeight);

	if (!Hlp_IsValidHandle (hPickLockHelper_LastCombination)) {
		hPickLockHelper_LastCombination = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hPickLockHelper_LastCombination, 00, 00, pickLockHelper_LastCombination, _pickLockHelper_FontName);
	};

	View_Open (hPickLockHelper_LastCombination);
	View_MoveTo (hPickLockHelper_LastCombination, posX, posY);
	View_Resize (hPickLockHelper_LastCombination, viewWidth, fontHeight);
	View_SetTextMargin (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, spaceWidth);

	if (!Hlp_IsValidHandle (hPickLockHelper_CurrentCombination)) {
		hPickLockHelper_CurrentCombination = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hPickLockHelper_CurrentCombination, 00, 00, pickLockHelper_CurrentCombination, _pickLockHelper_FontName);
	};

	View_Open (hPickLockHelper_CurrentCombination);
	View_MoveTo (hPickLockHelper_CurrentCombination, posX, posY);
	View_Resize (hPickLockHelper_CurrentCombination, viewWidth, fontHeight);
	View_SetTextMargin (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, spaceWidth);

	if (!Hlp_IsValidHandle (hpickLockHelper_LastKey)) {
		hpickLockHelper_LastKey = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hpickLockHelper_LastKey, 00, 00, pickLockHelper_LastKey, _pickLockHelper_FontName);
	};

	posX += Print_ToVirtual (Print_GetStringWidth (pickLockHelper_LastCombination, _pickLockHelper_FontName), PS_X);

	View_Open (hpickLockHelper_LastKey);
	View_MoveTo (hpickLockHelper_LastKey, posX, posY);
	View_Resize (hpickLockHelper_LastKey, viewWidth, fontHeight);
	View_SetTextMargin (hpickLockHelper_LastKey, pickLockHelper_LastKey, spaceWidth);
};

func void PickLockHelper_Hide () {
	if (Hlp_IsValidHandle (hpickLockHelper_LastKey)) { View_Close (hpickLockHelper_LastKey); };
	if (Hlp_IsValidHandle (hPickLockHelper_LastCombination)) { View_Close (hPickLockHelper_LastCombination); };
	if (Hlp_IsValidHandle (hPickLockHelper_CurrentCombination)) { View_Close (hPickLockHelper_CurrentCombination); };
	if (Hlp_IsValidHandle (hPickLockHelper_Frame)) { View_Close (hPickLockHelper_Frame); };
};

//G_PickLock (var int bSuccess, var int bBrokenOpen)

func void _daedalusHook_G_PickLock (var int bSuccess, var int bBrokenOpen) {

	if (bSuccess) {
		//Reset PickLockHelper string
		if (bBrokenOpen) {
			pickLockHelper_CurrentCombination = "";
		};
	} else {
		//Reset PickLockHelper string
		pickLockHelper_CurrentCombination = "";
	};

	//Update PickLockHelper view
	var int spaceWidth; spaceWidth = Print_GetStringWidth (" ", _pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	View_SetTextMarginAndFontColor (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, RGBA (255, 255, 255, 64), spaceWidth);
	View_SetTextMarginAndFontColor (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, RGBA (096, 255, 096, 255), spaceWidth);

	var int posX; posX = PickLockHelper_GetPosX ();
	var int posY; posY = PickLockHelper_GetPosY ();

	posX += Print_ToVirtual (Print_GetStringWidth (pickLockHelper_LastCombination, _pickLockHelper_FontName), PS_X);

	View_MoveTo (hpickLockHelper_LastKey, posX, posY);

	View_SetTextMarginAndFontColor (hpickLockHelper_LastKey, pickLockHelper_LastKey, RGBA (255, 070, 070, 255), spaceWidth);

	//Continue with original function
	PassArgumentI (bSuccess);
	PassArgumentI (bBrokenOpen);
	ContinueCall ();
};

func void _hook_oCMobLockable_PickLock__PickLockHelper () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var oCMobLockable mob; mob = _^ (ECX);

	var int c; c = MEM_ReadInt (ESP + 8);

	var string pickLockString; pickLockString = "";

	var int currCharCount; currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;

	currCharCount += 1;

	if (currCharCount > STR_Len (mob.pickLockStr)) {
		currCharCount = STR_Len (mob.pickLockStr);
	};

	if (currCharCount > 0) {
		pickLockString = STR_Prefix (mob.pickLockStr, currCharCount);
	};

//---
	//Localization support - switch to 'standard' L R combination
	pickLockHelper_CurrentCombination = STR_ReplaceAll (pickLockHelper_CurrentCombination, _pickLockHelper_LeftKey, "L");
	pickLockHelper_CurrentCombination = STR_ReplaceAll (pickLockHelper_CurrentCombination, _pickLockHelper_RightKey, "R");

	if (c == 76) {
		if (Hlp_StrCmp(ConcatStrings (pickLockHelper_CurrentCombination, "L"), pickLockString)) {
			pickLockHelper_CurrentCombination = pickLockString;
		} else {
			if ((!pickLockHelper_LastKeyPos) && (_pickLockHelper_ShowFailedAttempt)) {
				pickLockHelper_LastKey = _pickLockHelper_LeftKey;
				pickLockHelper_LastKeyPos = STR_Len (pickLockHelper_CurrentCombination);
			};
		};
	} else
	if (c == 82) {
		if (Hlp_StrCmp(ConcatStrings (pickLockHelper_CurrentCombination, "R"), pickLockString)) {
			pickLockHelper_CurrentCombination = pickLockString;
		} else {
			if ((!pickLockHelper_LastKeyPos) && (_pickLockHelper_ShowFailedAttempt)) {
				pickLockHelper_LastKey = _pickLockHelper_RightKey;
				pickLockHelper_LastKeyPos = STR_Len (pickLockHelper_CurrentCombination);
			};
		};
	};

	//Localization support - replace back to 'localized' version
	pickLockHelper_CurrentCombination = STR_ReplaceAll (pickLockHelper_CurrentCombination, "L", _pickLockHelper_LeftKey);
	pickLockHelper_CurrentCombination = STR_ReplaceAll (pickLockHelper_CurrentCombination, "R", _pickLockHelper_RightKey);

	if (STR_Len (pickLockHelper_CurrentCombination) > pickLockHelper_LastKeyPos) {
		pickLockHelper_LastKey = "";
		pickLockHelper_LastKeyPos = 0;
	};

//---

	if (STR_Len (pickLockHelper_CurrentCombination) > STR_Len (pickLockHelper_LastCombination)) {
		pickLockHelper_LastCombination = pickLockHelper_CurrentCombination;
	};
};

func void _eventMobStartInteraction__PickLockHelper () {
	if (!Hlp_Is_oCMobLockable (ECX))  { return; };

	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNPC slf; slf = _^ (slfPtr);
	if (!NPC_IsPlayer (slf)) { return; };

	var oCMobLockable mob; mob = _^ (ECX);

	//Reset for new mob
	if (pickLockHelper_LastMob != ECX) {
		pickLockHelper_CurrentCombination = "";
		pickLockHelper_LastCombination = "";
		pickLockHelper_LastKey = "";
		pickLockHelper_LastKeyPos = 0;
	};

	pickLockHelper_LastMob = ECX;

	//---

	var int currCharCount;
	currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;

	if (currCharCount > 0) {
		pickLockHelper_CurrentCombination = STR_Prefix (mob.pickLockStr, currCharCount);
	} else {
		pickLockHelper_CurrentCombination = "";
	};

	//Show picklock helper if chest is locked and player does not have key
	if ((STR_Len (mob.pickLockStr) > 0) && (mob.bitfield & oCMobLockable_bitfield_locked)) {

		var int canOpenWithKey; canOpenWithKey = FALSE;
		if (STR_Len (mob.keyInstance) > 0) {
			canOpenWithKey = NPC_HasItemInstanceName (slf, mob.keyInstance);
		};

		if (!canOpenWithKey) {
			PickLockHelper_Show ();
		};
	};
};

//Function is called when player ended interation
func void _hook_oCMobInter_EndInteraction__PickLockHelper () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNPC slf; slf = _^ (slfPtr);
	if (!NPC_IsPlayer (slf)) { return; };

	PickLockHelper_Hide ();
};

//Function is called when player broke picklock and does not have any
func void _hook_oCMobInter_StopInteraction__PickLockHelper () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNPC slf; slf = _^ (slfPtr);
	if (!NPC_IsPlayer (slf)) { return; };

	PickLockHelper_Hide ();

	//Reset
	pickLockHelper_CurrentCombination = "";
};

func void G12_PickLockHelper_Init () {
	G12_oCMobInterStartInterationEvent_Init ();

	//Add listener for mob use
	MobStartInteraction_AddListener (_eventMobStartInteraction__PickLockHelper);

	//-- Load API values / init default values
	_pickLockHelper_ShowFailedAttempt = API_GetSymbolIntValue ("PICKLOCKHELPER_SHOWFAILEDATTEMPT", 1);

	_pickLockHelper_FontName = API_GetSymbolStringValue ("PICKLOCKHELPER_FONTNAME", "FONT_OLD_10_WHITE.TGA");
	_pickLockHelper_FrameTex = API_GetSymbolStringValue ("PICKLOCKHELPER_FRAMETEX", "DLG_NOISE.TGA");

	_pickLockHelper_Alpha = API_GetSymbolIntValue ("PICKLOCKHELPER_ALPHA", 192);

	_pickLockHelper_LeftKey = API_GetSymbolStringValue ("PICKLOCKHELPER_LEFTKEY", "L");
	_pickLockHelper_RightKey = API_GetSymbolStringValue ("PICKLOCKHELPER_RIGHTKEY", "R");

	_pickLockHelper_PPosX = API_GetSymbolIntValue ("PICKLOCKHELPER_PPOSX", 0);
	_pickLockHelper_PPosY = API_GetSymbolIntValue ("PICKLOCKHELPER_PPOSY", -1);

	_pickLockHelper_VPosX = API_GetSymbolIntValue ("PICKLOCKHELPER_VPOSX", -1);
	_pickLockHelper_VPosY = API_GetSymbolIntValue ("PICKLOCKHELPER_VPOSY", -1);

	_pickLockHelper_WidthPxl = API_GetSymbolIntValue ("PICKLOCKHELPER_WIDTHPXL", 320);
	//--

	const int once = 0;

	if (!once) {
		//Hook Len for G1 = 13, for G2A = 6
		HookEngine (oCMobLockable__PickLock, MEMINT_SwitchG1G2 (13, 6), "_hook_oCMobLockable_PickLock__PickLockHelper");

		HookDaedalusFunc (G_PickLock, _daedalusHook_G_PickLock);

		HookEngine (oCMobInter__EndInteraction, 6, "_hook_oCMobInter_EndInteraction__PickLockHelper");
		HookEngine (oCMobInter__StopInteraction, 6, "_hook_oCMobInter_StopInteraction__PickLockHelper");

		once = 1;
	};
};
