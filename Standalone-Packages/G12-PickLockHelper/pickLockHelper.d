/*
 *	Requires LeGo flags: LeGo_HookEngine | LeGo_View
 */

//Last and Current PickLock combinations
var string pickLockHelper_LastCombination;
var string pickLockHelper_CurrentCombination;

//View handles
var int hPickLockHelper_Frame;
var int hPickLockHelper_LastCombination;
var int hPickLockHelper_CurrentCombination;

/*
 *
 */

func void PickLockHelper_Show () {
	//Recalculate size and positions
	var int scaleF; scaleF = _getInterfaceScaling ();

	var int fontHeight; fontHeight = Print_GetFontHeight (pickLockHelper_FontName);
	fontHeight = Print_ToVirtual (fontHeight, PS_Y);

	var int viewWidth;
	viewWidth = Print_ToVirtual(pickLockHelper_WidthPxl, PS_X);
	viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

	//--- calculate if not specified
	var int posX;
	if (pickLockHelper_PPosX == -1) {
		//txt.posX = (PS_VMax - Print_ToVirtual(Print_GetStringWidth(text, font), PS_X)) / 2;
		posX = (PS_VMax - viewWidth) / 2;
	} else {
		posX = Print_ToVirtual (pickLockHelper_PPosX, PS_X);
	};

	if (pickLockHelper_VPosX > -1) {
		posX = pickLockHelper_VPosX;
	};

	//Position does not have to be 'scaled'
	//posX = roundf (mulf (mkf (posX), scaleF));

	var int spaceWidth; spaceWidth = Print_GetStringWidth (" ", pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	var int posY;
	if (pickLockHelper_PPosY == -1) {
		//txt.posY = (PS_VMax - Print_ToVirtual(Print_GetFontHeight(font), PS_Y)) / 2;
		posY = (PS_VMax / 2 - fontHeight / 2);
	} else {
		posY = Print_ToVirtual (pickLockHelper_PPosY, PS_Y);
	};
	
	if (pickLockHelper_VPosY > -1) {
		posY = pickLockHelper_VPosY;
	};

	//Position does not have to be 'scaled'
	//posY = roundf (mulf (mkf (posY), scaleF));

	//---

	if (!Hlp_IsValidHandle (hPickLockHelper_Frame)) {
		hPickLockHelper_Frame = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_SetTexture (hPickLockHelper_Frame, pickLockHelper_FrameTex);
		View_SetAlpha (hPickLockHelper_Frame, pickLockHelper_Alpha);
	};

	View_Open (hPickLockHelper_Frame);
	View_MoveTo (hPickLockHelper_Frame, posX, posY);
	View_Resize (hPickLockHelper_Frame, viewWidth, fontHeight);
	
	if (!Hlp_IsValidHandle (hPickLockHelper_LastCombination)) {
		hPickLockHelper_LastCombination = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hPickLockHelper_LastCombination, 00, 00, pickLockHelper_LastCombination, pickLockHelper_FontName);
	};
	
	View_Open (hPickLockHelper_LastCombination);
	View_MoveTo (hPickLockHelper_LastCombination, posX, posY);
	View_Resize (hPickLockHelper_LastCombination, viewWidth, fontHeight);
	zcView_SetText (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, spaceWidth);
	
	if (!Hlp_IsValidHandle (hPickLockHelper_CurrentCombination)) {
		hPickLockHelper_CurrentCombination = View_Create(posX, posY, posX + viewWidth, posY + fontHeight);
		View_AddText (hPickLockHelper_CurrentCombination, 00, 00, pickLockHelper_CurrentCombination, pickLockHelper_FontName);
	};
	
	View_Open (hPickLockHelper_CurrentCombination);
	View_MoveTo (hPickLockHelper_CurrentCombination, posX, posY);
	View_Resize (hPickLockHelper_CurrentCombination, viewWidth, fontHeight);
	zcView_SetText (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, spaceWidth);
};

func void PickLockHelper_Hide () {
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
	var int spaceWidth; spaceWidth = Print_GetStringWidth (" ", pickLockHelper_FontName);
	spaceWidth = Print_ToVirtual (spaceWidth, PS_X);

	zcView_SetTextAndFontColor (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, RGBA (255, 255, 255, 64), spaceWidth);
	zcView_SetTextAndFontColor (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, RGBA (096, 255, 096, 255), spaceWidth);

	//Continue with original function
	PassArgumentI (bSuccess);
	PassArgumentI (bBrokenOpen);
	ContinueCall ();
};

func void _hook_oCMobLockable_PickLock () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var oCMobLockable mob; mob = _^ (ECX);

	var int c; c = MEM_ReadInt (ESP + 8);
	
	var string pickLockString;
	
	var int currCharCount; currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;
	
	currCharCount += 1;

	if (currCharCount > 0) {
		pickLockString = STR_Prefix (mob.pickLockStr, currCharCount);
	};

//---

	if (c == 76) {
		if (Hlp_StrCmp(ConcatStrings (pickLockHelper_CurrentCombination, "L"), pickLockString)) {
			pickLockHelper_CurrentCombination = pickLockString;
		};
	} else
	if (c == 82) {
		if (Hlp_StrCmp(ConcatStrings (pickLockHelper_CurrentCombination, "R"), pickLockString)) {
			pickLockHelper_CurrentCombination = pickLockString;
		};
	};

//---

	if (STR_Len (pickLockHelper_CurrentCombination) > STR_Len (pickLockHelper_LastCombination)) {
		pickLockHelper_LastCombination = pickLockHelper_CurrentCombination;
	};
};

func void _hook_oCMobInter_StartInteraction () {
	if (!Hlp_Is_oCMobLockable (ECX))  { return; };

	var oCNPC slf; slf = _^ (MEM_ReadInt (ESP + 4));
	
	if (!NPC_IsPlayer (slf)) { return; };

	var oCMobLockable mob; mob = _^ (ECX);
	
	//Reset for new mob
	if (pickLockHelper_LastMob != ECX) {
		pickLockHelper_CurrentCombination = "";
		pickLockHelper_LastCombination = "";
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
	
	if (STR_Len (mob.pickLockStr) > 0) {
		PickLockHelper_Show ();
	};
};

//Function is called when player ended interation
func void _hook_oCMobInter_EndInteraction () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var oCNPC slf; slf = _^ (MEM_ReadInt (ESP + 4));
	
	if (!NPC_IsPlayer (slf)) { return; };

	PickLockHelper_Hide ();
};

//Function is called when player broke picklock and does not have any
func void _hook_oCMobInter_StopInteraction () {
	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	var oCNPC slf; slf = _^ (MEM_ReadInt (ESP + 4));
	
	if (!NPC_IsPlayer (slf)) { return; };

	PickLockHelper_Hide ();

	//Reset
	pickLockHelper_CurrentCombination = "";
};

func void G12_PickLockHelper_Init () {
	const int once = 0;
	
	if (!once) {
		//Hook Len for G1 = 13, for G2A = 6
		HookEngine (oCMobLockable__PickLock, MEMINT_SwitchG1G2 (13, 6), "_hook_oCMobLockable_PickLock");
		
		HookDaedalusFunc (G_PickLock, _daedalusHook_G_PickLock);
		
		HookEngine (oCMobInter__StartInteraction, 6, "_hook_oCMobInter_StartInteraction");

		HookEngine (oCMobInter__EndInteraction, 6, "_hook_oCMobInter_EndInteraction");
		HookEngine (oCMobInter__StopInteraction, 6, "_hook_oCMobInter_StopInteraction");
		
		once = 1;
	};
};
