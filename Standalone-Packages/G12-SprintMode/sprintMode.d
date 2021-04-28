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

var int hStaminaBar;

const int PC_SprintModeTimedOverlayStacking_GetMaxValue	= 0;	//get max value
const int PC_SprintModeTimedOverlayStacking_SumValues	= 1;	//sum up all timers

//When removing duplicate timed overlays script can either sum up all timers or get max value
const int PC_SprintModeTimedOverlayStacking = PC_SprintModeTimedOverlayStacking_GetMaxValue;

const int BAR_TEX_SPRINTMODE_STAMINA		= 0;	//Bar texture for stamina
const int BAR_TEX_SPRINTMODE_TIMEDOVERLAY	= 1;	//Bar texture for timed overlays (potions)

const int BAR_TEX_SPRINTMODE_MAX		= 2;

const string BAR_TEX_SPRINTMODE [BAR_TEX_SPRINTMODE_MAX] = {
	//"Bar_SprintMode_Stamina.tga",
	//"Bar_SprintMode_TimedOverlay.tga",
	"Bar_Misc.tga",					//Default Gothic bar texture (yellow)
	"Bar_SprintMode_TimedOverlay.tga"		//This is my custom texture - you might have to adjust this one !!
};

func void _eventGameStateLoaded__SprintMode (var int state) {
	//Restore time overlay effect on game load
	if (state == Gamestate_Loaded) {
		if (PC_SprintModePlayerHasTimedOverlay) {
			if (!NPC_HasTimedOverlay (hero, "HUMANS_SPRINT.MDS")) {
				Mdl_ApplyOverlayMdsTimed (hero, "HUMANS_SPRINT.MDS", PC_SprintModePlayerTimedOverlayTimer);
			};
		};
	};
};

