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
var int PC_SprintModeBarAlpha;
var int PC_SprintModeBarFlashingTimer;
var int PC_SprintModeBarFlashingFadeOut;

var int PC_SprintModePlayerHasTimedOverlay;
var int PC_SprintModePlayerTimedOverlayTimer;
var int PC_SprintModePlayerTimedOverlayTimerMax;
var int PC_SprintModePlayerTimedOverlayDetected;

//--
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
			} else {
				PC_SprintMode = TRUE;
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
	};

	PC_SprintModeBarFlashingTimer = 80;
};

func void FrameFunction__SprintMode () {
	if (!Hlp_IsValidNPC (hero)) { return; };

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

	var int posX;
	var int posY;
	var int scaleF; scaleF = _getInterfaceScaling ();

	//Move bar right underneath health bar (if modder didn't define his own values)
	if (_PC_SprintModeBar_PPosY == -1) {
		if (MEM_Game.hpBar) {
			var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);

			//These LeGo bars have weird positions :-/
			posX = hpBar.zCView_pposx + (hpBar.zCView_psizex / 2);
			posY = hpBar.zCView_pposy + (hpBar.zCView_psizey / 2) * 2;
		};
	} else {
		posX = _PC_SprintModeBar_PPosX;
		posY = _PC_SprintModeBar_PPosY;
	};

	posX = Print_ToVirtual (posX, PS_X);
	posY = Print_ToVirtual (posY, PS_Y);

	if (_PC_SprintModeBar_VPosX > -1) {
		posX = _PC_SprintModeBar_VPosX;
	};

	if (_PC_SprintModeBar_VPosY > -1) {
		posY = _PC_SprintModeBar_VPosY;
	};

	//Bar_MoveTo (hStaminaBar, posX, posY);
	_Bar_MoveTo_Internal (hStaminaBar, posX, posY);
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
			PC_SprintModeBarAlpha = 255;
			PC_SprintModeCooldown = FALSE;
		};

		//Change alpha value for stamina bar
		Bar_SetAlphaBackAndBar (hStaminaBar, -1, PC_SprintModeBarAlpha);
	};
};

/*
 *	Better-bars display method
 */
func void FrameFunction_FadeInOutSprintBar__BetterBars () {
	//If this method returns true - then bar should be 100% visible
	if (BarGetOnDesk (BarType_SprintBar, sprintBarDisplayMethod)) {
		Bar_SetAlphaBackAndBar (hStaminaBar, 255, PC_SprintModeBarAlpha);
		return;
	};

	//If we somehow ended up here with bar display method inventory ... then remove display time
	if (sprintBarDisplayMethod == BarDisplay_OnlyInInventory) {
		sprintBarDisplayTime = 0;
	};

	//If we run out of display time - hide bar
	if (!sprintBarDisplayTime) {
		Bar_Hide (hStaminaBar);

		FF_Remove (FrameFunction_FadeInOutSprintBar__BetterBars);
		return;
	};

	//Check - is bar visible? If not show it
	if (!Bar_IsVisible (hStaminaBar)) {
		if (_Bar_PlayerStatus ()) {
			Bar_Show (hStaminaBar);
		};
	};

	//If bar is visible (this is not redundant condition, _Bar_PlayerStatus might return FALSE)
	if (Bar_IsVisible (hStaminaBar)) {
		//Decrease display time
		sprintBarDisplayTime -= 1;

		/*
			Fade effect logic - in relation to display time:
			Fade in		Display		Fade out
			120 - 80	80 - 40		40 - 0
		*/
		var int alphaBack;
		var int alphaBar;

		//Fade in
		if (sprintBarDisplayTime > 80) {
			alphaBack = roundf (mulf (mkf (255), divf (mkf (120 - sprintBarDisplayTime), mkf (40))));
		} else
		//Display
		if (sprintBarDisplayTime > 40) {
			alphaBack = 255;
		} else {
		//Fade out
			alphaBack = 255 - roundf (mulf (mkf (255), divf (mkf (40 - sprintBarDisplayTime), mkf (40))));
		};

		//Check boundaries min/max and set alpha
		alphaBack = clamp (alphaBack, 0, 255);
		alphaBar = alphaBack * PC_SprintModeBarAlpha / 255; //bar might be flashing in & out

		//Bar_SetAlpha (hStaminaBar, alphaBack);
		Bar_SetAlphaBackAndBar (hStaminaBar, alphaBack, alphaBar);
	};
};

