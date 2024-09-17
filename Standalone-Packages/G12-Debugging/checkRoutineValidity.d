/*
 *	oCRtnManager_RtnList_CheckIssues
 *	 - checks validity of routines that are currently running in routine manager
 *	 - function checks if waypoint exists
 *	 - function checks if routines are incomplete (they don't cover full 24 hour day cycle)
 *	 - function checks if routines are overlapping each other
 *
 *	oCRtnManager_RtnList_CheckValidity
 *	 - 'wrapper' function - calling oCRtnManager_RtnList_CheckIssues
 *	 - you can call this function from Init_Global () function to validate all **currently active** routines
 *	 - I would recommend to use it only for testing - as it can take up to 10 seconds to check all routines
 *
 *	oCRtnManager_AllRoutines_CheckValidity
 *	 - much more complex logic here:
 *		- function loops through all symbol addresses and searches for functions in format 'RTN_' routineName '_ID'
 *		- ID is extracted, script searches for all NPCs with this ID
 *		- script removes from routine manager all routines and inserts only found routine into routine manager
 *		- function oCRtnManager_RtnList_CheckIssues is called - this checks all issues
 *
 *	 - This should be used only for testing - it can take up to 60 seconds to check all routines.
 *
 *	oCRtnManager_InfoManager_CheckAllRoutines
 *	 - ultimate check which loops through all dialogues and calls their _info function (this might potentially update routine)
 *
 *	 - This should be used only for testing - it can take up to 10 minutes to check all routines.
 */

func string oCRtnEntry_GetString (var int rtnPtr) {
	if (!rtnPtr) { return STR_EMPTY; };
	var oCRtnEntry rtn; rtn = _^ (rtnPtr);

	var string s; s = STR_EMPTY;

	s = ConcatStrings (s, STR_FormatLeadingZeros (rtn.hour1, 2));
	s = ConcatStrings (s, ":");
	s = ConcatStrings (s, STR_FormatLeadingZeros (rtn.min1, 2));
	s = ConcatStrings (s, STR_SPACE);
	s = ConcatStrings (s, STR_FormatLeadingZeros (rtn.hour2, 2));
	s = ConcatStrings (s, ":");
	s = ConcatStrings (s, STR_FormatLeadingZeros (rtn.min2, 2));
	s = ConcatStrings (s, STR_SPACE);

	if (rtn.f_script > -1) {
		s = ConcatStrings (s, GetSymbolName (rtn.f_script));
	} else {
		s = ConcatStrings (s, IntToString (rtn.f_script));
	};

	if (rtn.overlay) {
		s = ConcatStrings (s, " (O)");
	};

	s = ConcatStrings (s, STR_SPACE);
	s = ConcatStrings (s, rtn.wpname);

	if (rtn.npc) {
		var oCNpc npc; npc = _^ (rtn.npc);
		s = ConcatStrings (s, STR_SPACE);
		s = ConcatStrings (s, GetSymbolName (Hlp_GetInstanceID (npc)));
	};

	return s;
};

func void zSpy_Info_RtnList (var int rtnListPtr) {
	if (!rtnListPtr) { return; };

	var oCRtnEntry rtn;

	var zCArray rtnList;
	rtnList = _^ (rtnListPtr);

	var string msg;
	var string lastMsg;

	var int startHour;
	var int startMin;

	var int lastEndHour;
	var int lastEndMin;

	msg = ConcatStrings ("   no of entries: ", IntToString (rtnList.numInArray));

	zSpy_Info (msg);

	repeat (i, rtnList.numInArray); var int i;
		var int rtnPtr; rtnPtr = MEM_ArrayRead (rtnListPtr, i);

		if (rtnPtr)
		{
			rtn = _^ (rtnPtr);

			msg = "      ";
			msg = ConcatStrings (msg, oCRtnEntry_GetString (rtnPtr));

			//No validation checks in case of overlays
			if (!rtn.overlay)
			{
				if (i == 0) {
					startHour = rtn.hour1;
					startMin = rtn.min1;
				};

				//Check if last end time == start time
				if (i > 0) {
					if ((lastEndHour != rtn.hour1) || (lastEndMin != rtn.min1)) {
						lastMsg = ConcatStrings (lastMsg, " -- gap/overlapping when compared with next routine entry");
					};
				};

				if (i == (rtnList.numInArray - 1)) {
					//Check if end time == start time
					if ((startHour != rtn.hour2) || (startMin != rtn.min2)) {
						msg = ConcatStrings (msg, " -- end time does not match routine start time");
					};
				};

				lastEndHour = rtn.hour2;
				lastEndMin = rtn.min2;
			};

			if (i == (rtnList.numInArray - 1)) {
				zSpy_Info (lastMsg);
				zSpy_Info (msg);
			} else {
				if (i > 0) {
					zSpy_Info (lastMsg);
				};
			};

			lastMsg = msg;
		};
	end;
};

