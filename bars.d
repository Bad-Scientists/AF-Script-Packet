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
 *	Dynamic position update
 */

func void HealthBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_healthBar_PPosX == -1) {
		//Virtual position (180 is default length)
		posX = Print_ToVirtual (100, PS_X);
	} else {
		posX = Print_ToVirtual (_healthBar_PPosX, PS_X);
	};

	if (_healthBar_PPosY == -1) {
		//Virtual position (20) is default height
		posY = PS_VMax - Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_healthBar_PPosY, PS_Y);
	};

	//Virtual pos
	if (_healthBar_VPosX > -1) {
		posX = _healthBar_VPosX;
	};

	if (_healthBar_VPosY > -1) {
		posY = _healthBar_VPosY;
	};

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _healthBar_LastPosX;
	var int _healthBar_LastPosY;

	if ((posX != _healthBar_LastPosX) || (posY != _healthBar_LastPosY))
	{
		//Move bar
		Bar_MoveTo (hHealthBar, posX, posY);

		//Move bar preview
		var zCView v1; v1 = View_Get (bHealthBar.v1);
		var zCView v2; v2 = View_Get (vHealthPreview);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vHealthPreview, v1.vposX, v1.vposY);
		};

		//Move bar values
		v1 = View_Get (bHealthBar.v1);
		v2 = View_Get (vHealthBarValue);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vHealthBarValue, v1.vposX, v1.vposY);
		};

		_healthBar_LastPosX = posX;
		_healthBar_LastPosY = posY;
	};
};

func void ManaBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_manaBar_PPosX == -1) {
		//Virtual position (180 is default length)
		posX = PS_VMax - Print_ToVirtual (100, PS_X);
	} else {
		posX = Print_ToVirtual (_manaBar_PPosX, PS_X);
	};

	if (_manaBar_PPosY == -1) {
		//Virtual position (20) is default height
		posY = PS_VMax - Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_manaBar_PPosY, PS_Y);
	};

	//Virtual pos
	if (_manaBar_VPosX > -1) {
		posX = _manaBar_VPosX;
	};

	if (_manaBar_VPosY > -1) {
		posY = _manaBar_VPosY;
	};

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _manaBar_LastPosX;
	var int _manaBar_LastPosY;

	if ((posX != _manaBar_LastPosX) || (posY != _manaBar_LastPosY))
	{
		//Move bar
		Bar_MoveTo (hManaBar, posX, posY);

		//Move bar preview
		var zCView v1; v1 = View_Get (bManaBar.v1);
		var zCView v2; v2 = View_Get (vManaPreview);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vManaPreview, v1.vposX, v1.vposY);
		};

		//Move bar values
		v1 = View_Get (bManaBar.v1);
		v2 = View_Get (vManaBarValue);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vManaBarValue, v1.vposX, v1.vposY);
		};

		_manaBar_LastPosX = posX;
		_manaBar_LastPosY = posY;
	};
};

func void SwimBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_swimBar_PPosX == -1) {
		//Virtual position (180 is default length)
		posX = PS_VMax / 2;
	} else {
		posX = Print_ToVirtual (_swimBar_PPosX, PS_X);
	};

	if (_swimBar_PPosY == -1) {
		//Virtual position (20) is default height
		posY = PS_VMax - Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_swimBar_PPosY, PS_Y);
	};

	if (_swimBar_VPosX > -1) {
		posX = _swimBar_VPosX;
	};

	if (_swimBar_VPosY > -1) {
		posY = _swimBar_VPosY;
	};

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _swimBar_LastPosX;
	var int _swimBar_LastPosY;

	if ((posX != _swimBar_LastPosX) || (posY != _swimBar_LastPosY))
	{
		//Move bar
		Bar_MoveTo (hSwimBar, posX, posY);

		//Move bar values
		var zCView v1; v1 = View_Get (bSwimBar.v1);
		var zCView v2; v2 = View_Get (vSwimBarValue);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vSwimBarValue, v1.vposX, v1.vposY);
		};

		_swimBar_LastPosX = posX;
		_swimBar_LastPosY = posY;
	};
};

func void FocusBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_focusBar_PPosX == -1) {
		//Virtual position (180 is default length)
		posX = PS_VMax / 2;
	} else {
		posX = Print_ToVirtual (_focusBar_PPosX, PS_X);
	};

	if (_focusBar_PPosY == -1) {
		//Virtual position (20) is default height
		posY = Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_focusBar_PPosY, PS_Y);
	};

	if (_focusBar_VPosX > -1) {
		posX = _focusBar_VPosX;
	};

	if (_focusBar_VPosY > -1) {
		posY = _focusBar_VPosY;
	};

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _focusBar_LastPosX;
	var int _focusBar_LastPosY;

	if ((posX != _focusBar_LastPosX) || (posY != _focusBar_LastPosY))
	{
		//Move bar
		Bar_MoveTo (hFocusBar, posX, posY);

		//Move bar values
		var zCView v1; v1 = View_Get (bFocusBar.v1);
		var zCView v2; v2 = View_Get (vFocusBarValue);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vFocusBarValue, v1.vposX, v1.vposY);
		};

		_focusBar_LastPosX = posX;
		_focusBar_LastPosY = posY;
	};
};