func void _eventGameKeyEvent__SprintMode (var int dummyVariable) {
	//Activate sprint mode
	//We have to check MEM_GetKey, MEM_GetSecondaryKey because of menu items (user can change keys during gameplay) (how much does this affect performance?)
	if (((GameKeyEvent_Key == MEM_GetKey ("keySprintModeToggleKey")) && GameKeyEvent_Pressed) || ((GameKeyEvent_Key == MEM_GetSecondaryKey ("keySprintModeToggleKey")) && GameKeyEvent_Pressed)) {
		//Toggle if not in cool down
		if (!PC_SprintModeCooldown) {
			PC_SprintModeSwitch = (!PC_SprintModeSwitch);
		};

		//Activate
		if (PC_SprintModeSwitch) {
			if (NPC_HasOverlay (hero, "HUMANS_SPRINT.MDS")) || (NPC_HasTimedOverlay (hero, "HUMANS_SPRINT.MDS"))
			|| (NPC_HasOverlay (hero, "HUMANS_DRUNKEN.MDS")) || (NPC_HasTimedOverlay (hero, "HUMANS_DRUNKEN.MDS"))
			{
				//Don't enable sprint mode if player already has HUMANS_SPRINT.MDS overlay or if he is drunk :)
				PC_SprintModeSwitch = FALSE;
			} else {
				PC_SprintMode = TRUE;
				Mdl_ApplyOverlayMds (hero, "HUMANS_SPRINT.MDS");
			};
		} else {
			//Deactivate - we can't remove overlay immediately, so we use PC_SprintModeDisable and script bellow will perform additional checks
			if (PC_SprintMode) {
				PC_SprintModeDisable = TRUE;
			};
		};

		GameKeyEvent_KeyHandled ();
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

	PC_SprintModeBarFlashingTimer = 40;
};

func void FrameFunction__SprintMode () {
	if (!Hlp_IsValidNPC (hero)) { return; };

	//Get animation name
	var string aniName; aniName = NPC_GetAniName (hero);
	var string textureName;

	//Is player walking?
	var int isWalking; isWalking = NPC_IsWalking (hero);

	//Is player fighting?
	var int isInFistAttack; isInFistAttack = (STR_IndexOf (aniName, "_FISTATTACK") > -1);
	var int is1H; is1H = (STR_IndexOf (aniName, "_1H") > -1);
	var int is2H; is2H = (STR_IndexOf (aniName, "_2H") > -1);

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
	PC_SprintModePlayerHasTimedOverlay = NPC_HasTimedOverlay (hero, "HUMANS_SPRINT.MDS");

	//If I remove overlay while jumping then players animation will 'stutter', that's why I can remove overlay only once player is not jumping
	if (PC_SprintModeDisable) {
		//We can't remove overlay if player has meanwhile timed overlay
		if (!isJumping) && (!PC_SprintModePlayerHasTimedOverlay) {
			PC_SprintMode = FALSE;
			PC_SprintModeSwitch = FALSE;
			PC_SprintModeDisable = FALSE;

			if (NPC_HasOverlay (hero, "HUMANS_SPRINT.MDS")) {
				Mdl_RemoveOverlayMds (hero, "HUMANS_SPRINT.MDS");
			};
		};
	};

	//Stamina regen
	if (!PC_SprintMode) || (!isWalking) {
		if (!isInFistAttack) && (!is1H) && (!is2H) && (!isJumping) {
			if (PC_SprintModeStamina < PC_SprintModeStaminaMax) {
				PC_SprintModeStamina += 1;
			};
		};
	};

	//Remove duplicated timed overlays
	if (PC_SprintModePlayerHasTimedOverlay) {
		NPC_RemoveDuplicatedTimedOverlays (hero, "HUMANS_SPRINT.MDS", PC_SprintModeTimedOverlayStacking);
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
		PC_SprintModePlayerTimedOverlayTimer = roundf (NPC_GetTimedOverlayTimer (hero, "HUMANS_SPRINT.MDS"));

		//If PC_SprintModePlayerTimedOverlayDetected == FALSE then this is first time script detected timed overlay, get max value and adjust texture
		if (!PC_SprintModePlayerTimedOverlayDetected)
		//Update if player drunk potion with longer lasting effect
		|| (PC_SprintModePlayerTimedOverlayTimer > PC_SprintModePlayerTimedOverlayTimerMax)
		{
			//Get timer value - first value will be considered max value
			PC_SprintModePlayerTimedOverlayTimerMax = roundf (NPC_GetTimedOverlayTimer (hero, "HUMANS_SPRINT.MDS"));
			PC_SprintModePlayerTimedOverlayDetected = TRUE;

			textureName = MEM_ReadStatStringArr (BAR_TEX_SPRINTMODE, BAR_TEX_SPRINTMODE_TIMEDOVERLAY);
			Bar_SetBarTexture (hStaminaBar, textureName);
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
			if (NPC_HasOverlay (hero, "HUMANS_SPRINT.MDS")) {
				Mdl_RemoveOverlayMds (hero, "HUMANS_SPRINT.MDS");
				Mdl_ApplyOverlayMds (hero, "HUMANS_SPRINT.MDS");
			};
			
			textureName = MEM_ReadStatStringArr (BAR_TEX_SPRINTMODE, BAR_TEX_SPRINTMODE_STAMINA);
			Bar_SetBarTexture (hStaminaBar, textureName);
		};

		//Set max and current value
		Bar_SetMax (hStaminaBar, PC_SprintModeStaminaMax);
		Bar_SetValue (hStaminaBar, PC_SprintModeStamina);
	};

	//Move bar right underneath health bar
	var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
	//Bar_MoveTo (hStaminaBar, hpBar.zCView_vposx + hpBar.zCView_vsizex / 2, hpBar.zCView_vposy - hpBar.zCView_vsizey / 2);
	//These LeGo bars have weird positions :-/
	Bar_MoveTo (hStaminaBar, hpBar.zCView_vposx + hpBar.zCView_vsizex / 2 + 1, hpBar.zCView_vposy + (hpBar.zCView_vsizey / 2) * 2);

	//Flash stamina bar if in cool down
	if (PC_SprintModeCooldown) {
		if (PC_SprintModeBarFlashingFadeOut) {
			PC_SprintModeBarAlpha -= 64;
		} else {
			PC_SprintModeBarAlpha += 64;
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
		Bar_SetAlphaBackAndBar (hStaminaBar, 255, PC_SprintModeBarAlpha);
	};
};

func void G12_SprintMode_Init () {
	//Add frame function (8/1s)
	FF_ApplyOnceExtGT (FrameFunction__SprintMode, 125, -1);

	//Create stamina bar
	if (!Hlp_IsValidHandle(hStaminaBar)) {
		hStaminaBar = Bar_Create (GothicBar@);

		//180, 20
		Bar_ResizePxl (hStaminaBar, 180, 10);

		//Initialize texture
		var string textureName;
		textureName = MEM_ReadStatStringArr (BAR_TEX_SPRINTMODE, BAR_TEX_SPRINTMODE_STAMINA);
		Bar_SetBarTexture (hStaminaBar, textureName);

		PC_SprintModeBarAlpha = 255;
		PC_SprintModeBarFlashingFadeOut = FALSE;
	};

	//Init Game key events
	Game_KeyEventInit ();

	//Add listener for key
	GameKeyEvent_AddListener (_eventGameKeyEvent__SprintMode);

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
};
