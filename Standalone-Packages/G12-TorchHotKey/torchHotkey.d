/*
 *	Torch HotKey
 *		- enables hotkey 'keyTorchToggleKey' equipping torches
 *		- 'keyTorchToggleKey' can be defined either in Gothic.ini file section [KEYS] or mod.ini file section [KEYS] (master is Gothic.ini)
 *		- if 'keyTorchToggleKey' is not defined then by default KEY_T will be used for toggling
 *		- fixes issue of disappearing torches in G2A (by removing DontWriteIntoArchive flag from ItLsTorchBurning)
 *			- number of torches in players inventory will be stored prior game saving
 *			- when game is loaded script will compare number of torches in players inventory, if there is torch missing it will add it back
 *			- if player was carrying torch, script will put it back to hand
 *		- compatible with sprint mode (reapplies overlay HUMANS_SPRINT.MDS when torch is removed/equipped)
 *		- will re-lit all mobs, that were previously lit by player (list can be maintained in file 'torchHotKey_API.d' in array TORCH_ASC_MODELS [];
 *		- Ctrl + 'keyTorchToggleKey' will put torch to right hand (with Union you can throw torch away in G1)
 */

var int PC_CarriesTorch;
var int PC_NumberOfTorches;

//-- Internal variables
var int _TorchHotkey_RelitMobs;

var int _TorchHotkey_RelitMobs_ASCModels_Count;
const int _TorchHotkey_RelitMobs_ascModels_Max = 255; //We probably don't need 255
var string _TorchHotkey_RelitMobs_ascModels[_TorchHotkey_RelitMobs_ascModels_Max];

var int _TorchHotkey_ReapplyOverlays_Count;
const int _TorchHotkey_ReapplyOverlays_Max = 255; //We probably don't need 255
var string _TorchHotkey_ReapplyOverlays[_TorchHotkey_ReapplyOverlays_Max];

func int MobIsTorch__TorchHotKey (var int mobPtr) {
	//0x007DD9E4 const oCMobFire::`vftable'
	if (!Hlp_Is_oCMobFire (mobPtr)) { return FALSE; };

	//Get visual name
	var string mobVisualName; mobVisualName = Vob_GetVisualName (mobPtr);

	//Check if this is indeed torch/mob for which we want to restore it's state
	repeat (i, _TorchHotkey_RelitMobs_ascModels_Count); var int i;
		var string testVisual; testVisual = MEM_ReadStringArray (_@s (_TorchHotkey_RelitMobs_ascModels), i);
		if (Hlp_StrCmp (mobVisualName, testVisual)) {
			return TRUE;
		};
	end;

	return FALSE;
};

func void FixBurningTorches__TorchHotKey () {
	var int vobPtr;

	//Create array
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	//Search by class oCItem
	if (!SearchVobsByClass ("oCItem", vobListPtr)) {
		MEM_ArrayFree (vobListPtr);
		MEM_Info ("No oCItem objects found.");
		return;
	};

	var int counter; counter = 0;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int ptr;

	//Loop through all objects
	var int i; i = 0;
	var int count; count = vobList.numInArray;

	//we have to use separate variable here for count
	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (Hlp_Is_oCItem (vobPtr)) {
			var oCItem itm; itm = _^ (vobPtr);

			if (Hlp_IsValidItem (itm)) {
				//Fix all ItLsTorchBurning items
				//Why would PB not want these to be saved anyway?
				if (Hlp_GetInstanceID (itm) == ItLsTorchBurning) {
					//Save only those which do not have flag zCVob_bitfield0_ignoredByTraceRay
					if (!Vob_GetBitfield (vobPtr, zCVob_bitfield0_ignoredByTraceRay)) {
						VobTree_SetBitfield (vobPtr, zCVob_bitfield4_dontWriteIntoArchive, FALSE);
					};
				};
			};
		};

		i += 1;
	end;

	//Free array
	MEM_ArrayFree (vobListPtr);
};

