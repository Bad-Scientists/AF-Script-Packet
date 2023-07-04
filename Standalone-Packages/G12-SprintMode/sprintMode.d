/*
 *	Sprint mode
 *		- toggle 'keySprintModeToggleKey' key to enable/disable sprint mode
 *		- 'keySprintModeToggleKey' can be defined either in Gothic.ini file section [KEYS] or mod.ini file section [KEYS]. (master is Gothic.ini)
 *		- if 'keySprintModeToggleKey' is not defined then by default KEY_RSHIFT will be used for toggling
 *
 *		- this feature adds stamina bar right underneath health bar, where it displays players stamina level
 *		- when player is exhausted sprint mode will disable with a cool down of 4 seconds
 *		- jumping and fighting exhausts stamina significantly
 *
 *		- you need to maintain stamina levels for player by yourself - set PC_SprintModeStaminaMax to whatever value makes sense to you at the beginning of the game in your STARTUP function:
 *			PC_SprintModeStaminaMax = 80;				//Max stamina level
 *			PC_SprintModeStamina = PC_SprintModeStaminaMax;		//Current stamina level
 *			PC_SprintModeConsumeStamina = TRUE;			//Make sure this is set to true
 *
 *		- potions of speed disable stamina consumption
 *		- potions of speed will have their own texture in stamina bar - you will see how much time is left from potion effect
 *
 *		- this feature restores potion effect (timed overlay) on game load
 *		- it also fixes error where multiple potion effects (multiple timed overlays with different times) would remove overlay
 *
 *	Requires LeGo flags: LeGo_HookEngine | LeGo_FrameFunctions | LeGo_Bars
 */

//-- Internal variables

var int PC_SprintMode;
var int PC_SprintModeSwitch;
var int PC_SprintModeDisable;

var int PC_SprintModeStamina;
var int PC_SprintModeStaminaMax;

var int PC_SprintModeConsumeStamina;

var int PC_SprintModeCooldown;
var int PC_SprintModeRemovedByExhaustion;
var int PC_SprintModeBarAlpha;
var int PC_SprintModeBarFlashingTimer;
var int PC_SprintModeBarFlashingFadeOut;

var int PC_SprintModePlayerHasTimedOverlay;
var int PC_SprintModePlayerTimedOverlayTimer;
var int PC_SprintModePlayerTimedOverlayTimerMax;
var int PC_SprintModePlayerTimedOverlayDetected;

//-- Internal variables

var int _PC_SprintModeBar_PPosX;
var int _PC_SprintModeBar_PPosY;

var int _PC_SprintModeBar_VPosX;
var int _PC_SprintModeBar_VPosY;

var string _PC_SprintModeBar_Tex;
var string _PC_SprintModeBar_Timed_Tex;

var string _PC_SprintModeOverlayName;

var int _PC_SprintMode_IgnoreWithOverlays_Count;
const int _PC_SprintMode_IgnoreWithOverlays_Max = 255; //We probably don't need 255
var string _PC_SprintMode_IgnoreWithOverlays[_PC_SprintMode_IgnoreWithOverlays_Max];

var int _PC_SprintModeTimedOverlayStacking;

var int _staminaBar_DisplayTime;

var string _PC_SprintMode_Font;

//--

func void _eventGameStateLoaded__SprintMode (var int state) {
	//Restore time overlay effect on game load
	if (state == Gamestate_Loaded) {
		if (PC_SprintModePlayerHasTimedOverlay) {
			if (!NPC_HasTimedOverlay (hero, _PC_SprintModeOverlayName)) {
				Mdl_ApplyOverlayMdsTimed (hero, _PC_SprintModeOverlayName, PC_SprintModePlayerTimedOverlayTimer);
			};
		};
	};
};

func void PlayerResetWeaponMode__SprintMode () {
	var oCNpc her; her = Hlp_GetNPC (hero);
	var int fmode; fmode = her.fmode;
	if (fmode != FMODE_NONE) {
		oCNpc_SetWeaponMode2 (her, FMODE_NONE);
		oCNpc_SetWeaponMode2 (her, fmode);
	};
};

