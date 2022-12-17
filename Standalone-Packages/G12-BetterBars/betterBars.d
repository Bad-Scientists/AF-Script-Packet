/*
 *	Requires another package from AFSP: G12-InvItemPreview
 *
 *	This feature 'replaces' original Gothic health and mana bars with LeGo bars (with LeGo bars we can control textures, alpha values and when bars will be displayed)
 *	By default this feature adds 4 visualisation options for new bars:
 *	 - standard (same as in vanilla Gothic)
 *	 - dynamic:
 *	    - health bar is visible: if player is hurt (and his health is below specified percentage), in fight mode, in inventory, when health changes
 *	    - mana bar is visible: in magic fight mode, in inventory, when mana changes
 *	 - always on
 *	 - only in inventory
 *
 *	In combination with G12-InvItemPreview it also adds health & mana bar preview - additional texture which indicates how much health/mana item in inventory will recover
 */

//-- Internal variables
var string _tex_BarPreview_HealthBar;
var string _tex_BarPreview_ManaBar;

var int _healthBar_DisplayWhenHurt_Percentage;

/*
 *	Function that will update texture of health bar (using original Gothic health bar texture!)
 */
func void HealthBar_UpdateTexture () {
	if (Hlp_IsValidHandle (hHealthBar)) {
		var oCViewStatusBar hpBar;
		hpBar = _^ (MEM_Game.hpBar);
		Bar_SetBarTexture (hHealthBar, hpBar.texValue);
		//Bar_SetBarTexture (hHealthBar, ViewPtr_GetTexture (hpBar.value_bar));
	};
};

func void FrameFunction_FadeInOutHealthBar__BetterBars () {
	//If this method returns true - then bar should be 100% visible
	if (BarGetOnDesk (BarType_HealthBar, healthBarDisplayMethod)) {
		Bar_SetAlpha (hHealthBar, 255);
		return;
	};

	//If we somehow ended up here with bar display method inventory ... then remove display time
	if (healthBarDisplayMethod == BarDisplay_OnlyInInventory) {
		healthBarDisplayTime = 0;
	};

	//If we run out of display time - hide bar
	if (!healthBarDisplayTime) {
		Bar_Hide (hHealthBar);

		FF_Remove (FrameFunction_FadeInOutHealthBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (!Bar_IsVisible (hHealthBar)) {
		//Show it only if allowed by game itself
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hHealthBar);
		};
	};

	//If bar is visible (this is not redundant condition, _Bar_PlayerStatus might return FALSE)
	if (Bar_IsVisible (hHealthBar)) {
		//Decrease display time
		healthBarDisplayTime -= 1;

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alpha;

		//Fade in
		if (healthBarDisplayTime > 80) {
			alpha = roundf (mulf (mkf (255), divf (mkf (120 - healthBarDisplayTime), mkf (40))));
		} else
		//Display
		if (healthBarDisplayTime > 40) {
			alpha = 255;
		} else {
		//Fade out
			alpha = 255 - roundf (mulf (mkf (255), divf (mkf (40 - healthBarDisplayTime), mkf (40))));
		};

		//Check boundaries min/max and set alpha
		alpha = clamp (alpha, 0, 255);
		Bar_SetAlpha (hHealthBar, alpha);
	};
};

