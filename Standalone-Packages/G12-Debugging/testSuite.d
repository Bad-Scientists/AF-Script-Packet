/*
 *	Collection of methods for dialogue testing
 *
 *	 - with proper test suite setup we can move forward story-wise to any desired point in time
 *	 - this feature will identify potential issues with unfulfilled dialogue condition
 */

var int TestSuite_Active;
var int TestSuite_DirectCall;
var int TestSuite_ReportOnlyIssues;
var int TestSuite_bErrorLevel;

func void TestSuite_Init () {
	//Set to true
	TestSuite_Active = TRUE;

	//Reset direct call variable
	TestSuite_DirectCall = TRUE;

	//Enable zSpy output (level 1) if not on already
	var int retVal; retVal = zERROR_SearchForSpy ();

	//Backup original setup
	TestSuite_bErrorLevel = zERROR_GetFilterLevel ();

	if (TestSuite_bErrorLevel < 1) {
		zERROR_SetFilterLevel (1);
	};
};

func void TestSuite_Stop () {
	TestSuite_Active = FALSE;
	zERROR_SetFilterLevel (TestSuite_bErrorLevel);
};

/*
 *	TestSuite_AddChoice
 *	 - function checks if subsequent function was already called (by checking once variable [which should be defined inside of called function])
 *	 - if function was already called we will change color of added choice to yellow-orange-ish to indicate these choices can no longer be selected
 */
func void TestSuite_AddChoice (var int diaInstance, var string s, var func f) {
	var int funcID; funcID = MEM_GetFuncID (f);
	if (funcID == -1) { return; };

	var string symbName; symbName = GetSymbolName (funcID);
	symbName = ConcatStrings (symbName, ".ONCE");

	var int once; once = API_GetSymbolIntValue (symbName, 0);

	if (once) {
		//yellow-orange-ish
		s = ConcatStrings ("h@FFF700 hs@FFFB80 ", s);
	};

	Info_AddChoiceByID (diaInstance, s, funcID);
};

func int TestSuite_GetDirectCall () {
	var int oldValue; oldValue = TestSuite_DirectCall;
	//Set to FALSE after 1. call
	TestSuite_DirectCall = FALSE;
	return + oldValue;
};

/*
 *	TestSuite_EquipItem
 *	 - function equips item (creates single piece if Npc does not have it already)
 */
func void TestSuite_EquipItem (var int slfInstance, var int itemInstance) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	oCNpc_UnpackInventory (slf);

	//If Npc does not have item - create it and notify modder
	if (!Npc_HasItems (slf, itemInstance)) {
		var string msg;
		msg = ConcatStrings ("TestSuite_EquipItem - npc: '", slf.Name);
		msg = ConcatStrings ("' didn't have item ", GetSymbolName (itemInstance));
		MEM_Info (msg);

		const int once = 0;
		if (!once) {
			MEM_Info (" - this might not be necessarily an issue:");
			MEM_Info (" - maybe item has to be taken from the world, stolen from inventory, bought from trader etc. ... anyway double-check it :)");
			once = 1;
		};

		CreateInvItems (slf, itemInstance, 1);
	};

	if (Npc_GetInvItem (slf, itemInstance)) {
		oCNpc_EquipPtr (slf, _@ (item));
	};
};

/*
 *	TestSuite_Exit_Dialog
 *	 - function exits dialogue (without using AI queue)
 */
func void TestSuite_Exit_Dialog () {
	const int symbID = 0;
	if (!symbID) {
		symbID = MEM_GetSymbolIndex ("Hero_SetInvincible");
	};

	if (symbID != -1) {
		//Hero_SetInvincible (FALSE);
		MEM_PushIntParam (FALSE);
		MEM_CallByID (symbID);
	} else {
		const int once = 0;
		if (!once) {
			MEM_Info ("TestSuite_Exit_Dialog - method Hero_SetInvincible missing!");
			once = 1;
		};
	};

	oCInformationManager_OnTermination ();
	oCInformationManager_Exit ();
};

/*
 *	TestSuite_CheckInvItems
 *	 - function creates items in inventory (if Npc does not have specified amount)
 */
func void TestSuite_CheckInvItems (var int slfInstance, var int itemInstance, var int qty) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	var int amount; amount = Npc_HasItems (slf, itemInstance);
	if (amount < qty) {
		var int delta;
		delta = qty - amount;

		//No warnings - this adds items to inventory to 'artificially' fulfill dialogue conditions

		CreateInvItems (slf, itemInstance, delta);
	};
};

/*
 *	TestSuite_SetMinAttribute
 *	 - function updates attribute value if too low
 */