func void _eventGameHandleEvent__SprintMode (var int dummyVariable) {
	var int cancel; cancel = FALSE;
	var int key; key = MEM_ReadInt (ESP + 4);
	if (!key) { return; };

	if (!Hlp_IsValidNPC (hero)) { return; };
	if (Npc_IsDead (hero)) { return; };

	//Activate sprint mode
	//We have to check MEM_GetKey, MEM_GetSecondaryKey because of menu items (user can change keys during gameplay) (how much does this affect performance?)
	if ((key == MEM_GetKey ("keySprintModeToggleKey")) || (key == MEM_GetSecondaryKey ("keySprintModeToggleKey"))) {
		//Toggle if not in cool down
		if (!PC_SprintModeCooldown) {
			PC_SprintModeSwitch = (!PC_SprintModeSwitch);
		} else {
			PC_SprintModeRemovedByExhaustion = TRUE;
		};

		//Activate
		if (PC_SprintModeSwitch) {
			var int dontActivate; dontActivate = FALSE;

			if (_PC_SprintMode_IgnoreWithOverlays_Count > 0) {
				repeat (i, _PC_SprintMode_IgnoreWithOverlays_Count); var int i;
					var string ignoreOverlay; ignoreOverlay = MEM_ReadStringArray (_@s (_PC_SprintMode_IgnoreWithOverlays), i);

					if (NPC_HasOverlay (hero, ignoreOverlay)) || (NPC_HasTimedOverlay (hero, ignoreOverlay)) {
						dontActivate = TRUE;
						break;
					};
				end;
			};

			if (!NPC_CanChangeOverlay (hero)) {
				dontActivate = TRUE;
			};

			if (dontActivate) {
				//Don't enable sprint mode if player already has HUMANS_SPRINT.MDS overlay or if he is drunk :)
				PC_SprintModeSwitch = FALSE;

				//--> Bugfix: set sprintmode to true if player already has relevant overlay!
				//In G1 with spell SPL_CONTROL I had enabled sprint mode on player
				//then I controlled Npc and disabled sprint mode on the Npc (PC_SprintMode variable was set to FALSE) & released control
				//Because of that PC_Hero had sprint mode overlay already applied --> this completely broke sprint mode feature and player could run forever :)
				if (!PC_SprintMode) {
					if (NPC_HasOverlay (hero, _PC_SprintModeOverlayName)) {
						PC_SprintMode = TRUE;
						PC_SprintModeDisable = TRUE;
					};
				};
				//<--
			} else {
				PC_SprintMode = TRUE;

				if (_staminaBar_DisplayTime) {
					_staminaBar_DisplayTime = 120 - _staminaBar_DisplayTime;
				};

				Mdl_ApplyOverlayMds (hero, _PC_SprintModeOverlayName);
				PlayerResetWeaponMode__SprintMode ();
			};
		} else {
			//Deactivate - we can't remove overlay immediately, so we use PC_SprintModeDisable and script bellow will perform additional checks
			if (PC_SprintMode) {
				PC_SprintModeDisable = TRUE;
			};
		};

		cancel = TRUE;
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

//Disable sprint mode once stamina is exhausted
func void DisableExhausted_SprintMode () {
	if (PC_SprintMode) {
		PC_SprintModeDisable = TRUE;
	};

	if (!PC_SprintModeCooldown) {
		PC_SprintModeCooldown = TRUE;
		PC_SprintModeBarFlashingFadeOut = TRUE;

		if (PC_SprintMode) {
			PC_SprintModeRemovedByExhaustion = TRUE;
		};
	};

	PC_SprintModeBarFlashingTimer = 80;
};

/*
 * Dynamic position update
 */
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

func void FrameFunction__SprintMode () {
	if (!Hlp_IsValidNPC (hero)) { return; };
	if (Npc_IsDead (hero)) { return; };

	//Get animation name
	var string aniName; aniName = NPC_GetAniName (hero);

	//Is player walking?
	var int isWalking; isWalking = NPC_IsWalking (hero);

	//Is player fighting?
	var int isInFistAttack; isInFistAttack = (STR_IndexOf (aniName, "_FISTATTACK") > -1);
	var int is1H; is1H = (STR_IndexOf (aniName, "_1H") > -1);
	var int is2H; is2H = (STR_IndexOf (aniName, "_2H") > -1);
	var int isInBowMode; isInBowMode = (STR_IndexOf (aniName, "_BOW") > -1);
	var int isInCBowMode; isInCBowMode = (STR_IndexOf (aniName, "_CBOW") > -1);

	/*
	//Commented out - checking for bodystate BS_JUMP is enough
	var int isJumping; isJumping = (STR_IndexOf (aniName, "JUMP") > -1);

	if (isJumping) {
		if (Hlp_StrCmp (aniName, "T_JUMPB")) {
			isJumping = FALSE;
		};
	};
	*/

	//Is player jumping? [C_BodyStateContains (hero, BS_JUMP)]
	var int isJumping; isJumping = ((NPC_GetBodyState (hero) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_JUMP & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)));

	//Does player have timed overlay ?
	PC_SprintModePlayerHasTimedOverlay = NPC_HasTimedOverlay (hero, _PC_SprintModeOverlayName);

	//If I remove overlay while jumping then players animation will 'stutter', that's why I can remove overlay only once player is not jumping
	if (PC_SprintModeDisable) {
		//We can't remove overlay if player has meanwhile timed overlay
		if (!isJumping) && (!PC_SprintModePlayerHasTimedOverlay) {
			PC_SprintMode = FALSE;
			PC_SprintModeSwitch = FALSE;
			PC_SprintModeDisable = FALSE;

			if (NPC_HasOverlay (hero, _PC_SprintModeOverlayName)) {
				Mdl_RemoveOverlayMds (hero, _PC_SprintModeOverlayName);
				PlayerResetWeaponMode__SprintMode ();
			};
		};
	};

	//Stamina regen
	if ((!PC_SprintMode) || (!isWalking)) {
		if ((!isInFistAttack) && (!is1H) && (!is2H) && (!isJumping) && (!isInBowMode) && (!isInCBowMode)) {
			if (PC_SprintModeStamina < PC_SprintModeStaminaMax) {
				PC_SprintModeStamina += 1;
			};
		};
	};

	//Remove duplicated timed overlays
	if (PC_SprintModePlayerHasTimedOverlay) {
		NPC_RemoveDuplicatedTimedOverlays (hero, _PC_SprintModeOverlayName, _PC_SprintModeTimedOverlayStacking);
	};

	//Option to disable consumption if needed
	if (PC_SprintModeConsumeStamina) {
		//If hero drunk speed potions then don't consume stamina
		if (!PC_SprintModePlayerHasTimedOverlay) {

			//Stamina consumption
			if (isWalking) {
				if (PC_SprintMode) {
					if (PC_SprintModeStamina > 0) {
						PC_SprintModeStamina -= 1;
					};
				};
			};

			if (isInFistAttack) { PC_SprintModeStamina -= 5; };

			if (is1H) { PC_SprintModeStamina -= 5; };

			if (is2H) { PC_SprintModeStamina -= 5; };

			if (isInBowMode) { PC_SprintModeStamina -= 5; };

			if (isInCBowMode) { PC_SprintModeStamina -= 5; };

			if (isJumping) { PC_SprintModeStamina -= 5; };
		};
	};

	if (PC_SprintModeStamina < 0) { PC_SprintModeStamina = 0; };

	if (PC_SprintModeStamina == 0) {
		//Cancel sprint mode - hero is exhausted
		DisableExhausted_SprintMode ();
	};

	//If sprint mode was removed by exhaustion - reset variable as soon as cooldown is gone (by default we will keep bar on screen during cool down)
	if (PC_SprintModeRemovedByExhaustion) {
		if (!PC_SprintModeCooldown) {
			PC_SprintModeRemovedByExhaustion = FALSE;
		};
	};

	//First time this is called player will most likely not have timed overlay - so set to 1 in order to 'reset' texture
	if (PC_SprintModePlayerHasTimedOverlay) {
		//Get timer value - this is current value
		PC_SprintModePlayerTimedOverlayTimer = roundf (NPC_GetTimedOverlayTimer (hero, _PC_SprintModeOverlayName));

		//If PC_SprintModePlayerTimedOverlayDetected == FALSE then this is first time script detected timed overlay, get max value and adjust texture
		if (!PC_SprintModePlayerTimedOverlayDetected)
		//Update if player drunk potion with longer lasting effect
		|| (PC_SprintModePlayerTimedOverlayTimer > PC_SprintModePlayerTimedOverlayTimerMax)
		{
			//Get timer value - first value will be considered max value
			PC_SprintModePlayerTimedOverlayTimerMax = roundf (NPC_GetTimedOverlayTimer (hero, _PC_SprintModeOverlayName));
			PC_SprintModePlayerTimedOverlayDetected = TRUE;

			Bar_SetBarTexture (hStaminaBar, _PC_SprintModeBar_Timed_Tex);
		};

		//Set max and current value for timed overlay
		Bar_SetMax (hStaminaBar, PC_SprintModePlayerTimedOverlayTimerMax);
		Bar_SetValue (hStaminaBar, PC_SprintModePlayerTimedOverlayTimer);

		//Disable sprint mode
		if (PC_SprintMode) {
		//	PC_SprintMode = FALSE;
		//	PC_SprintModeSwitch = FALSE;
			PC_SprintModeDisable = TRUE;
		};
	} else {
		//if PC_SprintModePlayerTimedOverlayDetected was set to TRUE - then reset and change texture to 'stamina' texture
		if (PC_SprintModePlayerTimedOverlayDetected) {
			PC_SprintModePlayerTimedOverlayDetected = FALSE;

			//If player had overlay - reapply
			if (NPC_HasOverlay (hero, _PC_SprintModeOverlayName)) {
				Mdl_RemoveOverlayMds (hero, _PC_SprintModeOverlayName);
				Mdl_ApplyOverlayMds (hero, _PC_SprintModeOverlayName);
				PlayerResetWeaponMode__SprintMode ();
			};

			Bar_SetBarTexture (hStaminaBar, _PC_SPRINTMODEBAR_TEX);
		};

		//Set max and current value
		Bar_SetMax (hStaminaBar, PC_SprintModeStaminaMax);
		Bar_SetValue (hStaminaBar, PC_SprintModeStamina);
	};
};

func void FrameFunction_FlashBar__SprintMode () {
	//Flash stamina bar if in cool down
	if (PC_SprintModeCooldown) {
		if (PC_SprintModeBarFlashingFadeOut) {
			PC_SprintModeBarAlpha -= 32;
		} else {
			PC_SprintModeBarAlpha += 32;
		};

		if (PC_SprintModeBarAlpha < 0) {
			PC_SprintModeBarAlpha = 0;
			PC_SprintModeBarFlashingFadeOut = (!PC_SprintModeBarFlashingFadeOut);
		};

		if (PC_SprintModeBarAlpha > 255) {
			PC_SprintModeBarAlpha = 255;
			PC_SprintModeBarFlashingFadeOut = (!PC_SprintModeBarFlashingFadeOut);
		};

		PC_SprintModeBarFlashingTimer -= 1;

		if (PC_SprintModeBarFlashingTimer == 0) {
			PC_SprintModeCooldown = FALSE;
		};
	};

	if ((PC_SprintModeCooldown) || (PC_SprintModeBarAlpha < 255))
	{
		if (!PC_SprintModeCooldown) {
			PC_SprintModeBarAlpha += 32;
			PC_SprintModeBarAlpha = clamp (PC_SprintModeBarAlpha, 0, 255);
		};

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alphaBack;

		//Fade in
		if (_staminaBar_DisplayTime > 80) {
			//255 * ((120 - _staminaBar_DisplayTime) / 40)
			alphaBack = roundf (mulf (mkf (255), divf (mkf (120 - _staminaBar_DisplayTime), mkf (40))));
		} else
		//Display
		if (_staminaBar_DisplayTime > 40) {
			alphaBack = 255;
		} else {
		//Fade out
			alphaBack = 255 - roundf (mulf (mkf (255), divf (mkf (40 - _staminaBar_DisplayTime), mkf (40))));
		};

		var int alphaBar; alphaBar = roundf (divf (mulf (mkf (PC_SprintModeBarAlpha), mkf (alphaBack)), mkf (255)));

		//Check boundaries min/max and set alpha
		alphaBar = clamp (alphaBar, 0, 255);

		//Change alpha value for stamina bar
		BBar_SetAlphaBackAndBar (hStaminaBar, -1, alphaBar);
	};
};

/*
 *	Better-bars display method
 */
func void FrameFunction_FadeInOutSprintBar__BetterBars () {
	//If this method returns true - then bar should be 100% visible
	if (BarGetOnDesk (BarType_SprintBar, _staminaBar_DisplayMethod)) {
		BBar_SetAlphaBackAndBar (hStaminaBar, 255, PC_SprintModeBarAlpha);
		return;
	};

	//If we somehow ended up here with bar display method inventory ... then remove display time
	if (_staminaBar_DisplayMethod == BarDisplay_OnlyInInventory) {
		_staminaBar_DisplayTime = 0;
	};

	//If we run out of display time - hide bar
	if (!_staminaBar_DisplayTime) {
		//Bar_Hide (hStaminaBar);
		View_Close(bStaminaBar.v0);
		View_Close(bStaminaBar.v1);
		bStaminaBar.hidden = TRUE;

		FF_Remove (FrameFunction_FadeInOutSprintBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (bStaminaBar.hidden) {
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hStaminaBar);
		};
	};

	//If bar is visible (this is not redundant condition, _Bar_PlayerStatus might return FALSE)
	if (!bStaminaBar.hidden) {
		//Decrease display time
		_staminaBar_DisplayTime -= 1;

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alphaBack;

		//Fade in
		if (_staminaBar_DisplayTime > 80) {
			//255 * ((120 - _staminaBar_DisplayTime) / 40)
			alphaBack = roundf (mulf (mkf (255), divf (mkf (120 - _staminaBar_DisplayTime), mkf (40))));
		} else
		//Display
		if (_staminaBar_DisplayTime > 40) {
			alphaBack = 255;
		} else {
		//Fade out
			alphaBack = 255 - roundf (mulf (mkf (255), divf (mkf (40 - _staminaBar_DisplayTime), mkf (40))));
		};

		//Check boundaries min/max and set alpha
		alphaBack = clamp (alphaBack, 0, 255);

		var int alphaBar; alphaBar = roundf (divf (mulf (mkf (PC_SprintModeBarAlpha), mkf (alphaBack)), mkf (255)));

		//Check boundaries min/max and set alpha
		alphaBar = clamp (alphaBar, 0, 255);

		//Bar_SetAlpha (hStaminaBar, alphaBack);
		BBar_SetAlphaBackAndBar (hStaminaBar, alphaBack, alphaBar);
	};
};

func void FrameFunction_EachFrame__SprintMode () {

	var string s;
	var int _staminaBar_LastValue;
	var int _staminaBar_LastMaxValue;

	var int sprintBarOnDesk; sprintBarOnDesk = BarGetOnDesk (BarType_SprintBar, _staminaBar_DisplayMethod);

	var int _playerStatus; _playerStatus = _Bar_PlayerStatus ();

//-- Auto hiding/display for sprint bar (when updated)

	//Was there an update?
	var int sprintBarUpdated; sprintBarUpdated = FALSE;

	var int _staminaBarVal_LastValue;

	//Potion effect
	if (PC_SprintModePlayerHasTimedOverlay) {
		if (_staminaBarVal_LastValue != PC_SprintModePlayerTimedOverlayTimer) {
			sprintBarUpdated = TRUE;
			_staminaBarVal_LastValue = PC_SprintModePlayerTimedOverlayTimer;
		};
	} else
	//'Standard' sprinting
	if (_staminaBarVal_LastValue != PC_SprintModeStamina) {
		//Consider bar updated whenever sprint mode is activated, or when sprint was on cooldown previously
		if (PC_SprintMode || PC_SprintModeRemovedByExhaustion) {
			sprintBarUpdated = TRUE;
			_staminaBarVal_LastValue = PC_SprintModeStamina;
		};
	};

	//Display only in inventory ...
	if ((_staminaBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!sprintBarOnDesk) && (!_staminaBar_ForceOnDesk)) {
		//... don't do anything :)
	} else
	//Sprint bar value updated / game status changed / fight mode
	if ((_staminaBar_ForceOnDesk) || (sprintBarUpdated) || (oCGame_GetHeroStatus ()) || (!Npc_IsInFightMode (hero, FMODE_NONE))) {
		//
		if ((_staminaBar_DisplayMethod != BarDisplay_AlwaysOn) && (!sprintBarOnDesk)) {
			if (_staminaBar_DisplayMethod == BarDisplay_DynamicUpdate) {
				if (!_staminaBar_DisplayTime) {
					_staminaBar_DisplayTime = 120;
				};
			};
		};

		if (_staminaBar_DisplayTime < 80) {
			_staminaBar_DisplayTime = 80;
		};

		FF_ApplyOnceExtGT (FrameFunction_FadeInOutSprintBar__BetterBars, 60, -1);
	};

	if ((_staminaBar_DisplayMethod == BarDisplay_AlwaysOn) || (sprintBarOnDesk) || (_staminaBar_DisplayTime))
	{
		if (_playerStatus) {
			if ((bStaminaBar.hidden) || ((!bStaminaBar.hidden && _staminaBar_WasHidden))) {
				//Bar_SetAlpha (hStaminaBar, 0);
				BBar_SetAlphaBackAndBar (hStaminaBar, 0, 0);

				if ((_staminaBar_DisplayMethod == BarDisplay_AlwaysOn) || (sprintBarOnDesk)) {
					if (!_staminaBar_DisplayTime) {
						//Bar_SetAlpha (hStaminaBar, 255);
						BBar_SetAlphaBackAndBar (hStaminaBar, 255, PC_SprintModeBarAlpha);
					};
				};

				//Bar_Show (hStaminaBar);
				View_Open (bStaminaBar.v0);
				View_Open (bStaminaBar.v1);
				bStaminaBar.hidden = FALSE;

				StaminaBar_UpdatePosition ();

				//Open bar values view
				View_Open (vStaminaBarValue);
				View_Resize (vStaminaBarValue, bStaminaBar.barW, -1);

				//Re-arrange views - first background texture view, second 'preview' view, then bar texture view and finally bar values
				View_Top(bStaminaBar.v0);
				//View_Top(vStaminaPreview);
				View_Top(bStaminaBar.v1);
				View_Top(vStaminaBarValue);

				_staminaBar_WasHidden = FALSE;
			};
		};
	};

	if ((_staminaBar_DisplayMethod != BarDisplay_AlwaysOn) && (!sprintBarOnDesk) && (!_staminaBar_DisplayTime))
	|| ((_staminaBar_DisplayMethod == BarDisplay_OnlyInInventory) && (!sprintBarOnDesk))
	{
		if (_playerStatus) {
			if (!bStaminaBar.hidden) {
				//Bar_Hide (hStaminaBar);
				View_Close(bStaminaBar.v0);
				View_Close(bStaminaBar.v1);
				bStaminaBar.hidden = TRUE;

				View_Close (vStaminaBarValue);
			};
		};
	};

	//Bar_PreviewSetValue (hStaminaBar, vStaminaPreview, previewValueSprintBar);

//-- Add Stamina bar values

	if (_playerStatus) {
		//Bar_DisplayValue_Update (hStaminaBar, _staminaBar_DisplayValues);
		var int stamina;
		var int staminaMax;

		if (PC_SprintModePlayerHasTimedOverlay) {
			stamina = PC_SprintModePlayerTimedOverlayTimer;
			staminaMax = PC_SprintModePlayerTimedOverlayTimerMax;
		} else {
			stamina = PC_SprintModeStamina;
			staminaMax = PC_SprintModeStaminaMax;
		};

		if ((stamina != _staminaBar_LastValue) || (staminaMax != _staminaBar_LastMaxValue))
		{
			if (PC_SprintModePlayerHasTimedOverlay) {
				var int hasteTimer; hasteTimer = stamina / 1000;
				var int hasteTimerMax; hasteTimerMax = staminaMax / 1000;

				s = " / ";
				s = ConcatStrings (IntToString (hasteTimer), s);
				s = ConcatStrings (s, IntToString (hasteTimerMax));
			} else {
				s = " / ";
				s = ConcatStrings (IntToString (PC_SprintModeStamina), s);
				s = ConcatStrings (s, IntToString (PC_SprintModeStaminaMax));
			};

			View_SetTextMarginAndFontColor (vStaminaBarValue, s, _staminaBar_DisplayValues_Color, 0);
		};

		_staminaBar_LastValue = stamina;
		_staminaBar_LastMaxValue = staminaMax;
	};

	if (_playerStatus) {
		StaminaBar_UpdatePosition ();
	};
};

func void G12_SprintMode_Init () {

	G12_InitDefaultBarFunctions ();

	//-- Load API values / init default values
	_PC_SprintModeBar_PPosX = API_GetSymbolIntValue ("PC_SPRINTMODEBAR_PPOSX", -1);
	_PC_SprintModeBar_PPosY = API_GetSymbolIntValue ("PC_SPRINTMODEBAR_PPOSY", -1);

	_PC_SprintModeBar_VPosX = API_GetSymbolIntValue ("PC_SPRINTMODEBAR_VPOSX", -1);
	_PC_SprintModeBar_VPosY = API_GetSymbolIntValue ("PC_SPRINTMODEBAR_VPOSY", -1);

	_PC_SprintModeBar_Tex = API_GetSymbolStringValue ("PC_SPRINTMODEBAR_TEX", "BAR_MISC.TGA");
	_PC_SprintModeBar_Timed_Tex = API_GetSymbolStringValue ("PC_SPRINTMODEBAR_TIMED_TEX", "BAR_SPRINTMODE_TIMEDOVERLAY.TGA");

	_PC_SprintModeOverlayName = API_GetSymbolStringValue ("PC_SPRINTMODEOVERLAYNAME", "HUMANS_SPRINT.MDS");

	_PC_SprintMode_IgnoreWithOverlays_Count = API_GetSymbolIntValue ("PC_SPRINTMODE_IGNOREWITHOVERLAYS_COUNT", 0);

	//--

	_staminaBar_DisplayMethod = API_GetSymbolIntValue ("SPRINTBAR_DISPLAYMETHOD", BarDisplay_DynamicUpdate);
	_staminaBar_PreviewEffect = API_GetSymbolIntValue ("SPRINTBAR_PREVIEWEFFECT", BarPreviewEffect_FadeInOut);

	_staminaBar_DisplayValues = API_GetSymbolIntValue ("SPRINTBAR_DISPLAYVALUES", 0);
	_staminaBar_DisplayValues_AlphaFunc = API_GetSymbolIntValue ("SPRINTBAR_VIEW_ALPHAFUNC", 2);
	_staminaBar_DisplayValues_Color = API_GetSymbolHEX2RGBAValue ("SPRINTBAR_DISPLAYVALUES_COLOR", "FFFFFF");

	//--

	if (_PC_SprintMode_IgnoreWithOverlays_Count > _PC_SprintMode_IgnoreWithOverlays_Max) {
		_PC_SprintMode_IgnoreWithOverlays_Count = _PC_SprintMode_IgnoreWithOverlays_Max;
	};

	if (_PC_SprintMode_IgnoreWithOverlays_Count == 0) {
		//Default overlays where sprint will be ignored
		_PC_SprintMode_IgnoreWithOverlays_Count = 2;

		MEM_WriteStringArray (_@s (_PC_SprintMode_IgnoreWithOverlays), 0, "HUMANS_SPRINT.MDS");
		MEM_WriteStringArray (_@s (_PC_SprintMode_IgnoreWithOverlays), 1, "HUMANS_DRUNKEN.MDS");

	} else {
		repeat (i, _PC_SprintMode_IgnoreWithOverlays_Count); var int i;
			var string symbName; symbName = ConcatStrings ("PC_SPRINTMODE_IGNOREWITHOVERLAYS", IntToString (i));
			var string ignoreOverlay; ignoreOverlay = API_GetSymbolStringValue (symbName, "");
			MEM_WriteStringArray (_@s (_PC_SprintMode_IgnoreWithOverlays), i, ignoreOverlay);
		end;
	};

	_PC_SprintModeTimedOverlayStacking = API_GetSymbolIntValue ("PC_SPRINTMODEBAR_TIMEDOVERLAY_STACKING", 0);

	//Sprint mode - initial value
	var int sprintModeValuesInitialized;
	if (!sprintModeValuesInitialized) {
		PC_SprintModeStaminaMax = API_GetSymbolIntValue ("PC_SPRINTMODE_STAMINAMAX_DEFAULT", 80);
		PC_SprintModeStamina = PC_SprintModeStaminaMax;

		PC_SprintModeConsumeStamina = API_GetSymbolIntValue ("PC_SPRINTMODE_CONSUMESTAMINA_DEFAULT", TRUE);
	};

	//--

	_PC_SprintMode_Font = API_GetSymbolStringValue ("PC_SPRINTMODE_FONT", "FONT_OLD_10_WHITE.TGA");

	//--

	//Add frame function (8/1s)
	FF_ApplyOnceExtGT (FrameFunction__SprintMode, 125, -1);
	FF_ApplyOnceExtGT (FrameFunction_FlashBar__SprintMode, 60, -1);
	FF_ApplyOnceExtGT (FrameFunction_EachFrame__SprintMode, 0, -1);

	//Create stamina bar
	if (!Hlp_IsValidHandle(hStaminaBar)) {
		hStaminaBar = Bar_Create (GothicBar@);

		//Initialize texture
		Bar_SetBarTexture (hStaminaBar, _PC_SprintModeBar_Tex);

		PC_SprintModeBarAlpha = 255;
		PC_SprintModeBarFlashingFadeOut = FALSE;

		Bar_Hide (hStaminaBar);
	};

	bStaminaBar = get (hStaminaBar);

	if (!Hlp_IsValidHandle (vStaminaBarValue)) {
		vStaminaBarValue = Bar_CreatePreview (hStaminaBar, "");
		View_AddText (vStaminaBarValue, 0, 0, "", _PC_SprintMode_Font);
		View_SetAlphaFunc (vStaminaBarValue, _staminaBar_DisplayValues_AlphaFunc);
	};

	//Init Game key events
	G12_GameHandleEvent_Init ();

	//Add listener for key
	GameHandleEvent_AddListener (_eventGameHandleEvent__SprintMode);

	//Add listener for loaded game
	if (_LeGo_Flags & LeGo_Gamestate) {
		Gamestate_AddListener (_eventGameStateLoaded__SprintMode);
	};

	//Load controls from .ini files Gothic.ini is master, mod.ini is secondary
	//onChgSetOption          = "keySprintModeToggleKey";
	//onChgSetOptionSection   = "KEYS";

	//Custom key from Gothic.ini
	if (!MEM_GothOptExists ("KEYS", "keySprintModeToggleKey")) {
		//Custom key from mod .ini file
		if (!MEM_ModOptExists ("KEYS", "keySprintModeToggleKey")) {
			//KEY_RSHIFT if not specified
			MEM_SetKey ("keySprintModeToggleKey", KEY_RSHIFT);
		} else {
			//Update from mod .ini file
			var string keyString; keyString = MEM_GetModOpt ("KEYS", "keySprintModeToggleKey");
			MEM_SetKey ("keySprintModeToggleKey", MEM_GetKey (keyString));
		};
	};

	//Custom sprint mode overlay
	if (!MEM_GothOptExists ("SPRINTMODE", "overlayName")) {
		//Custom key from mod .ini file
		if (!MEM_ModOptExists ("SPRINTMODE", "overlayName")) {
			//Keep default constant
		} else {
			//Update from mod .ini file
			_PC_SprintModeOverlayName = MEM_GetModOpt ("SPRINTMODE", "overlayName");
		};
	} else {
		//Update from Gothic.ini
		_PC_SprintModeOverlayName = MEM_GetGothOpt ("SPRINTMODE", "overlayName");
	};

	//Custom setup from Gothic.ini
	if (MEM_GothOptExists ("GAME", "_staminaBar_DisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - alwas on
		_staminaBar_DisplayMethod = STR_ToInt (MEM_GetGothOpt ("GAME", "_staminaBar_DisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("GAME", "_staminaBar_DisplayMethod")) {
			_staminaBar_DisplayMethod = STR_ToInt (MEM_GetModOpt ("GAME", "_staminaBar_DisplayMethod"));
			MEM_SetGothOpt ("GAME", "_staminaBar_DisplayMethod", IntToString (_staminaBar_DisplayMethod));
		} else {
			//Default
			_staminaBar_DisplayMethod = BarDisplay_DynamicUpdate;
			MEM_SetGothOpt ("GAME", "_staminaBar_DisplayMethod", IntToString (_staminaBar_DisplayMethod));
		};
	};
};
