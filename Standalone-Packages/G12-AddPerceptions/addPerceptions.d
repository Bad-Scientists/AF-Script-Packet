/*
 *	Additional perceptions
 *	 - this feature allows you to add your own 'perception' functions to Npc perception list
 *	 - newly added perceptions will have perception type higher than vanilla perceptions (> NPC_PERC_MAX)
 *	 - the only global variable that gets updated for these perceptions is `self`
 *
 *	Fair warning: only 32 perceptions can be active at the same time. There is a chance that your perception won't be called if you use all vanilla perceptions on Npc at the same time ...
 */

/*
//
//	PERCEPTIONS ( ACTIVE )
//
const int PERC_ASSESSPLAYER = 1 ;
const int PERC_ASSESSENEMY = 2 ;
const int PERC_ASSESSFIGHTER = 3 ;
const int PERC_ASSESSBODY = 4 ;
const int PERC_ASSESSITEM = 5 ;

//
//	SENSES
//
const int SENSE_SEE = 1 << 0 ;
const int SENSE_HEAR = 1 << 1 ;
const int SENSE_SMELL = 1 << 2 ;

//
//	PERCEPTIONS ( PASSIVE )
//
const int PERC_ASSESSMURDER = 6 ;
const int PERC_ASSESSDEFEAT = 7 ;
const int PERC_ASSESSDAMAGE = 8 ;
const int PERC_ASSESSOTHERSDAMAGE = 9 ;
const int PERC_ASSESSTHREAT = 10 ;
const int PERC_ASSESSREMOVEWEAPON = 11 ;
const int PERC_OBSERVEINTRUDER = 12 ;
const int PERC_ASSESSFIGHTSOUND = 13 ;
const int PERC_ASSESSQUIETSOUND = 14 ;
const int PERC_ASSESSWARN = 15 ;
const int PERC_CATCHTHIEF = 16 ;
const int PERC_ASSESSTHEFT = 17 ;
const int PERC_ASSESSCALL = 18 ;
const int PERC_ASSESSTALK = 19 ;
const int PERC_ASSESSGIVENITEM = 20 ;
const int PERC_ASSESSFAKEGUILD = 21 ;
const int PERC_MOVEMOB = 22 ;
const int PERC_MOVENPC = 23 ;
const int PERC_DRAWWEAPON = 24 ;
const int PERC_OBSERVESUSPECT = 25 ;
const int PERC_NPCCOMMAND = 26 ;
const int PERC_ASSESSMAGIC = 27 ;
const int PERC_ASSESSSTOPMAGIC = 28 ;
const int PERC_ASSESSCASTER = 29 ;
const int PERC_ASSESSSURPRISE = 30 ;
const int PERC_ASSESSENTERROOM = 31 ;
const int PERC_ASSESSUSEMOB = 32 ;
*/

/*
 *	oCNpc_GetNewPercType
 *	 - function finds next availble perc type (> vanilla NPC_PERC_MAX) for Npc
 */
func int oCNpc_GetNewPercType (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get highest percType number (we don't want to re-assign already existing perception type!)
	var int maxPercType; maxPercType = -1;
	repeat (i, slf.percActive); var int i;
		var int percType; percType = MEM_ReadStatArr (_@ (slf.percList[0]), i * 2);

		if (percType > maxPercType) {
			maxPercType = percType;
		};
	end;

	if (maxPercType < NPC_PERC_MAX) {
		maxPercType = NPC_PERC_MAX + 1;
	} else {
		maxPercType = maxPercType + 1;
	};


	return maxPercType;
};

/*
 *	Npc_HasPercFunc
 *	 - checks if perception function is already in perception list
 */
func int Npc_HasPercFunc (var int slfInstance, var func percFunc) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int funcID; funcID = MEM_GetFuncID (percFunc);

	repeat (i, slf.percActive); var int i;
		var int percFuncID; percFuncID = MEM_ReadStatArr (_@ (slf.percList[0]), i * 2 + 1);

		if (funcID == percFuncID) {
			return TRUE;
		};
	end;

	return FALSE;
};

/*
 *	Npc_PercEnableCustom
 *	 - function will add new perception type to perception list
 */