func int oCRtnManager_RtnList_CheckIssues (var int checkNpcPtr) {
	MEM_RtnMan_Init ();

	var zCListSort list;

	var int rtnPtr; rtnPtr = MEM_RtnMan.rtnList_next;

	var string msg;

	var int i;
	var int npcPtr;

	var int issueCounter; issueCounter = 0;

	var oCNPC slf;

	var int wpIsValid;
	var int npcIsValid;
	var int funcIDIsValid;

	var int incompleteRoutine;
	var int overlappingRoutines;

	//List of already listed issues err msgs (to prevent duplicates)
	var int errListPtr; errListPtr = MEM_ArrayCreate ();

	//List of already checked npc instances (to prevent multiple checks --> MEM_RtnMan.rtnList_next is list, **subsequent** runs for same Npc would be missing routines)
	var int npcListPtr; npcListPtr = MEM_ArrayCreate ();

	var int rtnListPtr;
	var zCArray rtnList;

	while (rtnPtr);
		list = _^ (rtnPtr);

		if (list.data) {
			var oCRtnEntry rtn; rtn = _^ (list.data);

			//--> Emulation of oCRtnManager::CheckConsistency from G2A - of course we don't have that one in G1 :)
			//Here we will check whether routines are overlapping or whether they are incomplete

			incompleteRoutine = FALSE;
			overlappingRoutines = FALSE;

			if ((rtn.npc == checkNpcPtr) || ((rtn.npc) && (!checkNpcPtr))) {
				var oCNpc npc; npc = _^ (rtn.npc);
				var string npcInstanceName; npcInstanceName = GetSymbolName (Hlp_GetInstanceID (npc));

				if (!MEM_StringArrayContains (npcListPtr, npcInstanceName)) {
					//Insert npc instance name to array
					MEM_StringArrayInsert (npcListPtr, npcInstanceName);

					//Create list of routines for this NPC
					rtnListPtr = MEM_ArrayCreate ();

					//Add first routine
					MEM_ArrayInsert (rtnListPtr, list.data);

					var oCRtnEntry rtn2;

					//Loop through remaining list
					var int rtnPtr2; rtnPtr2 = list.next;
					while (rtnPtr2);
						var zCListSort list2; list2 = _^ (rtnPtr2);

						if (list2.data) {
							rtn2 = _^ (list2.data);

							//Add routine entry to the list
							if (rtn.npc == rtn2.npc) {
								MEM_ArrayInsert (rtnListPtr, list2.data);
							};
						};

						rtnPtr2 = list2.next;
					end;

					//Daily routine should have 24 hours filled by action!
					var int minsPerDay; minsPerDay = 24 * 60;

					//Is there anything in routine list?

					rtnList = _^ (rtnListPtr);

					//Loop through routines
					repeat (i, rtnList.numInArray);
						rtn2 = _^ (MEM_ArrayRead (rtnListPtr, i));

						//If there is an overlay - then ignore this NPC
						if (rtn2.overlay) {
							zSpy_Info (ConcatStrings (" - overlay routine --> ignoring npc ", npcInstanceName));
							minsPerDay = 0;
							continue;
						};

						//Deduct routine time

						var int startHour; startHour = rtn2.hour1;

						//Convert end hour to midnight
						var int endHour; endHour = rtn2.hour2;
						if ((startHour != 0) && (endHour == 0)) {
							endHour = 24;
						};

						//Convert end hour to next day
						if (startHour > endHour) {
							endHour = endHour + 24;
						};

						var int minsRoutine; minsRoutine = (endHour * 60 + rtn2.min2) - (startHour * 60 + rtn2.min1);
						minsPerDay -= minsRoutine;
					end;

					//Is there any spare time? If yes - routine is incomplete
					if (minsPerDay > 0) {
						incompleteRoutine = TRUE;
					};

					//Is there any missing time? If yes - routines are overlapping
					if (minsPerDay < 0) {
						overlappingRoutines = TRUE;
					};
				};
			};

			if ((rtn.npc == checkNpcPtr) || (!checkNpcPtr)) {

				//<--

				msg = STR_EMPTY;

				wpIsValid = SearchWaypointByName (rtn.wpname);

				//Is it possible that these could also be invalid??
				npcIsValid = Hlp_Is_oCNpc (rtn.npc);
				funcIDIsValid = rtn.f_script;

				if ((!wpIsValid) || (!npcIsValid) || (!funcIDIsValid)) {
					issueCounter += 1;

					msg = " - rtn: ";

					//what is this?
					if (rtn.inst) {
					};

					if (!npcIsValid) {
						msg = ConcatStrings (msg, " invalid NPC ");
					} else {
						slf = _^ (rtn.npc);
						msg = ConcatStrings (msg, NPC_GetRoutineName (slf));
						msg = ConcatStrings (msg, ", npc: ");
						msg = ConcatStrings (msg, GetSymbolName (Hlp_GetInstanceID (slf)));
					};

					if (!funcIDIsValid) {
						msg = ConcatStrings (msg, ", invalid function ID, ");
					} else {
						msg = ConcatStrings (msg, ", ");
						msg = ConcatStrings (msg, GetSymbolName (rtn.f_script));
					};

					if (!wpIsValid) {
						msg = ConcatStrings (msg, ", wp: ");

						if (STR_Len (rtn.wpname) == 0) {
							msg = ConcatStrings (msg, "N/A - blank waypoint! ");
						} else {
							msg = ConcatStrings (msg, rtn.wpname);
							msg = ConcatStrings (msg, " - waypoint does not exist! ");
						};
					};

					if (!MEM_StringArrayContains (errListPtr, msg)) {
						//Insert err msg to array
						MEM_StringArrayInsert (errListPtr, msg);

						zSpy_Info (msg);
					};
				};

				if (overlappingRoutines) {
					if (npcIsValid) {
						issueCounter += 1;

						slf = _^ (rtn.npc);
						msg = " - rtn: ";
						msg = ConcatStrings (msg, NPC_GetRoutineName (slf));
						msg = ConcatStrings (msg, ", npc: ");
						msg = ConcatStrings (msg, GetSymbolName (Hlp_GetInstanceID (slf)));
						msg = ConcatStrings (msg, ", routines are overlapping - check the daily routine!");

						if (!MEM_StringArrayContains (errListPtr, msg)) {
							//Insert err msg to array
							MEM_StringArrayInsert (errListPtr, msg);
							zSpy_Info (msg);
							zSpy_Info_RtnList (rtnListPtr);
						};
					};
				};

				if (incompleteRoutine) {
					if (npcIsValid) {
						issueCounter += 1;

						slf = _^ (rtn.npc);
						msg = " - rtn: ";
						msg = ConcatStrings (msg, NPC_GetRoutineName (slf));
						msg = ConcatStrings (msg, ", npc: ");
						msg = ConcatStrings (msg, GetSymbolName (Hlp_GetInstanceID (slf)));
						msg = ConcatStrings (msg, ", routine is incomplete - check the daily routine!");

						if (!MEM_StringArrayContains (errListPtr, msg)) {
							//Insert err msg to array
							MEM_StringArrayInsert (errListPtr, msg);

							zSpy_Info (msg);
							zSpy_Info_RtnList (rtnListPtr);
						};
					};
				};

				MEM_ArrayFree (rtnListPtr);
			};
		};

		rtnPtr = list.next;
	end;

	MEM_StringArrayFree (npcListPtr);
	MEM_StringArrayFree (errListPtr);

	return + issueCounter;
};