func void TestSuite_SetMinAttribute (var int slfInstance, var int attr, var int minValue) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	if (attr == ATR_HITPOINTS) {
		if (slf.attribute [ATR_HITPOINTS] < minValue) {
			slf.attribute [ATR_HITPOINTS] = minValue;
		};
	};

	if (attr == ATR_HITPOINTS_MAX) {
		if (slf.attribute [ATR_HITPOINTS_MAX] < minValue) {
			slf.attribute [ATR_HITPOINTS_MAX] = minValue;
			slf.attribute [ATR_HITPOINTS] = slf.attribute [ATR_HITPOINTS_MAX];
		};
	};

	if (attr == ATR_MANA) {
		if (slf.attribute [ATR_MANA] < minValue) {
			slf.attribute [ATR_MANA] = minValue;
		};
	};

	if (attr == ATR_MANA_MAX) {
		if (slf.attribute [ATR_MANA_MAX] < minValue) {
			slf.attribute [ATR_MANA_MAX] = minValue;
			slf.attribute [ATR_MANA] = slf.attribute [ATR_MANA_MAX];
		};
	};

	if (attr == ATR_STRENGTH) {
		if (slf.attribute [ATR_STRENGTH] < minValue) {
			slf.attribute [ATR_STRENGTH] = minValue;
		};
	};

	if (attr == ATR_DEXTERITY) {
		if (slf.attribute [ATR_DEXTERITY] < minValue) {
			slf.attribute [ATR_DEXTERITY] = minValue;
		};
	};

	if (attr == ATR_REGENERATEHP) {
		if (slf.attribute [ATR_REGENERATEHP] < minValue) {
			slf.attribute [ATR_REGENERATEHP] = minValue;
		};
	};

	if (attr == ATR_REGENERATEMANA) {
		if (slf.attribute [ATR_REGENERATEMANA] < minValue) {
			slf.attribute [ATR_REGENERATEMANA] = minValue;
		};
	};
};

/*
 *	TestSuite_SetMinLevel
 *	 - function updates Npcs level if too low
 */
func void TestSuite_SetMinLevel (var int slfInstance, var int minLevel) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	if (slf.level < minLevel) {
		slf.level = minLevel;
	};
};

/*
 *	TestSuite_ClearEM
 *	 - function clears 'rubbish events' (not really required for testing) from event manager
 *		 - output units are deleted
 *		 - movement messages are deleted
 */

func void TestSuite_ClearEM (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	var int count; count = NPC_EM_GetEventCount (slf);

	repeat (i, count); var int i;
		var int eMsg; eMsg = zCEventManager_GetEventMessage (eMgr, i);

		var int subType;
		var int doDelete; doDelete = FALSE;

		//Delete all outputs messages
		if (Hlp_Is_oCMsgConversation (eMsg)) {
			subType = zCEventMessage_GetSubType (eMsg);

			if (subType == EV_OUTPUT)
			|| (subType == EV_OUTPUTSVM)
			|| (subType == EV_PLAYANISOUND)
			|| (subType == EV_WAITTILLEND)
			|| (subType == EV_STOPPROCESSINFOS)
			{
				doDelete = TRUE;
			};
		};

		//Delete all movement messages
		if (Hlp_Is_oCMsgMovement (eMsg)) {
			/*
			subType = zCEventMessage_GetSubType (eMsg);

			if (subType == EV_ROBUSTTRACE)
			|| (subType == EV_GOTOPOS)
			|| (subType == EV_GOTOVOB)
			|| (subType == EV_GOROUTE)
			|| (subType == EV_TURN)
			|| (subType == EV_TURNTOPOS)
			|| (subType == EV_TURNTOVOB)
			|| (subType == EV_TURNAWAY)
			{
				doDelete = TRUE;
			};
			*/
			doDelete = TRUE;
		};

		if (doDelete) {
			i -= 1;
			//zCEventMessage_Delete (eMsg);
			zCEventManager_Delete (eMgr, eMsg);
		};
	end;
};

/*
 *	AIQ_ClearInvincible
 *	 - 'internal' function called by TestSuite_TeleportToNpc (should clear invincible flag from hero)
 */
func void AIQ_ClearInvincible () {
	const int symbID = 0;
	if (!symbID) {
		symbID = MEM_GetSymbolIndex ("Hero_SetInvincible");
	};

	if (symbID != -1) {
		//Hero_SetInvincible (FALSE);
		MEM_PushIntParam (FALSE);
		MEM_CallByID (symbID);
	};

	TestSuite_Stop ();
};

/*
 *	TestSuite_TeleportToNpc
 *	 - teleports Npc to target Npc
 *	 - calls TestSuite_ClearEM
 */
