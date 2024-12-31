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

var int _pickLockHelper_AlignWithInvCatView;

var int _pickLockHelper_WidthPxl;

//Constant tracking last mob
const int pickLockHelper_LastMob = 0;

var int pickLockHelper_Visible;

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

/*
 *
 */
func int PickLockHelper_InvOpen_GetPosX () {
	if (Hlp_GetOpenInventoryType() != OpenInvType_Chest) {
		return -1;
	};

	var int npcInvPtr; npcInvPtr = Hlp_GetOpenContainer_oCItemContainer();
	if (!npcInvPtr) {
		return -1;
	};

	//var oCItemContainer cont; cont = _^(npcInvPtr);
	//if (!cont.inventory2_oCItemContainer_viewCat) {
	//	return -1;
	//};

	//var zCView v; v = _^(cont.inventory2_oCItemContainer_viewCat);

	//Get item category view
	//G1	inventory2_oCItemContainer_viewCat		0x0580 - 0x0550 = 48
	//G2A	inventory2_oCItemContainer_viewTitle	0x06C8 - 0x0668 = 96
	var int viewPtr; viewPtr = MEM_ReadInt(npcInvPtr + MEMINT_SwitchG1G2(48, 96));
	if (!viewPtr) { return -1; };
	var zCView v; v = _^(viewPtr);
	return +(v.vposx + v.vsizex + Print_ToVirtual(1, PS_X));
};

/*
 *
 */
func int PickLockHelper_GetPosX () {
	var int posX;

	if (_pickLockHelper_AlignWithInvCatView) {
		posX = PickLockHelper_InvOpen_GetPosX();
		if (posX > -1) { return posX; };
	};

	//--- calculate if not specified
	if (_pickLockHelper_PPosX == -1) {
		//Recalculate size and positions
		var int scaleF; scaleF = _getInterfaceScaling ();

		//var int fontHeight; fontHeight = Print_GetFontHeight (_pickLockHelper_FontName);
		//fontHeight = Print_ToVirtual (fontHeight, PS_Y);

		var int viewWidth; viewWidth = Print_ToVirtual(_pickLockHelper_WidthPxl, PS_X);
		viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

		posX = (PS_VMax - viewWidth) / 2;
	} else {
		posX = Print_ToVirtual (_pickLockHelper_PPosX, PS_X);
	};

	if (_pickLockHelper_VPosX > -1) {
		posX = _pickLockHelper_VPosX;
	};

	return posX;
};

/*
 *
 */
func int PickLockHelper_InvOpen_GetPosY() {
	if (Hlp_GetOpenInventoryType() != OpenInvType_Chest) {
		return -1;
	};

	var int npcInvPtr; npcInvPtr = Hlp_GetOpenContainer_oCItemContainer();
	if (!npcInvPtr) {
		return -1;
	};

	//var oCItemContainer cont; cont = _^(npcInvPtr);
	//if (!cont.inventory2_oCItemContainer_viewCat) {
	//	return -1;
	//};

	//var zCView v; v = _^(cont.inventory2_oCItemContainer_viewCat);

	//Get item category view
	//G1	inventory2_oCItemContainer_viewCat		0x0580 - 0x0550 = 48
	//G2A	inventory2_oCItemContainer_viewTitle	0x06C8 - 0x0668 = 96
	var int viewPtr; viewPtr = MEM_ReadInt(npcInvPtr + MEMINT_SwitchG1G2(48, 96));
	if (!viewPtr) { return -1; };
	var zCView v; v = _^(viewPtr);
	return +(v.vposy + Print_ToVirtual(1, PS_Y));
};

/*
 *
 */
