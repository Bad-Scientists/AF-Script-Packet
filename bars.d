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
var int vHealthPreview;			//handle for HP bar preview (view)

var int healthBarPreviewVisible;
var int healthBarPreviewAlpha;
var int healthBarPreviewFlashingFadeOut;
var int healthBarPreviewEffect;

var int healthBarLastValue;
var int healthBarDisplayMethod;
var int healthBarDisplayTime;
var int healthBarForceOnDesk;

// MANA BAR

var int hManaBar;			//handle for Mana bar
var int vManaPreview;			//handle for Mana bar preview (view)

var int manaBarPreviewVisible;
var int manaBarPreviewAlpha;
var int manaBarPreviewFlashingFadeOut;
var int manaBarPreviewEffect;

var int manaBarLastValue;
var int manaBarDisplayMethod;
var int manaBarDisplayTime;
var int manaBarForceOnDesk;

// SPRINT BAR

var int hStaminaBar;			//handle for Stamina bar

var int sprintBarLastValue;
var int sprintBarDisplayMethod;
var int sprintBarDisplayTime;
var int sprintBarForceOnDesk;

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
		if (v.alpha != 255) {
			View_SetAlpha (vHnd, v.alpha);
		};

		//Re-arrange views - first background texture view, second 'preview' view and finally bar texture view
		View_Top(b.v0);
		View_Top(vHnd);
		View_Top(b.v1);
	} else {
		View_Close (vHnd);
	};
};

/*
 *	Update display method (in-game)
 */
func void HealthBar_SetDisplayMethod (var int displayMethod) {
	healthBarDisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "healthBarDisplayMethod", IntToString (healthBarDisplayMethod));
};

func void ManaBar_SetDisplayMethod (var int displayMethod) {
	manaBarDisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "manaBarDisplayMethod", IntToString (manaBarDisplayMethod));
};

func void SprintBar_SetDisplayMethod (var int displayMethod) {
	sprintBarDisplayMethod = displayMethod;
	MEM_SetGothOpt ("GAME", "sprintBarDisplayMethod", IntToString (sprintBarDisplayMethod));
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
