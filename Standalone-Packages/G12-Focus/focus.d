const int PC_CHANGEFOCUS_LOCKABLE = 1;
const int PC_CHANGEFOCUS_NPCATTITUDE = 2;
const int PC_CHANGEFOCUS_RENAMEEMPTYCHESTS = 4;

//-- Internal variables
var int _PC_ChangeFocus_Flags;
var int _PC_ChangeFocus_Color_Default;
var int _PC_ChangeFocus_Color_LockedKey;
var int _PC_ChangeFocus_Color_LockedPickLocks;
var int _PC_ChangeFocus_Color_LockedKeyPickLocks;
var int _PC_ChangeFocus_Color_LockedHasKey;
var int _PC_ChangeFocus_Color_ContainerUnLocked;
var int _PC_ChangeFocus_Color_ContainerUnLockedEmpty;

var int _PC_ChangeFocus_Color_Friendly;
var int _PC_ChangeFocus_Color_Neutral;
var int _PC_ChangeFocus_Color_Angry;
var int _PC_ChangeFocus_Color_Hostile;

var int PC_FocusVobStatus;
	//Constant values are important here - do not change (Mob_LockableGetLockStatus__Focus adds 1, 2, 3, 4 to PC_FocusVob_DoorOpened/PC_FocusVob_ChestOpened when locked)
	const int PC_FocusVob_Unknown = 0;
	//Door
	const int PC_FocusVob_DoorOpened = 1;
	const int PC_FocusVob_DoorRequiresKey = 2;
	const int PC_FocusVob_DoorRequiresPickLocks = 3;
	const int PC_FocusVob_DoorRequiresKeyOrPickLocks = 4;
	const int PC_FocusVob_DoorHasRequiredKey = 5;
	//Chest
	const int PC_FocusVob_ChestOpened = 6;
	const int PC_FocusVob_ChestRequiresKey = 7;
	const int PC_FocusVob_ChestRequiresPickLocks = 8;
	const int PC_FocusVob_ChestRequiresKeyOrPickLocks = 9;
	const int PC_FocusVob_ChestHasRequiredKey = 10;

var string PC_FocusVobItemName;

func int Mob_LockableGetLockStatus__Focus (var int vobPtr) {
	const int lockRequiresKey = 1;
	const int lockRequiresPickLocks = 2;
	const int lockRequiresKeyOrPickLocks = 3;
	const int lockHasRequiredKey = 4;

	if (!Hlp_Is_oCMobLockable (vobPtr)) { return PC_FocusVob_Unknown; };

	var oCMobLockable lock; lock = _^ (vobPtr);

	var int status; status = 0;
	if (Hlp_Is_oCMobDoor (vobPtr)) { status = PC_FocusVob_DoorOpened; };
	if (Hlp_Is_oCMobContainer (vobPtr)) { status = PC_FocusVob_ChestOpened; };

	if (lock.bitfield & oCMobLockable_bitfield_locked) {
		//No pickLockStr ... can it be opened by key only?
		if (STR_Len (lock.pickLockStr) == 0) {
			//No keyInstance ...
			if (STR_Len (lock.keyInstance) == 0) {
				//well let's unlock this one then
				lock.bitfield = (lock.bitfield & ~ oCMobLockable_bitfield_locked);
			} else {
				//Do we have the key?
				if (NPC_HasItemInstanceName (hero, lock.keyInstance)) {
					//Get key name
					PC_FocusVobItemName = item.Name;
					status += lockHasRequiredKey;
				} else {
					status += lockRequiresKey;
				};
			};
		} else
		//No keyInstance ... it can be picklocked
		if (STR_Len (lock.keyInstance) == 0) {
			status += lockRequiresPickLocks;
		} else {
			//Do we have the key?
			if (NPC_HasItemInstanceName (hero, lock.keyInstance)) {
				//Get key name
				PC_FocusVobItemName = item.Name;
				status += lockHasRequiredKey;
			} else {
				//Can be opened with both key & picklocks
				status += lockRequiresKeyOrPickLocks;
			};
		};
	};

	return status;
};