func int PickLockHelper_GetPosY () {
	var int posY;

	if (_pickLockHelper_AlignWithInvCatView) {
		posY = PickLockHelper_InvOpen_GetPosY();
		if (posY > -1) { return posY; };
	};

	if (_pickLockHelper_PPosY == -1) {
		var int fontHeight; fontHeight = Print_GetFontHeight (_pickLockHelper_FontName);
		fontHeight = Print_ToVirtual (fontHeight, PS_Y);

		//var int spaceWidth; spaceWidth = Font_GetStringWidth (STR_SPACE, _pickLockHelper_FontName);
		//spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

		posY = (PS_VMax / 2 - fontHeight / 2);
	} else {
		posY = Print_ToVirtual (_pickLockHelper_PPosY, PS_Y);
	};

	if (_pickLockHelper_VPosY > -1) {
		posY = _pickLockHelper_VPosY;
	};

	return posY;
};

func void PickLockHelper_Show () {
	var int spaceWidth; spaceWidth = Font_GetStringWidth (STR_SPACE, _pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	var int scaleF; scaleF = _getInterfaceScaling ();

	var int fontHeight; fontHeight = Print_GetFontHeight (_pickLockHelper_FontName);
	fontHeight = Print_ToVirtual (fontHeight, PS_Y);

	var string s;
	if (STR_Len(pickLockHelper_LastCombination) > STR_Len(pickLockHelper_CurrentCombination)) {
		s = pickLockHelper_LastCombination;
	} else {
		s = pickLockHelper_CurrentCombination;
	};

	var int textWidth; textWidth = Font_GetStringWidth(s, _pickLockHelper_FontName);
	var int viewWidth; viewWidth = clamp(textWidth, _pickLockHelper_WidthPxl, textWidth);

	viewWidth = Print_ToVirtual(viewWidth, PS_X);
	viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

	var int posX; posX = PickLockHelper_GetPosX ();
	var int posY; posY = PickLockHelper_GetPosY ();

	if (!Hlp_IsValidHandle (hPickLockHelper_Frame)) {
		hPickLockHelper_Frame = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_SetTexture (hPickLockHelper_Frame, _pickLockHelper_FrameTex);
		View_SetAlpha (hPickLockHelper_Frame, _pickLockHelper_Alpha);
	};

	View_Open_Safe (hPickLockHelper_Frame);
	View_MoveTo_Safe (hPickLockHelper_Frame, posX, posY);
	View_Resize_Safe (hPickLockHelper_Frame, viewWidth, fontHeight);

	if (!Hlp_IsValidHandle (hPickLockHelper_LastCombination)) {
		hPickLockHelper_LastCombination = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hPickLockHelper_LastCombination, 00, 00, pickLockHelper_LastCombination, _pickLockHelper_FontName);
	};

	View_Open_Safe (hPickLockHelper_LastCombination);
	View_MoveTo_Safe (hPickLockHelper_LastCombination, posX, posY);
	View_Resize_Safe (hPickLockHelper_LastCombination, viewWidth, fontHeight);
	View_SetTextMargin (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, spaceWidth);

	if (!Hlp_IsValidHandle (hPickLockHelper_CurrentCombination)) {
		hPickLockHelper_CurrentCombination = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hPickLockHelper_CurrentCombination, 00, 00, pickLockHelper_CurrentCombination, _pickLockHelper_FontName);
	};

	View_Open_Safe (hPickLockHelper_CurrentCombination);
	View_MoveTo_Safe (hPickLockHelper_CurrentCombination, posX, posY);
	View_Resize_Safe (hPickLockHelper_CurrentCombination, viewWidth, fontHeight);
	View_SetTextMargin (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, spaceWidth);

	if (!Hlp_IsValidHandle (hpickLockHelper_LastKey)) {
		hpickLockHelper_LastKey = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hpickLockHelper_LastKey, 00, 00, pickLockHelper_LastKey, _pickLockHelper_FontName);
	};

	posX += Print_ToVirtual (Font_GetStringWidth (pickLockHelper_LastCombination, _pickLockHelper_FontName), PS_X);

	View_Open_Safe (hpickLockHelper_LastKey);
	View_MoveTo_Safe (hpickLockHelper_LastKey, posX, posY);
	View_Resize_Safe (hpickLockHelper_LastKey, viewWidth, fontHeight);
	View_SetTextMargin (hpickLockHelper_LastKey, pickLockHelper_LastKey, spaceWidth);

	pickLockHelper_Visible = TRUE;
};

