/*
 *	Requires another package from AFSP: G12-InvItemPreview
 *
 *	This feature 
 */
const int BarType_HealthBar = 0;
const int BarType_ManaBar = 1;

const int BarDisplay_Standard = 0;
const int BarDisplay_DynamicUpdate = 1;
const int BarDisplay_AlwaysOn = 2;

//---

var int hHealthBar;			//handle for HP bar
var int vHealthPreview;			//handle for HP bar preview (view)

var int healthBarPreviewVisible;
var int healthBarPreviewAlpha;
var int healthBarPreviewFlashingFadeOut;

var int healthBarLastValue;

var int healthBarDisplayMethod;

var int healthBarIsVisible;

var int healthBarDisplayTime;
var int healthBarAlpha;

//---

var int hManaBar;			//handle for Mana bar
var int vManaPreview;			//handle for Mana bar preview (view)

var int manaBarPreviewVisible;
var int manaBarPreviewAlpha;
var int manaBarPreviewFlashingFadeOut;

var int manaBarLastValue;

var int manaBarDisplayMethod;

var int manaBarIsVisible;

var int manaBarDisplayTime;
var int manaBarAlpha;

//---

var int InventoryOpened__BetterBars;

func void _eventOpenInventory__BetterBars () {
	InventoryOpened__BetterBars = TRUE;
};

func void _eventCloseInventory__BetterBars () {
	InventoryOpened__BetterBars = FALSE;
};

/*
 *	Function wrapper - that tells us whether bar should be on desk or not
 *	Returns TRUE if bar should be displayed, FALSE if not
 */
func int BarGetOnDesk (var int barType) {
	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
	var oCViewStatusBar manaBar; manaBar = _^ (MEM_Game.manaBar);

	//Health bar
	if (barType == BarType_HealthBar) {
		//If in 'standard display' - use original bar zCView_ondesk attribute to figure out whether it should be on desk or not
		if (healthBarDisplayMethod & BarDisplay_Standard) {
			if (hpBar.zCView_ondesk) {
				return TRUE;
			};
		};

		//If mana bar is visible - then health bar should also be visible
		if (manaBar.zCView_ondesk) {
			return TRUE;
		};

		//If inventory is opened
		if (InventoryOpened__BetterBars) {
			return TRUE;
		};
	};

	//Mana bar - use original bar zCView_ondesk attribute to figure out whether it should be on desk or not
	if (barType == BarType_ManaBar) {
		if (manaBar.zCView_ondesk) {
			return TRUE;
		};

		//If inventory is opened
		if (InventoryOpened__BetterBars) {
			return TRUE;
		};
	};

	return FALSE;
};


func void FrameFunction_FadeInOutHealthBar__BetterBars () {
	if (BarGetOnDesk (BarType_HealthBar)) {
		Bar_SetAlpha (hHealthBar, 255);
		return;
	};

	if (!healthBarDisplayTime) {
		Bar_Hide (hHealthBar);

		FF_Remove (FrameFunction_FadeInOutHealthBar__BetterBars);
		return;
	};

	if (!healthBarIsVisible) {
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hHealthBar);
			healthBarIsVisible = TRUE;
		};
	};

	if (healthBarIsVisible) {
		healthBarDisplayTime -= 1;

		if (healthBarDisplayTime > 80) {
			healthBarAlpha = roundf (mulf (mkf (255), divf (mkf (120 - healthBarDisplayTime), mkf (40))));
		} else
		if (healthBarDisplayTime > 40) {
			healthBarAlpha = 255;
		} else {
			healthBarAlpha = 255 - roundf (mulf (mkf (255), divf (mkf (40 - healthBarDisplayTime), mkf (40))));
		};

		if (healthBarAlpha < 0) { healthBarAlpha = 0; };

		Bar_SetAlpha (hHealthBar, healthBarAlpha);
	};
};

func void FrameFunction_FadeInOutManaBar__BetterBars () {
	if (BarGetOnDesk (BarType_ManaBar)) {
		Bar_SetAlpha (hManaBar, 255);
		return;
	};

	if (!manaBarDisplayTime) {
		Bar_Hide (hManaBar);

		FF_Remove (FrameFunction_FadeInOutManaBar__BetterBars);
		return;
	};

	if (!manaBarIsVisible) {
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hManaBar);
			manaBarIsVisible = TRUE;
		};
	};

	if (manaBarIsVisible) {
		manaBarDisplayTime -= 1;

		if (manaBarDisplayTime > 80) {
			manaBarAlpha = roundf (mulf (mkf (255), divf (mkf (120 - manaBarDisplayTime), mkf (40))));
		} else
		if (manaBarDisplayTime > 40) {
			manaBarAlpha = 255;
		} else {
			manaBarAlpha = 255 - roundf (mulf (mkf (255), divf (mkf (40 - manaBarDisplayTime), mkf (40))));
		};

		if (manaBarAlpha < 0) { manaBarAlpha = 0; };

		Bar_SetAlpha (hManaBar, manaBarAlpha);
	};
};

