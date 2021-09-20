/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC
 */
func int NPC_GetInfoInstanceCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Convert to instance ID
	var int slfInstanceID; slfInstanceID = Hlp_GetInstanceID (slf);

	var int count; count = 0;

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == slfInstanceID) {
			var int i; i;
			count += 1;
		};

		infoPtr = list.next;
	end;

	return count;
};

/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC and were not yet told
 */
func int NPC_GetInfoInstanceUntoldCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Convert to instance ID
	var int slfInstanceID; slfInstanceID = Hlp_GetInstanceID (slf);

	var int count; count = 0;

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == slfInstanceID) {
			if (dlgInstance.told == 0) {
				var int i; i;
				count += 1;
			};
		};

		infoPtr = list.next;
	end;

	return count;
};

//	Commented out - seems like this cannot be used when NPC is inserted into the world - causes crashes

/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC and have trade attribute == TRUE
 */
 /*
var int InfoMan_TotalCount;
var int InfoMan_NpcInstanceID;

func void NPC_InfoMan_GetTradeCount_Sub (var int node) {
	var zCListSort list; list = _^ (node);
	if (list.data) {
		var oCInfo dlgInstance;
		dlgInstance = _^ (list.data);

		if ((dlgInstance.npc == InfoMan_NpcInstanceID) && (dlgInstance.trade)) {
			var int i; i;
			InfoMan_TotalCount += 1;
		};
	};
};

func int NPC_GetInfoInstanceTradeCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	if (!MEM_InfoMan.infoList_next) { return 0; };

	InfoMan_TotalCount = 0;
	InfoMan_NpcInstanceID = Hlp_GetInstanceID (slf);

	List_ForFS (MEM_InfoMan.infoList_next, NPC_InfoMan_GetTradeCount_Sub);

	return +InfoMan_TotalCount;
};

func int NPC_GetInfoInstanceTradeCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	if (!MEM_InfoMan.infoList_next) { return 0; };

	var int count; count = 0;
	var int slfInstanceID; slfInstanceID = Hlp_GetInstanceID (slf);

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	var int p;

	p = MEM_StackPos.position;

	var zCListSort list; list = _^ (infoPtr);

	if (list.data) {

		var oCInfo dlgInstance;
		dlgInstance = _^ (list.data);

		if ((dlgInstance.npc == slfInstanceID) && (dlgInstance.trade)) {
			//No idea why ... but here I have to use var int i; i; otherwise Gothic crashes
			var int i; i;
			count += 1;
		};

		infoPtr = list.next;
	};

	if (infoPtr) {
		MEM_StackPos.position = p;
	};

	return +count;
};

func int NPC_IsTrader (var int slfInstance) {
	MEM_InitAll ();

	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	if (!MEM_InfoMan.infoList_next) { return 0; };

	var int slfInstanceID; slfInstanceID = Hlp_GetInstanceID (slf);

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		var zCListSort list; list = _^ (infoPtr);

		if (list.data) {
			var oCInfo dlgInstance;
			dlgInstance = _^ (list.data);

			if ((dlgInstance.npc == slfInstanceID) && (dlgInstance.trade)) {
				//No idea why ... but here I have to use var int i; i; otherwise Gothic crashes
				var int i; i;
				return TRUE;
			};
		};

		infoPtr = list.next;
	end;

	return FALSE;
};
*/

func int InfoManager_GetSelectedInfo () {
	if (InfoManager_HasFinished ()) { return 0; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;

	if (!choiceView) { return 0; };

	var zCViewDialogChoice dlg; dlg = _^ (choiceView);

	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	var zCArray arr; arr = _^ (choiceView + 172);

	if (arr.array) {
		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO) {
			var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
			var C_NPC her; her = _^ (MEM_InformationMan.player);

			return oCInfoManager_GetInfoUnimportant (slf, her, dlg.ChoiceSelected);
		} else
		//Choices - have to be extracted from oCInfo.listChoices_next
		//MEM_InformationMan.Info is oCInfo pointer
		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
			return MEM_InformationMan.Info;
		};
	};

	return 0;
};

func int InfoManager_GetSelectedInfoChoice () {
	if (InfoManager_HasFinished ()) { return 0; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;

	if (!choiceView) { return 0; };

	var zCViewDialogChoice dlg; dlg = _^ (choiceView);

	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	var zCArray arr; arr = _^ (choiceView + 172);

	if (arr.array) {
		//Choices - have to be extracted from oCInfo.listChoices_next
		//MEM_InformationMan.Info is oCInfo pointer
		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
			if (MEM_InformationMan.Info) {
				var oCInfo dlgInstance;
				dlgInstance = _^ (MEM_InformationMan.Info);

				if (dlgInstance.listChoices_next) {

					var oCInfoChoice dlgChoice;
					var int list; list = dlgInstance.listChoices_next;
					var zCList l;

					var int i; i = 0;
					while (list);
						l = _^ (list);

						if (l.data) {
							if (i == dlg.ChoiceSelected) {
								return l.data;
							};
						};

						list = l.next;
						i += 1;
					end;
				};
			};
		};
	};

	return 0;
};