//This one is being called whenever there is anything in focus - constantly
func void _hook_oCGame_UpdateStatus__Focus () {
	if (!Hlp_IsValidNPC (hero)) { return; };
	var oCNpc her; her = Hlp_GetNPC (hero);

	var oCMob mob;
	var string mobName;
	var int nameSymbIndex;

	//-- Default color
	var int focusColor; focusColor = _PC_ChangeFocus_Color_Default;

	//-- Change focus color
	if (_PC_ChangeFocus_Flags & PC_CHANGEFOCUS_LOCKABLE) {
		//Door/Chest
		PC_FocusVobStatus = Mob_LockableGetLockStatus__Focus (her.focus_vob);

		if ((PC_FocusVobStatus == PC_FocusVob_DoorRequiresKey) || (PC_FocusVobStatus == PC_FocusVob_ChestRequiresKey)) {
			focusColor = _PC_ChangeFocus_Color_LockedKey;
		} else
		if ((PC_FocusVobStatus == PC_FocusVob_DoorRequiresPickLocks) || (PC_FocusVobStatus == PC_FocusVob_ChestRequiresPickLocks)) {
			focusColor = _PC_ChangeFocus_Color_LockedPickLocks;
		} else
		if ((PC_FocusVobStatus == PC_FocusVob_DoorRequiresKeyOrPickLocks) || (PC_FocusVobStatus == PC_FocusVob_ChestRequiresKeyOrPickLocks)) {
			focusColor = _PC_ChangeFocus_Color_LockedKeyPickLocks;
		} else
		if ((PC_FocusVobStatus == PC_FocusVob_DoorHasRequiredKey) || (PC_FocusVobStatus == PC_FocusVob_ChestHasRequiredKey)) {
			focusColor = _PC_ChangeFocus_Color_LockedHasKey;
		} else
		if (PC_FocusVobStatus == PC_FocusVob_ChestOpened) {
			if (Mob_IsEmpty (her.focus_vob)) {
				focusColor = _PC_ChangeFocus_Color_ContainerUnLockedEmpty;
			} else {
				focusColor = _PC_ChangeFocus_Color_ContainerUnLocked;
			};
		};
	};

	if (_PC_ChangeFocus_Flags & PC_CHANGEFOCUS_NPCATTITUDE) {
		//NPC attitude (we could use LeGo color functions, but wanted to have all color functions in 1 file :))
		if (Hlp_Is_oCNpc (her.focus_vob)) {
			var C_NPC oth; oth = _^ (her.focus_vob);

			//Default - use Perm attitude
			var int att; att = Npc_GetPermAttitude(hero, oth);

			if (att == ATT_FRIENDLY) {
				focusColor = _PC_ChangeFocus_Color_Friendly;
			} else
			if (att == ATT_NEUTRAL) {
				focusColor = _PC_ChangeFocus_Color_Neutral;
			} else
			if(att == ATT_ANGRY) {
				focusColor = _PC_ChangeFocus_Color_Angry;
			} else
			if(att == ATT_HOSTILE) {
				focusColor = _PC_ChangeFocus_Color_Hostile;
			};

			//API function that determines focus color
			const int symbID = 0;
			if (!symbID) {
				symbID = MEM_GetSymbolIndex ("C_NPC_GETFOCUSCOLOR");
			};

			if (symbID != -1) {
				MEM_PushInstParam (oth);
				MEM_CallByID (symbID);

				focusColor = MEM_PopIntResult ();
			};
		};
	};

	SetFontColor (focusColor);

	//-- Rename mobs

	if (_PC_ChangeFocus_Flags & PC_CHANGEFOCUS_RENAMEEMPTYCHESTS) {
		//Door
		if (Hlp_Is_oCMobDoor (her.focus_vob)) {
			//...
		} else
		//Chest
		if (Hlp_Is_oCMobContainer (her.focus_vob)) {
			//If empty ... update mob name
			if (Mob_IsEmpty (her.focus_vob)) {
				mob = _^ (her.focus_vob);
				mobName = mob.name;

				//can be either MOBNAME_CHEST or CHEST! but we have to search for MOBNAME_CHEST
				if (!STR_StartsWith (mobName, "MOBNAME_")) {
					mobName = ConcatStrings ("MOBNAME_", mobName);
				};

				mobName = ConcatStrings (mobName, "_EMPTY");

				nameSymbIndex = MEM_FindParserSymbol (mobName);

				if (nameSymbIndex > -1) {
					mob.focusNameIndex = nameSymbIndex;
				};
			} else {
				//Update mob name in case it was previously empty and now it is not
				mob = _^ (her.focus_vob);
				mobName = mob.name;

				//MOBNAME_CHEST
				if (!STR_StartsWith (mobName, "MOBNAME_")) {
					mobName = ConcatStrings ("MOBNAME_", mobName);
				};

				mobName = ConcatStrings (mobName, "_EMPTY");

				if (mob.focusNameIndex > -1) {
					if (Hlp_StrCmp (GetSymbolName (mob.focusNameIndex), mobName)) {
						mobName = mob.name;

						if (!STR_StartsWith (mobName, "MOBNAME_")) {
							mobName = ConcatStrings ("MOBNAME_", mobName);
						};

						nameSymbIndex = MEM_FindParserSymbol (mobName);

						if (nameSymbIndex > -1) {
							mob.focusNameIndex = nameSymbIndex;
						};
					};
				};
			};
		};
	};
};