func void FrameFunction_FadeInOutManaBar__BetterBars () {
	//If this method returns true - then bar should be 100% visible
	if (BarGetOnDesk (BarType_ManaBar, manaBarDisplayMethod)) {
		Bar_SetAlpha (hManaBar, 255);
		return;
	};

	//If we somehow ended up here with bar display method inventory ... then remove display time
	if (manaBarDisplayMethod == BarDisplay_OnlyInInventory) {
		manaBarDisplayTime = 0;
	};

	//If we run out of display time - hide bar
	if (!manaBarDisplayTime) {
		Bar_Hide (hManaBar);

		FF_Remove (FrameFunction_FadeInOutManaBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (!Bar_IsVisible (hManaBar)) {
		//Show it only if allowed by game itself
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hManaBar);
		};
	};

	//If bar is visible (this is not redundant condition, _Bar_PlayerStatus might return FALSE)
	if (Bar_IsVisible (hManaBar)) {
		//Decrease display time
		manaBarDisplayTime -= 1;

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alpha;

		//Fade in
		if (manaBarDisplayTime > 80) {
			alpha = roundf (mulf (mkf (255), divf (mkf (120 - manaBarDisplayTime), mkf (40))));
		} else
		//Display
		if (manaBarDisplayTime > 40) {
			alpha = 255;
		} else {
		//Fade out
			alpha = 255 - roundf (mulf (mkf (255), divf (mkf (40 - manaBarDisplayTime), mkf (40))));
		};

		//Check boundaries min/max and set alpha
		alpha = clamp (alpha, 0, 255);
		Bar_SetAlpha (hManaBar, alpha);
	};
};

