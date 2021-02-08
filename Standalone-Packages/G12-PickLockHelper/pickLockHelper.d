const int pickLockHelper_Alpha = 192;					//Alpha
const string pickLockHelper_FontName = "font_old_10_white.tga";		//font

//PickLockHelper position
const int pickLockHelper_PPosX = 0;					//X position
const int pickLockHelper_PPosY = -1;					//Y position, if not define (-1) then it will be in a middle of screen on Y axis
const int pickLockHelper_Width = 320;					//Width

//Internal constants and variables

const int pickLockHelper_LastMob = 0;

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
	fontHeight = Print_ToVirtual(fontHeight, PS_Y);

	var int pickLockHelper_WidthScaled;
	pickLockHelper_WidthScaled = Print_ToVirtual(pickLockHelper_Width, PS_X);
	pickLockHelper_WidthScaled = roundf (mulf (mkf (pickLockHelper_WidthScaled), scaleF));

	//--- calculate if not specified
	var int posx; posx = pickLockHelper_PPosX;
	if (pickLockHelper_PPosX == -1) {
		posx = (PS_VMax - pickLockHelper_WidthScaled) / 2;
	};

	var int posy; posy = pickLockHelper_PPosY;
	if (pickLockHelper_PPosY == -1) {
		posy = (PS_VMax - fontHeight) / 2;
	};
	
	//---

	if (!Hlp_IsValidHandle (hPickLockHelper_Frame)) {
		hPickLockHelper_Frame  = View_Create(posx, posy, pickLockHelper_WidthScaled, posy + fontHeight);
		View_SetTexture (hPickLockHelper_Frame, "DLG_NOISE.TGA");
		View_SetAlpha (hPickLockHelper_Frame, pickLockHelper_Alpha);
	};

	View_Open (hPickLockHelper_Frame);
	View_MoveTo (hPickLockHelper_Frame, posx, posy);
	View_Resize (hPickLockHelper_Frame, pickLockHelper_WidthScaled, fontHeight);
	
	if (!Hlp_IsValidHandle (hPickLockHelper_LastCombination)) {
		hPickLockHelper_LastCombination = View_Create(posx, posy, pickLockHelper_WidthScaled, posy + fontHeight);
		View_AddText (hPickLockHelper_LastCombination, 00, 00, pickLockHelper_LastCombination, pickLockHelper_FontName);	
	};
	
	View_Open (hPickLockHelper_LastCombination);
	View_MoveTo (hPickLockHelper_LastCombination, posx, posy);
	View_Resize (hPickLockHelper_LastCombination, pickLockHelper_WidthScaled, fontHeight);
	
	if (!Hlp_IsValidHandle (hPickLockHelper_CurrentCombination)) {
		hPickLockHelper_CurrentCombination = View_Create(posx, posy, pickLockHelper_WidthScaled, posy + fontHeight);
		View_AddText (hPickLockHelper_CurrentCombination, 00, 00, pickLockHelper_CurrentCombination, pickLockHelper_FontName);	
	};
	
	View_Open (hPickLockHelper_CurrentCombination);
	View_MoveTo (hPickLockHelper_CurrentCombination, posx, posy);
	View_Resize (hPickLockHelper_CurrentCombination, pickLockHelper_WidthScaled, fontHeight);
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
	zcView_SetTextAndFontColor (hPickLockHelper_LastCombination, pickLockHelper_LastCombination, RGBA (255, 255, 255, 64));
	zcView_SetTextAndFontColor (hPickLockHelper_CurrentCombination, pickLockHelper_CurrentCombination, RGBA (096, 255, 096, 255));

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

	var string mobVisualName; mobVisualName = Vob_GetVisualName (ECX);
	
	var oCMobLockable mob; mob = _^ (ECX);
	
	//Reset for new mob
	if (STR_Len (pickLockHelper_LastCombination) > 0) {
		if (pickLockHelper_LastMob != ECX) {
			pickLockHelper_CurrentCombination = "";
			pickLockHelper_LastCombination = "";
		};
	};
	
	pickLockHelper_LastMob = ECX;
	
	//---

	var int currCharCount;
	currCharCount = (mob.bitfield & oCMobLockable_bitfield_pickLockNr) >> 2;

	if (currCharCount > 0)
	{
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
