/*
 *	Wrapper for *MD_GetSubType functions
 */
func int eMsg_MD_GetSubType (var int eMsg) {
	if (!eMsg) { return -1; };

	var int subType; subType = zCEventMessage_GetSubType (eMsg);

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

	//eventMessage.subType sometimes has huge values - idk why.
	//Are these some 'bitwise flags' that we can remove?
	//If I deduct these constants then function seems to return correct values.

/*
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
*/

	const int bitMask = (1 << 6) - 1;
	return (subType & bitMask);
};

func string eMsg_MD_GetMsgTypeString (var int eMsg) {
	if (!eMsg) { return ""; };

	var int vtbl; vtbl = MEM_ReadInt (eMsg);

	if (vtbl == oCMsgConversation_vtbl) { return "oCMsgConversation"; };
	if (vtbl == zCEventCore_vtbl) { return "zCEventCore"; };
	if (vtbl == oCNpcMessage_vtbl) { return "oCNpcMessage"; };
	if (vtbl == oCMsgDamage_vtbl) { return "oCMsgDamage"; };
	if (vtbl == oCMsgWeapon_vtbl) { return "oCMsgWeapon"; };
	if (vtbl == oCMsgMovement_vtbl) { return "oCMsgMovement"; };
	if (vtbl == oCMsgAttack_vtbl) { return "oCMsgAttack"; };
	if (vtbl == oCMsgUseItem_vtbl) { return "oCMsgUseItem"; };
	if (vtbl == oCMsgState_vtbl) { return "oCMsgState"; };
	if (vtbl == oCMsgManipulate_vtbl) { return "oCMsgManipulate"; };
	if (vtbl == oCMsgMagic_vtbl) { return "oCMsgMagic"; };
	if (vtbl == zCEvMsgCutscene_vtbl) { return "zCEvMsgCutscene"; };

	//Is this NPC related?
	if (vtbl == zCEventMusicControler_vtbl) { return "zCEventMusicControler"; };
	if (vtbl == oCMobMsg_vtbl) { return "oCMobMsg"; };

	//unknown vtbl
	MEM_Info (ConcatStrings ("eMsg_MD_GetMsgTypeString - Unknown vtbl: ", IntToString (vtbl)));
	return "";
};

/*
 *	Wrapper for *MD_GetSubTypeString functions
 */
func string eMsg_MD_GetSubTypeString (var int eMsg) {
	if (!eMsg) { return ""; };

	var int vtbl; vtbl = MEM_ReadInt (eMsg);

	var int subType; subType = eMsg_MD_GetSubType (eMsg);

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

	if (vtbl == zCEvMsgCutscene_vtbl) {
		return zCEvMsgCutscene_MD_GetSubTypeString (eMsg, subType);
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
	eventName = eMsg_MD_GetSubTypeString (eMsg);

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

	while (i < eventTotal);
		thisEventName = zcEventManager_GetEventName (eMgr, i);

		if (Hlp_StrCmp (eventName, thisEventName)) {
			eventCount += 1;
		};

		i += 1;
	end;

	return eventCount;
};

func int zcEventManager_GetEventByEventName (var int eMgr, var string eventName){
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);

	if (eventTotal == 0) { return 0; };

	var int eMsg;
	var string thisEventName;

	//Loop through Event Messages
	var int i; i = 0;

	while (i < eventTotal);
		thisEventName = zcEventManager_GetEventName (eMgr, i);

		if (Hlp_StrCmp (eventName, thisEventName)) {
			return +zCEventManager_GetEventMessage (eMgr, i);
		};

		i += 1;
	end;

	return 0;
};

