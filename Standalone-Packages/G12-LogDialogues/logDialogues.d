/*
 *	Super simple feature that allows you to log all dialogues into diary.
 */

//-- Internal variables
var int _log_SectionForDialogues;

//oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
func void _hook_oCNpc_OnMessage__LogDialogs () {
	var int eMsg; eMsg = MEM_ReadInt (ESP + 4);

	if (!Hlp_Is_oCMsgConversation (eMsg)) { return; };

	if (MEM_InformationMan.IsDone) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	if ((ECX != MEM_InformationMan.npc) && (ECX != MEM_InformationMan.player)) { return; };

	var string log;
	var string logName; logName = STR_EMPTY;
	var int writeLog; writeLog = FALSE;

	// 0 EV_PLAYANISOUND
	if (eMsg_MD_GetSubType (eMsg) == EV_PLAYANISOUND) {

		var oCMsgConversation msg; msg = _^ (eMsg);
		/*
		I will use oCMsgConversation.bitfield_oCNpcMessage to identify events, that have been already logged.

		These are bitfields that are used by engine:

		int highPriority : 1;	1
		int deleted      : 1;	2
		int inUse        : 1;	4

		So I will use dirty bitfield with value 256 - hopefully no one uses same constant for anything else :)
		*/

		const int bitfield_oCNpcMessage_DialogueLogged = 256;

		if ((msg.bitfield_oCNpcMessage & bitfield_oCNpcMessage_DialogueLogged) == 0) {

			//Flag as logged already
			msg.bitfield_oCNpcMessage = msg.bitfield_oCNpcMessage | bitfield_oCNpcMessage_DialogueLogged;

			var oCNpc her;
			var oCNpc npc;

			var int playerTalking; playerTalking = FALSE;

			if (ECX == MEM_InformationMan.player) { playerTalking = TRUE; };

			her = _^ (MEM_InformationMan.player);
			npc = _^ (MEM_InformationMan.npc);

			const int symbID = 0;

			if (!symbID) {
				symbID = MEM_FindParserSymbol ("GetLogTopicName__LogDialogs");
			};

			if (symbID != -1) {
				MEM_PushInstParam (npc);
				MEM_PushInstParam (her);

				MEM_CallByID (symbID);
				logName = MEM_PopStringResult ();
			};

			if (STR_Len (logName) == 0) { return; };

			//new line
			if (STR_Len (log) > 0) {
				log = ConcatStrings (log, BtoC (10));
			};

			//Who is talking --> get name prefix
			var oCNPC slf; slf = _^ (ECX);
			log = ConcatStrings (log, STR_Prefix (slf.Name, 1));
			log = ConcatStrings (log, ": ");

			//add to log
			log = ConcatStrings (log, msg.text);

			//Write log into diary only when there are no more 'follow-up' dialogue events in both NPC & player AI queues
			//Seems like EV_PLAYANISOUND is being created by EV_OUTPUT --> that's why we have to check number of both events in AI queue:
			// - EV_OUTPUT is what is still in AI queue
			// - EV_PLAYANISOUND is currently active dialogues output
			var int countPlayer; countPlayer = ((NPC_EM_GetEventCountByEventName (her, "EV_PLAYANISOUND")) + (NPC_EM_GetEventCountByEventName (her, "EV_OUTPUT")));
			var int countNpc; countNpc = ((NPC_EM_GetEventCountByEventName (npc, "EV_PLAYANISOUND")) + (NPC_EM_GetEventCountByEventName (npc, "EV_OUTPUT")));

			//If player is talking, has only 1 event and npc has 0 - we can write log
			if (((countPlayer == 1) && (playerTalking)) && (countNpc == 0)) {
				writeLog = TRUE;
			} else
			//If npc is talking, has only 1 event and player has 0 - we can write log
			if (((countPlayer == 0) && (!playerTalking)) && (countNpc == 1)) {
				writeLog = TRUE;
			};
		};
	};

	if (writeLog) {
		if (STR_Len (log) > 0) {
			Log_CreateTopic (logName, _log_SectionForDialogues);
			Log_AddEntry (logName, log);
			log = STR_EMPTY;
		};
	};
};

func void G12_LogDialogues_Init () {

	//-- Load API values / init default values
	_log_SectionForDialogues = API_GetSymbolIntValue ("LOG_SECTIONFORDIALOGUES", LOG_NOTE);
	//--

	const int once = 0;
	if (!once) {
		//Hooking zCEventManager__OnMessage would be ideal,
		//but seems like it causes unexpected issues (no idea what is happening) with other functions in script-packet, for example Enhanced PickLocking
		//HookEngine (zCEventManager__OnMessage, 7, "_hook_zCEventManager_OnMessage__LogDialogs");

		HookEngine (oCNpc__OnMessage, 7, "_hook_oCNpc_OnMessage__LogDialogs");
		once = 1;
	};
};
