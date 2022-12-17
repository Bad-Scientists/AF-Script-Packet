//-- Internal variables
var int PC_PickLockOutputVariation;

var int _PC_PickLockSkillRequired;

func void _hook_oCMobLockable_CanOpen () {
	//Initial value
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
	if (ECX == lastMobPtr) {
		PC_PickLockOutputVariation += 1;
	} else {
		PC_PickLockOutputVariation = 1;
		lastMobPtr = ECX;
	};

	//If mob is not locked - we can open it
	var oCMobLockable mob; mob = _^ (ECX);
	if (!(mob.bitfield & oCMobLockable_bitfield_locked)) {
		EAX = TRUE;
		return;
	};

	//We need one more C_NPC type variable for NPC_GetTalentSkil & Npc_SetTalentValue :-/
	var C_NPC npc; npc = Hlp_GetNPC (slf);

	var int lockType; lockType = 0;

	const int requiresPickLock = 1;
	const int requiresSpecialKey = 2;
	const int requiresBothSpecialKeyAndPickLock = 4;

	var int playerHasKey; playerHasKey = TRUE;
	var int playerHasPickLock; playerHasPickLock = TRUE;

	//Do we have picklocks?
	if (STR_Len (mob.pickLockStr)) {
		lockType = lockType | requiresPickLock;
		playerHasPickLock = NPC_HasItems (slf, ItKeLockPick);
	};

	//Do we have key?
	if (STR_Len (mob.keyInstance)) {
		playerHasKey = NPC_HasItemInstanceName (slf, mob.keyInstance);
		lockType = lockType | requiresSpecialKey;
	};

	//Recalculate skill level - based on dexterity
	var int failRate; failRate = 100 - npc.attribute [ATR_DEXTERITY];

	//Default 10% chance to break PickLock (even if dexterity > 90)
	if (failRate < 10) {
		failRate = 10;
	};

	Npc_SetTalentValue (npc, NPC_TALENT_PICKLOCK, failRate);

	//Generate output

	//We need a lockpick
	if (lockType == requiresPickLock) {
		//If player does not have skill - and if skill is **required**
		if ((NPC_GetTalentSkill (npc, NPC_TALENT_PICKLOCK) == 0) && (_PC_PickLockSkillRequired)) {
			const int symbID = 0;

			if (!symbID) {
				symbID = MEM_FindParserSymbol ("ENHANCEDPICKLOCKING_MISSINGSKILL");
			};

			if (symbID != -1) {
				MEM_PushInstParam (slf);
				MEM_CallByID (symbID);
			};

			oCNpc_SetFocusVob (slf, 0);
			AI_PlayAni (slf, "T_DONTKNOW");
			return;
		};

		if (!playerHasPickLock) {
			const int symbID2 = 0;

			if (!symbID2) {
				symbID2 = MEM_FindParserSymbol ("ENHANCEDPICKLOCKING_MISSINGLOCKPICK");
			};

			if (symbID2 != -1) {
				MEM_PushInstParam (slf);
				MEM_CallByID (symbID2);
			};

			oCNpc_SetFocusVob (slf, 0);
			AI_PlayAni (slf, "T_DONTKNOW");
			return;
		};
	} else
	//We need a key
	if (lockType == requiresSpecialKey) {
		if (!playerHasKey) {
			const int symbID3 = 0;

			if (!symbID3) {
				symbID3 = MEM_FindParserSymbol ("ENHANCEDPICKLOCKING_MISSINGKEY");
			};

			if (symbID3 != -1) {
				MEM_PushInstParam (slf);
				MEM_CallByID (symbID3);
			};

			oCNpc_SetFocusVob (slf, 0);
			AI_PlayAni (slf, "T_DONTKNOW");
			return;
		};
	} else
	//We either need a lockpick or a key
	if ((lockType & requiresPickLock) || (lockType & requiresSpecialKey)) {
		if ((!playerHasPickLock) && (!playerHasKey)) {
			//Do we need to learn anything ?
			if ((NPC_GetTalentSkill (npc, NPC_TALENT_PICKLOCK) == 0) && (_PC_PickLockSkillRequired)) {
				const int symbID4 = 0;

				if (!symbID4) {
					symbID4 = MEM_FindParserSymbol ("ENHANCEDPICKLOCKING_MISSINGSKILL");
				};

				if (symbID4 != -1) {
					MEM_PushInstParam (slf);
					MEM_CallByID (symbID4);
				};
			} else {
				const int symbID5 = 0;

				if (!symbID5) {
					symbID5 = MEM_FindParserSymbol ("ENHANCEDPICKLOCKING_MISSINGLOCKPICKORKEY");
				};

				if (symbID5 != -1) {
					MEM_PushInstParam (slf);
					MEM_CallByID (symbID5);
				};
			};

			oCNpc_SetFocusVob (slf, 0);
			AI_PlayAni (slf, "T_DONTKNOW");
			return;
		};
	};

	EAX = TRUE;
};

func void G1_EnhancedPickLocking_Init () {
	G12_GetActionKey_Init ();

	_PC_PickLockSkillRequired = API_GetSymbolIntValue ("PC_PICKLOCKSKILLREQUIRED", FALSE);

	const int once = 0;
	if (!once) {
		//HookEngine (oCMobLockable__CanOpen, 6, "_hook_oCMobLockable_CanOpen");
		ReplaceEngineFunc (oCMobLockable__CanOpen, 1, "_hook_oCMobLockable_CanOpen");

		once = 1;
	};
};