func int zcEventManager_GetIndexByEventName (var int eMgr, var string eventName){
	if (!Hlp_Is_zCEventManager (eMgr)) { return -1; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);

	if (eventTotal == 0) { return -1; };

	var int eMsg;
	var string thisEventName;

	//Loop through Event Messages
	var int i; i = 0;

	while (i < eventTotal);
		thisEventName = zcEventManager_GetEventName (eMgr, i);

		if (Hlp_StrCmp (eventName, thisEventName)) {
			return i;
		};

		i += 1;
	end;

	return -1;
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

	return +zCEventManager_GetNumMessages (eMgr);
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
	return +zcEventManager_GetEventCountByEventName (eMgr, eventName);
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
	eventName = eMsg_MD_GetSubTypeString (eMsg);

	return eventName;
};

func int NPC_EM_GetEventMessage (var int slfInstance, var int index) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	if (!zCEventManager_GetNumMessages (eMgr)) { return 0; };

	//Get Event Message
	return +zCEventManager_GetEventMessage (eMgr, index);
};

func int NPC_EM_GetEventMessageByEventName (var int slfInstance, var string eventName) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	if (!zCEventManager_GetNumMessages (eMgr)) { return 0; };

	//Get Event Message
	return +zcEventManager_GetEventByEventName (eMgr, eventName);
};

/*
 *	For testing purposes :) Prints out event-message properties
 */
