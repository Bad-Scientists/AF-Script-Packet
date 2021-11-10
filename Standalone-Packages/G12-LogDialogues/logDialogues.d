/*
 *	Super simple feature that allows you to log all dialogues into diary.
 */

//oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
func void _hook_oCNpc_OnMessage__LogDialogs () {
	var int eMsg; eMsg = MEM_ReadInt (ESP + 4);

	if (!Hlp_Is_oCMsgConversation (eMsg)) { return; };

	if (MEM_InformationMan.IsDone) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	if ((ECX != MEM_InformationMan.npc) && (ECX != MEM_InformationMan.player)) { return; };

/*
	EV_PLAYANISOUND
	ani --> aniID, seems like this event is active as long as animation is active
	when it is executed at first its ani ID == -1 --> this is where we can extract dialogue text
*/

	var string log;
	var string logName;
	var int writeLog; writeLog = FALSE;

	// 0 EV_PLAYANISOUND
	if (eMsg_MD_GetSubType (eMsg) == 0) {

		var oCNpc her;
		var oCNpc npc;

		var int playerTalking; playerTalking = FALSE;

		if (ECX == MEM_InformationMan.player) { playerTalking = TRUE; };

		her = _^ (MEM_InformationMan.player);
		npc = _^ (MEM_InformationMan.npc);

		logName = GetLogTopicName__LogDialogs (npc, her);
		if (STR_Len (logName) == 0) { return; };

		var oCMsgConversation msg; msg = _^ (eMsg);

		if (msg.ani == -1) {
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
			Log_CreateTopic (logName, LOG_NOTE);
			Log_AddEntry (logName, log);
			log = "";
		};
	};
};

func void G12_LogDialogues_Init () {
	const int once = 0;
	if (!once) {
		//Hooking zCEventManager__OnMessage would be ideal,
		//but seems like it causes unexpected issues (no idea what is happening) with other functions in script-packet, for example Enhanced PickLocking
		//HookEngine (zCEventManager__OnMessage, 7, "_hook_zCEventManager_OnMessage__LogDialogs");

		HookEngine (oCNpc__OnMessage, 7, "_hook_oCNpc_OnMessage__LogDialogs");
		once = 1;
	};
};
