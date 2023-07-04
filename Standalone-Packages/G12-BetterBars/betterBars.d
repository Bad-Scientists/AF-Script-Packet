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

//--

var int _healthBar_PreviewVisible;
var int _healthBar_PreviewAlpha;

var int _healthBar_DisplayTime;

var int _healthBar_PreviewFlashingFadeOut;

//--

var int _manaBar_PreviewVisible;
var int _manaBar_PreviewAlpha;

var int _manaBar_DisplayTime;

var int _manaBar_PreviewFlashingFadeOut;

//--

var int _healthBar_PPosX;
var int _healthBar_PPosY;

var int _healthBar_VPosX;
var int _healthBar_VPosY;

var int _manaBar_PPosX;
var int _manaBar_PPosY;

var int _manaBar_VPosX;
var int _manaBar_VPosY;

var int _swimBar_PPosX;
var int _swimBar_PPosY;

var int _swimBar_VPosX;
var int _swimBar_VPosY;

var int _focusBar_PPosX;
var int _focusBar_PPosY;

var int _focusBar_VPosX;
var int _focusBar_VPosY;

//--

var string _betterBars_Font;

/*
 *	Function that will update texture of health bar (using original Gothic health bar texture!)
 */
func void HealthBar_UpdateTexture () {
	if (Hlp_IsValidHandle (hHealthBar)) {
		var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
		Bar_SetBarTexture (hHealthBar, hpBar.texValue);
	};
};

