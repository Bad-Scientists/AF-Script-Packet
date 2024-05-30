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
 *	Bar display states
 *
 *	BarDisplayState_FadingIn (alpha ++) --> BarDisplayState_Displayed
 *	BarDisplayState_Displayed (alpha 255) --> BarDisplayState_FadingOut (if dynamic, otherwise states in this state)
 *	BarDisplayState_FadingOut (alpha --) --> BarDisplayState_Hidden
 *	BarDisplayState_Hidden (alpha 0)
 *
 *	BarDisplayState_StartFlashing --> BarDisplayState_IsFlashing - will reset flash counter
 *	BarDisplayState_IsFlashing (alpha +-) --> BarDisplayState_WasFlashing
 *	BarDisplayState_WasFlashing --> BarDisplayState_Displayed - will activate FF_FadeInOut* function
 */
const int BarDisplayState_FadingIn = 0;
const int BarDisplayState_Displayed = 1;
const int BarDisplayState_FadingOut = 2;
const int BarDisplayState_Hidden = 3;

const int BarDisplayState_StartFlashing = 4;
const int BarDisplayState_IsFlashing = 5;
const int BarDisplayState_WasFlashing = 6;

/*
 *	Internal variables
 */

//Bars (LeGo)
instance bHealthBar (_bar);
instance bManaBar (_bar);
instance bSwimBar (_bar);
instance bFocusBar (_bar);
instance bStaminaBar (_bar);

//Views
instance vHealthBarBackTexView (zCView);
instance vHealthBarValueView (zCView);
instance vManaBarBackTexView (zCView);
instance vManaBarValueView (zCView);
instance vSwimBarBackTexView (zCView);
instance vSwimBarValueView (zCView);
instance vFocusBarBackTexView (zCView);
instance vFocusBarValueView (zCView);
instance vStaminaBarBackTexView (zCView);
instance vStaminaBarValueView (zCView);

// HEALTH BAR

var int hHealthBar; //handle for HP bar
var int hHealthPreviewView; //handle for HP bar preview (view)
var int hHealthBarValueView; //handle for HP bar values (view)

var int _healthBar_PreviewVisible;

var int _healthBar_DisplayValueOffsetX;
var int _healthBar_DisplayValueOffsetY;

var int _healthBar_WasHidden;
var int _healthBar_DisplayMethod;
var int _healthBar_PreviewEffect;
var int _healthBar_ForceOnDesk;
var int _healthBar_DisplayValues;
var int _healthBar_DisplayValues_Color;
var int _healthBar_DisplayValues_AlphaFunc;

// MANA BAR

var int hManaBar; //handle for Mana bar
var int hManaPreviewView; //handle for Mana bar preview (view)
var int hManaBarValueView; //handle for Mana bar values (view)

var int _manaBar_PreviewVisible;

var int _manaBar_DisplayValueOffsetX;
var int _manaBar_DisplayValueOffsetY;

var int _manaBar_WasHidden;
var int _manaBar_DisplayMethod;
var int _manaBar_PreviewEffect;
var int _manaBar_ForceOnDesk;
var int _manaBar_DisplayValues;
var int _manaBar_DisplayValues_Color;
var int _manaBar_DisplayValues_AlphaFunc;

// STAMINA BAR

var int hStaminaBar; //handle for Stamina bar
var int hStaminaPreviewView; //handle for Stamina bar preview (view)
var int hStaminaBarValueView; //handle for Stamina bar values (view)

var int _staminaBar_DisplayValueOffsetX;
var int _staminaBar_DisplayValueOffsetY;

var int _staminaBar_WasHidden;
var int _staminaBar_DisplayMethod;
var int _staminaBar_PreviewEffect;
var int _staminaBar_ForceOnDesk;
var int _staminaBar_DisplayValues;
var int _staminaBar_DisplayValues_Color;
var int _staminaBar_DisplayValues_AlphaFunc;

// SWIM BAR

var int hSwimBar; //handle for Swim bar
var int hSwimBarValueView; //handle for Swim bar values (view)

