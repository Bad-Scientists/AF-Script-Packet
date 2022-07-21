/*
 *	Gothic Debug Dialogues v0.1
 *
 *	This feature allows you to access all NPC's dialogues:
 *	 - with spinner (left/right arrow) you can change .told property of each dialogue (if you need to re-test dialogues). If dialogues was already told, then its instance name will have green color
 *	 - you can select dialogue and call its .information function directly
 *
 *	Requires LeGo Console commands & EnhancedInfoManager
 *
 *		LeGo_Init (legoFlags | LeGo_ConsoleCommands);
 *
 */

var int debugDialoguesEnabled;
var int debugDialoguesTold[255]; //Told properties for dialogue instances
var int debugDialoguesDialogInstPtr[255]; //pointers to Info instances
var int debugDialoguesChoiceCount;

func string DebugDialogues_BuildChoiceTextFromInfo (var int infoPtr, var int index) {
	var string s;
	var oCInfo dlgInstance;

	if (!infoPtr) { return ""; };

	dlgInstance = _^ (infoPtr);

	//Add green overlay to instance name if told
	if (dlgInstance.told) {
		s = ConcatStrings ("o@h@00CC66 hs@66FFB2:", dlgInstance.name);
		s = ConcatStrings (s, "~");
	} else {
		s = dlgInstance.name;
	};

	//Add flags: Important, Trade or Permanent dialogue
	var string flags; flags = "";
	if (dlgInstance.important) { flags = STR_AddString (flags, "I", ","); };
	if (dlgInstance.trade) { flags = STR_AddString (flags, "T", ","); };
	if (dlgInstance.permanent) { flags = STR_AddString (flags, "P", ","); };

	if (STR_Len (flags) > 0) {
		s = ConcatStrings (s, " (");
		s = ConcatStrings (s, flags);
		s = ConcatStrings (s, ")");
	};

	s = ConcatStrings (s, " ");
	s = ConcatStrings (s, dlgInstance.description);

	//Add spinner --> option to switch dialogues (told/untold)
	var string spinnerID; spinnerID = ConcatStrings ("s@DebugDialogues", IntToString (index));
	spinnerID = ConcatStrings (spinnerID, " ");
	s = ConcatStrings (spinnerID, s);

	return s;
};

func void DebugDialogues_ExitDialogue () {
	debugDialoguesEnabled = FALSE;
	Info_ClearChoices (DIA_Debug_Dialogues);
	AI_StopProcessInfos (self);
};

func void DebugDialogues_BuildChoiceList () {
	//Double check if focus_vob is NPC
	var oCNPC her; her = Hlp_GetNPC (hero);
	if (!Hlp_Is_oCNpc (her.focus_vob)) { return; };

	var oCNpc npc; npc = _^ (her.focus_vob);
	var int npcInstance; npcInstance = Hlp_GetInstanceID (npc);

	debugDialoguesChoiceCount = 0;

	//Clear choices
	Info_ClearChoices (DIA_Debug_Dialogues);

	//Exit dialogue
	Info_AddChoice (DIA_Debug_Dialogues, "h@FF8000 hs@FFFF00 Exit.", DebugDialogues_ExitDialogue);

//--

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == npcInstance) {
			//Ignore debug dialog instance :)
			if (!Hlp_StrCmp (dlgInstance.name, "DIA_DEBUG_DIALOGUES")) {
				if (debugDialoguesChoiceCount < 255) {
					var string choiceText; choiceText = DebugDialogues_BuildChoiceTextFromInfo (list.data, debugDialoguesChoiceCount);

					//Store told property and dialog instance (info) pointer
					MEM_WriteIntArray (_@ (debugDialoguesTold), debugDialoguesChoiceCount, dlgInstance.told);
					MEM_WriteIntArray (_@ (debugDialoguesDialogInstPtr), debugDialoguesChoiceCount, list.data);

					Info_AddChoice (DIA_Debug_Dialogues, choiceText, DebugDialogues_CallInfo);

					debugDialoguesChoiceCount += 1;
				};
			};
		};

		infoPtr = list.next;
	end;
};

func void DebugDialogues_CallInfo () {
	var int choiceIndex; choiceIndex = InfoManager_GetSelectedChoiceIndex ();

	if ((choiceIndex >= 0) && (choiceIndex < debugDialoguesChoiceCount)) {
		//Choices are sorted from last added to first added --> so we have to flip our choice index here for infos!
		var int infoIndex;
		infoIndex = (debugDialoguesChoiceCount - 1) - choiceIndex;

		var int infoPtr; infoPtr = MEM_ReadIntArray (_@ (debugDialoguesDialogInstPtr), infoIndex);

		if (!infoPtr) { return; };

		//Change dialogue to told
		var oCInfo dlgInstance; dlgInstance = _^ (infoPtr);
		dlgInstance.told = TRUE;

		//Clear choices
		Info_ClearChoices (DIA_Debug_Dialogues);

		var int infoPtrBackup; infoPtrBackup = MEM_InformationMan.Info;

		//Little trick --> change MEM_InformationMan.info to selected infoPtr
		//This way choices added by 'tested' dialogue will be handled properly - we can fully test dialogues :)
		MEM_InformationMan.Info = infoPtr;

		//Call information function
		MEM_CallByID (dlgInstance.information);

		//If there are no choices added --> reset MEM_InformationMan.info and re-build dialog choices
		if (!dlgInstance.listChoices_next) {
			MEM_InformationMan.Info = infoPtrBackup;
			DebugDialogues_BuildChoiceList ();
		};
	};
};