func void TorchesReSendTrigger__TorchHotKey () {
	var int vobPtr;

	//Create array
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	//Search by zCVisual or zCParticleFX does not work
	if (!SearchVobsByClass ("oCMobFire", vobListPtr)) {
		MEM_ArrayFree (vobListPtr);
		MEM_Info ("No oCMobFire objects found.");
		return;
	};

	var int counter; counter = 0;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int ptr;

	//Loop through all objects
	var int i; i = 0;
	var int count; count = vobList.numInArray;

	//we have to use separate variable here for count
	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (MobIsTorch__TorchHotKey (vobPtr)) {
			if (oCMobInter_GetHitPoints (vobPtr) == 11) {
				//Trigger vob - will lit fireplace
				MEM_TriggerVob (vobPtr);
			};
		};

		i += 1;
	end;

	//Free array
	MEM_ArrayFree (vobListPtr);
};

//0x0067E6E0 protected: virtual void __thiscall oCMobInter::StartStateChange(class oCNpc *,int,int)
func void _eventMobStartStateChange__TorchHotKey (var int dummyVariable) {
	if (!Hlp_Is_oCMobFire (ECX)) { return; };

	var int npcPtr; npcPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (npcPtr)) { return; };
	var oCNpc slf; slf = _^ (npcPtr);

	if (!Hlp_IsValidNPC (slf)) { return; };

	var int fromState; fromState = MEM_ReadInt (ESP + 8);
	var int toState; toState = MEM_ReadInt (ESP + 12);

	//Is this torch ? is state changing from 0 to 1 ?
	if (MobIsTorch__TorchHotKey (ECX)) && (fromState == 0) && (toState == 1) {
		//Default value 10
		var int hitp; hitp = oCMobInter_GetHitPoints (ECX);
		if (hitp == 10) {
			hitp += 1;
			oCMobInter_SetHitPoints (ECX, hitp);

			//I case of G2A I didn't test if this works at all
			//Will leave here couple of additional details - that can be helpful in case of issues
			if (zERROR_GetFilterLevel () > 0) {
				var string msg;
				var oCMob mob; mob = _^ (ECX);

				MEM_Info ("_eventMobStartStateChange__TorchHotKey");

				msg = ConcatStrings ("name: ", mob.name);
				MEM_Info (msg);

				msg = IntToString (mob.bitfield & oCMob_bitfield_hitp);
				msg = ConcatStrings ("mob.bitfield & oCMob_bitfield_hitp: ", msg);
				MEM_Info (msg);
			};
		};
	};
};

func void PlayerReApplyOverlays__TorchHotKey () {
	repeat (i, _TorchHotkey_ReapplyOverlays_Count); var int i;
		var string testOverlay; testOverlay = MEM_ReadStringArray (_@s (_TorchHotkey_ReapplyOverlays), i);

		//Don't remove overlay if timed overlay is active
		if (!NPC_HasTimedOverlay (hero, testOverlay)) {
			//In case of sprinting torch will remove overlay
			if (NPC_HasOverlay (hero, testOverlay)) {
				Mdl_RemoveOverlayMds (hero, testOverlay);
				Mdl_ApplyOverlayMds (hero, testOverlay);
			};
		};
	end;

	/*
	//Timed overlay is not affected by HUMANS_TORCH.MDS removal/addition
	if (NPC_HasTimedOverlay (hero, "HUMANS_SPRINT.MDS")) {
		var int remainingTime; remainingTime = roundf (NPC_GetTimedOverlayTimer (hero, "HUMANS_SPRINT.MDS"));
		NPC_RemoveTimedOverlay (hero, "HUMANS_SPRINT.MDS");
		Mdl_ApplyOverlayMdsTimed (hero, "HUMANS_SPRINT.MDS", remainingTime);
	};
	*/
};