var int _swimBar_DisplayValueOffsetX;
var int _swimBar_DisplayValueOffsetY;

var int _swimBar_WasHidden;
var int _swimBar_DisplayValues;
var int _swimBar_DisplayValues_Color;
var int _swimBar_DisplayValues_AlphaFunc;

// FOCUS BAR

var int hFocusBar; //handle for Focus bar
var int hFocusBarValueView; //handle for Focus bar values (view)

var int _focusBar_DisplayValueOffsetX;
var int _focusBar_DisplayValueOffsetY;

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
	if (displayMethod == BarDisplay_OnlyInInventory) {
		return BarDisplay_InventoryOpened;
	};

	//Dipslay method - always on
	if (displayMethod == BarDisplay_AlwaysOn) {
		return TRUE;
	};

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
func int Bar_IsVisible (var int hBar) {
	if(!Hlp_IsValidHandle(hBar)) { return FALSE; };
	var _bar b; b = get(hBar);
	return !b.hidden;
};

/*
 *	Sets bar value (safely, LeGo does not have safety check for bar max value - which might cause division by 0 error and crash the game)
 */
func void Bar_SetValueSafe (var int hBar, var int val) {
	if (!Hlp_IsValidHandle(hBar)) { return; };

	var _bar b; b = get(hBar);

	if (val < 0) { val = 0; };

	if ((val) && (b.valMax)) {
		Bar_SetPromille(hBar, (val * 1000) / b.valMax);
	} else {
		Bar_SetPromille(hBar, 0);
	};
};

/*
 *	Creates View for bar preview
 */
func int Bar_CreatePreviewView (var int hBar, var string textureName) {
	if(!Hlp_IsValidHandle(hBar)) { return 0; };

	var int vHnd;

	var _bar b; b = get(hBar);
	var zCView v; v = View_Get(b.v1);

	vHnd = View_Create(v.vposx, v.vposy, v.vposx + b.barW, v.vposy + v.vsizey);

	if (STR_Len (textureName)) {
		View_SetTexture (vHnd, textureName);
	};

	return vHnd;
};

/*
 *	Creates View for bar values
 */
func int Bar_CreateValuesView (var int hBar, var string textureName) {
	if(!Hlp_IsValidHandle(hBar)) { return 0; };

	var int vHnd;

	var _bar b; b = get(hBar);
	var zCView v; v = View_Get(b.v0);

	vHnd = View_Create(v.vposx, v.vposy, v.vposx + v.vsizex, v.vposy + v.vsizey);

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
		posX = Print_ToVirtual (100, PS_X);
	} else {
		posX = Print_ToVirtual (_healthBar_PPosX, PS_X);
	};

	if (_healthBar_PPosY == -1) {
		posY = PS_VMax - Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_healthBar_PPosY, PS_Y);
	};

	if (_healthBar_VPosX > -1) {
		posX = _healthBar_VPosX;
	};

	if (_healthBar_VPosY > -1) {
		posY = _healthBar_VPosY;
	};

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _healthBar_LastPosX;
	var int _healthBar_LastPosY;

	if ((posX != _healthBar_LastPosX) || (posY != _healthBar_LastPosY)) {
		Bar_MoveTo (hHealthBar, posX, posY);

		var zCView v; v = View_Get(bHealthBar.v1);
		View_MoveTo_Safe (hHealthPreviewView, v.vposx, v.vposy);
	};

	//Move bar values
	var int targetPosX; var int targetPosY;

	if (_healthBar_DisplayValueOffsetX == 0) {
		targetPosX = vHealthBarBackTexView.vposX;
	} else {
		targetPosX = vHealthBarBackTexView.vposX + Print_ToVirtual (_healthBar_DisplayValueOffsetX, PS_X);
	};

	if (_healthBar_DisplayValueOffsetY == 0) {
		targetPosY = vHealthBarBackTexView.vposY;
	} else {
		var int fontHeight; fontHeight = Print_GetFontHeight (_betterBars_Font);

		if (_healthBar_DisplayValueOffsetY > 0) {
			targetPosY = vHealthBarBackTexView.vposY + Print_ToVirtual (fontHeight + _healthBar_DisplayValueOffsetY, PS_Y);
		} else {
			targetPosY = vHealthBarBackTexView.vposY - Print_ToVirtual (fontHeight - _healthBar_DisplayValueOffsetY, PS_Y);
		};
	};

	var int widthDiff; widthDiff = (vHealthBarValueView.psizeX - vHealthBarBackTexView.psizeX) / 2;
	if (widthDiff != 0) {
		targetPosX -= Print_ToVirtual (widthDiff, PS_X);
	};

	if ((vHealthBarValueView.vposX != targetPosX) || (vHealthBarValueView.vposY != targetPosY)) {
		View_MoveTo_Safe (hHealthBarValueView, targetPosX, targetPosY);
	};

	_healthBar_LastPosX = posX; _healthBar_LastPosY = posY;
};