func void FocusBar_UpdateTexture () {
	if (Hlp_IsValidHandle (hHealthBar)) {
		var oCViewStatusBar focusBar; focusBar = _^ (MEM_Game.focusBar);
		Bar_SetBarTexture (hFocusBar, focusBar.texValue);
	};
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

func void FrameFunction_FadeInOutHealthBar__BetterBars () {
	//If this method returns true - then bar should be 100% visible
	if (BarGetOnDesk (BarType_HealthBar, _healthBar_DisplayMethod)) {
		BBar_SetAlpha (hHealthBar, 255);
		return;
	};

	//If we somehow ended up here with bar display method inventory ... then remove display time
	if (_healthBar_DisplayMethod == BarDisplay_OnlyInInventory) {
		_healthBar_DisplayTime = 0;
	};

	//If we run out of display time - hide bar
	if (!_healthBar_DisplayTime) {
		Bar_Hide (hHealthBar);

		FF_Remove (FrameFunction_FadeInOutHealthBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (bHealthBar.hidden) {
		//Show it only if allowed by game itself
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hHealthBar);
		};
	};

	//If bar is visible (this is not redundant condition, _Bar_PlayerStatus might return FALSE)
	if (!bHealthBar.hidden) {
		//Decrease display time
		_healthBar_DisplayTime -= 1;

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alpha;

		//Fade in
		if (_healthBar_DisplayTime > 80) {
			alpha = roundf (mulf (mkf (255), divf (mkf (120 - _healthBar_DisplayTime), mkf (40))));
		} else
		//Display
		if (_healthBar_DisplayTime > 40) {
			alpha = 255;
		} else {
		//Fade out
			alpha = 255 - roundf (mulf (mkf (255), divf (mkf (40 - _healthBar_DisplayTime), mkf (40))));
		};

		//Check boundaries min/max and set alpha
		alpha = clamp (alpha, 0, 255);
		BBar_SetAlpha (hHealthBar, alpha);
	};
};

func void FrameFunction_FadeInOutManaBar__BetterBars () {
	//If this method returns true - then bar should be 100% visible
	if (BarGetOnDesk (BarType_ManaBar, _manaBar_DisplayMethod)) {
		BBar_SetAlpha (hManaBar, 255);
		return;
	};

	//If we somehow ended up here with bar display method inventory ... then remove display time
	if (_manaBar_DisplayMethod == BarDisplay_OnlyInInventory) {
		_manaBar_DisplayTime = 0;
	};

	//If we run out of display time - hide bar
	if (!_manaBar_DisplayTime) {
		Bar_Hide (hManaBar);

		FF_Remove (FrameFunction_FadeInOutManaBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (bManaBar.hidden) {
		//Show it only if allowed by game itself
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hManaBar);
		};
	};

	//If bar is visible (this is not redundant condition, _Bar_PlayerStatus might return FALSE)
	if (!bManaBar.hidden) {
		//Decrease display time
		_manaBar_DisplayTime -= 1;

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alpha;

		//Fade in
		if (_manaBar_DisplayTime > 80) {
			alpha = roundf (mulf (mkf (255), divf (mkf (120 - _manaBar_DisplayTime), mkf (40))));
		} else
		//Display
		if (_manaBar_DisplayTime > 40) {
			alpha = 255;
		} else {
		//Fade out
			alpha = 255 - roundf (mulf (mkf (255), divf (mkf (40 - _manaBar_DisplayTime), mkf (40))));
		};

		//Check boundaries min/max and set alpha
		alpha = clamp (alpha, 0, 255);
		BBar_SetAlpha (hManaBar, alpha);
	};
};

func void FrameFunction_FlashPreviewBars__BetterBars () {
	if ((!_healthBar_PreviewVisible) && (!_manaBar_PreviewVisible)) {
		View_SetAlpha (vHealthPreview, 255);
		View_SetAlpha (vManaPreview, 255);
		FF_Remove (FrameFunction_FlashPreviewBars__BetterBars);
		return;
	};

	if ((_healthBar_PreviewVisible) && (_healthBar_PreviewEffect == BarPreviewEffect_FadeInOut)) {
		if (_healthBar_PreviewFlashingFadeOut) {
			_healthBar_PreviewAlpha -= 32;
		} else {
			_healthBar_PreviewAlpha += 32;
		};

		if (_healthBar_PreviewAlpha < 0) {
			_healthBar_PreviewAlpha = 0;
			_healthBar_PreviewFlashingFadeOut = (!_healthBar_PreviewFlashingFadeOut);
		};

		if (_healthBar_PreviewAlpha > 255) {
			_healthBar_PreviewAlpha = 255;
			_healthBar_PreviewFlashingFadeOut = (!_healthBar_PreviewFlashingFadeOut);
		};

		//
		View_SetAlpha (vHealthPreview, _healthBar_PreviewAlpha);
	};

	if ((_manaBar_PreviewVisible) && (_manaBar_PreviewEffect == BarPreviewEffect_FadeInOut)) {
		if (_manaBar_PreviewFlashingFadeOut) {
			_manaBar_PreviewAlpha -= 32;
		} else {
			_manaBar_PreviewAlpha += 32;
		};

		if (_manaBar_PreviewAlpha < 0) {
			_manaBar_PreviewAlpha = 0;
			_manaBar_PreviewFlashingFadeOut = (!_manaBar_PreviewFlashingFadeOut);
		};

		if (_manaBar_PreviewAlpha > 255) {
			_manaBar_PreviewAlpha = 255;
			_manaBar_PreviewFlashingFadeOut = (!_manaBar_PreviewFlashingFadeOut);
		};

		//
		View_SetAlpha (vManaPreview, _manaBar_PreviewAlpha);
	};
};

func void FrameFunction_EachFrame__BetterBars ()
{
	var int _healthBar_LastValue;
	var int _healthBar_LastMaxValue;

	var int _manaBar_LastValue;
	var int _manaBar_LastMaxValue;

	var int _swimBar_LastValue;
	var int _swimBar_LastMaxValue;

	var int _focusBar_LastValue;
	var int _focusBar_LastMaxValue;

	var int healthBarOnDesk; healthBarOnDesk = BarGetOnDesk (BarType_HealthBar, _healthBar_DisplayMethod);
	var int manaBarOnDesk; manaBarOnDesk = BarGetOnDesk (BarType_ManaBar, _manaBar_DisplayMethod);

	var int _playerStatus; _playerStatus = _Bar_PlayerStatus ();

	var string s;

	var int previewValue;

//-- Item preview - apply FF

	//Health preview
	if (PC_ItemPreviewHealth) {
		if (_playerStatus) {
			if ((!_healthBar_PreviewVisible) || (_healthBar_WasHidden)) {
				//View_Open reinserts view to screen - essentially same as View_Top!
				View_Open (vHealthPreview);

				//Re-arrange views - first background texture view, second 'preview' view, then bar texture view and finally bar values
				View_Top(bHealthBar.v0);
				View_Top(vHealthPreview);
				View_Top(bHealthBar.v1);
				View_Top(vHealthBarValue);

				if (!_healthBar_PreviewVisible) {
					//Add frame function (16/1s)
					FF_ApplyOnceExtGT (FrameFunction_FlashPreviewBars__BetterBars, 60, -1);

					_healthBar_PreviewAlpha = 255;
					_healthBar_PreviewFlashingFadeOut = TRUE;
					_healthBar_PreviewVisible = TRUE;
				};
			};
		};
	} else {
		if (_healthBar_PreviewVisible) {
			View_Close (vHealthPreview);
			_healthBar_PreviewVisible = FALSE;
		};
	};

	//Mana preview
	if (PC_ItemPreviewMana) {
		if (_playerStatus) {
			if ((!_manaBar_PreviewVisible) || (_manaBar_WasHidden)) {
				//View_Open reinserts view to screen - essentially same as View_Top!
				View_Open (vManaPreview);

				//Re-arrange views - first background texture view, second 'preview' view, then bar texture view and finally bar values
				View_Top(bManaBar.v0);
				View_Top(vManaPreview);
				View_Top(bManaBar.v1);
				View_Top(vManaBarValue);

				if (!_manaBar_PreviewVisible) {
					//Add frame function (8/1s)
					FF_ApplyOnceExtGT (FrameFunction_FlashPreviewBars__BetterBars, 60, -1);

					_manaBar_PreviewVisible = TRUE;
					_manaBar_PreviewAlpha = 255;
					_manaBar_PreviewFlashingFadeOut = TRUE;
				};
			};
		};
	} else {
		if (_manaBar_PreviewVisible)
		{
			View_Close (vManaPreview);
			_manaBar_PreviewVisible = FALSE;
		};
	};

//-- Health bar

	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);

	if (hero.attribute [ATR_HITPOINTS_MAX] != _healthBar_LastMaxValue)
	{
		Bar_SetMax (hHealthBar, hero.attribute [ATR_HITPOINTS_MAX]);
	};

	if (hero.attribute [ATR_HITPOINTS] != _healthBar_LastValue)
	{
		Bar_SetValueSafe (hHealthBar, hero.attribute [ATR_HITPOINTS]);
	};

//-- Auto hiding/display for health bar (when updated)

	var int hurtPercentage;
	if (_healthBar_DisplayWhenHurt_Percentage > 0) {
		hurtPercentage = divf (mkf (hero.attribute [ATR_HITPOINTS]), mkf (hero.attribute [ATR_HITPOINTS_MAX]));
		hurtPercentage = mulf (hurtPercentage, mkf (100));
		hurtPercentage = roundf (hurtPercentage);
	};

	//Display only in inventory ...
	if ((_healthBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!healthBarOnDesk) && (!_healthBar_ForceOnDesk)) {
		//... don't do anything :)
	} else
	if ((_healthBar_ForceOnDesk) || (_healthBar_LastValue != hero.attribute [ATR_HITPOINTS]) || (oCGame_GetHeroStatus ()) || (!Npc_IsInFightMode (hero, FMODE_NONE)) || ((hurtPercentage <= _healthBar_DisplayWhenHurt_Percentage) && (_healthBar_DisplayWhenHurt_Percentage > 0)))
	{
		//
		if ((_healthBar_DisplayMethod != BarDisplay_AlwaysOn) && (!healthBarOnDesk)) {
			if (_healthBar_DisplayMethod == BarDisplay_DynamicUpdate) {
				if (!_healthBar_DisplayTime) {
					_healthBar_DisplayTime = 120;
				};
			};
		};

		if (_healthBar_DisplayTime < 80) {
			_healthBar_DisplayTime = 80;
		};

		FF_ApplyOnceExtGT (FrameFunction_FadeInOutHealthBar__BetterBars, 60, -1);
	};

	if ((_healthBar_DisplayMethod == BarDisplay_AlwaysOn) || (healthBarOnDesk) || (_healthBar_DisplayTime)) {
		if (_playerStatus) {
			if ((bHealthBar.hidden) || ((!bHealthBar.hidden && _healthBar_WasHidden))) {
				BBar_SetAlpha (hHealthBar, 0);

				if ((_healthBar_DisplayMethod == BarDisplay_AlwaysOn) || (healthBarOnDesk)) {
					if (!_healthBar_DisplayTime) {
						BBar_SetAlpha (hHealthBar, 255);
					};
				};

				//Bar_Show (hHealthBar);
				View_Open (bHealthBar.v0);
				View_Open (bHealthBar.v1);
				bHealthBar.hidden = FALSE;

				HealthBar_UpdatePosition ();

				//Open bar values view
				View_Open (vHealthBarValue);
				View_Resize (vHealthBarValue, bHealthBar.barW, -1);

				//Re-arrange views - first background texture view, second 'preview' view, then bar texture view and finally bar values
				View_Top(bHealthBar.v0);
				View_Top(vHealthPreview);
				View_Top(bHealthBar.v1);
				View_Top(vHealthBarValue);

				_healthBar_WasHidden = FALSE;
			};
		};
	};

	if ((_healthBar_DisplayMethod != BarDisplay_AlwaysOn) && (!healthBarOnDesk) && (!_healthBar_DisplayTime))
	|| ((_healthBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!healthBarOnDesk))
	{
		if (!bHealthBar.hidden) {
			//Bar_Hide (hHealthBar);

			View_Close(bHealthBar.v0);
			View_Close(bHealthBar.v1);
			bHealthBar.hidden = TRUE;

			View_Close (vHealthBarValue);
			View_Close (vHealthPreview);
		};
	};

	var int previewValueHealthBar;
	var int previewValueHealthBarLast;

	if (PC_ItemPreviewHealth > 0) {
		previewValueHealthBar = hero.attribute [ATR_HITPOINTS] + PC_ItemPreviewHealth;
		if (previewValueHealthBar > hero.attribute [ATR_HITPOINTS_MAX]) {
			previewValueHealthBar = hero.attribute [ATR_HITPOINTS_MAX];
		};
	} else {
		previewValueHealthBar = 0;
	};

	if (previewValueHealthBar != previewValueHealthBarLast)
	{
		previewValue = previewValueHealthBar;

		if (previewValue > 1000) { previewValue = 1000; };

		if ((previewValue) && (bHealthBar.valMax)) {
			previewValue = ((previewValue * 1000) / bHealthBar.valMax);
		} else {
			previewValue = 0;
		};

		View_Resize (vHealthPreview, (previewValue * bHealthBar.barW) / 1000, -1);

		//Bar_PreviewSetValue (hHealthBar, vHealthPreview, previewValueHealthBar);
		previewValueHealthBarLast = previewValueHealthBar;
	};

	//Bar_DisplayValue_Update (hHealthBar, _healthBar_DisplayValues);

	if (_playerStatus) {
		if ((hero.attribute [ATR_HITPOINTS_MAX] != _healthBar_LastMaxValue) || (hero.attribute [ATR_HITPOINTS] != _healthBar_LastValue))
		{
			s = " / ";
			s = ConcatStrings (IntToString (hero.attribute [ATR_HITPOINTS]), s);
			s = ConcatStrings (s, IntToString (hero.attribute [ATR_HITPOINTS_MAX]));

			View_SetTextMarginAndFontColor (vHealthBarValue, s, _healthBar_DisplayValues_Color, 0);
		};

		_healthBar_LastValue = hero.attribute [ATR_HITPOINTS];
		_healthBar_LastMaxValue = hero.attribute [ATR_HITPOINTS_MAX];
	};

//-- Mana Bar

	var oCViewStatusBar manaBar; manaBar = _^ (MEM_Game.manaBar);

	if (hero.attribute [ATR_MANA_MAX] != _manaBar_LastMaxValue)
	{
		Bar_SetMax (hManaBar, hero.attribute [ATR_MANA_MAX]);
	};

	if (hero.attribute [ATR_MANA] != _manaBar_LastValue)
	{
		Bar_SetValueSafe (hManaBar, hero.attribute [ATR_MANA]);
	};

//-- Auto hiding/display for mana bar (when updated)

	//Display only in inventory ...
	if ((_manaBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!manaBarOnDesk) && (!_manaBar_ForceOnDesk)) {
		//... don't do anything :)
	} else
	if ((_manaBar_ForceOnDesk) || (_manaBar_LastValue != hero.attribute [ATR_MANA])) {
		//
		if ((_manaBar_DisplayMethod != BarDisplay_AlwaysOn) && (!manaBarOnDesk)) {
			if (_manaBar_DisplayMethod == BarDisplay_DynamicUpdate) {
				if (!_manaBar_DisplayTime) {
					_manaBar_DisplayTime = 120;
				};
			};
		};

		if (_manaBar_DisplayTime < 80) {
			_manaBar_DisplayTime = 80;
		};

		FF_ApplyOnceExtGT (FrameFunction_FadeInOutManaBar__BetterBars, 60, -1);
	};

	if ((_manaBar_DisplayMethod == BarDisplay_AlwaysOn) || (manaBarOnDesk) || (_manaBar_DisplayTime)) {
		if (_playerStatus) {
			if ((bManaBar.hidden) || ((!bManaBar.hidden && _manaBar_WasHidden))) {
				BBar_SetAlpha (hManaBar, 0);

				if ((_manaBar_DisplayMethod == BarDisplay_AlwaysOn) || (manaBarOnDesk)) {
					if (!_manaBar_DisplayTime) {
						BBar_SetAlpha (hManaBar, 255);
					};
				};

				//Bar_Show (hManaBar);
				View_Open (bManaBar.v0);
				View_Open (bManaBar.v1);
				bManaBar.hidden = FALSE;

				ManaBar_UpdatePosition ();

				View_Open (vManaBarValue);
				View_Resize (vManaBarValue, bManaBar.barW, -1);

				//Re-arrange views - first background texture view, second 'preview' view, then bar texture view and finally bar values
				View_Top(bManaBar.v0);
				View_Top(vManaPreview);
				View_Top(bManaBar.v1);
				View_Top(vManaBarValue);

				_manaBar_WasHidden = FALSE;
			};
		};
	};

	if ((!(_manaBar_DisplayMethod == BarDisplay_AlwaysOn)) && (!manaBarOnDesk) && (!_manaBar_DisplayTime))
	|| ((_manaBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!manaBarOnDesk))
	{
		if (!bManaBar.hidden) {
			//Bar_Hide (hManaBar);

			View_Close(bManaBar.v0);
			View_Close(bManaBar.v1);
			bManaBar.hidden = TRUE;

			View_Close (vManaBarValue);
			View_Close (vManaPreview);
		};
	};

	var int previewValueManaBar;
	var int previewValueManaBarLast;
	if (PC_ItemPreviewMana > 0) {
		previewValueManaBar = hero.attribute [ATR_MANA] + PC_ItemPreviewMana;
		if (previewValueManaBar > hero.attribute [ATR_MANA_MAX]) {
			previewValueManaBar = hero.attribute [ATR_MANA_MAX];
		};
	} else {
		previewValueManaBar = 0;
	};

	if (previewValueManaBar != previewValueManaBarLast)
	{
		previewValue = previewValueManaBar;

		if (previewValue > 1000) { previewValue = 1000; };

		if ((previewValue) && (bManaBar.valMax)) {
			previewValue = ((previewValue * 1000) / bManaBar.valMax);
		} else {
			previewValue = 0;
		};

		View_Resize (vManaPreview, (previewValue * bManaBar.barW) / 1000, -1);

		//Bar_PreviewSetValue (hManaBar, vManaPreview, previewValueManaBar);
		previewValueManaBarLast = previewValueManaBar;
	};

	//Bar_DisplayValue_Update (hManaBar, _manaBar_DisplayValues);

	if (_playerStatus) {
		if ((hero.attribute [ATR_MANA_MAX] != _manaBar_LastMaxValue) || (hero.attribute [ATR_MANA] != _manaBar_LastValue))
		{
			s = " / ";
			s = ConcatStrings (IntToString (hero.attribute [ATR_MANA]), s);
			s = ConcatStrings (s, IntToString (hero.attribute [ATR_MANA_MAX]));

			View_SetTextMarginAndFontColor (vManaBarValue, s, _manaBar_DisplayValues_Color, 0);
		};

		_manaBar_LastValue = hero.attribute [ATR_MANA];
		_manaBar_LastMaxValue = hero.attribute [ATR_MANA_MAX];
	};

//-- Swim bar - display values

	var oCViewStatusBar swimBar; swimBar = _^ (MEM_Game.swimBar);

	var oCNpc her; her = Hlp_GetNpc (hero);

	var int diveTime; diveTime = her.divetime;
	var int diveCtr; diveCtr = her.divectr;

	if (diveTime == ANI_TIME_INFINITE) {
		diveCtr = diveTime;
	};

	diveTime = RoundF (diveTime);
	diveCtr = RoundF (diveCtr);

	if (diveCtr < 0) { diveCtr = 0; };

	if (diveTime != _swimBar_LastMaxValue)
	{
		Bar_SetMax (hSwimBar, diveTime);
	};

	if (diveCtr != _swimBar_LastValue)
	{
		Bar_SetValueSafe (hSwimBar, diveCtr);
	};

	//Figure out if bar should display or not
	var int hideSwimBar; hideSwimBar = TRUE;

	if (swimBar.zCView_ondesk) {
		if (_playerStatus) {
			if ((bSwimBar.hidden) || ((!bSwimBar.hidden && _swimBar_WasHidden))) {
				//Bar_Show (hSwimBar);
				View_Open (bSwimBar.v0);
				View_Open (bSwimBar.v1);
				bSwimBar.hidden = FALSE;

				hideSwimBar = FALSE;

				SwimBar_UpdatePosition ();

				View_Open (vSwimBarValue);
				View_Resize (vSwimBarValue, bSwimBar.barW, -1);

				_swimBar_WasHidden = FALSE;
			};
		};
	};

	if (hideSwimBar) {
		if (!bSwimBar.hidden) {
			//Bar_Hide (hSwimBar);
			View_Close(bSwimBar.v0);
			View_Close(bSwimBar.v1);
			bSwimBar.hidden = TRUE;

			View_Close (vSwimBarValue);
		};
	};

	//Bar_DisplayValue_Update (hSwimBar, _swimBar_DisplayValues);

	if (_playerStatus) {
		if ((diveTime != _swimBar_LastMaxValue) || (diveCtr != _swimBar_LastValue))
		{
			if (diveTime == ANI_TIME_INFINITE) {
				s = "- / -";
			} else {

				var int diveT; diveT = diveTime / 1000;
				var int diveC; diveC = diveCtr / 1000;

				s = " / ";
				s = ConcatStrings (IntToString (diveC), s);
				s = ConcatStrings (s, IntToString (diveT));
			};

			View_SetTextMarginAndFontColor (vSwimBarValue, s, _swimBar_DisplayValues_Color, 0);
		};

		_swimBar_LastValue = diveCtr;
		_swimBar_LastMaxValue = diveTime;
	};

//-- Focus bar - display values

	var oCViewStatusBar focusBar; focusBar = _^ (MEM_Game.focusBar);

	//Bar_DisplayValue_Update (hFocusBar, _focusBar_DisplayValues);

	//Figure out if bar should display or not
	var int hideFocusBar; hideFocusBar = TRUE;

	if (focusBar.zCView_ondesk) {
		if (_playerStatus) {
			if ((bFocusBar.hidden) || ((!bFocusBar.hidden) && (_focusBar_WasHidden))) {
				//Bar_Show (hFocusBar);
				View_Open (bFocusBar.v0);
				View_Open (bFocusBar.v1);
				bFocusBar.hidden = FALSE;

				FocusBar_UpdatePosition ();

				View_Open (vFocusBarValue);
				View_Resize (vFocusBarValue, bFocusBar.barW, -1);

				_focusBar_WasHidden = FALSE;
			};

			hideFocusBar = FALSE;
		};
	};

	if (hideFocusBar) {
		if (!bFocusBar.hidden) {
			//Bar_Hide (hFocusBar);
			View_Close(bFocusBar.v0);
			View_Close(bFocusBar.v1);
			bFocusBar.hidden = TRUE;

			View_Close (vFocusBarValue);
		};
	};

	if (Hlp_Is_oCNpc (her.focus_vob)) {
		var oCNpc npc; npc = _^ (her.focus_vob);

		if (npc.attribute [ATR_HITPOINTS_MAX] != _focusBar_LastMaxValue)
		{
			Bar_SetMax (hFocusBar, npc.attribute [ATR_HITPOINTS_MAX]);
		};

		if (npc.attribute [ATR_HITPOINTS] != _focusBar_LastValue)
		{
			Bar_SetValueSafe (hFocusBar, npc.attribute [ATR_HITPOINTS]);
		};

		if (_playerStatus) {
			if ((npc.attribute [ATR_HITPOINTS_MAX] != _focusBar_LastMaxValue) || (npc.attribute [ATR_HITPOINTS] != _focusBar_LastValue))
			{
				s = " / ";
				s = ConcatStrings (IntToString (npc.attribute [ATR_HITPOINTS]), s);
				s = ConcatStrings (s, IntToString (npc.attribute [ATR_HITPOINTS_MAX]));

				View_SetTextMarginAndFontColor (vFocusBarValue, s, _focusBar_DisplayValues_Color, 0);
			};

			_focusBar_LastMaxValue = npc.attribute [ATR_HITPOINTS_MAX];
			_focusBar_LastValue = npc.attribute [ATR_HITPOINTS];
		};
	};

	if (_playerStatus) {
		HealthBar_UpdatePosition ();
		ManaBar_UpdatePosition ();
		SwimBar_UpdatePosition ();
		FocusBar_UpdatePosition ();
	};

//When I tried to change alpha of Gothic bar I was not able to do so
	//View_SetAlpha (hpBarAddress, 0);
	//View_SetAlpha (hpBar.range_bar, 0);
	//View_SetAlpha (hpBar.value_bar, 0);

//I was also not able to remove Gothic bar
	//ViewStatusBar_Remove (hpBarAddress);

//Only option which was possible - moving original Gothic bars outside of screen :-)

	hpBar.zCView_vposy = 8192 * 2;
	manaBar.zCView_vposy = 8192 * 2;
	swimBar.zCView_vposy = 8192 * 2;
	focusBar.zCView_vposy = 8192 * 2;
};

