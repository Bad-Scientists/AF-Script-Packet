/*
 *
 */
func string Vob_GetPortalNameAndPosition (var int vobPtr) {
	var int x;
	var int y;
	var int z;

	var int pos[3];

	var string portalRoom;

	var string s;

	//Get portal room
	s = Vob_GetPortalName (vobPtr);

	s = ConcatStrings (", portalroom: '", s);
	s = ConcatStrings (s, "'");

	//Get position
	if (zCVob_GetPositionWorldToPos (vobPtr, _@ (pos))) {

		x = roundF (pos[0]);
		y = roundF (pos[1]) + 250; //add just enough for player to be able to teleport to location
		z = roundF (pos[2]);

		s = ConcatStrings (s, ", pos: ");
		s = ConcatStrings (s, IntToString (x));
		s = ConcatStrings (s, STR_SPACE);

		s = ConcatStrings (s, IntToString (y));
		s = ConcatStrings (s, STR_SPACE);

		s = ConcatStrings (s, IntToString (z));
	};

	return s;
};

/*
 *	oCMob_CheckProperties
 *	 - checks properties of oCMob objects
 *	 - you can call this function from Init_Global () function to validate all locks
 */
func void oCMob_CheckProperties () {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	var string msg;

	zSpy_Info ("oCMob_CheckProperties -->");
	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	//Case sensitive!
	if (!SearchVobsByClass ("oCMOB", vobListPtr)) {
		zSpy_Info (" - no oCMOB objects found.");
		zSpy_Info ("oCMob_CheckProperties <--");
		MEM_ArrayFree (vobListPtr);
		return;
	};

	//List of already listed issues err msgs (to prevent duplicates)
	var int errListPtr; errListPtr = MEM_ArrayCreate ();
	var int keyListPtr; keyListPtr = MEM_ArrayCreate ();

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i;
	var int issueCounter;

	var oCMob mob;
	var oCMobLockable mobLockable;

	issueCounter = 0;

	i = 0;

	while (i < vobList.numInArray);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (Hlp_Is_oCMob (vobPtr)) {
			mob = _^ (vobPtr);
			msg = STR_EMPTY;

			var int ownerStrHasToBeTrimmed; ownerStrHasToBeTrimmed = FALSE;
			var int ownerGuildStrHasToBeTrimmed; ownerGuildStrHasToBeTrimmed = FALSE;

			var int ownerStrInvalid; ownerStrInvalid = FALSE;
			var int ownerGuildStrInvalid; ownerGuildStrInvalid = FALSE;

			//--> check for extra spaces in ownerStr or ownerGuildStr
			var string ownerStr; ownerStr = mob.ownerStr;
			var string ownerGuildStr; ownerGuildStr = mob.ownerGuildStr;

			var int lenOwnerStr; lenOwnerStr = STR_Len (ownerStr);
			var int lenOwnerGuildStr; lenOwnerGuildStr = STR_Len (ownerGuildStr);

			ownerStr = STR_TrimChar (ownerStr, CHR_SPACE);
			ownerGuildStr = STR_TrimChar (ownerGuildStr, CHR_SPACE);

			if (lenOwnerStr != STR_Len (ownerStr)) {
				ownerStrHasToBeTrimmed = TRUE;
			};

			if (lenOwnerGuildStr != STR_Len (ownerGuildStr)) {
				ownerGuildStrHasToBeTrimmed = TRUE;
			};
			//<--

			//--> check invalid symbols (trimmed at this point)
			var int symbID;

			if (STR_Len (ownerStr)) {
				symbID = MEM_FindParserSymbol (ownerStr);
				if (symbID == -1) {
					ownerStrInvalid = TRUE;
				};
			};

			if (STR_Len (ownerGuildStr)) {
				symbID = MEM_FindParserSymbol (ownerGuildStr);
				if (symbID == -1) {
					ownerGuildStrInvalid = TRUE;
				};
			};

			//Report to zSpy:
			if (ownerStrHasToBeTrimmed || ownerGuildStrHasToBeTrimmed || ownerStrInvalid || ownerGuildStrInvalid) {
				issueCounter += 1;

				msg = ConcatStrings (" - oCMOB: '", mob.name);
				msg = ConcatStrings (msg, "'");

				msg = ConcatStrings (msg, Vob_GetPortalNameAndPosition (vobPtr));

				if (ownerStrHasToBeTrimmed) {
					msg = ConcatStrings (msg, ", ownerStr contains spaces: '");
					msg = ConcatStrings (msg, mob.ownerStr);
					msg = ConcatStrings (msg, "'");
				};

				if (ownerGuildStrHasToBeTrimmed) {
					msg = ConcatStrings (msg, ", ownerGuildStr contains spaces: '");
					msg = ConcatStrings (msg, mob.ownerGuildStr);
					msg = ConcatStrings (msg, "'");
				};

				if (ownerStrInvalid) {
					msg = ConcatStrings (msg, ", ownerStr is invalid : '");
					msg = ConcatStrings (msg, ownerStr);
					msg = ConcatStrings (msg, "'");
				};

				if (ownerGuildStrInvalid) {
					msg = ConcatStrings (msg, ", ownerGuildStr is invalid: '");
					msg = ConcatStrings (msg, ownerGuildStr);
					msg = ConcatStrings (msg, "'");
				};

				if (!MEM_StringArrayContains (errListPtr, msg)) {
					//Insert err msg to array
					MEM_StringArrayInsert (errListPtr, msg);
					zSpy_Info (msg);
				};
			};

			//We can fix this one from scripts:
			if (ownerStrHasToBeTrimmed || ownerGuildStrHasToBeTrimmed) {
				//Update owner strings (this will update oCMOB.owner & oCMOB.ownerGuild properties)
				oCMob_SetOwnerStr (vobPtr, ownerStr, ownerGuildStr);
			};
		};

		i += 1;
	end;

	//It's nicer if we have 2 loops and output is split by object category
	i = 0;
	while (i < vobList.numInArray);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (Hlp_Is_oCMobLockable (vobPtr)) {
			mobLockable = _^ (vobPtr);

			msg = STR_EMPTY;

			var int pickLockStrValid; pickLockStrValid = TRUE;
			var int keyIsValid; keyIsValid = TRUE;

			//Check if pickLockStr is valid (only combination of L and R)
			if (STR_Len (mobLockable.pickLockStr)) {
				var string pickLockStr; pickLockStr = mobLockable.pickLockStr;
				pickLockStr = STR_ReplaceAll (pickLockStr, "L", STR_EMPTY);
				pickLockStr = STR_ReplaceAll (pickLockStr, "R", STR_EMPTY);

				pickLockStr = STR_TrimChar (pickLockStr, CHR_SPACE);

				pickLockStrValid = (STR_Len (pickLockStr) == 0);
			};

			//Check if key is valid
			if (STR_Len (mobLockable.keyInstance)) {
				keyIsValid = MEM_FindParserSymbol (mobLockable.keyInstance);

				//Get name
				msg = ConcatStrings (" - oCMobLockable: '", mobLockable._oCMob_name);
				msg = ConcatStrings (msg, "'");

				//Get key
				msg = ConcatStrings (msg, ", key: '");
				msg = ConcatStrings (msg, mobLockable.keyInstance);
				msg = ConcatStrings (msg, "'");

				//Get picklock combination
				msg = ConcatStrings (msg, ", pickLockStr: '");
				msg = ConcatStrings (msg, mobLockable.pickLockStr);
				msg = ConcatStrings (msg, "'");

				msg = ConcatStrings (msg, Vob_GetPortalNameAndPosition (vobPtr));

				//Report key requirements to zSpy log
				if (!MEM_StringArrayContains (keyListPtr, msg)) {
					//Insert err msg to array
					MEM_StringArrayInsert (keyListPtr, msg);
				};
			};

			if ((keyIsValid == -1) || (pickLockStrValid == FALSE)) {
				issueCounter += 1;

				//Get name
				msg = ConcatStrings (" - oCMobLockable: '", mobLockable._oCMob_name);
				msg = ConcatStrings (msg, "'");

				//Get key
				msg = ConcatStrings (msg, ", key: '");
				msg = ConcatStrings (msg, mobLockable.keyInstance);
				msg = ConcatStrings (msg, "'");

				//Get picklock combination
				msg = ConcatStrings (msg, ", pickLockStr: '");
				msg = ConcatStrings (msg, mobLockable.pickLockStr);
				msg = ConcatStrings (msg, "'");

				msg = ConcatStrings (msg, Vob_GetPortalNameAndPosition (vobPtr));

				if (keyIsValid == -1) {
					//Key does not exits
					msg = ConcatStrings (msg, " has an invalid key - item does not exist!");
				};

				if (pickLockStrValid == FALSE) {
					//Key does not exits
					msg = ConcatStrings (msg, " has an invalid pickLockStr!");
				};

				if (!MEM_StringArrayContains (errListPtr, msg)) {
					//Insert err msg to array
					MEM_StringArrayInsert (errListPtr, msg);
					zSpy_Info (msg);
				};
			};
		};

		i += 1;
	end;

	if (keyListPtr) {
		zSpy_Info ("list all mobs with keys --> ");

		var zCArray arr; arr = _^ (keyListPtr);

		var int ptr;

		repeat (i, arr.numInArray);
			ptr = MEM_ArrayRead (keyListPtr, i);
			msg = MEM_ReadString (ptr);
			zSpy_Info (msg);
		end;

		zSpy_Info ("<-- list all mobs with keys");
	};

	MEM_StringArrayFree (keyListPtr);
	MEM_StringArrayFree (errListPtr);
	MEM_ArrayFree (vobListPtr);

	if (issueCounter == 0) {
		zSpy_Info (" - no issues detected.");
	};

	zSpy_Info ("oCMob_CheckProperties <--");
};