func void FrameFunction_FlashPreviewBars__BetterBars () {
	if ((!healthBarPreviewVisible) && (!manaBarPreviewVisible)) {
		View_SetAlpha (vHealthPreview, 255);
		View_SetAlpha (vManaPreview, 255);
		FF_Remove (FrameFunction_FlashPreviewBars__BetterBars);
		return;
	};

	if ((healthBarPreviewVisible) && (healthBarPreviewEffect == BarPreviewEffect_FadeInOut)) {
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

	if ((manaBarPreviewVisible) && (manaBarPreviewEffect == BarPreviewEffect_FadeInOut)) {
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
		//0 - standard, 1 - dynamic update, 2 - always on
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
	var int healthBarOnDesk; healthBarOnDesk = BarGetOnDesk (BarType_HealthBar, healthBarDisplayMethod);
	var int manaBarOnDesk; manaBarOnDesk = BarGetOnDesk (BarType_ManaBar, manaBarDisplayMethod);

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
		vHealthPreview = Bar_CreatePreview (hHealthBar, _tex_BarPreview_HealthBar);
		View_SetAlpha (vHealthPreview, 255);
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

	var int hurtPercentage;
	if (_healthBar_DisplayWhenHurt_Percentage > 0) {
		hurtPercentage = divf (mkf (hero.attribute [ATR_HITPOINTS]), mkf (hero.attribute [ATR_HITPOINTS_MAX]));
		hurtPercentage = mulf (hurtPercentage, mkf (100));
		hurtPercentage = roundf (hurtPercentage);
	};

	//Display only in inventory ...
	if ((healthBarDisplayMethod == BarDisplay_OnlyInInventory) && (!healthBarOnDesk) && (!healthBarForceOnDesk)) {
		//... don't do anything :)
	} else
	if ((healthBarForceOnDesk) || (healthBarLastValue != hero.attribute [ATR_HITPOINTS]) || (oCGame_GetHeroStatus ()) || (!Npc_IsInFightMode (hero, FMODE_NONE)) || ((hurtPercentage <= _healthBar_DisplayWhenHurt_Percentage) && (_healthBar_DisplayWhenHurt_Percentage > 0)))
	{
		healthBarLastValue = hero.attribute [ATR_HITPOINTS];

		//
		if ((healthBarDisplayMethod != BarDisplay_AlwaysOn) && (!healthBarOnDesk)) {
			if (healthBarDisplayMethod == BarDisplay_DynamicUpdate) {
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

	if ((healthBarDisplayMethod == BarDisplay_AlwaysOn) || (healthBarOnDesk) || (healthBarDisplayTime)) {
		if (!Bar_IsVisible (hHealthBar)) {
			if (_Bar_PlayerStatus ()) {
				Bar_SetAlpha (hHealthBar, 0);

				if ((healthBarDisplayMethod == BarDisplay_AlwaysOn) || (healthBarOnDesk)) {
					if (!healthBarDisplayTime) {
						Bar_SetAlpha (hHealthBar, 255);
					};
				};

				Bar_Show (hHealthBar);
			};
		};
	};

	if ((healthBarDisplayMethod != BarDisplay_AlwaysOn) && (!healthBarOnDesk) && (!healthBarDisplayTime))
	|| ((healthBarDisplayMethod == BarDisplay_OnlyInInventory) && (!healthBarOnDesk))
	{
		if (Bar_IsVisible (hHealthBar)) {
			if (_Bar_PlayerStatus ()) {
				Bar_Hide (hHealthBar);
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

		if (!manaBarOnDesk) {
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
		vManaPreview = Bar_CreatePreview (hManaBar, _tex_BarPreview_ManaBar);
		View_SetAlpha (vManaPreview, 255);
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

	//Display only in inventory ...
	if ((manaBarDisplayMethod == BarDisplay_OnlyInInventory) && (!manaBarOnDesk) && (!manaBarForceOnDesk)) {
		//... don't do anything :)
	} else
	if ((manaBarForceOnDesk) || (manaBarLastValue != hero.attribute [ATR_MANA])) {
		manaBarLastValue = hero.attribute [ATR_MANA];

		//
		if ((!(manaBarDisplayMethod == BarDisplay_AlwaysOn)) && (!manaBarOnDesk)) {
			if (manaBarDisplayMethod == BarDisplay_DynamicUpdate) {
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

	if ((manaBarDisplayMethod == BarDisplay_AlwaysOn) || (manaBarOnDesk) || (manaBarDisplayTime))
	{
		if (!Bar_IsVisible (hManaBar)) {
			if (_Bar_PlayerStatus ()) {
				Bar_SetAlpha (hManaBar, 0);

				if ((manaBarDisplayMethod == BarDisplay_AlwaysOn) || (manaBarOnDesk)) {
					if (!manaBarDisplayTime) {
						Bar_SetAlpha (hManaBar, 255);
					};
				};

				Bar_Show (hManaBar);
			};
		};
	};

	if ((!(manaBarDisplayMethod == BarDisplay_AlwaysOn)) && (!manaBarOnDesk) && (!manaBarDisplayTime))
	|| ((manaBarDisplayMethod == BarDisplay_OnlyInInventory) && (!manaBarOnDesk))
	{
		if (Bar_IsVisible (hManaBar)) {
			if (_Bar_PlayerStatus ()) {
				Bar_Hide (hManaBar);
			};
		};
	};

	Bar_PreviewSetValue (hManaBar, vManaPreview, previewValueManaBar);

//When I tried to change alpha of Gothic bar I was not able to do so
	//View_SetAlpha (hpBarAddress, 0);
	//View_SetAlpha (hpBar.range_bar, 0);
	//View_SetAlpha (hpBar.value_bar, 0);

//I was also not able to remove Gothic bar
	//ViewStatusBar_Remove (hpBarAddress);

//Only option which was possible - moving original Gothic bars outside of screen
	hpBar.zCView_vposy = 8192 * 2;
	manaBar.zCView_vposy = 8192 * 2;
};

func void G12_BetterBars_Init () {
	G12_InvItemPreview_Init ();

	G12_InitDefaultBarFunctions ();

	//-- Load API values / init default values

	_tex_BarPreview_HealthBar = API_GetSymbolStringValue ("TEXTURE_BARPREVIEW_HEALTBAR", "BAR_HEALTH_PREVIEW.TGA");
	_tex_BarPreview_ManaBar = API_GetSymbolStringValue ("TEXTURE_BARPREVIEW_MANABAR", "BAR_MANA_PREVIEW.TGA");

	_healthBar_DisplayWhenHurt_Percentage = API_GetSymbolIntValue ("HEALTHBAR_DISPLAYWHENHURT_PERCENTAGE", 50);

	//--

	FF_ApplyOnceExtGT (FrameFunction_EachFrame__BetterBars, 0, -1);
};
