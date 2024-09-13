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

var int _healthBar_PreviewAlpha;
var int _healthBar_PreviewFlashingFadeOut;

var int _healthBar_DisplayTime;
var int _healthBar_DisplayState;

//--

var int _manaBar_PreviewAlpha;
var int _manaBar_PreviewFlashingFadeOut;

var int _manaBar_DisplayTime;
var int _manaBar_DisplayState;
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
	if (Hlp_IsValidHandle (hFocusBar)) {
		var oCViewStatusBar focusBar; focusBar = _^ (MEM_Game.focusBar);
		Bar_SetBarTexture (hFocusBar, focusBar.texValue);
	};
};

func void FF_FadeInOutHealthBar__BetterBars () {
	//Don't execute if flashing
	if (_healthBar_DisplayState == BarDisplayState_StartFlashing)
	|| (_healthBar_DisplayState == BarDisplayState_IsFlashing)
	{
		return;
	};

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
		BBar_Hide (hHealthBar);

		FF_Remove (FF_FadeInOutHealthBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (bHealthBar.hidden) {
		//Show it only if allowed by game itself
		if (_Bar_PlayerStatus ()) {
			BBar_Show (hHealthBar);
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

func void FF_FadeInOutManaBar__BetterBars () {
	//Don't execute if flashing
	if (_manaBar_DisplayState == BarDisplayState_StartFlashing)
	|| (_manaBar_DisplayState == BarDisplayState_IsFlashing)
	{
		return;
	};

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
		BBar_Hide (hManaBar);

		FF_Remove (FF_FadeInOutManaBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (bManaBar.hidden) {
		//Show it only if allowed by game itself
		if (_Bar_PlayerStatus ()) {
			BBar_Show (hManaBar);
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

func void FF_FlashPreviewBars__BetterBars () {
	if ((!_healthBar_PreviewVisible) && (!_manaBar_PreviewVisible)) {
		View_SetAlpha (hHealthPreviewView, 255);
		View_SetAlpha (hManaPreviewView, 255);
		FF_Remove (FF_FlashPreviewBars__BetterBars);
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
		View_SetAlpha (hHealthPreviewView, _healthBar_PreviewAlpha);
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
		View_SetAlpha (hManaPreviewView, _manaBar_PreviewAlpha);
	};
};

func void FF_BetterBars ()
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
				//Add frame function (16/1s)
				FF_ApplyOnceExtGT (FF_FlashPreviewBars__BetterBars, 60, -1);

				_healthBar_PreviewAlpha = 255;
				_healthBar_PreviewFlashingFadeOut = TRUE;
				_healthBar_PreviewVisible = TRUE;

				//Force redraw
				BBar_Hide (hHealthBar);
				BBar_Show (hHealthBar);
			};
		};
	} else {
		if (_healthBar_PreviewVisible) {
			View_Close_Safe (hHealthPreviewView);
			_healthBar_PreviewVisible = FALSE;
		};
	};

	//Mana preview
	if (PC_ItemPreviewMana) {
		if (_playerStatus) {
			if ((!_manaBar_PreviewVisible) || (_manaBar_WasHidden)) {
				//Add frame function (8/1s)
				FF_ApplyOnceExtGT (FF_FlashPreviewBars__BetterBars, 60, -1);

				_manaBar_PreviewVisible = TRUE;
				_manaBar_PreviewAlpha = 255;
				_manaBar_PreviewFlashingFadeOut = TRUE;

				//Force redraw
				BBar_Hide (hManaBar);
				BBar_Show (hManaBar);
			};
		};
	} else {
		if (_manaBar_PreviewVisible)
		{
			View_Close_Safe (hManaPreviewView);
			_manaBar_PreviewVisible = FALSE;
		};
	};

//-- Health bar

	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);

	if (hero.attribute [ATR_HITPOINTS_MAX] != _healthBar_LastMaxValue)
	{
		Bar_SetMax (hHealthBar, hero.attribute [ATR_HITPOINTS_MAX]);
		Bar_SetValueSafe (hHealthBar, hero.attribute [ATR_HITPOINTS]);
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
	if ((_healthBar_ForceOnDesk) || (_healthBar_LastValue != hero.attribute [ATR_HITPOINTS]) || (_healthBar_LastMaxValue != hero.attribute [ATR_HITPOINTS_MAX])
	|| (oCGame_GetHeroStatus ()) || (!Npc_IsInFightMode (hero, FMODE_NONE)) || ((hurtPercentage <= _healthBar_DisplayWhenHurt_Percentage) && (_healthBar_DisplayWhenHurt_Percentage > 0))
	|| (_healthBar_DisplayState == BarDisplayState_WasFlashing)
	)
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

		if (_healthBar_DisplayState == BarDisplayState_WasFlashing) {
			_healthBar_DisplayState = BarDisplayState_Displayed;
		};

		FF_ApplyOnceExtGT (FF_FadeInOutHealthBar__BetterBars, 60, -1);
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

				BBar_Show (hHealthBar);

				_healthBar_WasHidden = FALSE;
			};
		};
	};

	if ((_healthBar_DisplayMethod != BarDisplay_AlwaysOn) && (!healthBarOnDesk) && (!_healthBar_DisplayTime))
	|| ((_healthBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!healthBarOnDesk))
	{
		if (!bHealthBar.hidden) {
			BBar_Hide (hHealthBar);
		};
	};

	var int previewValueHealthBar;
	const int previewValueHealthBarLast = -1;

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

		View_Resize_Safe (hHealthPreviewView, (previewValue * bHealthBar.barW) / 1000, -1);

		//Bar_PreviewSetValue (hHealthBar, hHealthPreviewView, previewValueHealthBar);
		previewValueHealthBarLast = previewValueHealthBar;
	};

	//Bar_DisplayValue_Update (hHealthBar, _healthBar_DisplayValues);

	if (_playerStatus) {
		if ((hero.attribute [ATR_HITPOINTS_MAX] != _healthBar_LastMaxValue) || (hero.attribute [ATR_HITPOINTS] != _healthBar_LastValue))
		{
			s = " / ";
			s = ConcatStrings (IntToString (hero.attribute [ATR_HITPOINTS]), s);
			s = ConcatStrings (s, IntToString (hero.attribute [ATR_HITPOINTS_MAX]));

			View_SetTextMarginAndFontColor (hHealthBarValueView, s, _healthBar_DisplayValues_Color, 0);
		};

		_healthBar_LastValue = hero.attribute [ATR_HITPOINTS];
		_healthBar_LastMaxValue = hero.attribute [ATR_HITPOINTS_MAX];
	};

//-- Mana Bar

	var oCViewStatusBar manaBar; manaBar = _^ (MEM_Game.manaBar);

	if (hero.attribute [ATR_MANA_MAX] != _manaBar_LastMaxValue)
	{
		Bar_SetMax (hManaBar, hero.attribute [ATR_MANA_MAX]);
		Bar_SetValueSafe (hManaBar, hero.attribute [ATR_MANA]);
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
	if ((_manaBar_ForceOnDesk) || (_manaBar_LastValue != hero.attribute [ATR_MANA]) || (_manaBar_LastMaxValue != hero.attribute [ATR_MANA_MAX])
	|| (_manaBar_DisplayState == BarDisplayState_WasFlashing)
	)
	{
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

		if (_manaBar_DisplayState == BarDisplayState_WasFlashing) {
			_manaBar_DisplayState = BarDisplayState_Displayed;
		};

		FF_ApplyOnceExtGT (FF_FadeInOutManaBar__BetterBars, 60, -1);
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

				BBar_Show (hManaBar);

				_manaBar_WasHidden = FALSE;
			};
		};
	};

	if ((!(_manaBar_DisplayMethod == BarDisplay_AlwaysOn)) && (!manaBarOnDesk) && (!_manaBar_DisplayTime))
	|| ((_manaBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!manaBarOnDesk))
	{
		if (!bManaBar.hidden) {
			BBar_Hide (hManaBar);
		};
	};

	var int previewValueManaBar;
	const int previewValueManaBarLast = -1;

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

		View_Resize_Safe (hManaPreviewView, (previewValue * bManaBar.barW) / 1000, -1);

		//Bar_PreviewSetValue (hManaBar, hManaPreviewView, previewValueManaBar);
		previewValueManaBarLast = previewValueManaBar;
	};

	//Bar_DisplayValue_Update (hManaBar, _manaBar_DisplayValues);

	if (_playerStatus) {
		if ((hero.attribute [ATR_MANA_MAX] != _manaBar_LastMaxValue) || (hero.attribute [ATR_MANA] != _manaBar_LastValue))
		{
			s = " / ";
			s = ConcatStrings (IntToString (hero.attribute [ATR_MANA]), s);
			s = ConcatStrings (s, IntToString (hero.attribute [ATR_MANA_MAX]));

			View_SetTextMarginAndFontColor (hManaBarValueView, s, _manaBar_DisplayValues_Color, 0);
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
		Bar_SetValueSafe (hSwimBar, diveCtr);
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
				BBar_Show (hSwimBar);

				_swimBar_WasHidden = FALSE;
			};

			hideSwimBar = FALSE;
		};
	};

	if (hideSwimBar) {
		if (!bSwimBar.hidden) {
			BBar_Hide (hSwimBar);
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

			View_SetTextMarginAndFontColor (hSwimBarValueView, s, _swimBar_DisplayValues_Color, 0);
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
				BBar_Show (hFocusBar);

				_focusBar_WasHidden = FALSE;
			};

			hideFocusBar = FALSE;
		};
	};

	if (hideFocusBar) {
		if (!bFocusBar.hidden) {
			BBar_Hide (hFocusBar);
		};
	};

	if (Hlp_Is_oCNpc (her.focus_vob)) {
		var oCNpc npc; npc = _^ (her.focus_vob);

		if (npc.attribute [ATR_HITPOINTS_MAX] != _focusBar_LastMaxValue)
		{
			Bar_SetMax (hFocusBar, npc.attribute [ATR_HITPOINTS_MAX]);
			Bar_SetValueSafe (hFocusBar, npc.attribute [ATR_HITPOINTS]);
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

				View_SetTextMarginAndFontColor (hFocusBarValueView, s, _focusBar_DisplayValues_Color, 0);
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

func void SaveIniOptions__BetterBars () {
	MEM_SetGothOpt ("AFSP", "healthBar.DisplayMethod", IntToString (_healthBar_DisplayMethod));
	MEM_SetGothOpt ("AFSP", "manaBar.DisplayMethod", IntToString (_manaBar_DisplayMethod));

	MEM_SetGothOpt ("AFSP", "healthBar.DisplayValues", IntToString (_manaBar_DisplayValues));
	MEM_SetGothOpt ("AFSP", "manaBar.DisplayValues", IntToString (_manaBar_DisplayValues));
	MEM_SetGothOpt ("AFSP", "swimBar.DisplayValues", IntToString (_swimBar_DisplayValues));
	MEM_SetGothOpt ("AFSP", "focusBar.DisplayValues", IntToString (_focusBar_DisplayValues));
};

func void ReloadIniOptions__BetterBars () {
	//Custom setup from Gothic.ini

	//** Display methods **

	if (MEM_GothOptExists ("AFSP", "healthBar.DisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - always on, 3 only in inventory
		_healthBar_DisplayMethod = STR_ToInt (MEM_GetGothOpt ("AFSP", "healthBar.DisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("AFSP", "healthBar.DisplayMethod")) {
			_healthBar_DisplayMethod = STR_ToInt (MEM_GetModOpt ("AFSP", "healthBar.DisplayMethod"));
		} else {
			//Default
			_healthBar_DisplayMethod = BarDisplay_DynamicUpdate;
		};
	};

	if (MEM_GothOptExists ("AFSP", "manaBar.DisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - always on, 3 only in inventory
		_manaBar_DisplayMethod = STR_ToInt (MEM_GetGothOpt ("AFSP", "manaBar.DisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("AFSP", "manaBar.DisplayMethod")) {
			_manaBar_DisplayMethod = STR_ToInt (MEM_GetModOpt ("AFSP", "manaBar.DisplayMethod"));
		} else {
			//Default
			_manaBar_DisplayMethod = BarDisplay_DynamicUpdate;
		};
	};

	 //** Display values **

	if (MEM_GothOptExists ("AFSP", "healthBar.DisplayValues")) {
		//0 - no, 1 - yes
		_healthBar_DisplayValues = STR_ToInt (MEM_GetGothOpt ("AFSP", "healthBar.DisplayValues"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("AFSP", "healthBar.DisplayValues")) {
			_healthBar_DisplayValues = STR_ToInt (MEM_GetModOpt ("AFSP", "healthBar.DisplayValues"));
		} else {
			//Default
			_healthBar_DisplayValues = BarDisplay_DynamicUpdate;
		};
	};

	if (MEM_GothOptExists ("AFSP", "manaBar.DisplayValues")) {
		//0 - no, 1 - yes
		_manaBar_DisplayValues = STR_ToInt (MEM_GetGothOpt ("AFSP", "manaBar.DisplayValues"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("AFSP", "manaBar.DisplayValues")) {
			_manaBar_DisplayValues = STR_ToInt (MEM_GetModOpt ("AFSP", "manaBar.DisplayValues"));
		} else {
			//Default
			_manaBar_DisplayValues = BarDisplay_DynamicUpdate;
		};
	};

	if (MEM_GothOptExists ("AFSP", "swimBar.DisplayValues")) {
		//0 - no, 1 - yes
		_swimBar_DisplayValues = STR_ToInt (MEM_GetGothOpt ("AFSP", "swimBar.DisplayValues"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("AFSP", "swimBar.DisplayValues")) {
			_swimBar_DisplayValues = STR_ToInt (MEM_GetModOpt ("AFSP", "swimBar.DisplayValues"));
		} else {
			//Default
			_swimBar_DisplayValues = BarDisplay_DynamicUpdate;
		};
	};

	if (MEM_GothOptExists ("AFSP", "focusBar.DisplayValues")) {
		//0 - no, 1 - yes
		_focusBar_DisplayValues = STR_ToInt (MEM_GetGothOpt ("AFSP", "focusBar.DisplayValues"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("AFSP", "focusBar.DisplayValues")) {
			_focusBar_DisplayValues = STR_ToInt (MEM_GetModOpt ("AFSP", "focusBar.DisplayValues"));
		} else {
			//Default
			_focusBar_DisplayValues = BarDisplay_DynamicUpdate;
		};
	};

	SaveIniOptions__BetterBars();
};

/*
 *	Functions allowing bar flashing
 */
func void FF_FlashHealthBar__BetterBars () {
	//If bar is hidden - show it
	if (bHealthBar.hidden) {
		if (_Bar_PlayerStatus ()) {
			BBar_Show(bHealthBar);
		};
	};

	var int fadeOut;
	var int fadeOutCounter;
	var int alpha;

	//Initialize
	if (fadeOutCounter == 0) {
		alpha = 255;
		fadeOut = TRUE;
		fadeOutCounter = 1;
	} else
	if (fadeOutCounter > 0) {
		if (_healthBar_DisplayState == BarDisplayState_StartFlashing) {
			fadeOutCounter = 1;
		};
	};

	_healthBar_DisplayState = BarDisplayState_IsFlashing;

	if (fadeOut) {
		alpha -= 64;

		if (alpha < 0) {
			alpha = 0;
			fadeOut = (!fadeOut);
		};
	} else {
		alpha += 64;

		if (alpha > 255) {
			alpha = 255;
			fadeOut = (!fadeOut);
			fadeOutCounter += 1;
		};
	};

	BBar_SetAlpha (hhealthBar, alpha);

	//Remove FF after 3 flashes
	if (fadeOutCounter >= 3) {
		fadeOutCounter = 0;

		//Leave visible
		alpha = 255;
		BBar_SetAlpha (hhealthBar, alpha);

		_healthBar_DisplayState = BarDisplayState_WasFlashing;

		FF_Remove(FF_FlashHealthBar__BetterBars);
	};
};

func void FF_FlashManaBar__BetterBars () {
	//If bar is hidden - show it
	if (bManaBar.hidden) {
		if (_Bar_PlayerStatus ()) {
			BBar_Show(bManaBar);
		};
	};

	var int fadeOut;
	var int fadeOutCounter;
	var int alpha;

	//Initialize
	if (fadeOutCounter == 0) {
		alpha = 255;
		fadeOut = TRUE;
		fadeOutCounter = 1;
	} else
	if (fadeOutCounter > 0) {
		if (_manaBar_DisplayState == BarDisplayState_StartFlashing) {
			fadeOutCounter = 1;
		};
	};

	_manaBar_DisplayState = BarDisplayState_IsFlashing;

	if (fadeOut) {
		alpha -= 64;

		if (alpha < 0) {
			alpha = 0;
			fadeOut = (!fadeOut);
		};
	} else {
		alpha += 64;

		if (alpha > 255) {
			alpha = 255;
			fadeOut = (!fadeOut);
			fadeOutCounter += 1;
		};
	};

	BBar_SetAlpha (hManaBar, alpha);

	//Remove FF after 3 flashes
	if (fadeOutCounter >= 3) {
		fadeOutCounter = 0;

		//Leave visible
		alpha = 255;
		BBar_SetAlpha (hManaBar, alpha);

		_manaBar_DisplayState = BarDisplayState_WasFlashing;

		FF_Remove(FF_FlashManaBar__BetterBars);
	};
};

func void HealthBar_FlashBar() {
	_healthBar_DisplayTime = 80;
	_healthBar_DisplayState = BarDisplayState_StartFlashing;

	//Add frame function (16/1s)
	FF_ApplyOnceExtGT (FF_FlashHealthBar__BetterBars, 60, -1);
};

func void ManaBar_FlashBar() {
	_manaBar_DisplayTime = 80;
	_manaBar_DisplayState = BarDisplayState_StartFlashing;

	//Add frame function (16/1s)
	FF_ApplyOnceExtGT (FF_FlashManaBar__BetterBars, 60, -1);
};

func void _event_MenuLeave__BetterBars (var int eventType) {
	if (!ECX) { return; };
	var zCMenu menu; menu = _^ (ECX);

	if (Hlp_StrCmp (menu.name, "MENU_MAIN")) {
		ReloadIniOptions__BetterBars();
	};
};

func void G12_BetterBars_Init () {
	G12_InvItemPreview_Init ();
	G12_InitDefaultBarFunctions ();

	G12_MenuEvent_Init();

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

	_healthBar_DisplayValueOffsetX = API_GetSymbolIntValue ("HEALTHBAR_DISPLAYVALUEOFFSETX", 0);
	_healthBar_DisplayValueOffsetY = API_GetSymbolIntValue ("HEALTHBAR_DISPLAYVALUEOFFSETY", -1);

	_manaBar_DisplayMethod = API_GetSymbolIntValue ("MANABAR_DISPLAYMETHOD", BarDisplay_Standard);
	_manaBar_PreviewEffect = API_GetSymbolIntValue ("MANABAR_PREVIEWEFFECT", BarPreviewEffect_FadeInOut);

	_manaBar_DisplayValues = API_GetSymbolIntValue ("MANABAR_DISPLAYVALUES", 0);
	_manaBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("MANABAR_VIEW_ALPHAFUNC", 2);
	_manaBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("MANABAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_manaBar_PPosX = API_GetSymbolIntValue ("MANABAR_PPOSX", -1);
	_manaBar_PPosY = API_GetSymbolIntValue ("MANABAR_PPOSY", -1);

	_manaBar_VPosX = API_GetSymbolIntValue ("MANABAR_VPOSX", -1);
	_manaBar_VPosY = API_GetSymbolIntValue ("MANABAR_VPOSY", -1);

	_manaBar_DisplayValueOffsetX = API_GetSymbolIntValue ("MANABAR_DISPLAYVALUEOFFSETX", 0);
	_manaBar_DisplayValueOffsetY = API_GetSymbolIntValue ("MANABAR_DISPLAYVALUEOFFSETY", -1);

	_swimBar_DisplayValues = API_GetSymbolIntValue ("SWIMBAR_DISPLAYVALUES", 0);
	_swimBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("SWIMBAR_VIEW_ALPHAFUNC", 2);
	_swimBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("SWIMBAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_swimBar_PPosX = API_GetSymbolIntValue ("SWIMBAR_PPOSX", -1);
	_swimBar_PPosY = API_GetSymbolIntValue ("SWIMBAR_PPOSY", -1);

	_swimBar_VPosX = API_GetSymbolIntValue ("SWIMBAR_VPOSX", -1);
	_swimBar_VPosY = API_GetSymbolIntValue ("SWIMBAR_VPOSY", -1);

	_swimBar_DisplayValueOffsetX = API_GetSymbolIntValue ("SWIMBAR_DISPLAYVALUEOFFSETX", 0);
	_swimBar_DisplayValueOffsetY = API_GetSymbolIntValue ("SWIMBAR_DISPLAYVALUEOFFSETY", -1);

	_focusBar_DisplayValues = API_GetSymbolIntValue ("FOCUSBAR_DISPLAYVALUES", 0);
	_focusBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("FOCUSBAR_VIEW_ALPHAFUNC", 2);
	_focusBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("FOCUSBAR_DISPLAYVALUES_COLOR", "FFFFFF");

	_focusBar_PPosX = API_GetSymbolIntValue ("FOCUSBAR_PPOSX", -1);
	_focusBar_PPosY = API_GetSymbolIntValue ("FOCUSBAR_PPOSY", -1);

	_focusBar_VPosX = API_GetSymbolIntValue ("FOCUSBAR_VPOSX", -1);
	_focusBar_VPosY = API_GetSymbolIntValue ("FOCUSBAR_VPOSY", -1);

	_focusBar_DisplayValueOffsetX = API_GetSymbolIntValue ("FOCUSBAR_DISPLAYVALUEOFFSETX", 0);
	_focusBar_DisplayValueOffsetY = API_GetSymbolIntValue ("FOCUSBAR_DISPLAYVALUEOFFSETY", +1);

	//--

	_betterBars_Font = API_GetSymbolStringValue ("BETTERBARS_FONT", "FONT_OLD_10_WHITE.TGA");

	//--

	//Add listeners for closing menu - will reload options
	MenuLeaveEvent_AddListener(_event_MenuLeave__BetterBars);

	//Reload options explicitly
	ReloadIniOptions__BetterBars();

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
	vHealthBarBackTexView = View_Get (bHealthBar.v0); //back texture

	//hHealthPreviewView is View created by Bar_CreatePreviewView
	if (!Hlp_IsValidHandle (hHealthPreviewView)) {
		hHealthPreviewView = Bar_CreatePreviewView (hHealthBar, _tex_BarPreview_HealthBar);
		View_SetAlpha (hHealthPreviewView, 255);
	};

	if (!Hlp_IsValidHandle (hHealthBarValueView)) {
		hHealthBarValueView = Bar_CreateValuesView (hHealthBar, STR_EMPTY);
		View_AddText (hHealthBarValueView, 0, 0, STR_EMPTY, _betterBars_Font);
		View_SetAlphaFunc (hHealthBarValueView, _healthBar_DisplayValues_AlphaFunc);
		View_SetIntFlags (hHealthBarValueView, VIEW_AUTO_ALPHA | VIEW_AUTO_RESIZE | VIEW_TXT_HCENTER | VIEW_TXT_VCENTER);
	};

	vHealthBarValueView = View_Get (hHealthBarValueView);

	//Create mana bar
	if (!Hlp_IsValidHandle(hManaBar)) {
		hManaBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hManaBar, manaBar.texValue);
		Bar_Hide (hManaBar);
	};

	bManaBar = get (hManaBar);
	vManaBarBackTexView = View_Get (bManaBar.v0); //back texture

	//hManaPreviewView is View created by Bar_CreatePreviewView
	if (!Hlp_IsValidHandle (hManaPreviewView)) {
		hManaPreviewView = Bar_CreatePreviewView (hManaBar, _tex_BarPreview_ManaBar);
		View_SetAlpha (hManaPreviewView, 255);
	};

	if (!Hlp_IsValidHandle (hManaBarValueView)) {
		hManaBarValueView = Bar_CreateValuesView (hManaBar, STR_EMPTY);
		View_AddText (hManaBarValueView, 0, 0, STR_EMPTY, _betterBars_Font);
		View_SetAlphaFunc (hManaBarValueView, _manaBar_DisplayValues_AlphaFunc);
		View_SetIntFlags (hManaBarValueView, VIEW_AUTO_ALPHA | VIEW_AUTO_RESIZE | VIEW_TXT_HCENTER | VIEW_TXT_VCENTER);
	};

	vManaBarValueView = View_Get (hManaBarValueView);

	//Create swim bar
	if (!Hlp_IsValidHandle(hSwimBar)) {
		hSwimBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hSwimBar, swimBar.texValue);
		Bar_Hide (hSwimBar);
	};

	bSwimBar = get (hSwimBar);
	vSwimBarBackTexView = View_Get (bSwimBar.v0); //back texture

	if (!Hlp_IsValidHandle (hSwimBarValueView)) {
		hSwimBarValueView = Bar_CreateValuesView (hSwimBar, STR_EMPTY);
		View_AddText (hSwimBarValueView, 0, 0, STR_EMPTY, _betterBars_Font);
		View_SetAlphaFunc (hSwimBarValueView, _focusBar_DisplayValues_AlphaFunc);
		View_SetIntFlags (hSwimBarValueView, VIEW_AUTO_ALPHA | VIEW_AUTO_RESIZE | VIEW_TXT_HCENTER | VIEW_TXT_VCENTER);
	};

	vSwimBarValueView = View_Get (hSwimBarValueView);

	//Create focus bar
	if (!Hlp_IsValidHandle(hFocusBar)) {
		hFocusBar = Bar_Create (GothicBar@);
		Bar_SetBarTexture (hFocusBar, focusBar.texValue);
		Bar_Hide (hFocusBar);
	};

	bFocusBar = get (hFocusBar);
	vFocusBarBackTexView = View_Get (bFocusBar.v0); //back texture

	if (!Hlp_IsValidHandle (hFocusBarValueView)) {
		hFocusBarValueView = Bar_CreateValuesView (hFocusBar, STR_EMPTY);
		View_AddText (hFocusBarValueView, 0, 0, STR_EMPTY, _betterBars_Font);
		View_SetAlphaFunc (hFocusBarValueView, _focusBar_DisplayValues_AlphaFunc);
		View_SetIntFlags (hFocusBarValueView, VIEW_AUTO_ALPHA | VIEW_AUTO_RESIZE | VIEW_TXT_HCENTER | VIEW_TXT_VCENTER);
	};

	vFocusBarValueView = View_Get (hFocusBarValueView);

	//--

	FF_ApplyOnceExtGT (FF_BetterBars, 0, -1);
};
