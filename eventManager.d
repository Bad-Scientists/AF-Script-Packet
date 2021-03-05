/*
 *	Wrapper for *MD_GetSubType functions
 */
func int eMsg_MD_GetSubType (var int eMsg) {
	if (!eMsg) { return -1; };

	/*
	0		0
	1		1 << 0
	2		1 << 1
	4		1 << 2
	8		1 << 3
	16		1 << 4
	32		1 << 5
	64		1 << 6
	128		1 << 7
	256		1 << 8
	512		1 << 9
	1024		1 << 10
	2048		1 << 11
	4096		1 << 12
	8192		1 << 13
	16384		1 << 14
	32768		1 << 15
	65536		1 << 16
	131072		1 << 17
	262144		1 << 18
	524288		1 << 19
	1048576		1 << 20
	2097152		1 << 21
	4194304		1 << 22
	8388608		1 << 23
	16777216	1 << 24
	33554432	1 << 25
	67108864	1 << 26
	134217728	1 << 27
	268435456	1 << 28
	536870912	1 << 29
	1073741824	1 << 30
	*/

	//564133898
	//564133895
	//1073741841

	//1073741824;
	//-2147483648; 

	//var zCEventMessage eventMessage;
	//eventMessage = _^ (eMsg);
	//return eventMessage.subType;
	return zCEventMessage_GetSubType (eMsg);
};

/*
 *	Wrapper for *MD_GetSubTypeString functions
 */
func string eMsg_MD_GetSubTypeString (var int eMsg, var int subType) {
	if (!eMsg) { return ""; };
	if (subType < 0) { return ""; };

	const int bit6 = 1 << 6;	//64
	const int bit7 = 1 << 7;	//128
	const int bit8 = 1 << 8;	//256
	const int bit9 = 1 << 9;	//512
	const int bit10 = 1 << 10;	//1024
	const int bit11 = 1 << 11;	//2048
	const int bit12 = 1 << 12;
	const int bit13 = 1 << 13;
	const int bit14 = 1 << 14;
	const int bit15 = 1 << 15;
	const int bit16 = 1 << 16;
	const int bit17 = 1 << 17;
	const int bit18 = 1 << 18;
	const int bit19 = 1 << 19;
	const int bit20 = 1 << 20;
	const int bit21 = 1 << 21;
	const int bit22 = 1 << 22;
	const int bit23 = 1 << 23;
	const int bit24 = 1 << 24;
	const int bit25 = 1 << 25;
	const int bit26 = 1 << 26;
	const int bit27 = 1 << 27;
	const int bit28 = 1 << 28;
	const int bit29 = 1 << 29;
	const int bit30 = 1 << 30;	//1073741824
	
	/*
	eventMessage.subType sometimes has huge values - idk why.
	Are these some 'bitwise flags' that we can remove?
	If I deduct these constants then function seems to return correct values.
	*/

	if (subType & bit30) { subType = (subType & ~ bit30); };
	if (subType & bit29) { subType = (subType & ~ bit29); };
	if (subType & bit28) { subType = (subType & ~ bit28); };
	if (subType & bit27) { subType = (subType & ~ bit27); };
	if (subType & bit26) { subType = (subType & ~ bit26); };
	if (subType & bit25) { subType = (subType & ~ bit25); };
	if (subType & bit24) { subType = (subType & ~ bit24); };
	if (subType & bit23) { subType = (subType & ~ bit23); };
	if (subType & bit22) { subType = (subType & ~ bit22); };
	if (subType & bit21) { subType = (subType & ~ bit21); };
	if (subType & bit20) { subType = (subType & ~ bit20); };
	if (subType & bit19) { subType = (subType & ~ bit19); };
	if (subType & bit18) { subType = (subType & ~ bit18); };
	if (subType & bit17) { subType = (subType & ~ bit17); };
	if (subType & bit16) { subType = (subType & ~ bit16); };
	if (subType & bit15) { subType = (subType & ~ bit15); };
	if (subType & bit14) { subType = (subType & ~ bit14); };
	if (subType & bit13) { subType = (subType & ~ bit13); };
	if (subType & bit12) { subType = (subType & ~ bit12); };
	if (subType & bit11) { subType = (subType & ~ bit11); };
	if (subType & bit10) { subType = (subType & ~ bit10); };
	if (subType & bit9) { subType = (subType & ~ bit9); };
	if (subType & bit8) { subType = (subType & ~ bit8); };
	if (subType & bit7) { subType = (subType & ~ bit7); };
	if (subType & bit6) { subType = (subType & ~ bit6); };

	var int vtbl; vtbl = MEM_ReadInt (eMsg);

	/*
		Seems like not all event-like classes have their MD_GetSubTypeString function ...
		Do we need to emulate them ?
	*/

	if (vtbl == oCMsgConversation_vtbl) {
		return oCMsgConversation_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == zCEventCore_vtbl) {
		return zCEventCore_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCNpcMessage_vtbl) {
		MEM_Info ("oCNpcMessage_vtbl");
		return "";
	};

	if (vtbl == oCMsgDamage_vtbl) {
		return oCMsgDamage_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgWeapon_vtbl) {
		return oCMsgWeapon_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgMovement_vtbl) {
		return oCMsgMovement_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgAttack_vtbl) {
		return oCMsgAttack_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgUseItem_vtbl) {
		MEM_Info ("oCMsgUseItem_vtbl");
		return "";
	};

	if (vtbl == oCMsgState_vtbl) {
		return oCMsgState_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgManipulate_vtbl) {
		return oCMsgManipulate_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgMagic_vtbl) {
		return oCMsgMagic_MD_GetSubTypeString (eMsg, subType);
	};

	//Is this NPC related?
	if (vtbl == zCEventMusicControler_vtbl) {
		return zCEventMusicControler_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMobMsg_vtbl) {
		return oCMobMsg_MD_GetSubTypeString (eMsg, subType);
	};

	//unknown vtbl
	MEM_Info (ConcatStrings ("eMsg_MD_GetSubTypeString - Unknown vtbl: ", IntToString (vtbl)));
	return "";
};