func void ManaBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_manaBar_PPosX == -1) {
		posX = PS_VMax - Print_ToVirtual (100, PS_X);
	} else {
		posX = Print_ToVirtual (_manaBar_PPosX, PS_X);
	};

	if (_manaBar_PPosY == -1) {
		posY = PS_VMax - Print_ToVirtual (20, PS_Y);
	} else {
		posY = Print_ToVirtual (_manaBar_PPosY, PS_Y);
	};

	if (_manaBar_VPosX > -1) {
		posX = _manaBar_VPosX;
	};

	if (_manaBar_VPosY > -1) {
		posY = _manaBar_VPosY;
	};

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _manaBar_LastPosX;
	var int _manaBar_LastPosY;

	if ((posX != _manaBar_LastPosX) || (posY != _manaBar_LastPosY)) {
		Bar_MoveTo (hManaBar, posX, posY);

		var zCView v; v = View_Get(bManaBar.v1);
		View_MoveTo_Safe (hManaPreviewView, v.vposx, v.vposy);
	};

	//Move bar values
	var int targetPosX; var int targetPosY;

	if (_manaBar_DisplayValueOffsetX == 0) {
		targetPosX = vmanaBarBackTexView.vposX;
	} else {
		targetPosX = vmanaBarBackTexView.vposX + Print_ToVirtual (_manaBar_DisplayValueOffsetX, PS_X);
	};

	if (_manaBar_DisplayValueOffsetY == 0) {
		targetPosY = vmanaBarBackTexView.vposY;
	} else {
		var int fontHeight; fontHeight = Print_GetFontHeight (_betterBars_Font);

		if (_manaBar_DisplayValueOffsetY > 0) {
			targetPosY = vmanaBarBackTexView.vposY + Print_ToVirtual (fontHeight + _manaBar_DisplayValueOffsetY, PS_Y);
		} else {
			targetPosY = vmanaBarBackTexView.vposY - Print_ToVirtual (fontHeight - _manaBar_DisplayValueOffsetY, PS_Y);
		};
	};

	var int widthDiff; widthDiff = (vmanaBarValueView.psizeX - vmanaBarBackTexView.psizeX) / 2;
	if (widthDiff != 0) {
		targetPosX -= Print_ToVirtual (widthDiff, PS_X);
	};

	if ((vmanaBarValueView.vposX != targetPosX) || (vmanaBarValueView.vposY != targetPosY)) {
		View_MoveTo_Safe (hManaBarValueView, targetPosX, targetPosY);
	};

	_manaBar_LastPosX = posX; _manaBar_LastPosY = posY;
};