func void PickLockHelper_Hide () {
	View_Close_Safe (hpickLockHelper_LastKey);
	View_Close_Safe (hPickLockHelper_LastCombination);
	View_Close_Safe (hPickLockHelper_CurrentCombination);
	View_Close_Safe (hPickLockHelper_Frame);

	pickLockHelper_Visible = FALSE;
};

//0x00681FF0 public: virtual void __thiscall oCMobLockable::Interact(class oCNpc *,int,int,int,int,int)
func void _hook_oCMobLockable_Interact__PickLockHelper () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var int npcPtr; npcPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (npcPtr)) { return; };

	var oCNpc slf; slf = _^ (npcPtr);
	if (!NPC_IsPlayer (slf)) { return; };

	var oCMobLockable mob; mob = _^ (ECX);

//-- Reset current combination

	var int currCharCount; currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;

	//Reset current combination
	if (currCharCount == 0) {
		pickLockHelper_CurrentCombination = STR_EMPTY;
	};

	//Reset last combination if it has changed meanwhile
	if (!STR_StartsWith(mob.pickLockStr, pickLockHelper_LastCombination)) {
		pickLockHelper_LastCombination = STR_EMPTY;
	};

//-- Update PickLockHelper view

	if (!pickLockHelper_Visible) { return; };

	//Update position
	PickLockHelper_Show();

	var int spaceWidth; spaceWidth = Font_GetStringWidth (STR_SPACE, _pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	//Update texts
	View_SetTextMarginAndFontColor (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, RGBA (255, 255, 255, 64), spaceWidth);
	View_SetTextMarginAndFontColor (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, RGBA (096, 255, 096, 255), spaceWidth);
	View_SetTextMarginAndFontColor (hpickLockHelper_LastKey, pickLockHelper_LastKey, RGBA (255, 070, 070, 255), spaceWidth);
};

func void _hook_oCMobLockable_PickLock__PickLockHelper () {

	if (!Hlp_Is_oCMobLockable (ECX)) { return; };
	var oCMobLockable mob; mob = _^ (ECX);

	var int c; c = MEM_ReadInt (ESP + 8);

	var string pickLockString; pickLockString = STR_EMPTY;

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
		pickLockHelper_LastKey = STR_EMPTY;
		pickLockHelper_LastKeyPos = 0;
	};

//---

	if (STR_Len (pickLockHelper_CurrentCombination) > STR_Len (pickLockHelper_LastCombination)) {
		pickLockHelper_LastCombination = pickLockHelper_CurrentCombination;
	};
};

func void _eventMobStartInteraction__PickLockHelper (var int eventType) {
	if (!Hlp_Is_oCMobLockable (ECX))  { return; };

	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNPC slf; slf = _^ (slfPtr);
	if (!NPC_IsPlayer (slf)) { return; };

	var oCMobLockable mob; mob = _^ (ECX);

	//Reset for new mob
	if (pickLockHelper_LastMob != ECX) {
		pickLockHelper_CurrentCombination = STR_EMPTY;
		pickLockHelper_LastCombination = STR_EMPTY;
		pickLockHelper_LastKey = STR_EMPTY;
		pickLockHelper_LastKeyPos = 0;
	};

	pickLockHelper_LastMob = ECX;

	//---

	var int currCharCount;
	currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;

	if (currCharCount > 0) {
		pickLockHelper_CurrentCombination = STR_Prefix (mob.pickLockStr, currCharCount);
	} else {
		pickLockHelper_CurrentCombination = STR_EMPTY;
	};

	//Show picklock helper if chest is locked with pickLockStr
	if (STR_Len (mob.pickLockStr) > 0) /*&& (mob.bitfield & oCMobLockable_bitfield_locked))*/
	{
		//If chest is unlocked - update strings
		if ((mob.bitfield & oCMobLockable_bitfield_locked) != oCMobLockable_bitfield_locked) {
			pickLockHelper_LastCombination = mob.pickLockStr;
		};

		var int canOpenWithKey; canOpenWithKey = FALSE;
		if (STR_Len (mob.keyInstance) > 0) {
			canOpenWithKey = NPC_HasItemInstanceName (slf, mob.keyInstance);
		};

		if (!canOpenWithKey) {
			PickLockHelper_Show ();
		};
	};
};

