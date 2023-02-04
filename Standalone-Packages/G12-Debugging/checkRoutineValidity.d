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
func int oCRtnManager_RtnList_CheckIssues (var int checkNpcPtr) {
	MEM_RtnMan_Init ();

	var zCListSort list;

	var int rtnPtr; rtnPtr = MEM_RtnMan.rtnList_next;

	var string msg;

	var int npcPtr;
	var int npcPtrList; npcPtrList = MEM_ArrayCreate ();
	var zCArray npcList; npcList = _^ (npcPtrList);

	var int issueCounter; issueCounter = 0;

	var oCNPC slf;

	var int wpIsValid;
	var int npcIsValid;
	var int funcIDIsValid;

	var int incompleteRoutine;
	var int overlappingRoutines;

	while (rtnPtr);
		list = _^ (rtnPtr);

		if (list.data) {
			var oCRtnEntry rtn; rtn = _^ (list.data);

			//--> Emulation of oCRtnManager::CheckConsistency from G2A - of course we don't have that one in G1 :)
			//Here we will check whether routines are overlapping or whether they are incomplete

			incompleteRoutine = FALSE;
			overlappingRoutines = FALSE;

			if ((rtn.npc == checkNpcPtr) || ((rtn.npc) && (!checkNpcPtr))) {
				var int i;
				var int newNpc; newNpc = TRUE;

				//Did we check this NPC already?
				if (npcList.numInArray) {
					repeat (i, npcList.numInArray);
						npcPtr = MEM_ArrayRead (npcPtrList, i);

						if (npcPtr == rtn.npc) {
							newNpc = FALSE;
							break;
						};
					end;
				};

				//We didn't check this one yet
				if (newNpc) {
					//Add to the list - to prevent multiple loops
					MEM_ArrayInsert (npcPtrList, rtn.npc);

					//Create list of routines for this NPC
					var int rtnListPtr; rtnListPtr = MEM_ArrayCreate ();

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

					var zCArray rtnList; rtnList = _^ (rtnListPtr);

					if (rtnList.numInArray) {
						//Loop through routines
						repeat (i, rtnList.numInArray);
							rtn2 = _^ (MEM_ArrayRead (rtnListPtr, i));

							//If there is an overlay - then ignore this NPC
							if (rtn2.overlay) {
								zSpy_Info (" - overlay routine --> ignoring");
								minsPerDay = 0;
								continue;
							};

							//Deduct routine time

							//Convert end hour to midnight
							var int endHour; endHour = rtn2.hour2;
							if (endHour == 0) {
								endHour = 24;
							};

							//Convert end hour to next day
							var int startHour; startHour = rtn2.hour1;
							if (startHour > endHour) {
								endHour = endHour + 24;
							};

							var int minsRoutine; minsRoutine = (endHour * 60 + rtn2.min2) - (startHour * 60 + rtn2.min1);
							minsPerDay -= minsRoutine;
						end;
					};

					MEM_ArrayFree (rtnListPtr);

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

				msg = "";

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

					zSpy_Info (msg);
				};

				if (overlappingRoutines) {
					if (npcIsValid) {
						slf = _^ (rtn.npc);
						msg = " - rtn: ";
						msg = ConcatStrings (msg, NPC_GetRoutineName (slf));
						msg = ConcatStrings (msg, ", npc: ");
						msg = ConcatStrings (msg, GetSymbolName (Hlp_GetInstanceID (slf)));
						msg = ConcatStrings (msg, ", routines are overlapping - check the daily routine!");
						zSpy_Info (msg);
					};
				};

				if (incompleteRoutine) {
					if (npcIsValid) {
						slf = _^ (rtn.npc);
						msg = " - rtn: ";
						msg = ConcatStrings (msg, NPC_GetRoutineName (slf));
						msg = ConcatStrings (msg, ", npc: ");
						msg = ConcatStrings (msg, GetSymbolName (Hlp_GetInstanceID (slf)));
						msg = ConcatStrings (msg, ", routine is incomplete - check the daily routine!");
						zSpy_Info (msg);
					};
				};
			};
		};

		rtnPtr = list.next;
	end;

	MEM_ArrayFree (npcPtrList);

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

	var int issueCounter; issueCounter = 0;

	var int i;
	var int symOffset;

	var zCPar_Symbol symb;

	var C_NPC selfBackup; selfBackup = Hlp_GetNpc (self);

	var int npcPtr;
	var int npcIDListPtr; npcIDListPtr = MEM_ArrayCreate ();
	var zCArray npcIDList; npcIDList = _^ (npcIDListPtr);

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
					var string npcWithID; npcWithID = "";

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
					var int newNpcID; newNpcID = TRUE;

					var int npcCheckedID;

					//Did we check this NPC ID already?
					if (npcIDList.numInArray) {
						repeat (j, npcIDList.numInArray);
							npcCheckedID = MEM_ArrayRead (npcIDListPtr, j);

							if (npcCheckedID == npcID) {
								newNpcID = FALSE;
								break;
							};
						end;
					};

					if (newNpcID) {
						//Add to the list - to prevent multiple loops
						MEM_ArrayInsert (npcIDListPtr, npcID);

						if (countNPC > 1) {
							msg = " - npc ID: ";
							msg = ConcatStrings (msg, s);
							msg = ConcatStrings (msg, " npcs: ");
							msg = ConcatStrings (msg, npcWithID);
							msg = ConcatStrings (msg, " have same ID! Results of routine check for this ID above might be wrong.");
							zSpy_Info (msg);
						};

						if (countNPC == 0) {
							msg = " - npc ID: ";
							msg = ConcatStrings (msg, s);
							msg = ConcatStrings (msg, " no NPC found. Routine ");
							msg = ConcatStrings (msg, symb.Name);
							msg = ConcatStrings (msg, " is either redundant or NPC was not yet inserted into the world.");
							zSpy_Info (msg);
						};
					};
				};
			};
		};
	end;

	MEM_ArrayFree (npcIDListPtr);

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
				rtnIssueCounter += oCRtnManager_RtnList_CheckIssues (_@ (slf));

				lastDaily_routine = daily_routine;
			};
		};

		infoPtr = list.next;
	end;

	if (rtnIssueCounter == 0) {
		zSpy_Info (" - no issues detected for changes triggere by dialogues.");
	} else {
		msg = " - total issues with routines: ";
		msg = ConcatStrings (msg, IntToString (rtnIssueCounter));
		zSpy_Info (msg);
	};
	zSpy_Info ("<-- oCRtnManager_InfoManager_CheckAllRoutines");
};