/*
 *	Dialogue instance that will build choice list with all dialogues.
 *	Condition function handles spinners on all choices added by this feature.
 */
instance DIA_Debug_Dialogues (C_Info) {
	nr = 0;
	condition = DIA_Debug_Dialogues_Condition;
	information = DIA_Debug_Dialogues_Info;
	permanent = 1;
	important = 1;
};

func int DIA_Debug_Dialogues_Condition() {
	if (!debugDialoguesEnabled) { return FALSE; };

	var int choiceIndex; choiceIndex = InfoManager_GetSelectedChoiceIndex ();

	if ((choiceIndex >= 0) && (choiceIndex < debugDialoguesChoiceCount)) {
		var string choiceText; choiceText = InfoManager_GetChoiceDescription (choiceIndex);
		var string spinnerID; spinnerID = Choice_GetModifierSpinnerID (choiceText);

		//--

		var string lastSpinnerID;

		var int min;
		var int max;
		var int value;
		var int oldValue;

		//Choices are sorted from last added to first added --> so we have to flip our choice index here for infos!
		var int infoIndex;
		infoIndex = (debugDialoguesChoiceCount - 1) - choiceIndex;

		value = MEM_ReadIntArray (_@ (debugDialoguesTold), infoIndex);
		oldValue = value;

		//Min/max values
		min = 0;
		max = 1;

		//Check boundaries
		if (value < min) { value = min; };
		if (value > max) { value = max; };

		var int isActive;
		isActive = Hlp_StrCmp (InfoManagerSpinnerID, spinnerID);

		//Setup spinner if spinner ID has changed
		if (isActive) {
			//What is current InfoManagerSpinnerID ?
			if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
				//Update value
				InfoManagerSpinnerValue = value;
			};

			//Page Up/Down quantity
			InfoManagerSpinnerPageSize = 1;

			//Min/max value (Home/End keys)
			InfoManagerSpinnerValueMin = min;
			InfoManagerSpinnerValueMax = max;

			//Update
			value = InfoManagerSpinnerValue;
		};

		var int spinnerValueChanged; spinnerValueChanged = (value != oldValue);

		if (spinnerValueChanged) {
			MEM_WriteIntArray (_@ (debugDialoguesTold), infoIndex, value);
		};

		//Update choice description!
		if ((isActive) && (spinnerValueChanged)) {
			var int infoPtr; infoPtr = MEM_ReadIntArray (_@ (debugDialoguesDialogInstPtr), infoIndex);

			if (infoPtr) {
				//Update told property
				var oCInfo dlgInstance; dlgInstance = _^ (infoPtr);
				dlgInstance.told = value;

				//Update choice text
				choiceText = DebugDialogues_BuildChoiceTextFromInfo (infoPtr, infoIndex);
				InfoManager_SetInfoChoiceText_BySpinnerID (choiceText, spinnerID);
			};
		};

		lastSpinnerID = InfoManagerSpinnerID;
	};

	return TRUE;
};

func void DIA_Debug_Dialogues_Info () {
	DebugDialogues_BuildChoiceList ();
};

func string CC_DebugDialogues (var string param) {
	var oCNPC her; her = Hlp_GetNPC (hero);
	if (!Hlp_Is_oCNpc (her.focus_vob)) { return "hero.focus_vob is not an NPC."; };

	var oCNpc npc; npc = _^ (her.focus_vob);
	var int npcInstance; npcInstance = Hlp_GetInstanceID (npc);

	//Hide console
	zCConsole_Hide ();

	//Enable DIA_Debug_Dialogues
	debugDialoguesEnabled = TRUE;

	//Assign npc instance to our dialog instance
	DIA_Debug_Dialogues.npc = npcInstance;

	NPC_ClearAIQueue (npc);
	AI_StandUpQuick (npc);

	AI_StartState (npc, ZS_Talk, 1, "");
	return "ok";
};

func void CC_DebugDialogues_Init () {
	//Init Enhanced info manager
	G12_EnhancedInfoManager_Init ();

	//Register console command
	CC_Register (CC_DebugDialogues, "debug dialogues", "Debug dialogues for NPC in focus.");
};