func void FrameFunction_EachFrame__SprintMode () {
	//Custom setup from Gothic.ini
	if (MEM_GothOptExists ("GAME", "sprintBarDisplayMethod")) {
		//0 - standard, 1 - dynamic update, 2 - alwas on
		sprintBarDisplayMethod = STR_ToInt (MEM_GetGothOpt ("GAME", "sprintBarDisplayMethod"));
	} else {
		//Custom setup from mod .ini file
		if (MEM_ModOptExists ("GAME", "sprintBarDisplayMethod")) {
			sprintBarDisplayMethod = STR_ToInt (MEM_GetModOpt ("GAME", "sprintBarDisplayMethod"));
			MEM_SetGothOpt ("GAME", "sprintBarDisplayMethod", IntToString (sprintBarDisplayMethod));
		} else {
			//Default
			sprintBarDisplayMethod = BarDisplay_DynamicUpdate;
			MEM_SetGothOpt ("GAME", "sprintBarDisplayMethod", IntToString (sprintBarDisplayMethod));
		};
	};

	var int sprintBarOnDesk; sprintBarOnDesk = BarGetOnDesk (BarType_SprintBar, sprintBarDisplayMethod);

//-- Auto hiding/display for sprint bar (when updated)

	//Was there an update?
	var int sprintBarUpdated; sprintBarUpdated = FALSE;

	//Potion effect
	if (PC_SprintModePlayerHasTimedOverlay) {
		if (sprintBarLastValue != PC_SprintModePlayerTimedOverlayTimer) {
			sprintBarUpdated = TRUE;
			sprintBarLastValue = PC_SprintModePlayerTimedOverlayTimer;
		};
	} else
	//'Standard' sprinting
	if (sprintBarLastValue != PC_SprintModeStamina) {
		sprintBarUpdated = TRUE;
		sprintBarLastValue = PC_SprintModeStamina;
	};

	//Display only in inventory ...
	if ((sprintBarDisplayMethod == BarDisplay_OnlyInInventory) && (!sprintBarOnDesk) && (!sprintBarForceOnDesk)) {
		//... don't do anything :)
	} else
	//Sprint bar value updated / game status changed / fight mode
	if ((sprintBarForceOnDesk) || (sprintBarUpdated) || (oCGame_GetHeroStatus ()) || (!Npc_IsInFightMode (hero, FMODE_NONE))) {
		//
		if ((sprintBarDisplayMethod != BarDisplay_AlwaysOn) && (!sprintBarOnDesk)) {
			if (sprintBarDisplayMethod == BarDisplay_DynamicUpdate) {
				if (!sprintBarDisplayTime) {
					sprintBarDisplayTime = 120;
				} else
				if (sprintBarDisplayTime < 80) {
					sprintBarDisplayTime = 80;
				};
			};
		};

		if (sprintBarDisplayTime < 80) {
			sprintBarDisplayTime = 80;
		};

		FF_ApplyOnceExtGT (FrameFunction_FadeInOutSprintBar__BetterBars, 60, -1);
	};

	if ((sprintBarDisplayMethod == BarDisplay_AlwaysOn) || (sprintBarOnDesk) || (sprintBarDisplayTime))
	{
		if (!Bar_IsVisible (hStaminaBar)) {
			if (_Bar_PlayerStatus ()) {
				//Bar_SetAlpha (hStaminaBar, 0);
				Bar_SetAlphaBackAndBar (hStaminaBar, 0, 0);

				if ((sprintBarDisplayMethod == BarDisplay_AlwaysOn) || (sprintBarOnDesk)) {
					if (!sprintBarDisplayTime) {
						//Bar_SetAlpha (hStaminaBar, 255);
						Bar_SetAlphaBackAndBar (hStaminaBar, 255, PC_SprintModeBarAlpha);
					};
				};

				Bar_Show (hStaminaBar);
			};
		};
	};

	if ((sprintBarDisplayMethod != BarDisplay_AlwaysOn) && (!sprintBarOnDesk) && (!sprintBarDisplayTime))
	|| ((sprintBarDisplayMethod == BarDisplay_OnlyInInventory) && (!sprintBarOnDesk))
	{
		if (Bar_IsVisible (hStaminaBar)) {
			if (_Bar_PlayerStatus ()) {
				Bar_Hide (hStaminaBar);
			};
		};
	};

	//Bar_PreviewSetValue (hStaminaBar, vSprintBarPreview, previewValueSprintBar);
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

	//Add frame function (8/1s)
	FF_ApplyOnceExtGT (FrameFunction__SprintMode, 125, -1);
	FF_ApplyOnceExtGT (FrameFunction_FlashBar__SprintMode, 60, -1);
	FF_ApplyOnceExtGT (FrameFunction_EachFrame__SprintMode, 0, -1);

	//Create stamina bar
	if (!Hlp_IsValidHandle(hStaminaBar)) {
		hStaminaBar = Bar_Create (GothicBar@);

		//If Bar_Show is called immediately bar is visible already on load screen
		//Bar_Show (hStaminaBar);

		//180, 20
		Bar_ResizePxl (hStaminaBar, 180, 10);

		//Initialize texture
		Bar_SetBarTexture (hStaminaBar, _PC_SprintModeBar_Tex);

		PC_SprintModeBarAlpha = 255;
		PC_SprintModeBarFlashingFadeOut = FALSE;
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
};