func void G12_Focus_Init () {

	//-- Load API values / init default values

	_PC_ChangeFocus_Flags = API_GetSymbolIntValue ("PC_CHANGEFOCUS_FLAGS", PC_CHANGEFOCUS_LOCKABLE | PC_CHANGEFOCUS_RENAMEEMPTYCHESTS);

	_PC_ChangeFocus_Color_Default = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_DEFAULT", "FFFFFF");
	_PC_ChangeFocus_Color_LockedKey = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_LOCKEDKEY", "FF8000");
	_PC_ChangeFocus_Color_LockedPickLocks = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_LOCKEDPICKLOCKS", "FFFF00");
	_PC_ChangeFocus_Color_LockedKeyPickLocks = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_LOCKEDKEYPICKLOCKS", "FFFF00");
	_PC_ChangeFocus_Color_LockedHasKey = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_LOCKEDHASKEY", "FFFF00");

	_PC_ChangeFocus_Color_ContainerUnLocked = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_CONTAINERUNLOCKED", "66FFB2");
	_PC_ChangeFocus_Color_ContainerUnLockedEmpty = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_CONTAINERUNLOCKEDEMPTY", "FFFFFF");

	_PC_ChangeFocus_Color_Friendly = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_FRIENDLY", "66FFB2");
	_PC_ChangeFocus_Color_Neutral = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_NEUTRAL", "FFFFFF");
	_PC_ChangeFocus_Color_Angry = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_ANGRY", "FF8000");
	_PC_ChangeFocus_Color_Hostile = API_GetSymbolHEX2RGBAValue ("PC_CHANGEFOCUS_COLOR_HOSTILE", "FF4646");

	//--

	const int once = 0;
	if (!once) {
		const int oCGame__GetFocusVob_G1 = 6525544;

		const int oCGame__GetFocusVob_G2 = 7091621;

		HookEngine(MEMINT_SwitchG1G2 (oCGame__GetFocusVob_G1, oCGame__GetFocusVob_G2), MEMINT_SwitchG1G2 (5, 8), "_hook_oCGame_UpdateStatus__Focus");
		once = 1;
	};
};