func void G12_BetterBars_Init () {
	G12_InvItemPreview_Init ();

	G12_InitDefaultBarFunctions ();

	//-- Load API values / init default values

	_tex_BarPreview_HealthBar = API_GetSymbolStringValue ("TEXTURE_BARPREVIEW_HEALTBAR", "BAR_HEALTH_PREVIEW.TGA");
	_tex_BarPreview_ManaBar = API_GetSymbolStringValue ("TEXTURE_BARPREVIEW_MANABAR", "BAR_MANA_PREVIEW.TGA");

	_healthBar_DisplayWhenHurt_Percentage = API_GetSymbolIntValue ("HEALTHBAR_DISPLAYWHENHURT_PERCENTAGE", 50);

	_healthBar_DisplayMethod = API_GetSymbolIntValue ("HEALTHBAR_DISPLAYMETHOD", BarDisplay_Standard);
	_healthBar_PreviewEffect = API_GetSymbolIntValue ("HEALTHBAR_PREVIEWEFFECT", BarPreviewEffect_FadeInOut);

	_healthBar_DisplayValues = API_GetSymbolIntValue ("HEALTHBAR_DISPLAYVALUES", 0);
	_healthBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("HEALTHBAR_VIEW_ALPHAFUNC", 2);
	_healthBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("HEALTHBAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_healthBar_PPosX = API_GetSymbolIntValue ("HEALTHBAR_PPOSX", -1);
	_healthBar_PPosY = API_GetSymbolIntValue ("HEALTHBAR_PPOSY", -1);

	_healthBar_VPosX = API_GetSymbolIntValue ("HEALTHBAR_VPOSX", -1);
	_healthBar_VPosY = API_GetSymbolIntValue ("HEALTHBAR_VPOSY", -1);

	_manaBar_DisplayMethod = API_GetSymbolIntValue ("MANABAR_DISPLAYMETHOD", BarDisplay_Standard);
	_manaBar_PreviewEffect = API_GetSymbolIntValue ("MANABAR_PREVIEWEFFECT", BarPreviewEffect_FadeInOut);

	_manaBar_DisplayValues = API_GetSymbolIntValue ("MANABAR_DISPLAYVALUES", 0);
	_manaBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("MANABAR_VIEW_ALPHAFUNC", 2);
	_manaBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("MANABAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_manaBar_PPosX = API_GetSymbolIntValue ("MANABAR_PPOSX", -1);
	_manaBar_PPosY = API_GetSymbolIntValue ("MANABAR_PPOSY", -1);

	_manaBar_VPosX = API_GetSymbolIntValue ("MANABAR_VPOSX", -1);
	_manaBar_VPosY = API_GetSymbolIntValue ("MANABAR_VPOSY", -1);

	_swimBar_DisplayValues = API_GetSymbolIntValue ("SWIMBAR_DISPLAYVALUES", 0);
	_swimBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("SWIMBAR_VIEW_ALPHAFUNC", 2);
	_swimBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("SWIMBAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_swimBar_PPosX = API_GetSymbolIntValue ("SWIMBAR_PPOSX", -1);
	_swimBar_PPosY = API_GetSymbolIntValue ("SWIMBAR_PPOSY", -1);

	_swimBar_VPosX = API_GetSymbolIntValue ("SWIMBAR_VPOSX", -1);
	_swimBar_VPosY = API_GetSymbolIntValue ("SWIMBAR_VPOSY", -1);

	_focusBar_DisplayValues = API_GetSymbolIntValue ("FOCUSBAR_DISPLAYVALUES", 0);
	_focusBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("FOCUSBAR_VIEW_ALPHAFUNC", 2);
	_focusBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("FOCUSBAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_focusBar_PPosX = API_GetSymbolIntValue ("FOCUSBAR_PPOSX", -1);
	_focusBar_PPosY = API_GetSymbolIntValue ("FOCUSBAR_PPOSY", -1);

	_focusBar_VPosX = API_GetSymbolIntValue ("FOCUSBAR_VPOSX", -1);
	_focusBar_VPosY = API_GetSymbolIntValue ("FOCUSBAR_VPOSY", -1);

	//--

	_betterBars_Font = API_GetSymbolStringValue ("BETTERBARS_FONT", "FONT_OLD_10_WHITE.TGA");

	//--

	//Custom setup from Gothic.ini
	if (MEM_GothOptExists ("GAME", "healthBarDisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - always on
		_healthBar_DisplayMethod = STR_ToInt (MEM_GetGothOpt ("GAME", "healthBarDisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("GAME", "healthBarDisplayMethod")) {
			_healthBar_DisplayMethod = STR_ToInt (MEM_GetModOpt ("GAME", "healthBarDisplayMethod"));
			MEM_SetGothOpt ("GAME", "healthBarDisplayMethod", IntToString (_healthBar_DisplayMethod));
		} else {
			//Default
			_healthBar_DisplayMethod = BarDisplay_DynamicUpdate;
			MEM_SetGothOpt ("GAME", "healthBarDisplayMethod", IntToString (_healthBar_DisplayMethod));
		};
	};

	if (MEM_GothOptExists ("GAME", "_manaBar_DisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - alwas on
		_manaBar_DisplayMethod = STR_ToInt (MEM_GetGothOpt ("GAME", "_manaBar_DisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("GAME", "_manaBar_DisplayMethod")) {
			_manaBar_DisplayMethod = STR_ToInt (MEM_GetModOpt ("GAME", "_manaBar_DisplayMethod"));
			MEM_SetGothOpt ("GAME", "_manaBar_DisplayMethod", IntToString (_manaBar_DisplayMethod));
		} else {
			//Default
			_manaBar_DisplayMethod = BarDisplay_DynamicUpdate;
			MEM_SetGothOpt ("GAME", "_manaBar_DisplayMethod", IntToString (_manaBar_DisplayMethod));
		};
	};

	//--

	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
	var oCViewStatusBar manaBar; manaBar = _^ (MEM_Game.manaBar);
	var oCViewStatusBar swimBar; swimBar = _^ (MEM_Game.swimBar);
	var oCViewStatusBar focusBar; focusBar = _^ (MEM_Game.focusBar);

	//Create health bar
	if (!Hlp_IsValidHandle(hHealthBar)) {
		hHealthBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hHealthBar, hpBar.texValue);
		Bar_Hide (hHealthBar);
	};

	bHealthBar = get (hHealthBar);

	//vHealthPreview is View created by Bar_CreatePreview
	if (!Hlp_IsValidHandle (vHealthPreview)) {
		vHealthPreview = Bar_CreatePreview (hHealthBar, _tex_BarPreview_HealthBar);
		View_SetAlpha (vHealthPreview, 255);
	};

	if (!Hlp_IsValidHandle (vHealthBarValue)) {
		vHealthBarValue = Bar_CreatePreview (hHealthBar, "");
		View_AddText (vHealthBarValue, 0, 0, "", _betterBars_Font);
		View_SetAlphaFunc (vHealthBarValue, _healthBar_DisplayValues_AlphaFunc);
	};

	//Create mana bar
	if (!Hlp_IsValidHandle(hManaBar)) {
		hManaBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hManaBar, manaBar.texValue);
		Bar_Hide (hManaBar);
	};

	bManaBar = get (hManaBar);

	//vHealthPreview is View created by Bar_CreatePreview
	if (!Hlp_IsValidHandle (vManaPreview)) {
		vManaPreview = Bar_CreatePreview (hManaBar, _tex_BarPreview_ManaBar);
		View_SetAlpha (vManaPreview, 255);
	};

	if (!Hlp_IsValidHandle (vManaBarValue)) {
		vManaBarValue = Bar_CreatePreview (hManaBar, "");
		View_AddText (vManaBarValue, 0, 0, "", _betterBars_Font);
		View_SetAlphaFunc (vManaBarValue, _manaBar_DisplayValues_AlphaFunc);
	};

	//Create swim bar
	if (!Hlp_IsValidHandle(hSwimBar)) {
		hSwimBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hSwimBar, swimBar.texValue);
		Bar_Hide (hSwimBar);
	};

	bSwimBar = get (hSwimBar);

	if (!Hlp_IsValidHandle (vSwimBarValue)) {
		vSwimBarValue = Bar_CreatePreview (hSwimBar, "");
		View_AddText (vSwimBarValue, 0, 0, "", _betterBars_Font);
		View_SetAlphaFunc (vSwimBarValue, _focusBar_DisplayValues_AlphaFunc);
	};

	//Create focus bar
	if (!Hlp_IsValidHandle(hFocusBar)) {
		hFocusBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hFocusBar, focusBar.texValue);
		Bar_Hide (hFocusBar);
	};

	bFocusBar = get (hFocusBar);

	if (!Hlp_IsValidHandle (vFocusBarValue)) {
		vFocusBarValue = Bar_CreatePreview (hFocusBar, "");
		View_AddText (vFocusBarValue, 0, 0, "", _betterBars_Font);
		View_SetAlphaFunc (vFocusBarValue, _focusBar_DisplayValues_AlphaFunc);
	};

	//--

	FF_ApplyOnceExtGT (FrameFunction_EachFrame__BetterBars, 0, -1);
};