func void _eventGameHandleEvent__TorchHotKey (var int dummyVariable) {
	var int cancel; cancel = FALSE;
	var int key; key = MEM_ReadInt (ESP + 4);
	if (!key) { return; };

	if (!Hlp_IsValidNPC (hero)) { return; };
	if (Npc_IsDead (hero)) { return; };

	if ((key == MEM_GetKey ("keyTorchToggleKey")) || (key == MEM_GetSecondaryKey ("keyTorchToggleKey"))) {
		//Get Ctrl key status
		var int ctrlKey; ctrlKey = MEM_GetKey ("keyAction");
		var int ctrlSecondaryKey; ctrlSecondaryKey = MEM_GetSecondaryKey ("keyAction");

		ctrlKey = MEM_KeyState (ctrlKey);
		ctrlSecondaryKey = MEM_KeyState (ctrlSecondaryKey);

		if (NPC_CanChangeOverlay (hero)) {
			if (((ctrlKey == KEY_PRESSED) || (ctrlKey == KEY_HOLD)) || ((ctrlSecondaryKey == KEY_PRESSED) || (ctrlSecondaryKey == KEY_HOLD))) {
				//Put torch to right hand
				//Function NPC_DoExchangeTorch also removes overlay (when player would switch torch while walking - hero's hand still be in a carrying position)
				if (NPC_DoExchangeTorch (hero)) {
					cancel = TRUE;
				};
			} else {
				//On & Off
				if (NPC_TorchSwitchOnOff (hero) != -1) {
					PlayerReApplyOverlays__TorchHotKey ();
					cancel = TRUE;
				};
			};
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

/*
 *	Seems like on world change torch remains in hand in both G1 & G2A
 */
func void _eventGameState__TorchHotKey (var int state) {
	if (!Hlp_IsValidNPC (hero)) { return; };

	//Game saving event
	if (state == Gamestate_PreSaveGameProcessing) {
		//Fix ItLsTorchBurning for G2A
		if (MEMINT_SwitchG1G2 (0, 1)) {
			FixBurningTorches__TorchHotKey ();
		};

		//Remember how many torches we have in inventory when saving
		PC_CarriesTorch = NPC_CarriesTorch (hero);

		PC_NumberOfTorches = 0;

		if (PC_CarriesTorch) {
			//Get number of all torches in inventory
			PC_NumberOfTorches = NPC_CarriesTorch (hero); //1 which is in hand
			PC_NumberOfTorches += NPC_HasItems (hero, ItLsTorch);
			PC_NumberOfTorches += NPC_HasItems (hero, ItLsTorchBurning);
			PC_NumberOfTorches += NPC_HasItems (hero, ItLsTorchBurned);
		};
	} else
	//Game loaded
	if (state == Gamestate_Loaded) {
		//Re-create if torches are missing
		if (PC_NumberOfTorches) {
			var int total;
			total = NPC_CarriesTorch (hero); //in G1 torch wont disappear - so we want to count it (in G2A it will disappear, so value will be 0)
			total += NPC_HasItems (hero, ItLsTorch);
			total += NPC_HasItems (hero, ItLsTorchBurning);
			total += NPC_HasItems (hero, ItLsTorchBurned);

			if (total < PC_NumberOfTorches) {
				CreateInvItems (hero, ItLsTorch, PC_NumberOfTorches - total);
			};

			PC_NumberOfTorches = 0;
		};

		//Put back torch
		if (PC_CarriesTorch) {
			NPC_TorchSwitchOn (hero);
		};

		//Resends triggers to all lit mobs
		if (_TorchHotkey_RelitMobs) {
			if (_TorchHotkey_RelitMobs_ascModels_Count) {
				//TorchesReSendTrigger__TorchHotKey ();
				//Function has to be called with frame function in game - if script was called immediately then mob status would be changed by object routines (Wld_SetObjectRoutine)
				FF_ApplyOnceExtGT (TorchesReSendTrigger__TorchHotKey, 0, 1);
			};
		};
	} else
	//Level change event
	if (state == Gamestate_ChangeLevel) {
		//Fix ItLsTorchBurning for G2A
		if (MEMINT_SwitchG1G2 (0, 1)) {
			FixBurningTorches__TorchHotKey ();
		};
	};
};

func void G12_TorchHotKey_Init () {
	//Init Game key events
	G12_GameHandleEvent_Init ();

	//Add listener for key
	GameHandleEvent_AddListener (_eventGameHandleEvent__TorchHotKey);

	//TriggerChangeLevel event
	G12_GameState_Extended_Init ();

	//Mob start change event
	G12_MobStartStateChangeEvent_Init ();

	//Add listener for mob state change
	MobStartStateChangeEvent_AddListener (_eventMobStartStateChange__TorchHotKey);

	//Add listener for saving/world change/loaded game
	if (_LeGo_Flags & LeGo_Gamestate) {
		Gamestate_AddListener (_eventGameState__TorchHotKey);
	};

	//-- Load API values / init default values

	var int i;
	var string symbName;
	var string ascModel;

	_TorchHotkey_RelitMobs = API_GetSymbolIntValue ("TORCHHOTKEY_RELITMOBS", 1);

	_TorchHotkey_RelitMobs_ascModels_Count = API_GetSymbolIntValue ("TORCHHOTKEY_RELITMOBS_ASCMODELS_COUNT", 0);

	if (_TorchHotkey_RelitMobs_ascModels_Count > _TorchHotkey_RelitMobs_ascModels_Max) {
		_TorchHotkey_RelitMobs_ascModels_Count = _TorchHotkey_RelitMobs_ascModels_Max;
	};

	if (_TorchHotkey_RelitMobs_ascModels_Count > 0) {
		repeat (i, _TorchHotkey_RelitMobs_ascModels_Count);
			symbName = ConcatStrings ("TORCHHOTKEY_RELITMOBS_ASCMODELS", IntToString (i));
			ascModel = API_GetSymbolStringValue (symbName, "");
			MEM_WriteStringArray (_@s (_TorchHotkey_RelitMobs_ascModels), i, ascModel);
		end;
	};

	_TorchHotkey_ReapplyOverlays_Count = API_GetSymbolIntValue ("TORCHHOTKEY_REAPPLYOVERLAYS_COUNT", 0);

	if (_TorchHotkey_ReapplyOverlays_Count > _TorchHotkey_ReapplyOverlays_Max) {
		_TorchHotkey_ReapplyOverlays_Count = _TorchHotkey_ReapplyOverlays_Max;
	};

	if (_TorchHotkey_ReapplyOverlays_Count == 0) {
		//Default
		_TorchHotkey_ReapplyOverlays_Count = 1;
		MEM_WriteStringArray (_@s (_TorchHotkey_ReapplyOverlays), 0, "HUMANS_SPRINT.MDS");
	} else {
		repeat (i, _TorchHotkey_ReapplyOverlays_Count);
			symbName = ConcatStrings ("TORCHHOTKEY_REAPPLYOVERLAYS", IntToString (i));
			ascModel = API_GetSymbolStringValue (symbName, "");
			MEM_WriteStringArray (_@s (_TorchHotkey_ReapplyOverlays), i, ascModel);
		end;
	};
	//--

	//Load controls from .ini files Gothic.ini is master, mod.ini is secondary

	//Custom key from Gothic.ini
	if (!MEM_GothOptExists ("KEYS", "keyTorchToggleKey")) {
		//Custom key from mod .ini file
		if (!MEM_ModOptExists ("KEYS", "keyTorchToggleKey")) {
			//KEY_T if not specified
			MEM_SetKey ("keyTorchToggleKey", KEY_T);
		} else {
			//Update from mod .ini file
			var string keyString; keyString = MEM_GetModOpt ("KEYS", "keyTorchToggleKey");
			MEM_SetKey ("keyTorchToggleKey", MEMINT_KeyStringToKey (keyString));
		};
	};
};
