func void _hook_oCMobLockable_CanOpen () {
	EAX = FALSE;

	if (!Hlp_Is_oCMobLockable (ECX)) { return; };

	//NPC is first parameter
	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNPC slf; slf = _^ (slfPtr);

	//NPC can open any chest
	if (!NPC_IsPlayer (slf)) {
		EAX = TRUE;
		return;
	};

	const int lastMobPtr = 0;

	var int AlreadyValidated;

	if (!PC_ActionButtonPressed) {
		AlreadyValidated = FALSE;
		return;
	};

	if (slf.focus_vob != ECX) {
		AlreadyValidated = FALSE;
		return;
	};

	if (slf.focus_vob != lastMobPtr) || (ECX != lastMobPtr) {
		AlreadyValidated = FALSE;
	};
	
	if (AlreadyValidated) {
		return;
	};

	AlreadyValidated = TRUE;

	if (ECX == lastMobPtr) {
		PC_PickLockOutputVariation += 1;
	} else {
		PC_PickLockOutputVariation = 1;
		lastMobPtr = ECX;
	};
	
	//We need one more C_NPC type variable for NPC_GetTalentSkil & Npc_SetTalentValue :-/
	var C_NPC npc; npc = Hlp_GetNPC (slf);

	//By default let's assume we can open this mob
	var int canOpen; canOpen = TRUE;
	
	var oCMobLockable mob; mob = _^ (ECX);

	var int lockType; lockType = 0;

	const int requiresPickLock			= 1;
	const int requiresSpecialKey			= 2;
	const int requiresBothSpecialKeyAndPickLock	= 3;

	//Determine if we really can open this mob
	if (mob.bitfield & oCMobLockable_bitfield_locked) {
		//No PickLocks required, only special key
		if (STR_Len (mob.pickLockStr) == 0) {
			//No PickLocks, no key ?
			if (STR_Len (mob.keyinstance) == 0) {
				//Unlock - this is incorrectly flagged as locked
				mob.bitfield = (mob.bitfield & ~ oCMobLockable_bitfield_locked);
			} else {
				lockType = requiresSpecialKey;

				//Do we have key?
				if (!NPC_HasItemInstanceName (slf, mob.keyinstance)) {
					canOpen = FALSE;
				};
			};
		} else {
		//Can be PickLocked
			//Can be opened only with pickLocks
			if (STR_Len (mob.keyinstance) == 0) {
				lockType = requiresPickLock;

				//No picklocks
				if (!NPC_HasItems (slf, ItKeLockPick)) {
					canOpen = FALSE;
				};
			} else {
			//Can be opened with both special key and pickLocks
				lockType = requiresBothSpecialKeyAndPickLock;

				if (!NPC_HasItemInstanceName (slf, mob.keyinstance)) {
					//Do we have LockPicks ?
					if (!NPC_HasItems (slf, ItKeLockPick)) {
						canOpen = FALSE;
					};
				};
			};
		};

		//Generate output

		//If we need to picklock this one - check if we know ho to do so !
		if (lockType == requiresPickLock) {
			//Do we need to learn anything ?
			if (NPC_GetTalentSkill (npc, NPC_TALENT_PICKLOCK) == 0) {
				G1_EnhancedPickLocking_MissingSkill (slf);
				canOpen = FALSE;
			} else {
				if (!canOpen) {
					G1_EnhancedPickLocking_MissingLockPick (slf);
				};
			};
		} else
		if (lockType == requiresSpecialKey) {
			if (!canOpen) {
				G1_EnhancedPickLocking_MissingKey (slf);
			};
		} else
		//If this one can be picklocked ...
		if (lockType == requiresBothSpecialKeyAndPickLock) {
			//And we are not able to open it ... (as we don't have a key)
			if (!canOpen) {
				//Do we need to learn anything ?
				if (NPC_GetTalentSkill (npc, NPC_TALENT_PICKLOCK) == 0) {
					G1_EnhancedPickLocking_MissingSkill (slf);
				} else {
					G1_EnhancedPickLocking_MissingLockPickOrKey (slf);
				};
			};
		};
	};

	if (!slf.focus_vob) {
		AlreadyValidated = FALSE;
	};

	//Recalculate skill level - based on dexterity
	var int failRate; failRate = 100 - npc.attribute [ATR_DEXTERITY];

	//Default 10% chance to break PickLock (even if dexterity > 90)
	if (failRate < 10) {
		failRate = 10;
	};

	Npc_SetTalentValue (npc, NPC_TALENT_PICKLOCK, failRate);

	EAX = canOpen;
};

func void G1_EnhancedPickLocking_Init () {
	G12_GetActionButton_Init ();

	const int once = 0;
	if (!once) {
		//HookEngine (oCMobLockable__CanOpen, 6, "_hook_oCMobLockable_CanOpen");
		ReplaceEngineFunc (oCMobLockable__CanOpen, 1, "_hook_oCMobLockable_CanOpen");

		once = 1;
	};
};