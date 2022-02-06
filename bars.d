const int BarType_HealthBar = 0;
const int BarType_ManaBar = 1;
const int BarType_Swimbar = 2;
const int BarType_SprintBar = 3;

const int BarDisplay_Standard = 0;
const int BarDisplay_DynamicUpdate = 1;
const int BarDisplay_AlwaysOn = 2;

/*
 *
 */
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
func int BarGetOnDesk (var int barType) {
	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
	var oCViewStatusBar manaBar; manaBar = _^ (MEM_Game.manaBar);

	//Health bar
	if (barType == BarType_HealthBar)
	//Sprint bar will have by default same behaviour as health bar
	|| (barType == BarType_SprintBar)
	{
		//If in 'standard display' - use original bar zCView_ondesk attribute to figure out whether it should be on desk or not
		if (healthBarDisplayMethod == BarDisplay_Standard) {
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
 *
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

func void Bar_Top (var int bar) {
	if(!Hlp_IsValidHandle(bar)) { return; };
	var _bar b; b = get(bar);
	View_Top(b.v0);
	View_Top(b.v1);
};

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
 *
 */
func void G12_InitDefaultBarFunctions () {
	G12_OpenInventoryEvent_Init ();
	G12_CloseInventoryEvent_Init ();

	OpenInventoryEvent_AddListener (_eventOpenInventory__BetterBars);
	CloseInventoryEvent_AddListener (_eventCloseInventory__BetterBars);
};
