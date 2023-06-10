/*
 *	Bars
 *	 - additional methods that will help us with bars
 *	 - required by BetterBars and SprintMode features (both should be standalone, you can use BetterBars without using SprintMode and other way around)
 */

/*
 *	Bar constants
 */

//Bar types
const int BarType_HealthBar = 0;
const int BarType_ManaBar = 1;
const int BarType_Swimbar = 2;
const int BarType_SprintBar = 3;

//Bar display methods
const int BarDisplay_Standard = 0;
const int BarDisplay_DynamicUpdate = 1;
const int BarDisplay_AlwaysOn = 2;
const int BarDisplay_OnlyInInventory = 3;

//Bar preview - fadein/fadeout
const int BarPreviewEffect_None = 0; //Default no effect (preferred by Auronen)
const int BarPreviewEffect_FadeInOut = 1; //Fade in / out (you should definitelly use this one :) )

/*
 *	Internal variables
 */

// HEALTH BAR

var int hHealthBar;			//handle for HP bar
var int vHealthPreview;		//handle for HP bar preview (view)
var int vHealthBarValue;	//handle for HP bar values (view)

var int _healthBar_DisplayMethod;
var int _healthBar_PreviewEffect;
var int _healthBar_ForceOnDesk;
var int _healthBar_DisplayValues;
var int _healthBar_DisplayValues_Color;
var int _healthBar_DisplayValues_AlphaFunc;

// MANA BAR

var int hManaBar;			//handle for Mana bar
var int vManaPreview;		//handle for Mana bar preview (view)
var int vManaBarValue;		//handle for Mana bar values (view)

var int _manaBar_DisplayMethod;
var int _manaBar_PreviewEffect;
var int _manaBar_ForceOnDesk;
var int _manaBar_DisplayValues;
var int _manaBar_DisplayValues_Color;
var int _manaBar_DisplayValues_AlphaFunc;

// STAMINA BAR

var int hStaminaBar;		//handle for Stamina bar
var int vStaminaPreview;	//handle for Stamina bar preview (view)
var int vStaminaBarValue;	//handle for Stamina bar values (view)

var int _sprintBar_DisplayMethod;
var int _sprintBar_PreviewEffect;
var int _sprintBar_ForceOnDesk;
var int _sprintBar_DisplayValues;
var int _sprintBar_DisplayValues_Color;
var int _sprintBar_DisplayValues_AlphaFunc;

// SWIM BAR

var int hSwimBar;			//handle for Swim bar
var int vSwimBarValue;		//handle for Swim bar values (view)

var int _swimBar_DisplayValues;
var int _swimBar_DisplayValues_Color;
var int _swimBar_DisplayValues_AlphaFunc;

// FOCUS BAR

var int hFocusBar;			//handle for Focus bar
var int vFocusBarValue;		//handle for Focus bar values (view)

var int _focusBar_DisplayValues;
var int _focusBar_DisplayValues_Color;
var int _focusBar_DisplayValues_AlphaFunc;

//--

//Identifier which tells us whether inventory is opened
var int BarDisplay_InventoryOpened;

func void _eventOpenInventory__BetterBars () {
	BarDisplay_InventoryOpened = TRUE;
};

func void _eventCloseInventory__BetterBars () {
	BarDisplay_InventoryOpened = FALSE;
};

/*
 *	Function wrapper - that tells us whether bar should be on desk or not
 *	Returns TRUE if bar should be displayed, FALSE if not
 */
func int BarGetOnDesk (var int barType, var int displayMethod) {
	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
	var oCViewStatusBar manaBar; manaBar = _^ (MEM_Game.manaBar);

	//Display only in inventory
	if ((displayMethod == BarDisplay_OnlyInInventory) && (!BarDisplay_InventoryOpened)) {
		return FALSE;
	};

	//Dipslay method - always on
	if (displayMethod == BarDisplay_AlwaysOn) { return TRUE; };

	//Health bar
	if (barType == BarType_HealthBar)
	//Sprint bar will have by default same behaviour as health bar
	|| (barType == BarType_SprintBar)
	{
		//If in 'standard display' - use original bar zCView_ondesk attribute to figure out whether it should be on desk or not
		if (displayMethod == BarDisplay_Standard) {
			if (hpBar.zCView_ondesk) {
				return TRUE;
			};
		};

		//If mana bar is visible - then health bar should also be visible
		if (manaBar.zCView_ondesk) {
			return TRUE;
		};

		//If inventory is opened
		if (BarDisplay_InventoryOpened) {
			return TRUE;
		};
	};

	//Mana bar - use original bar zCView_ondesk attribute to figure out whether it should be on desk or not
	if (barType == BarType_ManaBar) {
		if (manaBar.zCView_ondesk) {
			return TRUE;
		};

		//If inventory is opened
		if (BarDisplay_InventoryOpened) {
			return TRUE;
		};
	};

	return FALSE;
};