func void Npc_PercEnableCustom (var int slfInstance, var func percFunc) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var string msg;

	//With this function we will allow only 32 perceptions
	if (slf.percActive + 1 >= NPC_PERC_MAX) {
		msg = ConcatStrings ("Npc_PercEnableCustom: Npc ", GetSymbolName (Hlp_GetInstanceID (slf)));
		msg = ConcatStrings (msg, " has already maximum number of perceptions enabled.");
		MEM_Info (msg);
		return;
	};

	var int funcID; funcID = MEM_GetFuncID (percFunc);

	if (Npc_HasPercFunc (slf, percFunc)) {
		msg = ConcatStrings ("Npc_PercEnableCustom: Npc ", GetSymbolName (Hlp_GetInstanceID (slf)));
		msg = ConcatStrings (msg, " perception function ");
		msg = ConcatStrings (msg, GetSymbolName (funcID));
		msg = ConcatStrings (msg, " already enabled.");
		MEM_Info (msg);
		return;
	};

	var int percType; percType = oCNpc_GetNewPercType (slfInstance);
	oCNpc_EnablePerception (slfInstance, percType, funcID);

	//Identification for additional perceptions (further below explanation)
	slf.percList[64] = 1;
};

/*
 *	Npc_RemovePercFunc
 *	 - removes perception function
 */
func void Npc_RemovePercFunc (var int slfInstance, var func percFunc) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int funcID; funcID = MEM_GetFuncID (percFunc);

	repeat (i, slf.percActive); var int i;
		var int percFuncID; percFuncID = MEM_ReadStatArr (_@ (slf.percList[0]), i * 2 + 1);

		if (funcID == percFuncID) {
			MEM_WriteStatArr (_@ (slf.percList[0]), i * 2 + 1, 0);
		};
	end;
};

/*
 *	oCNpc::PerceptionCheck hook
 *	 - main hook that handles perception execution
 */
func void _hook_oCNpc_PerceptionCheck__AddPerceptions () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNpc slf; slf = _^ (ECX);

	//NPC_PERC_MAX = 33
	//percList[66] has 66 indexes 0 - 65
	//vanilla game has 32 perceptions indexes 1 - 32
	//this means we can have a spare variables with indexes 64 - 65 !
	//we can use these to identify additional perceptions and to eliminate unnecessary execution of loop below
	if (slf.percList[64] == 1) {
		//Loop through active perceptions
		repeat (i, slf.percActive); var int i;
			var int percType; percType = MEM_ReadStatArr (_@ (slf.percList[0]), i * 2);

			//Is this additional (> vanilla perceptions) perception ?
			if (percType > NPC_PERC_MAX) {
				//Update self
				self = Hlp_GetNpc (slf);

				//Call function
				var int funcID; funcID = MEM_ReadStatArr (_@ (slf.percList[0]), i * 2 + 1);
				MEM_CallByID (funcID);
			};
		end;
	};
};

func void G12_AddPerceptions_Init () {
	const int once = 0;

	if (!once) {
		//0x006B7400 public: void __thiscall oCNpc::PerceptionCheck(void)
		const int oCNpc__PerceptionCheck_G1 = 7042048;

		//0x0075DD30 public: void __thiscall oCNpc::PerceptionCheck(void)
		const int oCNpc__PerceptionCheck_G2 = 7724336;

		//HookEngine (oCNpc__PerceptionCheck_G1 + 15, 6, "_hook_oCNpc_PerceptionCheck__AddPerceptions");
		//HookEngine (oCNpc__PerceptionCheck_G1 + 21, 6, "_hook_oCNpc_PerceptionCheck__AddPerceptions");
		//HookEngine (oCNpc__PerceptionCheck_G1 + 27, 6, "_hook_oCNpc_PerceptionCheck__AddPerceptions");

		//+ 44 (trial & error) --> works exactly as I hoped - get's called once a perception time
		//HookEngine (oCNpc__PerceptionCheck_G1 + 44, 6, "_hook_oCNpc_PerceptionCheck__AddPerceptions");
		//HookEngine (oCNpc__PerceptionCheck_G1 + 50, 6, "_hook_oCNpc_PerceptionCheck__AddPerceptions");

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__PerceptionCheck_G1, oCNpc__PerceptionCheck_G2) + 44, 6, "_hook_oCNpc_PerceptionCheck__AddPerceptions");

		once = 1;
	};
};