func void FF_WaitForInvOpen__PickLockHelper() {
	if (Hlp_GetOpenInventoryType() != OpenInvType_Chest) {
		return;
	};

	//Function will update view position
	PickLockHelper_Show();
};

func void _eventOpenInventory__PickLockHelper (var int eventType) {
	if (!pickLockHelper_Visible) { return; };
	FF_ApplyOnceExtGT(FF_WaitForInvOpen__PickLockHelper, 0, -1);
};

func void _eventCloseInventory__PickLockHelper (var int eventType) {
	if (!pickLockHelper_Visible) { return; };
	PickLockHelper_Hide();
	FF_Remove(FF_WaitForInvOpen__PickLockHelper);
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

//Function is called when player breaks picklock / does not have any more picklocks
func void _hook_oCMobInter_StopInteraction__PickLockHelper () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNPC slf; slf = _^ (slfPtr);
	if (!NPC_IsPlayer (slf)) { return; };

	PickLockHelper_Hide ();

	//Reset
	pickLockHelper_CurrentCombination = STR_EMPTY;
};

func void G12_PickLockHelper_Init () {
	//Add listener for inventory opening
	G12_OpenInventoryEvent_Init();
	OpenInventoryEvent_AddListener(_eventOpenInventory__PickLockHelper);

	G12_CloseInventoryEvent_Init();
	CloseInventoryEvent_AddListener(_eventCloseInventory__PickLockHelper);

	//Add listener for mob use
	G12_MobStartInterationEvent_Init();
	MobStartInteractionEvent_AddListener(_eventMobStartInteraction__PickLockHelper);

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

	_pickLockHelper_AlignWithInvCatView = API_GetSymbolIntValue ("PICKLOCKHELPER_ALINGWITHINVCATVIEW", 1);

	_pickLockHelper_WidthPxl = API_GetSymbolIntValue ("PICKLOCKHELPER_WIDTHPXL", 160);
	//--

	const int once = 0;

	if (!once) {
		//Hook Len for G1 = 13, for G2A = 6
		HookEngine (oCMobLockable__PickLock, MEMINT_SwitchG1G2 (13, 6), "_hook_oCMobLockable_PickLock__PickLockHelper");

		//0x00681FF0 public: virtual void __thiscall oCMobLockable::Interact(class oCNpc *,int,int,int,int,int)
		const int oCMobLockable__Interact_G1 = 6823920;

		//0x00723CF0 public: virtual void __thiscall oCMobLockable::Interact(class oCNpc *,int,int,int,int,int)
		const int oCMobLockable__Interact_G2 = 7486704;

		HookEngine (MEMINT_SwitchG1G2 (oCMobLockable__Interact_G1, oCMobLockable__Interact_G2), 7, "_hook_oCMobLockable_Interact__PickLockHelper");

		HookEngine (oCMobInter__EndInteraction, 6, "_hook_oCMobInter_EndInteraction__PickLockHelper");
		HookEngine (oCMobInter__StopInteraction, 6, "_hook_oCMobInter_StopInteraction__PickLockHelper");

		once = 1;
	};
};
