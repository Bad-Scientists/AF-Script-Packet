/*
 *	Gothic Debug Dialogues
 *
 *	This feature allows you to access all NPC's dialogues:
 *	 - with spinner (left/right arrow) you can change .told property of each dialogue (if you need to re-test dialogues). If dialogues was already told, then its instance name will have green color
 *	 - you can select dialogue and call its .information function directly
 *
 *	There are in total 3 modes:
 *	 - call it with Npc in focus to debug focused Npc dialogues
 *	 - call it with no Npc in focus to debug dialogues associated with hero
 *	 - call it with Mob in focus to debug dialogues associated with mob (**ideally** [depends on how it is implemented, so this might not work 100% of the time] dialogues are associated with Npc via onState function)
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
var int debugDialoguesNpc;
var int debugDialoguesMode; //0 - npc, 1 - mob
var int debugDialoguesHideDialogueInstances; //hide/show dialogue instances (credits: thank you Plasquar for the idea :))

func string DebugDialogues_BuildChoiceTextFromInfo (var int infoPtr, var int index) {
	var string s;
	var oCInfo dlgInstance;

	if (!infoPtr) { return STR_EMPTY; };

	dlgInstance = _^ (infoPtr);

	//Important dialogues will always display instance name
	if ((!debugDialoguesHideDialogueInstances) || (dlgInstance.important))
	{
		//Add green overlay to instance name if told
		if (dlgInstance.told) {
			s = ConcatStrings ("o@h@00CC66 hs@66FFB2:", dlgInstance.name);
			s = ConcatStrings (s, "~");
		} else {
			s = dlgInstance.name;
		};

		//Add flags: Important, Trade or Permanent dialogue
		var string flags; flags = STR_EMPTY;
		if (dlgInstance.important) { flags = STR_AddString (flags, "I", ","); };
		if (dlgInstance.trade) { flags = STR_AddString (flags, "T", ","); };
		if (dlgInstance.permanent) { flags = STR_AddString (flags, "P", ","); };

		if (STR_Len (flags) > 0) {
			s = ConcatStrings (s, " (");
			s = ConcatStrings (s, flags);
			s = ConcatStrings (s, ")");
		};

		s = ConcatStrings (s, STR_SPACE);
	} else {
		//Green color for told dialogues
		if (dlgInstance.told) {
			s = "h@00CC66 hs@66FFB2 ";
		} else {
			s = "";
		};
	};

	s = ConcatStrings (s, dlgInstance.description);

	//Add spinner --> option to switch dialogues (told/untold)
	var string spinnerID; spinnerID = ConcatStrings ("s@DebugDialogues", IntToString (index));
	spinnerID = ConcatStrings (spinnerID, STR_SPACE);
	s = ConcatStrings (spinnerID, s);

	return s;
};

func void DebugDialogues_ExitDialogue () {
	debugDialoguesEnabled = FALSE;
	Info_ClearChoices (DIA_Debug_Dialogues);
	AI_StopProcessInfos (self);
};

func void DebugDialogues_BuildChoiceList () {
	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr;

	var int debugDialoguesDialogInstPtrBackup[255]; //pointers to Info instances
	var int debugDialoguesBackupChoiceCount; debugDialoguesBackupChoiceCount = 0;

	//If oCMobInter is in focus:
	// - backup and clear dialogues that have hero set as Npc
	// - call onState function - this should enable dialogues assiocated with mob
	// - restore dialogues that have hero set as Npc

	//mob
	if (debugDialoguesMode == 1) {
		//Backup dialogues with hero set as Npc
		infoPtr = MEM_InfoMan.infoList_next;

		while (infoPtr);
			list = _^ (infoPtr);
			dlgInstance = _^ (list.data);
			if (dlgInstance.npc == debugDialoguesNpc) {
				//Ignore debug dialog instance :)
				if (!Hlp_StrCmp (dlgInstance.name, "DIA_DEBUG_DIALOGUES")) {
					if (debugDialoguesBackupChoiceCount < 255) {
						//Backup dialog instance (info) pointer
						MEM_WriteIntArray (_@ (debugDialoguesDialogInstPtrBackup), debugDialoguesBackupChoiceCount, list.data);

						//Clear Npc
						dlgInstance.npc = -1;

						debugDialoguesBackupChoiceCount += 1;
					};
				};
			};

			infoPtr = list.next;
		end;

		//Call onState function - this should (... it really depends on implementation of mobsi dialogues ... some mods will probably use different logic) assign required dialogues to Npc
		var oCNpc her; her = Hlp_GetNpc(hero);
		var oCMobInter mobInter; mobInter = _^(her.focus_vob);
		var string onStateFuncName; onStateFuncName = mobInter.onStateFuncName;
		onStateFuncName = ConcatStrings(onStateFuncName, "_S1");

		//--
		var C_NPC bSelf; bSelf = Hlp_GetNpc(self);

		self = Hlp_GetNpc(hero);

		var int symbID; symbID = MEM_GetSymbolIndex(onStateFuncName);
		if (symbID > 0) {
			MEM_CallByID(symbID);
		};

		self = Hlp_GetNpc(bSelf);
		//--
	};

	debugDialoguesChoiceCount = 0;

	//Clear choices
	Info_ClearChoices (DIA_Debug_Dialogues);

	//Exit dialogue
	Info_AddChoice (DIA_Debug_Dialogues, "h@FF8000 hs@FFFF00 (exit)", DebugDialogues_ExitDialogue);

	//Toggle display instance
	if (debugDialoguesHideDialogueInstances) {
		Info_AddChoice (DIA_Debug_Dialogues, "h@FF8000 hs@FFFF00 (show dialogue instances)", DebugDialogues_ToggleDisplayDialogueInstances);
	} else {
		Info_AddChoice (DIA_Debug_Dialogues, "h@FF8000 hs@FFFF00 (hide dialogue instances)", DebugDialogues_ToggleDisplayDialogueInstances);
	};

//--

	infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == debugDialoguesNpc) {
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

	//Restore Npc for backed up dialogues
	if (debugDialoguesMode == 1) {
		repeat(i, debugDialoguesBackupChoiceCount); var int i;
			infoPtr = MEM_ReadIntArray (_@(debugDialoguesDialogInstPtrBackup), i);
			if (infoPtr) {
				dlgInstance = _^ (infoPtr);
				dlgInstance.npc = debugDialoguesNpc;
			};
		end;
	};
};

func void DebugDialogues_ToggleDisplayDialogueInstances() {
	debugDialoguesHideDialogueInstances = !debugDialoguesHideDialogueInstances;
	DebugDialogues_BuildChoiceList ();
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
		var string spinnerID; spinnerID = Choice_GetModifier (choiceText, "s@");

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
			//Min/max value (Home/End keys)
			EIM_ActiveSpinnerSetBoundaries(min, max, 1);

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
	var oCNPC her; her = Hlp_GetNPC(hero);

	//Default - npc
	debugDialoguesMode = 0;
	debugDialoguesNpc = Hlp_GetInstanceID(hero);

	if (Hlp_Is_oCMobInter(her.focus_vob)) {
		//mob
		debugDialoguesMode = 1;

		debugDialoguesEnabled = TRUE;
		DIA_Debug_Dialogues.npc = debugDialoguesNpc;
		AI_ProcessInfos(hero);

		//Hide console
		zCConsole_Hide ();
		return "ok";
	};

	//If there is nothing in focus - then we will debug dialogues assiociated with hero
	if (!Hlp_Is_oCNpc(her.focus_vob)) {

		//Assign npc instance to our dialog instance
		debugDialoguesEnabled = TRUE;
		DIA_Debug_Dialogues.npc = debugDialoguesNpc;
		AI_ProcessInfos(hero);

		//Hide console
		zCConsole_Hide ();
		return "ok";
	};

	debugDialoguesNpc = -1;

	//If npc is in focus - debug its dialogues
	if (Hlp_Is_oCNpc(her.focus_vob)) {
		var oCNpc npc; npc = _^ (her.focus_vob);
		debugDialoguesNpc = Hlp_GetInstanceID(npc);

		//Assign npc instance to our dialog instance
		debugDialoguesEnabled = TRUE;
		DIA_Debug_Dialogues.npc = debugDialoguesNpc;

		NPC_ClearAIQueue(npc);
		AI_StandUpQuick(npc);
		AI_StartState(npc, ZS_Talk, 1, STR_EMPTY);

		//Hide console
		zCConsole_Hide ();
		return "ok";
	};

	return "This command can be used only with no focus or Npc / Mob in focus.";
};

func void CC_DebugDialogues_Init () {
	//Init Enhanced info manager
	G12_EnhancedInfoManager_Init ();

	//Register console command
	CC_Register (CC_DebugDialogues, "debug dialogues", "Debug dialogues for NPC in focus.");
};
