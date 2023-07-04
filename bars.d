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

//LeGo bar
instance bHealthBar (_bar);
instance bManaBar (_bar);
instance bSwimBar (_bar);
instance bFocusBar (_bar);
instance bStaminaBar (_bar);

// HEALTH BAR

var int hHealthBar;			//handle for HP bar
var int vHealthPreview;		//handle for HP bar preview (view)
var int vHealthBarValue;	//handle for HP bar values (view)

var int _healthBar_WasHidden;
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

var int _manaBar_WasHidden;
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

var int _staminaBar_WasHidden;
var int _staminaBar_DisplayMethod;
var int _staminaBar_PreviewEffect;
var int _staminaBar_ForceOnDesk;
var int _staminaBar_DisplayValues;
var int _staminaBar_DisplayValues_Color;
var int _staminaBar_DisplayValues_AlphaFunc;

// SWIM BAR

var int hSwimBar;			//handle for Swim bar
var int vSwimBarValue;		//handle for Swim bar values (view)

var int _swimBar_WasHidden;
var int _swimBar_DisplayValues;
var int _swimBar_DisplayValues_Color;
var int _swimBar_DisplayValues_AlphaFunc;

// FOCUS BAR

var int hFocusBar;			//handle for Focus bar
var int vFocusBarValue;		//handle for Focus bar values (view)

var int _focusBar_WasHidden;
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
func void Bar_SetAlphaBackAndBar (var int hBar, var int alphaBack, var int alphaBar) {
	if(!Hlp_IsValidHandle(hBar)) { return; };
	var _bar b; b = get(hBar);

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

	if (STR_Len (textureName)) {
		View_SetTexture (vHnd, textureName);
	};

	return vHnd;
};

/*
 *
 */
func void BBar_SetAlpha (var int hBar, var int alpha) {
	Bar_SetAlpha (hBar, alpha);

	if (hBar == hHealthBar) {
		View_SetAlphaAll (vHealthBarValue, alpha);
		return;
	};

	if (hBar == hStaminaBar) {
		View_SetAlphaAll (vStaminaBarValue, alpha);
		return;
	};

	if (hBar == hFocusBar) {
		View_SetAlphaAll (vFocusBarValue, alpha);
		return;
	};

	if (hBar == hManaBar) {
		View_SetAlphaAll (vManaBarValue, alpha);
		return;
	};

	if (hBar == hSwimBar) {
		View_SetAlphaAll (vSwimBarValue, alpha);
		return;
	};
};

/*
 *
 */
func void BBar_SetAlphaBackAndBar (var int hBar, var int alphaBack, var int alphaBar) {
	Bar_SetAlphaBackAndBar (hbar, alphaBack, alphaBar);

	if (hBar == hStaminaBar) {
		View_SetAlphaAll (vStaminaBarValue, alphaBack);
		return;
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
	_staminaBar_DisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "sprintBarDisplayMethod", IntToString (_staminaBar_DisplayMethod));
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

const int _BBar_Update_Status = -1;

func void _BBar_Update() {
    var int status; status = _Bar_PlayerStatus();

	if (_Bar_Update_Status == -1) {
		_BBar_Update_Status = -1;
	};

    if (_BBar_Update_Status != status) {
        _BBar_Update_Status = status;

        if (status) {
			_healthBar_WasHidden = TRUE;
			_manaBar_WasHidden = TRUE;
			_swimBar_WasHidden = TRUE;
			_focusBar_WasHidden = TRUE;
			_staminaBar_WasHidden = TRUE;
        } else {
			if (Hlp_IsValidHandle (vHealthBarValue)) { View_Close (vHealthBarValue); };
			if (Hlp_IsValidHandle (vHealthPreview)) { View_Close (vHealthPreview); };
			if (Hlp_IsValidHandle (vManaBarValue)) { View_Close (vManaBarValue); };
			if (Hlp_IsValidHandle (vManaPreview)) { View_Close (vManaPreview); };
			if (Hlp_IsValidHandle (vSwimBarValue)) { View_Close (vSwimBarValue); };
			if (Hlp_IsValidHandle (vFocusBarValue)) { View_Close (vFocusBarValue); };
			//if (Hlp_IsValidHandle (vStaminaPreview)) { View_Close (vStaminaPreview); };
			if (Hlp_IsValidHandle (vStaminaBarValue)) { View_Close (vStaminaBarValue); };
		};
    };
};

func void G12_InitDefaultBarFunctions () {
	G12_OpenInventoryEvent_Init ();
	G12_CloseInventoryEvent_Init ();

	OpenInventoryEvent_AddListener (_eventOpenInventory__BetterBars);
	CloseInventoryEvent_AddListener (_eventCloseInventory__BetterBars);

	//Taken from LeGo
	const int once = 0;
	if (!once) {
		HookEngineF(oCGame__UpdateStatus_start, 6, _BBar_Update);
		once = 1;
	};
};

func void testBarAF () {
	_healthBar_DisplayValues_AlphaFunc += 1;
	_manaBar_DisplayValues_AlphaFunc += 1;
	_focusBar_DisplayValues_AlphaFunc += 1;
	_staminaBar_DisplayValues_AlphaFunc += 1;

	if (_healthBar_DisplayValues_AlphaFunc > 7) {
		_healthBar_DisplayValues_AlphaFunc = 0;
		_manaBar_DisplayValues_AlphaFunc = 0;
		_focusBar_DisplayValues_AlphaFunc = 0;
		_staminaBar_DisplayValues_AlphaFunc = 0;
	};

	View_SetAlphaFunc (vHealthBarValue, _healthBar_DisplayValues_AlphaFunc);
	View_SetAlphaFunc (vManaBarValue, _manaBar_DisplayValues_AlphaFunc);
	View_SetAlphaFunc (vFocusBarValue, _focusBar_DisplayValues_AlphaFunc);
	View_SetAlphaFunc (vStaminaBarValue, _staminaBar_DisplayValues_AlphaFunc);
};

func void testSBA () {
	Bar_SetAlphaBackAndBar (hStaminaBar, -1, 128);
};