func void SwimBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_swimBar_PPosX == -1) {
		posX = PS_VMax / 2;
	} else {
		posX = Print_ToVirtual (_swimBar_PPosX, PS_X);
	};

	if (_swimBar_PPosY == -1) {
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

	if ((posX != _swimBar_LastPosX) || (posY != _swimBar_LastPosY)) {
		Bar_MoveTo (hSwimBar, posX, posY);
	};

	//Move bar values
	var int targetPosX; var int targetPosY;

	if (_swimBar_DisplayValueOffsetX == 0) {
		targetPosX = vSwimBarBackTexView.vposX;
	} else {
		targetPosX = vSwimBarBackTexView.vposX + Print_ToVirtual (_swimBar_DisplayValueOffsetX, PS_X);
	};

	if (_swimBar_DisplayValueOffsetY == 0) {
		targetPosY = vSwimBarBackTexView.vposY;
	} else {
		var int fontHeight; fontHeight = Print_GetFontHeight (_betterBars_Font);

		if (_swimBar_DisplayValueOffsetY > 0) {
			targetPosY = vSwimBarBackTexView.vposY + Print_ToVirtual (fontHeight + _swimBar_DisplayValueOffsetY, PS_Y);
		} else {
			targetPosY = vSwimBarBackTexView.vposY - Print_ToVirtual (fontHeight - _swimBar_DisplayValueOffsetY, PS_Y);
		};
	};

	var int widthDiff; widthDiff = (vSwimBarValueView.psizeX - vSwimBarBackTexView.psizeX) / 2;
	if (widthDiff != 0) {
		targetPosX -= Print_ToVirtual (widthDiff, PS_X);
	};

	if ((vSwimBarValueView.vposX != targetPosX) || (vSwimBarValueView.vposY != targetPosY)) {
		View_MoveTo_Safe (hSwimBarValueView, targetPosX, targetPosY);
	};

	_swimBar_LastPosX = posX; _swimBar_LastPosY = posY;
};

func void FocusBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_focusBar_PPosX == -1) {
		posX = PS_VMax / 2;
	} else {
		posX = Print_ToVirtual (_focusBar_PPosX, PS_X);
	};

	if (_focusBar_PPosY == -1) {
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

	if ((posX != _focusBar_LastPosX) || (posY != _focusBar_LastPosY)) {
		Bar_MoveTo (hFocusBar, posX, posY);
	};

	//Move bar values
	var int targetPosX; var int targetPosY;

	if (_focusBar_DisplayValueOffsetX == 0) {
		targetPosX = vFocusBarBackTexView.vposX;
	} else {
		targetPosX = vFocusBarBackTexView.vposX + Print_ToVirtual (_focusBar_DisplayValueOffsetX, PS_X);
	};

	if (_focusBar_DisplayValueOffsetY == 0) {
		targetPosY = vFocusBarBackTexView.vposY;
	} else {
		var int fontHeight; fontHeight = Print_GetFontHeight (_betterBars_Font);

		if (_focusBar_DisplayValueOffsetY > 0) {
			targetPosY = vFocusBarBackTexView.vposY + Print_ToVirtual (fontHeight + _focusBar_DisplayValueOffsetY, PS_Y);
		} else {
			targetPosY = vFocusBarBackTexView.vposY - Print_ToVirtual (fontHeight - _focusBar_DisplayValueOffsetY, PS_Y);
		};
	};

	var int widthDiff; widthDiff = (vFocusBarValueView.psizeX - vFocusBarBackTexView.psizeX) / 2;
	if (widthDiff != 0) {
		targetPosX -= Print_ToVirtual (widthDiff, PS_X);
	};

	if ((vFocusBarValueView.vposX != targetPosX) || (vFocusBarValueView.vposY != targetPosY)) {
		View_MoveTo_Safe (hFocusBarValueView, targetPosX, targetPosY);
	};

	_focusBar_LastPosX = posX; _focusBar_LastPosY = posY;
};