/*
 *	Updates bar texture alpha values - separately for bar itself and background
 */
func void Bar_SetAlphaBackAndBar (var int bar, var int alphaBack, var int alphaBar) {
	if(!Hlp_IsValidHandle(bar)) { return; };
	var _bar b; b = get(bar);

	//-1 means do not change this one
	if (alphaBack > -1) {
		//Another trick von Mud-freak :)
		View_SetAlpha(b.v0, alphaBack);
	};
	if (alphaBar > -1) {
		View_SetAlpha(b.v1, alphaBar);
	};
};

/*
 *	Checks if LeGo bar is visible
 */
func int Bar_IsVisible (var int bar) {
	if(!Hlp_IsValidHandle(bar)) { return FALSE; };
	var _bar b; b = get(bar);
	return !b.hidden;
};

/*
 *	Sets bar value (safely, LeGo does not have safety check for bar max value - which might cause division by 0 error and crash the game)
 */
func void Bar_SetValueSafe (var int bar, var int val) {
	if (!Hlp_IsValidHandle(bar)) { return; };

	var _bar b; b = get(bar);

	if (val < 0) { val = 0; };

	if ((val) && (b.valMax)) {
		Bar_SetPromille(bar, (val * 1000) / b.valMax);
	} else {
		Bar_SetPromille(bar, 0);
	};
};

/*
 *	Creates View for bar preview
 */
func int Bar_CreatePreview (var int bHnd, var string textureName) {
	if(!Hlp_IsValidHandle(bHnd)) { return 0; };

	var int vHnd;

	var _bar b; b = get(bHnd);
	var zCView v; v = View_Get(b.v1);

	vHnd = View_CreatePxl(v.pposx, v.pposy, v.pposx + b.barW, v.pposy + v.psizey);
	View_SetTexture (vHnd, textureName);

	return vHnd;
};

/*
 *	Resizes View bar preview
 */
func void Bar_PreviewSetValue (var int bHnd, var int vHnd, var int previewValue) {
	if(!Hlp_IsValidHandle(bHnd)) { return; };
	if(!Hlp_IsValidHandle(vHnd)) { return; };

	var _bar b; b = get(bHnd);

	if (_Bar_PlayerStatus () && (!b.hidden)) {
		if (previewValue > 1000) { previewValue = 1000; };

		if ((previewValue) && (b.valMax)) {
			previewValue = ((previewValue * 1000) / b.valMax);
		} else {
			previewValue = 0;
		};

		View_Resize (vHnd, (previewValue * b.barW) / 1000, -1);

		var zCView v; v = View_Get(b.v1);
		View_MoveTo (vHnd, v.vposx, v.vposy);

		View_Open (vHnd);
		View_SetAlpha (vHnd, v.alpha);

		//Re-arrange views - first background texture view, second 'preview' view and finally bar texture view
		View_Top(b.v0);
		View_Top(vHnd);
		View_Top(b.v1);
	} else {
		View_Close (vHnd);
	};
};

func void Bar_SetViewVisible (var int bHnd, var int vHnd) {
	if(!Hlp_IsValidHandle(bHnd)) { return; };
	if(!Hlp_IsValidHandle(vHnd)) { return; };

	var _bar b; b = get(bHnd);

	if (_Bar_PlayerStatus () && (!b.hidden)) {
		var zCView v;
		v = View_Get(b.v1);

		View_Resize (vHnd, b.barW, -1);
		View_MoveTo (vHnd, v.vposx, v.vposy);

		View_Open (vHnd);

		v = View_Get(b.v0);
		View_SetAlphaAll (vHnd, v.alpha);

		View_Top(vHnd);
	} else {
		View_Close (vHnd);
	};
};

