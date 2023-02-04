/*
const int PC_PickLockSkillRequired = 0;	//Set to true if player should not be able to open chests with no skill

//Custom output units - feel free to translate to your own language :)
func void Subtitles_EnhancedPickLocking () {
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingKey_15_01");		//I need to find the right key ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingKey_15_02");		//It will not work without the right key ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingKey_15_03");		//Sesame, open up! Nothing ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingKey_15_04");		//The key definitelly will be somewhere ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingKey_15_05");		//It won't open just like that ...

	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPick_15_01");		//I need a lockpick ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPick_15_02");		//I won't open it without a lockpick ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPick_15_03");		//I really won't open it without a lockpick ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPick_15_04");		//I should get some lockpicks ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPick_15_05");		//Maybe one of the traders can sell some lockpicks ...

	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_01");	//I need a lockpick or the right key ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_02");	//No matter how hard I try, it wont open ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_03");	//I can't do anything ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_04");	//Well, I should either get a lockpick or the right key ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_05");	//Who knows where that key might be ...

	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingSkill_15_01");		//I know nothing about picking a locks ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingSkill_15_02");		//I should learn how to picklock ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingSkill_15_03");		//I really don't know how to open it ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingSkill_15_04");		//Maybe ... No without the skill it wont open ...
	AI_Output (self, self, "DIA_EnhancedPickLocking_MissingSkill_15_05");		//Sesame, open up! Nothing ...
};

func void EnhancedPickLocking_MissingKey (var C_NPC slf) {
	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	//G1 vanilla output
	//EN: I need a key for that
	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "$NEEDKEY");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingKey_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingKey_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingKey_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingKey_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
};

func void EnhancedPickLocking_MissingLockPick (var C_NPC slf) {
	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	//G1 vanilla output
	//EN: No more skeleton keys
	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "$NOMOREPICKS");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPick_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPick_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPick_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPick_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
};

func void EnhancedPickLocking_MissingLockPickOrKey (var C_NPC slf) {
	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_01");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingLockPickOrKey_15_05");
	};
};

func void EnhancedPickLocking_MissingSkill (var C_NPC slf) {
	if (PC_PickLockOutputVariation > 5) { PC_PickLockOutputVariation = 1; };

	if (PC_PickLockOutputVariation == 1) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingSkill_15_01");
	} else
	if (PC_PickLockOutputVariation == 2) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingSkill_15_02");
	} else
	if (PC_PickLockOutputVariation == 3) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingSkill_15_03");
	} else
	if (PC_PickLockOutputVariation == 4) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingSkill_15_04");
	} else
	if (PC_PickLockOutputVariation == 5) {
		AI_OutputSVM_Overlay (slf, NULL, "DIA_EnhancedPickLocking_MissingSkill_15_05");
	};

	AI_PlayAni (slf, "T_DONTKNOW");
};
*/