func void FrameFunction_FlashPreviewBars__BetterBars () {
	if ((!healthBarPreviewVisible) && (!manaBarPreviewVisible)) {
		View_SetAlpha (vHealthPreview, 255);
		View_SetAlpha (vManaPreview, 255);
		FF_Remove (FrameFunction_FlashPreviewBars__BetterBars);
		return;
	};

	if (healthBarPreviewVisible) {
		if (Hlp_IsValidHandle (vHealthPreview)) {

			if (healthBarPreviewFlashingFadeOut) {
				healthBarPreviewAlpha -= 32;
			} else {
				healthBarPreviewAlpha += 32;
			};
			
			if (healthBarPreviewAlpha < 0) {
				healthBarPreviewAlpha = 0;
				healthBarPreviewFlashingFadeOut = (!healthBarPreviewFlashingFadeOut);
			};

			if (healthBarPreviewAlpha > 255) {
				healthBarPreviewAlpha = 255;
				healthBarPreviewFlashingFadeOut = (!healthBarPreviewFlashingFadeOut);
			};
			
			//
			View_SetAlpha (vHealthPreview, healthBarPreviewAlpha);
		};
	};

	if (manaBarPreviewVisible) {
		if (Hlp_IsValidHandle (vManaPreview)) {

			if (manaBarPreviewFlashingFadeOut) {
				manaBarPreviewAlpha -= 32;
			} else {
				manaBarPreviewAlpha += 32;
			};
			
			if (manaBarPreviewAlpha < 0) {
				manaBarPreviewAlpha = 0;
				manaBarPreviewFlashingFadeOut = (!manaBarPreviewFlashingFadeOut);
			};

			if (manaBarPreviewAlpha > 255) {
				manaBarPreviewAlpha = 255;
				manaBarPreviewFlashingFadeOut = (!manaBarPreviewFlashingFadeOut);
			};
			
			//
			View_SetAlpha (vManaPreview, manaBarPreviewAlpha);
		};
	};
};