func void _hook_zCEventManager_OnMessage__AnalyzeEM () {
	var string msg;

	var int eMsg; eMsg = MEM_ReadInt (ESP + 4);
	var zCEventManager eMgr; eMgr = _^ (ECX);
	if (!Hlp_Is_oCNpc (eMgr.hostVob)) { return; };

	var oCNpc slf; slf = _^ (eMgr.hostVob);
	if (!Npc_IsPlayer (slf)) { return; };

	var string msgType; msgType = eMsg_MD_GetMsgTypeString (eMsg);
	var string subType; subType = eMsg_MD_GetSubTypeString (eMsg);

	MEM_Info (msgType);
	MEM_Info (subType);

	if (Hlp_Is_oCMsgConversation (eMsg)) {
		var oCMsgConversation msgConversation;
		msgConversation = _^ (eMsg);

		msg = ConcatStrings ("targetVobName: ", msgConversation.targetVobName); MEM_Info (msg);
		msg = ConcatStrings ("bitfield_oCNpcMessage: ", IntToString (msgConversation.bitfield_oCNpcMessage)); MEM_Info (msg);
		msg = ConcatStrings ("text: ", msgConversation.text); MEM_Info (msg);
		msg = ConcatStrings ("name: ", msgConversation.name); MEM_Info (msg);
		msg = ConcatStrings ("target: ", IntToString (msgConversation.target)); MEM_Info (msg);
		msg = ConcatStrings ("ani: ", IntToString (msgConversation.ani)); MEM_Info (msg);
		msg = ConcatStrings ("cAni: ", IntToString (msgConversation.cAni)); MEM_Info (msg);
		msg = ConcatStrings ("watchMsg: ", IntToString (msgConversation.watchMsg)); MEM_Info (msg);
		msg = ConcatStrings ("handle: ", IntToString (msgConversation.handle)); MEM_Info (msg);
		msg = ConcatStrings ("timer: ", IntToString (msgConversation.timer)); MEM_Info (msg);
		msg = ConcatStrings ("number: ", IntToString (msgConversation.number)); MEM_Info (msg);
		msg = ConcatStrings ("f_no: ", IntToString (msgConversation.f_no)); MEM_Info (msg);
		msg = ConcatStrings ("f_yes: ", IntToString (msgConversation.f_yes)); MEM_Info (msg);
	};

	if (Hlp_Is_oCMsgMagic (eMsg)) {
		var oCMsgMagic msgMagic;
		msgMagic = _^ (eMsg);

		msg = ConcatStrings ("targetVobName: ", msgMagic.targetVobName); MEM_Info (msg);
		msg = ConcatStrings ("bitfield_oCNpcMessage: ", IntToString (msgMagic.bitfield_oCNpcMessage)); MEM_Info (msg);
		msg = ConcatStrings ("what: ", IntToString (msgMagic.what)); MEM_Info (msg);
		msg = ConcatStrings ("level: ", IntToString (msgMagic.level)); MEM_Info (msg);
		msg = ConcatStrings ("removeSymbol: ", IntToString (msgMagic.removeSymbol)); MEM_Info (msg);
		msg = ConcatStrings ("manaInvested: ", IntToString (msgMagic.manaInvested)); MEM_Info (msg);
		msg = ConcatStrings ("energyLeft: ", IntToString (msgMagic.energyLeft)); MEM_Info (msg);
		msg = ConcatStrings ("target: ", IntToString (msgMagic.target)); MEM_Info (msg);
		msg = ConcatStrings ("activeSpell: ", IntToString (msgMagic.activeSpell)); MEM_Info (msg);
	};

	if (Hlp_Is_oCMsgAttack (eMsg)) {
		var oCMsgAttack msgAttack;
		msgAttack = _^ (eMsg);

		msg = ConcatStrings ("targetVobName: ", msgAttack.targetVobName); MEM_Info (msg);
		msg = ConcatStrings ("bitfield_oCNpcMessage: ", IntToString (msgAttack.bitfield_oCNpcMessage)); MEM_Info (msg);
		msg = ConcatStrings ("combo: ", IntToString (msgAttack.combo)); MEM_Info (msg);
		msg = ConcatStrings ("target: ", IntToString (msgAttack.target)); MEM_Info (msg);
		msg = ConcatStrings ("hitAni: ", IntToString (msgAttack.hitAni)); MEM_Info (msg);
		msg = ConcatStrings ("startFrame: ", toStringF (msgAttack.startFrame)); MEM_Info (msg);
		msg = ConcatStrings ("bitfield_oCMsgAttack: ", IntToString (msgAttack.bitfield_oCMsgAttack)); MEM_Info (msg);
	};

	if (Hlp_Is_oCMsgManipulate (eMsg)) {
		var oCMsgManipulate msgManipulate;
		msgManipulate = _^ (eMsg);

		msg = ConcatStrings ("targetVobName: ", msgManipulate.targetVobName); MEM_Info (msg);
		msg = ConcatStrings ("bitfield_oCNpcMessage: ", IntToString (msgManipulate.bitfield_oCNpcMessage)); MEM_Info (msg);
		msg = ConcatStrings ("name: ", msgManipulate.name); MEM_Info (msg);
		msg = ConcatStrings ("slot: ", msgManipulate.slot); MEM_Info (msg);
		msg = ConcatStrings ("targetVob: ", IntToString (msgManipulate.targetVob)); MEM_Info (msg);
		msg = ConcatStrings ("flag: ", IntToString (msgManipulate.flag)); MEM_Info (msg);
		msg = ConcatStrings ("aniCombY: ", toStringF (msgManipulate.aniCombY)); MEM_Info (msg);
		//msg = ConcatStrings ("npcSlot: ", IntToString (msgManipulate.npcSlot)); MEM_Info (msg);
		//msg = ConcatStrings ("targetState: ", IntToString (msgManipulate.targetState)); MEM_Info (msg);
		//msg = ConcatStrings ("aniID: ", IntToString (msgManipulate.aniID)); MEM_Info (msg);
	};
};

func void G12_AnalyzeEventManager_Init () {
	const int once = 0;
	if (!once) {
		//0x006DD090 public: virtual void __thiscall zCEventManager::OnMessage(class zCEventMessage *,class zCVob *)
		HookEngine (zCEventManager__OnMessage, 7, "_hook_zCEventManager_OnMessage__AnalyzeEM");

		//0x006DE030 protected: virtual void __thiscall zCEventManager::InsertInList(class zCEventMessage *)
		//const int zCEventManager__InsertInList_G1 = 7200816;
		//HookEngine (zCEventManager__InsertInList_G1, 6, "_hook_zCEventManager_OnMessage__AnalyzeEM");

		once = 1;
	};
};