func void StaminaBar_UpdatePosition () {

	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_PC_SprintModeBar_PPosX == -1) {
		//Virtual position (180 is default length)
		posX = PS_VMax / 2;
	} else {
		posX = Print_ToVirtual (_PC_SprintModeBar_PPosX, PS_X);
	};

	if (_PC_SprintModeBar_PPosY == -1) {
		//Virtual position (20) is default height
		posY = PS_VMax - Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_PC_SprintModeBar_PPosY, PS_Y);
	};

	if (_PC_SprintModeBar_VPosX > -1) {
		posX = _PC_SprintModeBar_VPosX;
	};

	if (_PC_SprintModeBar_VPosY > -1) {
		posY = _PC_SprintModeBar_VPosY;
	};

	var int _staminaBar_LastPosX;
	var int _staminaBar_LastPosY;

	if ((posX != _staminaBar_LastPosX) || (posY != _staminaBar_LastPosY))
	{
		Bar_MoveTo (hStaminaBar, posX, posY);

		//Move bar preview
		//var zCView v1; v1 = View_Get (bStaminaBar.v1);
		//var zCView v2; v2 = View_Get (vStaminaPreview);

		//if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		//{
		//	View_MoveTo (vStaminaPreview, v1.vposX, v1.vposY);
		//};

		//Move bar values
		var zCView v1; v1 = View_Get (bStaminaBar.v1);
		var zCView v2; v2 = View_Get (vStaminaBarValue);

		if ((v2.vposX != v1.vposX) || (v2.vposY != v1.vposY))
		{
			View_MoveTo (vStaminaBarValue, v1.vposX, v1.vposY);
		};

		_staminaBar_LastPosX = posX;
		_staminaBar_LastPosY = posY;
	};
};

/*
 *	BBar_SetAlpha
 *	 - wrapper function that updates also additional views
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
 *	BBar_SetAlphaBackAndBar
 *	 - wrapper function that updates also additional views
 */
func void BBar_SetAlphaBackAndBar (var int hBar, var int alphaBack, var int alphaBar) {
	Bar_SetAlphaBackAndBar (hbar, alphaBack, alphaBar);

	if (hBar == hStaminaBar) {
		View_SetAlphaAll (vStaminaBarValue, alphaBack);
		return;
	};
};

/*
 *	BBar_Hide
 *	 - wrapper function that closes also additional views
 */
func void BBar_Hide (var int hBar) {
	if (hbar == hHealthBar) {
		View_Close(bHealthBar.v0);
		View_Close(bHealthBar.v1);
		bHealthBar.hidden = TRUE;

		View_Close (vHealthBarValue);
		View_Close (vHealthPreview);
	};

	if (hbar == hStaminaBar) {
		View_Close(bStaminaBar.v0);
		View_Close(bStaminaBar.v1);
		bStaminaBar.hidden = TRUE;

		View_Close (vStaminaBarValue);
	};

	if (hbar == hManaBar) {
		View_Close(bManaBar.v0);
		View_Close(bManaBar.v1);
		bManaBar.hidden = TRUE;

		View_Close (vManaBarValue);
		View_Close (vManaPreview);
	};

	if (hbar == hSwimBar) {
		View_Close(bSwimBar.v0);
		View_Close(bSwimBar.v1);
		bSwimBar.hidden = TRUE;

		View_Close (vSwimBarValue);
	};

	if (hbar == hFocusBar) {
		View_Close(bFocusBar.v0);
		View_Close(bFocusBar.v1);
		bFocusBar.hidden = TRUE;

		View_Close (vFocusBarValue);
	};
};

/*
 *	BBar_Show
 *	 - wrapper function that opens / re-arranges also additional views
 */
func void BBar_Show (var int hBar) {
	if (hbar == hHealthBar) {
		View_Open (bHealthBar.v0);
		View_Top (vHealthPreview);
		View_Open (bHealthBar.v1);
		View_Open (vHealthBarValue);
		bHealthBar.hidden = FALSE;

		HealthBar_UpdatePosition ();
		View_Resize (vHealthBarValue, bHealthBar.barW, -1);
	};

	if (hbar == hStaminaBar) {
		View_Open (bStaminaBar.v0);
		View_Open (bStaminaBar.v1);
		View_Open (vStaminaBarValue);
		bStaminaBar.hidden = FALSE;

		StaminaBar_UpdatePosition ();
		View_Resize (vStaminaBarValue, bStaminaBar.barW, -1);
	};

	if (hbar == hManaBar) {
		View_Open (bManaBar.v0);
		View_Top(vManaPreview);
		View_Open (bManaBar.v1);
		View_Open (vManaBarValue);
		bManaBar.hidden = FALSE;

		ManaBar_UpdatePosition ();
		View_Resize (vManaBarValue, bManaBar.barW, -1);
	};

	if (hbar == hSwimBar) {
		View_Open (bSwimBar.v0);
		View_Open (bSwimBar.v1);
		View_Open (vSwimBarValue);
		bSwimBar.hidden = FALSE;

		SwimBar_UpdatePosition ();
		View_Resize (vSwimBarValue, bSwimBar.barW, -1);
	};

	if (hbar == hFocusBar) {
		View_Open (bFocusBar.v0);
		View_Open (bFocusBar.v1);
		View_Open (vFocusBarValue);
		bFocusBar.hidden = FALSE;

		FocusBar_UpdatePosition ();
		View_Resize (vFocusBarValue, bFocusBar.barW, -1);
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