/*
 *
 */
func void oCRtnManager_RtnList_CheckValidity () {
	var string msg;
	zSpy_Info ("oCRtnManager_RtnList_CheckValidity --> ");
	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	if (oCRtnManager_RtnList_CheckIssues (0) == 0) {
		zSpy_Info (" - no issues detected at this point of time.");
	};

	zSpy_Info ("oCRtnManager_RtnList_CheckValidity <--");
};

/*
 *
 */
func void oCRtnManager_AllRoutines_CheckValidity () {
	var string msg;
	zSpy_Info ("oCRtnManager_AllRoutines_CheckValidity --> ");
	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	//List of already listed issues err msgs (to prevent duplicates)
	var int errListPtr; errListPtr = MEM_ArrayCreate ();

	var int issueCounter; issueCounter = 0;

	var int i;
	var int symOffset;

	var zCPar_Symbol symb;

	var C_NPC selfBackup; selfBackup = Hlp_GetNpc (self);

	var int npcPtr;

	repeat (i, currSymbolTableLength);
		symb = _^ (MEM_GetSymbolByIndex (i));

		if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_FUNC) {

			//We need to make sure we only work with functions in format RTN_ routine name _ID
			//For example ... calling RTN_EXCHANGE will crash the game :)
			if (STR_StartsWith (symb.Name, "RTN_")) {
				var string s; s = symb.Name;

				//Remove prefixes - to get only NPC ID
				var int index; index = STR_IndexOf (s, "_");
				while (index > -1);
					s = STR_Right (s, STR_Len (s) - index - 1);
					index = STR_IndexOf (s, "_");
				end;

				//Is this NPC ID ?
				if (STR_IsNumeric (s)) {
					var int npcID; npcID = STR_ToInt (s);

					//Some NPCs might have same ID by mistake!
					var int countNPC; countNPC = 0;
					var string npcWithID; npcWithID = STR_EMPTY;

					//Find an NPC with this ID
					var int listPtr; listPtr = MEM_World_Get_voblist_npcs ();
					var zCListSort list;

					while (listPtr);

						list = _^ (listPtr);

						if (list.data) {
							if (Hlp_Is_oCNpc (list.data)) {
								var oCNPC slf; slf = _^ (list.data);
								if (Hlp_IsValidNpc (slf)) {
									if (slf.IDX == npcID) {
										countNPC += 1;
										npcWithID = STR_AddString (npcWithID, GetSymbolName (Hlp_GetInstanceID (slf)), ", ");

										//Backup daily routine of this NPC
										var int daily_routine; daily_routine = NPC_GetDailyRoutineFuncID (slf);

										//Remove all routines!
										//oCRtnManager_RemoveAllRoutines ();

										self = Hlp_GetNpc (slf);

										//Change daily_routine (engine will update routine list)
										NPC_ChangeRoutine (slf, i); //i is index in a symbol table

										//Check issues in routine list
										issueCounter += oCRtnManager_RtnList_CheckIssues (_@ (slf));

										//Restore daily_routine
										NPC_ChangeRoutine (slf, daily_routine);
									};
								};
							};
						};

						listPtr = list.next;
					end;

					var int j;

					if (countNPC > 1) {
						msg = " - npc ID: ";
						msg = ConcatStrings (msg, s);
						msg = ConcatStrings (msg, " npcs: ");
						msg = ConcatStrings (msg, npcWithID);
						msg = ConcatStrings (msg, " have same ID! Results of routine check for this ID above might be wrong.");

						if (!MEM_StringArrayContains (errListPtr, msg)) {
							//Insert err msg to array
							MEM_StringArrayInsert (errListPtr, msg);

							zSpy_Info (msg);
						};
					};

					if (countNPC == 0) {
						msg = " - npc ID: ";
						msg = ConcatStrings (msg, s);
						msg = ConcatStrings (msg, " no NPC found. Routine ");
						msg = ConcatStrings (msg, symb.Name);
						msg = ConcatStrings (msg, " is either redundant or NPC was not yet inserted into the world.");

						if (!MEM_StringArrayContains (errListPtr, msg)) {
							//Insert err msg to array
							MEM_StringArrayInsert (errListPtr, msg);

							zSpy_Info (msg);
						};
					};
				};
			};
		};
	end;

	MEM_StringArrayFree (errListPtr);

	self = Hlp_GetNpc (selfBackup);

	if (issueCounter == 0) {
		zSpy_Info (" - no issues detected at this point of time.");
	};

	zSpy_Info ("oCRtnManager_AllRoutines_CheckValidity <--");

	//Remove any leftover routines ...

	oCRtnManager_RemoveAllRoutines ();

	//Restart routines !

	//listPtr = MEM_World_Get_voblist_npcs ();

	//while (listPtr);
	//	list = _^ (listPtr);
	//	if (list.data) {
	//		if (Hlp_Is_oCNpc (list.data)) {
	//			slf = _^ (list.data);
	//			daily_routine = NPC_GetDailyRoutineFuncID (slf);
	//			if (daily_routine) {
	//				NPC_ChangeRoutine (slf, daily_routine);
	//			};
	//		};
	//	};

	//	listPtr = list.next;
	//end;

	/*
	if (symb.offset) {
		if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INSTANCE) {

			//Hlp_Is_oCNpc will crash!
			//if (Hlp_Is_oCNpc (symb.offset)) {
			if (MEM_ReadInt (symb.offset) == oCNpc_vtbl) {
				var oCNPC slf; slf = Hlp_GetNpc (symb.instanz);
				if (Hlp_IsValidNpc (slf)) {
				};
			};
		};
	};
	*/
};

