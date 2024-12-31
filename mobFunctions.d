/*
 *	Miscellaneous mob attributes
 */
func void oCMob_SetMobName (var int mobPtr, var string mobName) {
	if (!Hlp_Is_oCMob (mobPtr)) { return; };

	var oCMob mob; mob = _^ (mobPtr);
	mob.name = mobName;
	mob.focusNameIndex = MEM_GetSymbolIndex (mobName);
};

func void oCMob_SetOwnerStr (var int mobPtr, var string ownerStr, var string ownerGuildStr) {
	//0x0067ADA0 public: void __thiscall oCMOB::SetOwner(class zSTRING const &,class zSTRING const &)
	const int oCMOB__SetOwner_G1 = 6794656;

	//0x0071BF80 public: void __thiscall oCMOB::SetOwner(class zSTRING const &,class zSTRING const &)
	const int oCMOB__SetOwner_G2 = 7454592;

	if (!mobPtr) { return; };

	ownerStr = STR_TrimChar (ownerStr, CHR_SPACE);
	ownerStr = STR_Upper (ownerStr);

	ownerGuildStr = STR_TrimChar (ownerGuildStr, CHR_SPACE);
	ownerGuildStr = STR_Upper (ownerGuildStr);

	var int ownerStrPtr; ownerStrPtr = _@s (ownerStr);
	var int ownerGuildStrPtr; ownerGuildStrPtr = _@s (ownerGuildStr);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (ownerGuildStrPtr));
		CALL_PtrParam (_@ (ownerStrPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMOB__SetOwner_G1, oCMOB__SetOwner_G2));
		call = CALL_End();
	};
};

//0x0067AF90 public: void __thiscall oCMOB::SetOwner(int,int)
//0x0071C170 public: void __thiscall oCMOB::SetOwner(int,int)

//0x0067C790 public: virtual void __thiscall oCMobInter::SetUseWithItem(class zSTRING const &)

func void oCMobInter_SetUseWithItem (var int mobPtr, var string itemInstanceName) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCMobInter mob; mob = _^ (mobPtr);
	mob.useWithItem = itemInstanceName;
};

func void oCMobInter_SetTriggerTarget (var int mobPtr, var string triggerTarget) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCMobInter mob; mob = _^ (mobPtr);
	mob.triggerTarget = triggerTarget;
};

func void oCMobInter_SetSceme (var int mobPtr, var string sceme) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCMobInter mob; mob = _^ (mobPtr);
	mob.sceme = sceme;
};

func void oCMobInter_SetConditionFunc (var int mobPtr, var string conditionFunc) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCMobInter mob; mob = _^ (mobPtr);
	mob.conditionFunc = conditionFunc;
};

func void oCMobInter_SetOnStateFuncName (var int mobPtr, var string onStateFuncName) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCMobInter mob; mob = _^ (mobPtr);
	mob.onStateFuncName = onStateFuncName;
};

func void oCMobLockable_UpdateLock (var int mobPtr) {
	if (!Hlp_Is_oCMobLockable (mobPtr)) { return; };

	var oCMobLockable mob; mob = _^ (mobPtr);

	//No key
	if (STR_Len (mob.keyInstance) == 0) {
		//No pickLockStr - unlock chest
		if (STR_Len (mob.pickLockStr) == 0) {
			mob.bitfield = (mob.bitfield & ~ oCMobLockable_bitfield_locked);
		} else {
			//Lock chest
			mob.bitfield = (mob.bitfield | oCMobLockable_bitfield_locked);
		};
	} else {
		//Lock chest
		mob.bitfield = (mob.bitfield | oCMobLockable_bitfield_locked);
	};

	//Reset picklockNr
	mob.bitfield = mob.bitfield & 3;
};

func void oCMobLockable_SetKeyInstance (var int mobPtr, var string keyInstance) {
	if (!Hlp_Is_oCMobLockable (mobPtr)) { return; };

	var oCMobLockable mob; mob = _^ (mobPtr);
	mob.keyInstance = keyInstance;

	oCMobLockable_UpdateLock (mobPtr);
};