func void FrameFunction_EachFrame__BetterBars () {
	var oCViewStatusBar hpBar;
	var oCViewStatusBar manaBar;
	//var oCViewStatusBar swimBar;
	//var oCViewStatusBar focusBar;

	//Custom setup from Gothic.ini
	if (MEM_GothOptExists ("GAME", "healthBarDisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - alwas on
		healthBarDisplayMethod = STR_ToInt (MEM_GetGothOpt ("GAME", "healthBarDisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("GAME", "healthBarDisplayMethod")) {
			healthBarDisplayMethod = STR_ToInt (MEM_GetModOpt ("GAME", "healthBarDisplayMethod"));
			MEM_SetGothOpt ("GAME", "healthBarDisplayMethod", IntToString (healthBarDisplayMethod));
		} else {
			//Default
			healthBarDisplayMethod = BarDisplay_DynamicUpdate;
			MEM_SetGothOpt ("GAME", "healthBarDisplayMethod", IntToString (healthBarDisplayMethod));
		};
	};

	if (MEM_GothOptExists ("GAME", "manaBarDisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - alwas on
		manaBarDisplayMethod = STR_ToInt (MEM_GetGothOpt ("GAME", "manaBarDisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("GAME", "manaBarDisplayMethod")) {
			manaBarDisplayMethod = STR_ToInt (MEM_GetModOpt ("GAME", "manaBarDisplayMethod"));
			MEM_SetGothOpt ("GAME", "manaBarDisplayMethod", IntToString (manaBarDisplayMethod));
		} else {
			//Default
			manaBarDisplayMethod = BarDisplay_DynamicUpdate;
			MEM_SetGothOpt ("GAME", "manaBarDisplayMethod", IntToString (manaBarDisplayMethod));
		};
	};

//--
	var int healthBarOnDesk; healthBarOnDesk = BarGetOnDesk (BarType_HealthBar);
	var int manaBarOnDesk; manaBarOnDesk = BarGetOnDesk (BarType_ManaBar);

//-- Health bar

	hpBar = _^ (MEM_Game.hpBar);

	//Create health bar
	if (!Hlp_IsValidHandle(hHealthBar)) {
		hHealthBar = Bar_Create (GothicBar@);

		//Initialize texture
		Bar_SetBarTexture (hHealthBar, hpBar.texValue);
		Bar_MoveTo (hHealthBar, hpBar.zCView_vposx + (hpBar.zCView_vsizex / 2), hpBar.zCView_vposy + (hpBar.zCView_vsizey / 2));
	};

	Bar_SetMax (hHealthBar, hero.attribute [ATR_HITPOINTS_MAX]);
	Bar_SetValueSafe (hHealthBar, hero.attribute [ATR_HITPOINTS]);

	//vHealthPreview is View created by Bar_Preview
	var int previewValueHealthBar;
	if (PC_ItemPreviewHealth > 0) {
		previewValueHealthBar = hero.attribute [ATR_HITPOINTS] + PC_ItemPreviewHealth;
		if (previewValueHealthBar > hero.attribute [ATR_HITPOINTS_MAX]) {
			previewValueHealthBar = hero.attribute [ATR_HITPOINTS_MAX];
		};
	} else {
		previewValueHealthBar = 0;
	};

	if (!Hlp_IsValidHandle (vHealthPreview)) {
		vHealthPreview = Bar_CreatePreview (hHealthBar, "Bar_Health_Preview.tga");
	};

	//
	if (PC_ItemPreviewHealth) {
		if (!healthBarPreviewVisible) {
			//Add frame function (16/1s)
			FF_ApplyOnceExtGT (FrameFunction_FlashPreviewBars__BetterBars, 60, -1);
			healthBarPreviewVisible = TRUE;
			healthBarPreviewAlpha = 255;
			healthBarPreviewFlashingFadeOut = TRUE;
		};
	} else {
		healthBarPreviewVisible = FALSE;
	};

//-- Auto hiding/display for health bar (when updated)

	if ((healthBarLastValue != hero.attribute [ATR_HITPOINTS]) || (oCGame_GetHeroStatus ()) || (!Npc_IsInFightMode (hero, FMODE_NONE)) || (hero.attribute [ATR_HITPOINTS] != hero.attribute [ATR_HITPOINTS_MAX])) {
		healthBarLastValue = hero.attribute [ATR_HITPOINTS];

		//
		if ((!(healthBarDisplayMethod & BarDisplay_AlwaysOn)) && (!healthBarOnDesk)) {
			if (healthBarDisplayMethod & BarDisplay_DynamicUpdate) {
				if (!healthBarDisplayTime) {
					healthBarDisplayTime = 120;
				} else
				if (healthBarDisplayTime < 80) {
					healthBarDisplayTime = 80;
				};
			};
		};

		if (healthBarDisplayTime < 80) {
			healthBarDisplayTime = 80;
		};

		FF_ApplyOnceExtGT (FrameFunction_FadeInOutHealthBar__BetterBars, 60, -1);
	};

	if ((healthBarDisplayMethod & BarDisplay_AlwaysOn) || (healthBarOnDesk) || (healthBarDisplayTime)) {
		if (!healthBarIsVisible) {
			if (_Bar_PlayerStatus ()) {
				Bar_SetAlpha (hHealthBar, 0);

				if ((healthBarDisplayMethod & BarDisplay_AlwaysOn) || (healthBarOnDesk)) {
					if (!healthBarDisplayTime) {
						Bar_SetAlpha (hHealthBar, 255);
					};
				};

				Bar_Show (hHealthBar);
				healthBarIsVisible = TRUE;
			};
		};
	};

	if ((!(healthBarDisplayMethod & BarDisplay_AlwaysOn)) && (!healthBarOnDesk) && (!healthBarDisplayTime)) {
		if (healthBarIsVisible) {
			if (_Bar_PlayerStatus ()) {
				Bar_Hide (hHealthBar);
				healthBarIsVisible = FALSE;
			};
		};
	};

	Bar_PreviewSetValue (hHealthBar, vHealthPreview, previewValueHealthBar);

//-- Mana Bar

	manaBar = _^ (MEM_Game.manaBar);

	//Create mana bar
	if (!Hlp_IsValidHandle(hManaBar)) {
		hManaBar = Bar_Create (GothicBar@);

		//Initialize texture
		Bar_SetBarTexture (hManaBar, manaBar.texValue);
		Bar_MoveTo (hManaBar, manaBar.zCView_vposx + (manaBar.zCView_vsizex / 2), manaBar.zCView_vposy + (manaBar.zCView_vsizey / 2));

		manaBarIsVisible = manaBarOnDesk;
		if (!manaBarIsVisible) {
			Bar_Hide (hManaBar);
		};

		manaBarLastValue = hero.attribute [ATR_MANA];
	};

	Bar_SetMax (hManaBar, hero.attribute [ATR_MANA_MAX]);
	Bar_SetValueSafe (hManaBar, hero.attribute [ATR_MANA]);

	//vHealthPreview is View created by Bar_Preview
	var int previewValueManaBar;
	if (PC_ItemPreviewMana > 0) {
		previewValueManaBar = hero.attribute [ATR_MANA] + PC_ItemPreviewMana;
		if (previewValueManaBar > hero.attribute [ATR_MANA_MAX]) {
			previewValueManaBar = hero.attribute [ATR_MANA_MAX];
		};
	} else {
		previewValueManaBar = 0;
	};

	if (!Hlp_IsValidHandle (vManaPreview)) {
		vManaPreview = Bar_CreatePreview (hManaBar, "Bar_Mana_Preview.tga");
	};

	//
	if (PC_ItemPreviewMana) {
		if (!manaBarPreviewVisible) {
			//Add frame function (8/1s)
			FF_ApplyOnceExtGT (FrameFunction_FlashPreviewBars__BetterBars, 60, -1);
			manaBarPreviewVisible = TRUE;
			manaBarPreviewAlpha = 255;
			manaBarPreviewFlashingFadeOut = TRUE;
		};
	} else {
		manaBarPreviewVisible = FALSE;
	};

//-- Auto hiding/display for mana bar (when updated)

	if (manaBarLastValue != hero.attribute [ATR_MANA]) {
		manaBarLastValue = hero.attribute [ATR_MANA];

		//
		if ((!(manaBarDisplayMethod & BarDisplay_AlwaysOn)) && (!manaBarOnDesk)) {
			if (manaBarDisplayMethod & BarDisplay_DynamicUpdate) {
				if (!manaBarDisplayTime) {
					manaBarDisplayTime = 120;
				};
			};
		};

		if (manaBarDisplayTime < 80) {
			manaBarDisplayTime = 80;
		};

		FF_ApplyOnceExtGT (FrameFunction_FadeInOutManaBar__BetterBars, 60, -1);
	};

	if ((manaBarDisplayMethod & BarDisplay_AlwaysOn) || (manaBarOnDesk) || (manaBarDisplayTime)) {
		if (!manaBarIsVisible) {
			if (_Bar_PlayerStatus ()) {
				Bar_SetAlpha (hManaBar, 0);

				if ((manaBarDisplayMethod & BarDisplay_AlwaysOn) || (manaBarOnDesk)) {
					if (!manaBarDisplayTime) {
						Bar_SetAlpha (hManaBar, 255);
					};
				};

				Bar_Show (hManaBar);
				manaBarIsVisible = TRUE;
			};
		};
	};

	if ((!(manaBarDisplayMethod & BarDisplay_AlwaysOn)) && (!manaBarOnDesk) && (!manaBarDisplayTime)) {
		if (manaBarIsVisible) {
			if (_Bar_PlayerStatus ()) {
				Bar_Hide (hManaBar);
				manaBarIsVisible = FALSE;
			};
		};
	};

	Bar_PreviewSetValue (hManaBar, vManaPreview, previewValueManaBar);

//Zmenit alpha nepomoze - asi je tu ina funkcia, ktora to updatne po nasej frame funkcii
	//View_SetAlpha (hpBarAddress, 0);
	//View_SetAlpha (hpBar.range_bar, 0);
	//View_SetAlpha (hpBar.value_bar, 0);

//Odstranit sa neda
	//ViewStatusBar_Remove (hpBarAddress);
	
//jedine presun mimo obrazovku nas zbavi originalneho health baru
	hpBar.zCView_vposy = 8192 * 2;
	manaBar.zCView_vposy = 8192 * 2;
};

func void G12_BetterBars_Init () {
	G12_InvItemPreview_Init ();

	G12_OpenInventoryEvent_Init ();
	G12_CloseInventoryEvent_Init ();

	OpenInventoryEvent_AddListener (_eventOpenInventory__BetterBars);
	CloseInventoryEvent_AddListener (_eventCloseInventory__BetterBars);

	FF_ApplyOnceExtGT (FrameFunction_EachFrame__BetterBars, 0, -1);
};