/*
 *	zCTrigger_CheckProperties
 *	 - checks properties of zCTrigger objects
 *	 - you can call this function from Init_Global () function to validate all locks
 */
func void zCTrigger_CheckProperties () {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	var string msg;

	zSpy_Info ("zCTrigger_CheckProperties -->");
	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	//Case sensitive!
	if (!SearchVobsByClass ("zCTrigger", vobListPtr)) {
		zSpy_Info (" - no zCTrigger objects found.");
		zSpy_Info ("zCTrigger_CheckProperties <--");
		MEM_ArrayFree (vobListPtr);
		return;
	};

	//List of already listed issues err msgs (to prevent duplicates)
	var int errListPtr; errListPtr = MEM_ArrayCreate ();

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i;

	var int issueCounter; issueCounter = 0;

	var zCTrigger trigger;

	i = 0;
	while (i < vobList.numInArray);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (Hlp_Is_zCTrigger (vobPtr)) {
			trigger = _^ (vobPtr);
			msg = STR_EMPTY;

			var int countTriggerTarget; countTriggerTarget = 0;
			var int triggerTargetHasToBeTrimmed; triggerTargetHasToBeTrimmed = FALSE;
			var int triggerTargetInvalid; triggerTargetInvalid = FALSE;

			//--> check for extra spaces in triggetTarget
			var string triggerTarget; triggerTarget = trigger.triggerTarget;

			var int lenTriggerTarget; lenTriggerTarget = STR_Len (triggerTarget);

			triggerTarget = STR_TrimChar (triggerTarget, CHR_SPACE);

			if (lenTriggerTarget != STR_Len (triggerTarget)) {
				triggerTargetHasToBeTrimmed = TRUE;
			};
			//<--

			//--> check invalid symbols (trimmed at this point)
			var int symbID;

			if (STR_Len (triggerTarget)) {
				countTriggerTarget = Vob_GetNoOfVobsByName (triggerTarget);

				if (!countTriggerTarget) {
					msg = ConcatStrings (" - zCTrigger: '", trigger._zCObject_objectName);
					msg = ConcatStrings (msg, "'");

					msg = ConcatStrings (msg, ", triggerTarget not found: '");
					msg = ConcatStrings (msg, triggerTarget);
					msg = ConcatStrings (msg, "'");

					if (!MEM_StringArrayContains (errListPtr, msg)) {
						//Insert err msg to array
						MEM_StringArrayInsert (errListPtr, msg);
						zSpy_Info (msg);
					};
				};

				if (countTriggerTarget > 1) {
					msg = ConcatStrings (" - zCTrigger: '", trigger._zCObject_objectName);
					msg = ConcatStrings (msg, "'");

					msg = ConcatStrings (msg, ", multiple triggerTargets found.");
					msg = ConcatStrings (msg, triggerTarget);
					msg = ConcatStrings (msg, "'");

					if (!MEM_StringArrayContains (errListPtr, msg)) {
						//Insert err msg to array
						MEM_StringArrayInsert (errListPtr, msg);
						zSpy_Info (msg);
					};
				};

				symbID = MEM_FindParserSymbol (triggerTarget);
				if (symbID == -1) {
					triggerTargetInvalid = TRUE;
				};
			};

			//Report to zSpy:
			if (triggerTargetInvalid || triggerTargetHasToBeTrimmed) {
				issueCounter += 1;

				msg = ConcatStrings (" - zCTrigger: '", trigger._zCObject_objectName);
				msg = ConcatStrings (msg, "'");

				msg = ConcatStrings (msg, Vob_GetPortalNameAndPosition (vobPtr));

				if (triggerTargetHasToBeTrimmed) {
					msg = ConcatStrings (msg, ", triggerTarget contains spaces: '");
					msg = ConcatStrings (msg, trigger.triggerTarget);
					msg = ConcatStrings (msg, "'");
				};

				if (triggerTargetInvalid) {
					msg = ConcatStrings (msg, ", triggerTarget is invalid: '");
					msg = ConcatStrings (msg, triggerTarget);
					msg = ConcatStrings (msg, "'");
				};

				if (!MEM_StringArrayContains (errListPtr, msg)) {
					//Insert err msg to array
					MEM_StringArrayInsert (errListPtr, msg);
					zSpy_Info (msg);
				};
			};
		};

		i += 1;
	end;

	MEM_StringArrayFree (errListPtr);
	MEM_ArrayFree (vobListPtr);

	if (issueCounter == 0) {
		zSpy_Info (" - no issues detected.");
	};

	zSpy_Info ("zCTrigger_CheckProperties <--");
};

