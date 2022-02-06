/*
 *	Let's be honest LeGo 'focus names' feature ... it can be so much more!!!
 *	 - this feature changes font color of focus:
 *	   - to orange if chest/mob is locked by special key, cannot be picklocked and player does not have key
 *	   - to yellow if chest/mob is locked by special key and player does not have key, or can be picklocked
 *	   - to yellow if chest/mob can be picklocked
 *	 - renames chest from MOBNAME_CHEST to MOBNAME_CHEST_EMPTY and crates from MOBNAME_CRATE to MOBNAME_CRATE_EMPTY when they are empty and vice versa
 */

var int PC_FocusVob;
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
	if (Hlp_Is_oCMobDoor (PC_FocusVob)) { status = PC_FocusVob_DoorOpened; };
	if (Hlp_Is_oCMobContainer (PC_FocusVob)) { status = PC_FocusVob_ChestOpened; };

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
func void _hook_oCGame_UpdateStatus () {
	if (!Hlp_IsValidNPC (hero)) { return; };

	var oCNpc her; her = Hlp_GetNPC (hero);

	//Focus changed
	if (PC_FocusVob != her.focus_vob) {

	};

	PC_FocusVob = her.focus_vob;

	var oCMob mob;
	var string mobName;
	var int nameSymbIndex;

	//-- Default color
	var int focusColor; focusColor = ColorDefault__Focus ();

	//-- Change focus color
	if (PC_ChangeFocus_Flags & PC_ChangeFocus_Lockable) {
		//Door/Chest
		PC_FocusVobStatus = Mob_LockableGetLockStatus__Focus (PC_FocusVob);

		if ((PC_FocusVobStatus == PC_FocusVob_DoorRequiresKey) || (PC_FocusVobStatus == PC_FocusVob_ChestRequiresKey)) {
			focusColor = ColorLockedKey__Focus ();
		} else
		if ((PC_FocusVobStatus == PC_FocusVob_DoorRequiresPickLocks) || (PC_FocusVobStatus == PC_FocusVob_ChestRequiresPickLocks)) {
			focusColor = ColorLockedPickLocks__Focus ();
		} else
		if ((PC_FocusVobStatus == PC_FocusVob_DoorRequiresKeyOrPickLocks) || (PC_FocusVobStatus == PC_FocusVob_ChestRequiresKeyOrPickLocks)) {
			focusColor = ColorLockedKeyPickLocks__Focus ();
		} else
		if ((PC_FocusVobStatus == PC_FocusVob_DoorHasRequiredKey) || (PC_FocusVobStatus == PC_FocusVob_ChestHasRequiredKey)) {
			focusColor = ColorLockedHasKey__Focus ();
		};
	};

	if (PC_ChangeFocus_Flags & PC_ChangeFocus_NpcAttitude) {
		//NPC attitude (we could use LeGo color functions, but wanted to have all color functions in 1 file :))
		if (Hlp_Is_oCNpc (her.focus_vob)) {
			var c_npc oth; oth = MEM_PtrToInst(her.focus_vob);
			var int att; att = Npc_GetPermAttitude(hero, oth);
			if (att == ATT_FRIENDLY) {
				focusColor = ColorFriendly__Focus ();
			} else
			if (att == ATT_NEUTRAL) {
				focusColor = ColorNeutral__Focus ();
			} else
			if(att == ATT_ANGRY) {
				focusColor = ColorAngry__Focus ();
			} else
			if(att == ATT_HOSTILE) {
				focusColor = ColorHostile__Focus ();
			};
		};
	};

	SetFontColor (focusColor);

	//-- Rename mobs

	if (PC_ChangeFocus_Flags & PC_ChangeFocus_RenameEmptyChests) {
		//Door
		if (Hlp_Is_oCMobDoor (PC_FocusVob)) {
			//...
		} else
		//Chest
		if (Hlp_Is_oCMobContainer (PC_FocusVob)) {
			//If empty ... update mob name
			if (Mob_IsEmpty (PC_FocusVob)) {
				mob = _^ (PC_FocusVob);
				mobName = mob.name;

				//can be either MOBNAME_CHEST or CHEST! but we have to search for MOBNAME_CHEST
				if (!STR_StartsWith (mobName, "MOBNAME_")) {
					mobName = ConcatStrings ("MOBNAME_", mobName);
				};

				mobName = ConcatStrings (mobName, "_EMPTY");

				nameSymbIndex = MEM_FindParserSymbol (mobName);

				if (NameSymbIndex > -1) {
					mob.focusNameIndex = nameSymbIndex;
				};
			} else {
				//Update mob name in case it was previously empty and now it is not
				mob = _^ (PC_FocusVob);
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

						if (NameSymbIndex > -1) {
							mob.focusNameIndex = nameSymbIndex;
						};
					};
				};
			};
		};
	};
};

func void G12_Focus_Init () {
	const int once = 0;
	if (!once) {
		HookEngineF(oCGame__UpdateStatus, 8, _hook_oCGame_UpdateStatus);
		once = 1;
	};
};
