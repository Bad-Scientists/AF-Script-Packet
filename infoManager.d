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

func void InfoManager_SetInfoChoiceText (var int index, var string text) {
	if (InfoManager_HasFinished ()) { return; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;

	if (!choiceView) { return; };

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

					var int list; list = dlgInstance.listChoices_next;
					var zCList l;

					var int i; i = 0;
					while (list);
						l = _^ (list);

						if (l.data) {
							if (i == index) {
								var oCInfoChoice dlgChoice;
								dlgChoice = _^ (l.data);
								dlgChoice.Text = text;
								return;
							};
						};

						list = l.next;
						i += 1;
					end;
				};
			};
		};
	};
};

func int InfoManager_GetSelectedChoiceIndex () {
	if (InfoManager_HasFinished ()) { return -1; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;

	if (!choiceView) { return -1; };

	var zCViewDialogChoice dlg; dlg = _^ (choiceView);

	return dlg.ChoiceSelected;
};

func string InfoManager_GetChoiceDescription (var int index) {
	if (InfoManager_HasFinished ()) { return ""; };

	if (index < 0) { return ""; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;

	if (!choiceView) { return ""; };

	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	var zCArray arr; arr = _^ (choiceView + 172);

	if ((arr.array) && (index < arr.numInArray)) {
		var int infoPtr;
		var oCInfo dlgInstance;

		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO)
		{
			infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, index);

			if (infoPtr) {
				dlgInstance = _^ (infoPtr);
				return dlgInstance.description;
			};
		} else
		//Choices - have to be extracted from oCInfo.listChoices_next
		//MEM_InformationMan.Info is oCInfo pointer
		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
			infoPtr = MEM_InformationMan.Info;

			if (infoPtr) {
				dlgInstance = _^ (infoPtr);

				if (dlgInstance.listChoices_next) {
					//loop counter for all Choices
					var int i; i = 0;

					var oCInfoChoice dlgChoice;

					var int list; list = dlgInstance.listChoices_next;
					var zCList l;

					while (list);
						l = _^ (list);
						if (l.data) {
							//if our dialog option is dialog choice - put text to dlgDescription
							if (i == index) {
								dlgChoice = _^ (l.data);
								return dlgChoice.Text;
							};
						};

						list = l.next;
						i += 1;
					end;
				};
			};
		};
	};

	return "";
};

/*
 *	Npc_KnowsInfoByString
 *	 - function checks out if oCInfo.told property != 0
 *	 - I will be using this one to avoid compilation issues (function will allow me to compile incomplete/interconnected dialogues)
 *	 - but it might be actually quite useful - as it also works with .permanent dialogues, unlike vanilla Npc_KnowsInfo!
 *	 - NPC parameter is pointless ... it's always 'hero', using it just for sake of consistency with Npc_KnowsInfo
 *
 *	Altered version of setInfoToTold function, originally created by Cryp18Struct
 *	Original function: https://forum.worldofplayers.de/forum/threads/1529361-Dialog-Instance-auf-TRUE-setzten?p=25955510&viewfull=1#post25955510
 */
func int Npc_KnowsInfoByString (var int slfInstance, var string instanceName) {
	// Find instance symbol by instance name
	var int symbID; symbID = MEM_GetSymbolIndex(instanceName);
	if (symbID < 0) || (symbID >= currSymbolTableLength) {
		MEM_Info(ConcatStrings("Npc_KnowsInfoByString: symbol not found ", instanceName));
		return 0;
	};

	var zCPar_Symbol symb; symb = _^ (MEM_GetSymbolByIndex(symbID));

	// Verify that it is an instance
	if ((symb.bitfield & zCPar_Symbol_bitfield_type) != zPAR_TYPE_INSTANCE)
	|| (!symb.offset) {
		MEM_Info(ConcatStrings("Npc_KnowsInfoByString: symbol is not an instance ", instanceName));
		return 0;
	};

	// Verify that it is a oCInfo instance

	//0x007DCD8C const oCInfo::`vftable'
	const int oCInfo___vftable_G1 = 8244620;

	//0x0083C44C const oCInfo::`vftable'
	const int oCInfo___vftable_G2 = 8635468;

	if (MEM_ReadInt(symb.offset - oCInfo_C_INFO_Offset) != MEMINT_SwitchG1G2 (oCInfo___vftable_G1, oCInfo___vftable_G2)) {
		MEM_Info(ConcatStrings("Npc_KnowsInfoByString: symbol is not a oCInfo instance: ", instanceName));
		return 0;
	};

	var oCInfo info; info = _^ (symb.offset - oCInfo_C_INFO_Offset);
	return info.told;
};