func void TestSuite_TeleportToNpc (var int npcInstance) {
	//First teleport hero
	NPC_TeleportToNpc (hero, npcInstance);

	//Then teleport Story helper (he might be still useful :) )
	//var C_NPC npc; npc = Hlp_GetNpc (SH);
	//NPC_TeleportToNpc (npc, npcInstance);

	//Clear AI queue (output units and movement messages)
	TestSuite_ClearEM (hero);

	//As soon as Npc is teleported to another Npc ... AI queue can get cleared by B_AssessTalk!
	//Therefore we have to set AIV_Invincible flag ... and add AI_Function to player's AI queue - which will clear AIV_Invincible flag afterwards

	const int symbID = 0;
	if (!symbID) {
		symbID = MEM_GetSymbolIndex ("Hero_SetInvincible");
	};

	if (symbID != -1) {
		//Setup invincible flag immediately
		//Hero_SetInvincible (TRUE);
		MEM_PushIntParam (TRUE);
		MEM_CallByID (symbID);

		//Invincible flag will be cleared from AI queue
		AI_Function (hero, AIQ_ClearInvincible);

		//Reset trialogue camera override pointer (bad things could happen if target is too far)
		//Trialogue is usually properly ended with Trialogue_Finish, which resets pointer from AI queue ...
		//However with testsuite cases we might uintentionally clear AI queues and bypass proper trialogue exit
		AI_Function (hero, _Trialogue_Finish);
	} else {
		const int once = 0;
		if (!once) {
			MEM_Info ("TestSuite_TeleportToNpc - method Hero_SetInvincible missing!");
			once = 1;
		};
	};
};

/*
 *	TestSuite_ProcessInfo
 *
 *	Modified SetInfoToTold function, originally created by Cryp18Struct
 *	Original function: https://forum.worldofplayers.de/forum/threads/1529361-Dialog-Instance-auf-TRUE-setzten?p=25955510&viewfull=1#post25955510
 *
 *	Our modified version will:
 *	 - set .told property to true
 *	 - call .information function (self & other global variables are initialized - self is oCInfo.npc & other is oCInfo.player)
 *	 - clear from EM all output units related messages & movement messages (teleport, turn to e.g.)
 *	 - call choices (if specified by query)
 *
 *	Format:
 *	=======
 *	TestSuite_ProcessInfo ("DIA_Instance");
 *	 - simple call - calls DIA_Instance oCInfo.information function
 *
 *	TestSuite_ProcessInfo ("DIA_Instance.DIA_Choice_1|DIA_Choice_2");
 *	 - useful in case of dialogue with choices added by Info_AddChoice
 *	 - calls DIA_Instance oCInfo.information function and subsequently calls DIA_Choice_1 & DIA_Choice_2 functions (which would be normally called by choice selection)
 */