func void Bar_DisplayValue_Update (var int hBar, var int display) {
	var string s;
	var oCNpc her;

	if (!Hlp_IsValidNpc (hero)) { return; };

	if (display) {
		if (hBar == hHealthBar) {
			Bar_SetViewVisible (hHealthBar, vHealthBarValue);

			s = " / ";
			s = ConcatStrings (IntToString (hero.attribute [ATR_HITPOINTS]), s);
			s = ConcatStrings (s, IntToString (hero.attribute [ATR_HITPOINTS_MAX]));

			View_SetTextMarginAndFontColor (vHealthBarValue, s, _healthBar_DisplayValues_Color, 0);
			return;
		};

		if (hBar == hManaBar) {
			Bar_SetViewVisible (hManaBar, vManaBarValue);

			s = " / ";
			s = ConcatStrings (IntToString (hero.attribute [ATR_MANA]), s);
			s = ConcatStrings (s, IntToString (hero.attribute [ATR_MANA_MAX]));

			View_SetTextMarginAndFontColor (vManaBarValue, s, _manaBar_DisplayValues_Color, 0);
			return;
		};

		if (hBar == hStaminaBar) {
			Bar_SetViewVisible (hStaminaBar, vStaminaBarValue);

			if (PC_SprintModePlayerHasTimedOverlay) {
				var int hasteTimer; hasteTimer = PC_SprintModePlayerTimedOverlayTimer;
				var int hasteTimerMax; hasteTimerMax = PC_SprintModePlayerTimedOverlayTimerMax;

				hasteTimer = hasteTimer / 1000;
				hasteTimerMax = hasteTimerMax / 1000;

				s = " / ";
				s = ConcatStrings (IntToString (hasteTimer), s);
				s = ConcatStrings (s, IntToString (hasteTimerMax));
			} else {
				s = " / ";
				s = ConcatStrings (IntToString (PC_SprintModeStamina), s);
				s = ConcatStrings (s, IntToString (PC_SprintModeStaminaMax));
			};

			View_SetTextMarginAndFontColor (vStaminaBarValue, s, _sprintBar_DisplayValues_Color, 0);
			return;
		};

		if (hBar == hFocusBar) {
			Bar_SetViewVisible (hFocusBar, vFocusBarValue);

			her = Hlp_GetNpc (hero);
			if (Hlp_Is_oCNpc (her.focus_vob)) {
				var oCNpc npc; npc = _^ (her.focus_vob);

				s = " / ";
				s = ConcatStrings (IntToString (npc.attribute [ATR_HITPOINTS]), s);
				s = ConcatStrings (s, IntToString (npc.attribute [ATR_HITPOINTS_MAX]));

				View_SetTextMarginAndFontColor (vFocusBarValue, s, _focusBar_DisplayValues_Color, 0);
				return;
			};
		};

		if (hBar == hSwimBar) {
			Bar_SetViewVisible (hSwimBar, vSwimBarValue);

			her = Hlp_GetNpc (hero);

			var int diveTime; diveTime = her.divetime;
			var int diveCtr; diveCtr = her.divectr;

			if (diveTime == ANI_TIME_INFINITE) {
				diveCtr = diveTime;
				s = "- / -";
			} else {

				diveTime = RoundF (diveTime);
				diveCtr = RoundF (diveCtr);

				if (diveCtr < 0) { diveCtr = 0; };

				diveTime = diveTime / 1000;
				diveCtr = diveCtr / 1000;

				s = " / ";
				s = ConcatStrings (IntToString (diveCtr), s);
				s = ConcatStrings (s, IntToString (diveTime));
			};

			View_SetTextMarginAndFontColor (vSwimBarValue, s, _swimBar_DisplayValues_Color, 0);
			return;
		};
	};
};

/*
 *	Update display method (in-game)
 */
func void HealthBar_SetDisplayMethod (var int displayMethod) {
	_healthBar_DisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "healthBarDisplayMethod", IntToString (_healthBar_DisplayMethod));
};

func void ManaBar_SetDisplayMethod (var int displayMethod) {
	_manaBar_DisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "manaBarDisplayMethod", IntToString (_manaBar_DisplayMethod));
};

func void SprintBar_SetDisplayMethod (var int displayMethod) {
	_sprintBar_DisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "sprintBarDisplayMethod", IntToString (_sprintBar_DisplayMethod));
};

/*
 *	Helping functions for display methods
 */
func void HUD_Standard () {
	HealthBar_SetDisplayMethod (BarDisplay_Standard);
	ManaBar_SetDisplayMethod (BarDisplay_Standard);
	SprintBar_SetDisplayMethod (BarDisplay_Standard);
};

func void HUD_Dynamic () {
	HealthBar_SetDisplayMethod (BarDisplay_DynamicUpdate);
	ManaBar_SetDisplayMethod (BarDisplay_DynamicUpdate);
	SprintBar_SetDisplayMethod (BarDisplay_DynamicUpdate);
};

func void HUD_AlwaysOn () {
	HealthBar_SetDisplayMethod (BarDisplay_AlwaysOn);
	ManaBar_SetDisplayMethod (BarDisplay_AlwaysOn);
	SprintBar_SetDisplayMethod (BarDisplay_AlwaysOn);
};

func void HUD_OnlyInInventory () {
	HealthBar_SetDisplayMethod (BarDisplay_OnlyInInventory);
	ManaBar_SetDisplayMethod (BarDisplay_OnlyInInventory);
	SprintBar_SetDisplayMethod (BarDisplay_OnlyInInventory);
};

/*
 *	Default initialization for all bar features - adds event listeners for opening / closing inventory
 */
func void G12_InitDefaultBarFunctions () {
	G12_OpenInventoryEvent_Init ();
	G12_CloseInventoryEvent_Init ();

	OpenInventoryEvent_AddListener (_eventOpenInventory__BetterBars);
	CloseInventoryEvent_AddListener (_eventCloseInventory__BetterBars);
};