/*
oCMsgConversation_vtbl
-4-	00:37 Info:  0 Q:     0 1 EV_PLAYANISOUND  
-4-	00:37 Info:  0 Q:     1 1 EV_PLAYANI  
-4-	00:37 Info:  0 Q:     2 1 EV_PLAYSOUND  
-4-	00:37 Info:  0 Q:     3 1 EV_LOOKAT  
-4-	00:37 Info:  0 Q:     4 1 EV_OUTPUT  
-4-	00:37 Info:  0 Q:     5 1 EV_OUTPUTSVM  
-4-	00:37 Info:  0 Q:     6 1 EV_CUTSCENE  
-4-	00:37 Info:  0 Q:     7 1 EV_WAITTILLEND  
-4-	00:37 Info:  0 Q:     8 1 EV_ASK  
-4-	00:37 Info:  0 Q:     9 1 EV_WAITFORQUESTION  
-4-	00:37 Info:  0 Q:     10 1 EV_STOPLOOKAT  
-4-	00:37 Info:  0 Q:     11 1 EV_STOPPOINTAT  
-4-	00:37 Info:  0 Q:     12 1 EV_POINTAT  
-4-	00:37 Info:  0 Q:     13 1 EV_QUICKLOOK  
-4-	00:37 Info:  0 Q:     14 1 EV_PLAYANI_NOOVERLAY  
-4-	00:37 Info:  0 Q:     15 1 EV_PLAYANI_FACE  
-4-	00:37 Info:  0 Q:     16 1 EV_PROCESSINFOS  
-4-	00:37 Info:  0 Q:     17 1 EV_STOPPROCESSINFOS  
-4-	00:37 Info:  0 Q:     18 1 EV_OUTPUTSVM_OVERLAY  
*/
func string zCEventMessage_GetEventName (var int eMsg){
	if (!eMsg) { return ""; };

	var string eventName;
	eventName = eMsg_MD_GetSubTypeString (eMsg, eMsg_MD_GetSubType (eMsg));

	return eventName;
};

/*
 *	Function returns Event Name from Event Manager at index
 *		eMgr			Event Manager
 *		index			Event Message index (starts at 0)
 */
func string zcEventManager_GetEventName (var int eMgr, var int index){
	if (!Hlp_Is_zCEventManager (eMgr)) { return ""; };

	//Is there anything in event manager?
	if (zCEventManager_GetNumMessages (eMgr) <= index) { return ""; };

	//Get Event Message
	var int eMsg; eMsg = zCEventManager_GetEventMessage (eMgr, index);
	
	if (!eMsg) { return ""; };

	var string eventName;
	eventName = eMsg_MD_GetSubTypeString (eMsg, eMsg_MD_GetSubType (eMsg));

	return eventName;
};

func int zcEventManager_GetEventCountByEventName (var int eMgr, var string eventName){
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	//Is there anything in event manager?
	var int eventCount; eventCount = 0;
	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);
	
	if (eventTotal == 0) { return 0; };

	var int eMsg;
	var string thisEventName;
	
	//Loop through Event Messages
	var int i; i = 0;
	
	while (i<eventTotal);
	
		eMsg = zCEventManager_GetEventMessage (eMgr, i);

		if (eMsg) {
			thisEventName = eMsg_MD_GetSubTypeString (eMsg, eMsg_MD_GetSubType (eMsg));
			
			if (Hlp_StrCmp (eventName, thisEventName)) {
				eventCount += 1;
			};
		};
		
		i += 1;
	end;

	return eventCount;
};

/*
 *	Function returns number of Event messages in NPC's Event Manager
 *		slfinstance		NPC instance
 */
func int NPC_EM_GetEventCount (var int slfinstance){
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	return zCEventManager_GetNumMessages (eMgr);
};

/*
 *	Function returns Event Name from NPC's Event Manager at index
 *		slfinstance		NPC instance
 *		index			Event Message index (starts at 0)
 */
func string NPC_EM_GetEventName (var int slfinstance, var int index){
	if (index < 0) { return ""; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	return zcEventManager_GetEventName (eMgr, index);
};

/*
 *	Function returns number of Event Messages which are in NPC's Event Manager (by name)
 *		slfinstance		NPC instance
 *		eventName		Event Name
 */
func int NPC_EM_GetEventCountByEventName (var int slfinstance, var string eventName){
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	return zcEventManager_GetEventCountByEventName (eMgr, eventName);
};

/*
 *	Function returns Event Name of Active Event Message from NPC's Event Manager
 *		slfinstance		NPC instance
 *
 *
 *	Hmmm this one does not return same thing as NPC_EM_GetEventName (eMgr, 0);
 */
func string NPC_EM_GetActiveEventName (var int slfinstance){
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);

	if (!Hlp_IsValidNPC (slf)) { return ""; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	if (!Hlp_Is_zCEventManager (eMgr)) { return ""; };

	//Get Event Message
	var int eMsg; eMsg = zCEventManager_GetActiveMessage (eMgr);

	if (!eMsg) { return ""; };

	var string eventName;
	eventName = eMsg_MD_GetSubTypeString (eMsg, eMsg_MD_GetSubType (eMsg));

	return eventName;
};