func void oCMobLockable_SetPickLockStr (var int mobPtr, var string pickLockStr) {
	if (!Hlp_Is_oCMobLockable (mobPtr)) { return; };

	var oCMobLockable mob; mob = _^ (mobPtr);
	mob.pickLockStr = pickLockStr;

	oCMobLockable_UpdateLock (mobPtr);
};

func void oCMobDoor_SetAddName (var int mobPtr, var string addName) {
	if (!Hlp_Is_oCMobDoor (mobPtr)) { return; };

	var oCMobDoor mob; mob = _^ (mobPtr);
	mob.addName = addName;
};

func void oCMobFire_SetFireSlot (var int mobPtr, var string fireSlot) {
	if (!Hlp_Is_oCMobFire (mobPtr)) { return; };

	var oCMobFire mob; mob = _^ (mobPtr);
	mob.fireSlot = fireSlot;
};

func void oCMobFire_SetFireVobtreeName (var int mobPtr, var string fireVobtreeName) {
	if (!Hlp_Is_oCMobFire (mobPtr)) { return; };

	var oCMobFire mob; mob = _^ (mobPtr);
	mob.fireVobtreeName = fireVobtreeName;
};

/*
 *	Function locks chest with specific key or pick lock string
 *	 - use "-" if you don't want to update keyInstance / pickLockStr
 *	MOB_SetLock ("CHEST", "KEY_GOMEZ", STR_EMPTY); //locks chest with KEY_GOMEZ, pick lock string is removed if present previously
 *	MOB_SetLock ("CHEST", "KEY_GOMEZ", "-"); //locks chest with KEY_GOMEZ, pick lock string is not touched if present previously
 *	MOB_SetLock ("CHEST", "KEY_GOMEZ", "LRLR"); //locks chest with KEY_GOMEZ, updates pick lock string to LRLR
 */
func void MOB_SetLock (var string mobName, var string keyInstance, var string pickLockStr) {
	var int mobPtr; mobPtr = MEM_SearchVobByName (mobName);
	if (!Hlp_StrCmp (keyInstance, "-")) {
		oCMobLockable_SetKeyInstance (mobPtr, keyInstance);
	};
	if (!Hlp_StrCmp (pickLockStr, "-")) {
		oCMobLockable_SetPickLockStr (mobPtr, pickLockStr);
	};
};

func void MOB_SetOwnerStr (var string mobName, var string ownerStr, var string ownerGuildStr) {
	var int mobPtr; mobPtr = MEM_SearchVobByName (mobName);
	oCMob_SetOwnerStr (mobPtr, ownerStr, ownerGuildStr);
};

func void MOB_SetOnStateFuncName (var string mobName, var string onStateFuncName) {
	var int mobPtr; mobPtr = MEM_SearchVobByName (mobName);
	oCMobInter_SetOnStateFuncName (mobPtr, onStateFuncName);
};

func int MOB_IsLocked (var string mobName) {
	var int mobPtr; mobPtr = MEM_SearchVobByName (mobName);

	if (!mobPtr) { return FALSE; };

	var oCMobLockable mob; mob = _^(mobPtr);
	return ((mob.bitfield & oCMobLockable_bitfield_locked) == oCMobLockable_bitfield_locked);
};

/*
 *	Function returns oCMobInter hitpoints
 */
func int oCMobInter_GetHitPoints (var int mobPtr) {
	var oCMobInter mob;
	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	mob = _^ (mobPtr);
	return (mob._oCMob_bitfield & oCMob_bitfield_hitp);
};

/*
 *	Function updates oCMobInter hitpoints
 */
func void oCMobInter_SetHitPoints (var int mobPtr, var int hitp) {
	var oCMobInter mob;
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	//111111111111
	//oCMob_bitfield_hitp = 4095
	//const int oCMob_bitfield_hitp           = ((1 << 12) - 1) <<  0;

	mob = _^ (mobPtr);
	//Remove hitpoints
	mob._oCMob_bitfield = (mob._oCMob_bitfield >> 12);
	//Add new hitoints
	mob._oCMob_bitfield = (mob._oCMob_bitfield << 12) | (oCMob_bitfield_hitp & hitp);
};