func void StaminaBar_UpdatePosition () {
	var int posX; var int posY;

	//If modder didn't define their own values - use default position
	if (_PC_SprintModeBar_PPosX == -1) {
		posX = PS_VMax / 2;
	} else {
		posX = Print_ToVirtual (_PC_SprintModeBar_PPosX, PS_X);
	};

	if (_PC_SprintModeBar_PPosY == -1) {
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

	//Bar_MoveTo is extremely performance heavy - do not call if position didn't change
	var int _staminaBar_LastPosX;
	var int _staminaBar_LastPosY;

	if ((posX != _staminaBar_LastPosX) || (posY != _staminaBar_LastPosY)) {
		Bar_MoveTo (hStaminaBar, posX, posY);
	};

	//Move bar values
	var int targetPosX; var int targetPosY;

	if (_staminaBar_DisplayValueOffsetX == 0) {
		targetPosX = vStaminaBarBackTexView.vposX;
	} else {
		targetPosX = vStaminaBarBackTexView.vposX + Print_ToVirtual (_staminaBar_DisplayValueOffsetX, PS_X);
	};

	if (_staminaBar_DisplayValueOffsetY == 0) {
		targetPosY = vStaminaBarBackTexView.vposY;
	} else {
		var int fontHeight; fontHeight = Print_GetFontHeight (_betterBars_Font);

		if (_staminaBar_DisplayValueOffsetY > 0) {
			targetPosY = vStaminaBarBackTexView.vposY + Print_ToVirtual (fontHeight + _staminaBar_DisplayValueOffsetY, PS_Y);
		} else {
			targetPosY = vStaminaBarBackTexView.vposY - Print_ToVirtual (fontHeight - _staminaBar_DisplayValueOffsetY, PS_Y);
		};
	};

	var int widthDiff; widthDiff = (vStaminaBarValueView.psizeX - vStaminaBarBackTexView.psizeX) / 2;
	if (widthDiff != 0) {
		targetPosX -= Print_ToVirtual (widthDiff, PS_X);
	};

	if ((vStaminaBarValueView.vposX != targetPosX) || (vStaminaBarValueView.vposY != targetPosY)) {
		View_MoveTo_Safe (hStaminaBarValueView, targetPosX, targetPosY);
	};

	_staminaBar_LastPosX = posX; _staminaBar_LastPosY = posY;
};

/*
 *	BBar_SetAlpha
 *	 - wrapper function that updates also additional views
 */
func void BBar_SetAlpha (var int hBar, var int alpha) {
	if(!Hlp_IsValidHandle(hBar)) { return; };

	Bar_SetAlpha (hBar, alpha);

	if (hBar == hHealthBar) {
		View_SetAlphaAll (hHealthBarValueView, alpha);
		return;
	};

	if (hBar == hStaminaBar) {
		View_SetAlphaAll (hStaminaBarValueView, alpha);
		return;
	};

	if (hBar == hFocusBar) {
		View_SetAlphaAll (hFocusBarValueView, alpha);
		return;
	};

	if (hBar == hManaBar) {
		View_SetAlphaAll (hManaBarValueView, alpha);
		return;
	};

	if (hBar == hSwimBar) {
		View_SetAlphaAll (hSwimBarValueView, alpha);
		return;
	};
};

/*
 *	BBar_SetAlphaBackAndBar
 *	 - wrapper function that updates also additional views
 */
func void BBar_SetAlphaBackAndBar (var int hBar, var int alphaBack, var int alphaBar) {
	if(!Hlp_IsValidHandle(hBar)) { return; };

	Bar_SetAlphaBackAndBar (hbar, alphaBack, alphaBar);

	if (hBar == hStaminaBar) {
		if (alphaBack > -1) {
			View_SetAlphaAll (hStaminaBarValueView, alphaBack);
		};

		return;
	};
};

/*
 *	BBar_Hide
 *	 - wrapper function that closes also additional views
 */
func void BBar_Hide (var int hBar) {
	if(!Hlp_IsValidHandle(hBar)) { return; };

	if (hbar == hHealthBar) {
		View_Close_Safe(bHealthBar.v0);
		View_Close_Safe(bHealthBar.v1);
		bHealthBar.hidden = TRUE;

		View_Close_Safe (hHealthBarValueView);
		View_Close_Safe (hHealthPreviewView);
	};

	if (hbar == hStaminaBar) {
		View_Close_Safe(bStaminaBar.v0);
		View_Close_Safe(bStaminaBar.v1);
		bStaminaBar.hidden = TRUE;

		View_Close_Safe (hStaminaBarValueView);
	};

	if (hbar == hManaBar) {
		View_Close_Safe(bManaBar.v0);
		View_Close_Safe(bManaBar.v1);
		bManaBar.hidden = TRUE;

		View_Close_Safe (hManaBarValueView);
		View_Close_Safe (hManaPreviewView);
	};

	if (hbar == hSwimBar) {
		View_Close_Safe(bSwimBar.v0);
		View_Close_Safe(bSwimBar.v1);
		bSwimBar.hidden = TRUE;

		View_Close_Safe (hSwimBarValueView);
	};

	if (hbar == hFocusBar) {
		View_Close_Safe(bFocusBar.v0);
		View_Close_Safe(bFocusBar.v1);
		bFocusBar.hidden = TRUE;

		View_Close_Safe (hFocusBarValueView);
	};
};

/*
 *	BBar_Show
 *	 - wrapper function that opens / re-arranges also additional views
 */
func void BBar_Show (var int hBar) {
	if(!Hlp_IsValidHandle(hBar)) { return; };

	if (hbar == hHealthBar) {
		View_Open_Safe (bHealthBar.v0);

		if (_healthBar_PreviewVisible)
		{
			View_Open_Safe (hHealthPreviewView);
		};

		View_Open_Safe (bHealthBar.v1);

		View_Top (bHealthBar.v0);

		if (_healthBar_PreviewVisible)
		{
			View_Top (hHealthPreviewView);
		};

		View_Top (bHealthBar.v1);
		if (_healthBar_DisplayValues)
		{
			View_Open_Safe (hHealthBarValueView);
			View_Top (hHealthBarValueView);
		};

		bHealthBar.hidden = FALSE;
		HealthBar_UpdatePosition ();
	};

	if (hbar == hStaminaBar) {
		View_Open_Safe (bStaminaBar.v0);
		View_Open_Safe (bStaminaBar.v1);

		View_Top (bStaminaBar.v0);
		View_Top (bStaminaBar.v1);

		if (_staminaBar_DisplayValues)
		{
			View_Open_Safe (hStaminaBarValueView);
			View_Open_Safe (hStaminaBarValueView);
		};

		bStaminaBar.hidden = FALSE;
		StaminaBar_UpdatePosition ();
	};

	if (hbar == hManaBar) {
		View_Open_Safe (bManaBar.v0);

		if (_manaBar_PreviewVisible)
		{
			View_Open_Safe (hManaPreviewView);
		};

		View_Open_Safe (bManaBar.v1);

		View_Top (bManaBar.v0);

		if (_manaBar_PreviewVisible)
		{
			View_Top (hManaPreviewView);
		};

		View_Top (bManaBar.v1);

		if (_manaBar_DisplayValues)
		{
			View_Open_Safe (hManaBarValueView);
			View_Top (hManaBarValueView);
		};

		bManaBar.hidden = FALSE;
		ManaBar_UpdatePosition ();
	};

	if (hbar == hSwimBar) {
		View_Open_Safe (bSwimBar.v0);
		View_Open_Safe (bSwimBar.v1);

		View_Top (bSwimBar.v0);
		View_Top (bSwimBar.v1);

		if (_swimBar_DisplayValues)
		{
			View_Open_Safe (hSwimBarValueView);
			View_Top (hSwimBarValueView);
		};

		bSwimBar.hidden = FALSE;
		SwimBar_UpdatePosition ();
	};

	if (hbar == hFocusBar) {
		View_Open_Safe (bFocusBar.v0);
		View_Open_Safe (bFocusBar.v1);

		View_Top (bFocusBar.v0);
		View_Top (bFocusBar.v1);

		if (_focusBar_DisplayValues)
		{
			View_Open_Safe (hFocusBarValueView);
			View_Top (hFocusBarValueView);
		};

		bFocusBar.hidden = FALSE;
		FocusBar_UpdatePosition ();
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
			View_Close_Safe (hHealthBarValueView);
			View_Close_Safe (hHealthPreviewView);
			View_Close_Safe (hManaBarValueView);
			View_Close_Safe (hManaPreviewView);
			View_Close_Safe (hSwimBarValueView);
			View_Close_Safe (hFocusBarValueView);
			//View_Close_Safe (hStaminaPreviewView);
			View_Close_Safe (hStaminaBarValueView);
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