func string ObjectRoutine_GetString (var int ptr) {
	if (!ptr) { return STR_EMPTY; };

	var TObjectRoutine oRtn; oRtn = _^ (ptr);

	var string s;

	s = oRtn.objName;
	s = ConcatStrings (s, STR_SPACE);
	s = ConcatStrings (s, STR_FormatLeadingZeros (oRtn.hour1, 2));
	s = ConcatStrings (s, STR_SPACE);
	s = ConcatStrings (s, STR_FormatLeadingZeros (oRtn.min1, 2));
	s = ConcatStrings (s, " s");
	s = ConcatStrings (s, IntToString (oRtn.stateNum));
	s = ConcatStrings (s, " t");
	s = ConcatStrings (s, IntToString (oRtn.type));

	return s;
};

func void Game_CheckObjectRoutines () {
	var string msg;

	zSpy_Info ("Game_CheckObjectRoutines -->");

	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();
	if (!SearchVobsByClass ("oCMobInter", vobListPtr)) {
		zSpy_Info (" - no oCMobInter objects found.");
		MEM_ArrayFree (vobListPtr);
		return;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	//List of already listed issues err msgs (to prevent duplicates)
	var int errListPtr; errListPtr = MEM_ArrayCreate ();

	//List of all checked visuals
	var int visListPtr; visListPtr = MEM_ArrayCreate ();

	//List of all Wld_SetMobRoutine routines
	var int mobRoutineSchemeDuplicatesPtr; mobRoutineSchemeDuplicatesPtr = MEM_ArrayCreate ();

	var int i;
	var int j;

	var int ptr;
	var zCListSort l;
	var TObjectRoutine oRtn;
	var oCMobInter mobInter;

	//zSpy_Info ("list all routines --> ");

	//First get list of all scheme names updated by `Wld_SetMobRoutine` (type = 0)
	ptr = MEM_Game.objRoutineList_next;
	while (ptr);
		l = _^ (ptr);

		if (l.data) {
			oRtn = _^ (l.data);

			/*
			Only for testing
			msg = ObjectRoutine_GetString (l.data);
			zSpy_Info (msg);
			*/

			//type 0 - all objects with **sceme** will be triggered
			//type 1 - single object will be triggerer
			if (oRtn.type == 0) {

				//Identify duplicate entries
				msg = ObjectRoutine_GetString (l.data);

				if (!MEM_StringArrayContains (mobRoutineSchemeDuplicatesPtr, oRtn.objName)) {
					//Insert scheme name to array
					MEM_StringArrayInsert (mobRoutineSchemeDuplicatesPtr, msg);
				} else {
					msg = ConcatStrings (" - several Wld_SetMobRoutine routines: ", msg);

					if (!MEM_StringArrayContains (errListPtr, msg)) {
						//Insert err msg to array
						MEM_StringArrayInsert (errListPtr, msg);
						zSpy_Info (msg);
					};
				};
			};
		};

		ptr = l.next;
	end;

	//zSpy_Info ("<-- list all routines");

	ptr = MEM_Game.objRoutineList_next;
	while (ptr);
		l = _^ (ptr);

		if (l.data) {
			oRtn = _^ (l.data);

			//type 0 - all objects with **sceme** will be triggered
			//type 1 - single object will be triggerer
			if (oRtn.type == 0) {
				var int flagMobFound; flagMobFound = FALSE;

				i = 0;
				while (i < vobList.numInArray);
					vobPtr = MEM_ArrayRead (vobListPtr, i);

					if (vobPtr) {
						mobInter = _^ (vobPtr);

						if (Hlp_StrCmp (mobInter.sceme, oRtn.objName)) {
							flagMobFound = TRUE;
							break;
						};
					};

					i += 1;
				end;

				if (!flagMobFound) {
					//Build string backwards
					msg = ObjectRoutine_GetString (l.data);
					msg = ConcatStrings (" --> Wld_SetMobRoutine is using sceme name to trigger objects. ", msg);
					msg = ConcatStrings (" - no oCMobInter found with sceme name: ", msg);

					if (!MEM_StringArrayContains (errListPtr, msg)) {
						//Insert err msg to array
						MEM_StringArrayInsert (errListPtr, msg);
						zSpy_Info (msg);
					};
				};
			} else
			if (oRtn.type == 1) {

				var int arr; arr = MEM_SearchAllVobsByName (oRtn.objName);
				var zCArray zarr; zarr = _^ (arr);

				if (zarr.numInArray == 0) {
					//Build string backwards
					msg = ObjectRoutine_GetString (l.data);
					msg = ConcatStrings (" - object not found: ", msg);

					if (!MEM_StringArrayContains (errListPtr, msg)) {
						//Insert err msg to array
						MEM_StringArrayInsert (errListPtr, msg);
						zSpy_Info (msg);
					};
				} else {
					//Get first vobPtr
					vobPtr = MEM_ArrayRead (arr, 0);

					if (zarr.numInArray > 1) {
						//Build string backwards
						msg = ObjectRoutine_GetString (l.data);
						msg = ConcatStrings (" --> Wld_SetObjectRoutine updates 1 object, you might have to rename duplicates. ", msg);
						msg = ConcatStrings (") ", msg);
						msg = ConcatStrings (IntToString (zarr.numInArray), msg);
						msg = ConcatStrings (" - multiple objects found (", msg);

						if (!MEM_StringArrayContains (errListPtr, msg)) {
							//Insert err msg to array
							MEM_StringArrayInsert (errListPtr, msg);
							zSpy_Info (msg);

							//List object details
							j = 0;
							while (j < zarr.numInArray);
								vobPtr = MEM_ArrayRead (arr, j);
								msg = ConcatStrings ("   - ", Vob_GetPortalNameAndPosition (vobPtr));
								zSpy_Info (msg);
								j += 1;
							end;
						};
					};

					//Check all oCMobInter objects - all objects with same visual should have object routines (maybe?!)
					var string visualName; visualName = Vob_GetVisualName (vobPtr);

					//If this is new visual ...
					if (!MEM_StringArrayContains (visListPtr, visualName))
					{
						//Insert visual to array
						MEM_StringArrayInsert (visListPtr, visualName);

						i = 0;
						while (i < vobList.numInArray);
							vobPtr = MEM_ArrayRead (vobListPtr, i);

							if (vobPtr) {
								if (Hlp_StrCmp (visualName, Vob_GetVisualName (vobPtr))) {

									var zCVob vob; vob = _^ (vobPtr);

									var int flagObjRtnFound; flagObjRtnFound = FALSE;

									//Loop again through all object routines (uh oh, how performance heavy will this be?)
									var int ptr2; ptr2 = MEM_Game.objRoutineList_next;
									while (ptr2);
										var zCListSort l2; l2 = _^ (ptr2);

										if (l2.data) {
											var TObjectRoutine oRtn2;
											oRtn2 = _^ (l2.data);

											if (Hlp_StrCmp (vob._zCObject_objectName, oRtn2.objName)) {
												flagObjRtnFound = TRUE;
												break;
											};
										};

										ptr2 = l2.next;
									end;

									if (!flagObjRtnFound) {
										//Report potential problem
										msg = ConcatStrings (" - (warning - potential issue) object does not have object routine: ", vob._zCObject_objectName);
										msg = ConcatStrings (msg, " --> objects with same visual have object routines setup");
										msg = ConcatStrings (msg, Vob_GetPortalNameAndPosition (vobPtr));

										if (!MEM_StringArrayContains (errListPtr, msg)) {
											//Insert err msg to array
											MEM_StringArrayInsert (errListPtr, msg);
											zSpy_Info (msg);
										};
									};
								};
							};

							i += 1;
						end;
					};
				};

				MEM_ArrayFree (arr);
			};
		};

		ptr = l.next;
	end;

	MEM_StringArrayFree (mobRoutineSchemeDuplicatesPtr);
	MEM_StringArrayFree (visListPtr);
	MEM_StringArrayFree (errListPtr);
	MEM_ArrayFree (vobListPtr);

	zSpy_Info ("Game_CheckObjectRoutines <--");
};

/*
 *	zCWaynet_CheckRoutes
 *	 - all waypoints in the world should be connected via waynet
 *	 - this function loops through all of them - and checks whether there is route available from one to another
 */
func void zCWaynet_CheckRoutes () {
	var string msg;

	zSpy_Info ("zCWaynet_CheckRoutes -->");

	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	zSpy_Info (msg);

	var int susWaypoints; susWaypoints = 0;
	var int issueCounter; issueCounter = 0;
	var int susWaypointsListPtr; susWaypointsListPtr = MEM_ArrayCreate ();

	//zCListSort
	var int ptr; ptr = MEM_WayNet.wplist_next;
	var int ptr2; ptr2 = MEM_WayNet.wplist_next;

	var zCListSort list;
	var zCListSort list2;

	var zCWaypoint wp1;
	var zCWaypoint wp2;
	var zCWaypoint wp3;

	var int routePtr;

	while (ptr);
		list = _^ (ptr);

		if (list.data) {
			wp1 = _^ (list.data);

			while (ptr2);
				list2 = _^ (ptr2);

				if (list2.data) {
					wp2 = _^ (list2.data);

					routePtr = zCWayNet_FindRoute_Waypoints (_@ (wp1), _@ (wp2), 0);

					if (!routePtr) {
						//Insert 'orphan' waypoints to array
						if (!MEM_StringArrayContains (susWaypointsListPtr, wp1.Name)) {
							susWaypoints += 1;
							MEM_StringArrayInsert (susWaypointsListPtr, wp1.Name);
						};

						//Insert 'orphan' waypoints to array
						if (!MEM_StringArrayContains (susWaypointsListPtr, wp2.Name)) {
							susWaypoints += 1;
							MEM_StringArrayInsert (susWaypointsListPtr, wp2.Name);
						};
					};

					zCRoute_Delete (routePtr);
				};

				ptr2 = list2.next;
			end;
		};

		ptr = list.next;
	end;

	zCRoute_Delete (routePtr);

	var int wpNamePtr;
	var string wpName;

	var int wpPtr;
	var int wpPtr2;

	var int i;
	var int j;
	var int k;

	var int wayPtr;

	if (susWaypoints) {
		//identify closed waypoint loops
		var zCArray wpList; wpList = _^ (susWaypointsListPtr);

		var zCArray closedLoopList;

		i = 0;

		while (i < wpList.numInArray);
			var int closedLoop;
			var int closedLoopWaypointsListPtr;

			closedLoop = FALSE;
			closedLoopWaypointsListPtr = MEM_ArrayCreate ();

			wpNamePtr = MEM_ArrayRead (susWaypointsListPtr, i);
			if (wpNamePtr) {
				wpName = MEM_ReadString (wpNamePtr);
				wpPtr = SearchWaypointByName (wpName);

				if (wpPtr) {
					closedLoopList = _^ (closedLoopWaypointsListPtr);

					k = -1;
					while (k < closedLoopList.numInArray);

						j = 0;

						while (j < wpList.numInArray);
							if (j != i) {
								wpNamePtr = MEM_ArrayRead (susWaypointsListPtr, j);

								if (wpNamePtr) {
									wpName = MEM_ReadString (wpNamePtr);
									wpPtr2 = SearchWaypointByName (wpName);

									if (wpPtr2) {
										wayPtr = zCWaypoint_HasWay (wpPtr, wpPtr2);

										if (wayPtr) {
											if (k == -1) {
												wp1 = _^ (wpPtr);
												if (!MEM_StringArrayContains (closedLoopWaypointsListPtr, wp1.Name)) {
													MEM_StringArrayInsert (closedLoopWaypointsListPtr, wp1.Name);
												};
											};

											wp2 = _^ (wpPtr2);

											if (!MEM_StringArrayContains (closedLoopWaypointsListPtr, wp2.Name)) {
												MEM_StringArrayInsert (closedLoopWaypointsListPtr, wp2.Name);
											};

											MEM_StringArrayRemoveIndex (susWaypointsListPtr, j);
											j -= 1;

											closedLoop = TRUE;
										};
									};
								};
							};

							j += 1;
						end;

						k += 1;

						if (closedLoop) {
							if (k < closedLoopList.numInArray) {
								wpNamePtr = MEM_ArrayRead (closedLoopWaypointsListPtr, k);
								if (wpNamePtr) {
									wpName = MEM_ReadString (wpNamePtr);
									wpPtr = SearchWaypointByName (wpName);
								};
							};
						};
					end;
				};
			};

			if (closedLoop) {
				msg = " - closed waypoint loop found: ";

				j = 0;
				while (j < closedLoopList.numInArray);
					wpNamePtr = MEM_ArrayRead (closedLoopWaypointsListPtr, j);

					if (wpNamePtr) {
						wpName = MEM_ReadString (wpNamePtr);

						if (j > 0) {
							msg = ConcatStrings (msg, ", ");
						};

						msg = ConcatStrings (msg, wpName);
					};

					j += 1;
				end;

				zSpy_Info (msg);
				issueCounter += 1;

				//restart loop completely (we were removing indexes left and right ...)
				i = 0;
			};

			MEM_StringArrayFree (closedLoopWaypointsListPtr);

			i += 1;
		end;

		//identify orphan waypoints
		wpList = _^ (susWaypointsListPtr);

		i = 0;
		while (i < wpList.numInArray);
			wpNamePtr = MEM_ArrayRead (susWaypointsListPtr, i);

			if (wpNamePtr) {
				wpName = MEM_ReadString (wpNamePtr);
				wpPtr = SearchWaypointByName (wpName);

				//Double check if orphaned (we might have false positives from closed loop identification)
				var int orphaned; orphaned = TRUE;

				ptr = MEM_WayNet.wplist_next;
				while (ptr);
					list = _^ (ptr);

					if (list.data) {
						wpPtr2 = list.data;

						if (zCWaypoint_HasWay (wpPtr, wpPtr2)) {
							orphaned = FALSE;
							break;
						};
					};

					ptr = list.next;
				end;

				if (orphaned) {
					msg = ConcatStrings (" - orphan waypoint found: ", wpName);
					zSpy_Info (msg);

					issueCounter += 1;
				};

			};

			i += 1;
		end;
	};

	if (!issueCounter) {
		zSpy_Info (" - no problematic waypoints found.");
	};

	MEM_StringArrayFree (susWaypointsListPtr);

	zSpy_Info ("zCWaynet_CheckRoutes <--");
};

func void Vobs_CheckProperties () {
	Game_CheckObjectRoutines ();
	oCMob_CheckProperties ();
	zCTrigger_CheckProperties ();
	zCWaynet_CheckRoutes ();
};