func void TestSuite_ProcessInfo(var string infoQuery) {
	var string infoName; infoName = STR_Split (infoQuery, ".", 0);

    // Find instance symbol by instance name
    var int symbID; symbID = MEM_GetSymbolIndex(infoName);
    if (symbID < 0) || (symbID >= currSymbolTableLength) {
        MEM_Info (ConcatStrings("TestSuite_ProcessInfo - symbol not found: ", infoName));
        return;
    };

	var int ptr; ptr = MEM_GetSymbolByIndex(symbID);
	if (!ptr) { return; };
	var zCPar_Symbol symb; symb = _^ (ptr);

    // Verify that it is an instance
    if ((symb.bitfield & zCPar_Symbol_bitfield_type) != zPAR_TYPE_INSTANCE)
    || (!symb.offset) {
        MEM_Info (ConcatStrings("TestSuite_ProcessInfo - symbol is not a C_Info instance: ", infoName));
        return;
    };

    // Verify that it is a oCInfo instance
	var int infoPtr; infoPtr = (symb.offset - oCInfo_C_INFO_Offset);

	//0x007DCD8C const oCInfo::`vftable'
	const int oCInfo___vftable_G1 = 8244620;

	//0x0083C44C const oCInfo::`vftable'
	const int oCInfo___vftable_G2 = 8635468;

    if (MEM_ReadInt(infoPtr) != MEMINT_SwitchG1G2 (oCInfo___vftable_G1, oCInfo___vftable_G2)) {
        MEM_Info (ConcatStrings("TestSuite_ProcessInfo - symbol is not an oCInfo instance: ", infoName));
        return;
    };

//--

	if (!TestSuite_ReportOnlyIssues) {
		MEM_Info (ConcatStrings ("TestSuite_ProcessInfo - processing: ", infoName));
	};

//-- get info

    var oCInfo info; info = _^ (infoPtr);

//--

	var C_NPC selfBackup; selfBackup = Hlp_GetNpc (self);
	var C_NPC otherBackup; otherBackup = Hlp_GetNpc (other);

	var C_NPC slf;
	var C_NPC oth;

	slf = Hlp_GetNpc (info.npc);

	if (!Hlp_IsValidNpc (slf)) {
		var string npcInstanceName; npcInstanceName = GetSymbolName (info.npc);
		var string worldName; worldName = oCWorld_GetWorldFilename ();
		var string s;

		s = Concat3Strings ("TestSuite_ProcessInfo - world ", worldName, STR_SPACE);
		MEM_Info (Concat5Strings (s, "dialogue instance ", infoName, " npc is invalid: ", npcInstanceName));

		var C_NPC diaMeatbug;

		const int once = 0;
		if (!once) {
			MEM_Info (" - this might be caused by testing dialogue in different world (so Npc is not inserted in current world) or you forgot to insert Npc into the world - double check it :)");
			MEM_Info (" - or maybe your test suite case is not properly structured - double-check it");
			MEM_Info (" - in order to simulate dialogue properly script will spawn meatbug instead :) ...");
			once = 1;
		};

		if (!Hlp_IsValidNpc (diaMeatbug)) {
			Wld_InsertNpc (Meatbug, GetSymbolName (Hlp_GetInstanceID (hero)));
			diaMeatbug = Hlp_GetNpc (self);
		};

		slf = Hlp_GetNpc (diaMeatbug);
	};

	oth = Hlp_GetNpc (hero);

//-- Override state - set to ZS_TALK

	Npc_SetAIState (slf, "ZS_TALK");

//-- Override info ptr (probably not required - but wont harm)

	MEM_InformationMan.Info = infoPtr;

//--

	//Validate condition
	var int retVal; retVal = 0;
	if (info.conditions > -1) {
		MEM_CallByID (info.conditions);
		retVal = MEMINT_PopInt();

		if (!retVal) {
			MEM_Info (ConcatStrings ("TestSuite_ProcessInfo - condition unfulfilled: ", GetSymbolName (info.conditions)));
		};
	} else {
		MEM_Info (ConcatStrings ("TestSuite_ProcessInfo - condition function undefined: ", infoName));
	};

	//If told already (and not permanent) - exit
	if (info.told) {
		if (!info.permanent) {
			MEM_Info (ConcatStrings ("TestSuite_ProcessInfo - info already told: ", infoName));
			return;
		};
	};

//-- update .told property

    info.told = TRUE;

//-- call .information function

	if (info.information > -1) {
		//Setup global variables
		self = Hlp_GetNpc (slf);
		other = Hlp_GetNpc (oth);

		MEM_CallByID (info.information);
	} else {
		MEM_Info (ConcatStrings ("TestSuite_ProcessInfo - information function undefined: ", infoName));
	};

//-- call subsequent choices (if specified by query)

	var int index; index = STR_IndexOf (infoQuery, ".");
	if (index > -1) {
		var int len; len = STR_Len (infoQuery);
		infoQuery = mySTR_SubStr (infoQuery, index + 1, len - (index + 1));

		//Split query
		var int count; count = STR_SplitCount (infoQuery, STR_PIPE);

		repeat (i, count); var int i;
			var string infoChoice; infoChoice = STR_Split (infoQuery, STR_PIPE, i);
			symbID = MEM_GetSymbolIndex(infoChoice);

			if (!TestSuite_ReportOnlyIssues) {
				MEM_Info (ConcatStrings ("TestSuite_ProcessInfo - sub: ", infoChoice));
			};

			if (symbID != -1) {
				//Setup global variables
				self = Hlp_GetNpc (slf);
				other = Hlp_GetNpc (oth);

				MEM_CallByID (symbID);
			};
		end;
	};

//-- clear AI queue (non-important stuff)

	TestSuite_ClearEM (slf);
	TestSuite_ClearEM (oth);

	self = Hlp_GetNpc (selfBackup);
	other = Hlp_GetNpc (otherBackup);
};

/*
 *	TestSuite_Skip
 *	 - function sets local variable function.once to 1
 */
func void TestSuite_Skip (var func f) {
	var int ID; ID = MEM_GetFuncID (f);
	var string s; s = GetSymbolName (ID);
	s = ConcatStrings (s, ".");
	s = ConcatStrings (s, "ONCE");
	ID = MEM_GetSymbolIndex (s);
	SetSymbolIntValue (ID, 1);
};