/*
 *
 */
func void oCRtnManager_InfoManager_CheckAllRoutines () {
	zSpy_Info ("oCRtnManager_InfoManager_CheckAllRoutines --> ");

	var string msg;
	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	var int lastDaily_routine; lastDaily_routine = 0;
	var int rtnIssueCounter; rtnIssueCounter = 0;

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);

		var oCNpc slf; slf = Hlp_GetNpc (dlgInstance.npc);

		if (Hlp_IsValidNpc (slf)) {
			//Beam player to NPC!
			NPC_TeleportToNpc (hero, slf);

			//Backup daily routine of this NPC
			var int daily_routine; daily_routine = NPC_GetDailyRoutineFuncID (slf);

			//Update self & other
			self = Hlp_GetNPC (slf);
			other = Hlp_GetNpc (hero);

			//Call Info dialogue
			MEM_CallByID (dlgInstance.information);

			//If routine was changed ... check potential issues
			if (lastDaily_routine != daily_routine) {
				var int issues; issues = oCRtnManager_RtnList_CheckIssues (_@ (slf));

				if (issues) {
					msg = ConcatStrings (" - dialogue ", GetSymbolName (dlgInstance));
					msg = ConcatStrings (msg, " might have caused issues with routines");
					zSpy_Info (msg);
				};

				rtnIssueCounter += issues;

				lastDaily_routine = daily_routine;
			};
		};

		infoPtr = list.next;
	end;

	if (rtnIssueCounter == 0) {
		zSpy_Info (" - no issues detected for changes triggered by dialogues.");
	} else {
		msg = " - total issues with routines: ";
		msg = ConcatStrings (msg, IntToString (rtnIssueCounter));
		zSpy_Info (msg);
	};
	zSpy_Info ("<-- oCRtnManager_InfoManager_CheckAllRoutines");
};
