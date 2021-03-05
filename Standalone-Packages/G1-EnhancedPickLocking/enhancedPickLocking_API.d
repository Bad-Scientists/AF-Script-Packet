var int PC_PickLockOutputVariation;

/*
 *	Custom output units - feel free to translate to your own language
 */
func void G1_EnhancedPickLocking_SVM () {
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingKey_15_01");		//Potřebuju najít správný klíč ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingKey_15_02");		//Bez správného klíče to nepůjde ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingKey_15_03");		//Bez klíče to opravdu nepůjde ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingKey_15_04");		//Ten klíč někde určitě bude ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingKey_15_05");		//Tohle jen tak otevřít nepůjde ...

	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPick_15_01");		//Potřebuju paklíč ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPick_15_02");		//Bez paklíče to neotevřu ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPick_15_03");		//Potřebuju nějaký paklíč ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPick_15_04");		//Musím sehnat nějaký paklíč ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPick_15_05");		//Některý z obchodníků určitě prodává i paklíče ...

	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_01");	//Potřebuju paklíč anebo správný klíč ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_02");	//Bez paklíče anebo správného klíče to neotevřu ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_03");	//Opravdu to nepůjde ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_04");	//Hmmm, měl bych zkusit sehnat klíč anebo aspoň paklíč ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_05");	//Kdoví kde ten klíč je ...

	AI_Output (self, self, "G1_EnhancedPickLocking_MissingSkill_15_01");		//O páčení zámků nevím vůbec nic ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingSkill_15_02");		//Musím se naučit páčení zámků ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingSkill_15_03");		//Opravdu to neumím ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingSkill_15_04");		//Možná by ... Ne, bez učení to určitě nepůjde ...
	AI_Output (self, self, "G1_EnhancedPickLocking_MissingSkill_15_05");		//Sezame, otevři se! Nic ...
};

func void G1_EnhancedPickLocking_MissingKey (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//G1 vanilla output
	//EN: I need a key for that
	//CZ: Potřebuju správný klíč ...

	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "$NEEDKEY");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingKey_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingKey_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingKey_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingKey_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
	oCNpc_SetFocusVob (slf, 0);
};

func void G1_EnhancedPickLocking_MissingLockPick (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//G1 vanilla output
	//EN: No more skeleton keys
	//CZ: Nemám žádný paklíč ...

	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "$NOMOREPICKS");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPick_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPick_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPick_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPick_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
	oCNpc_SetFocusVob (slf, 0);
};

func void G1_EnhancedPickLocking_MissingLockPickOrKey (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_01");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingLockPickOrKey_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
	oCNpc_SetFocusVob (slf, 0);
};

func void G1_EnhancedPickLocking_MissingSkill (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingSkill_15_01");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingSkill_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingSkill_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingSkill_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "G1_EnhancedPickLocking_MissingSkill_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
	oCNpc_SetFocusVob (slf, 0);
};
