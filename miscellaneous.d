/*
 *	Miscellaneous functions
 *	 - these functions are very useful, but I felt they should not be in same files as other more 'generic' functions.
 */

/*
 *	Function traverses through all oCMobInter objects and updates onStateFunc, conditionFunc and useWithItem for all objects, which do have specified visual name.
 *	Usage:
 *
 *	oCMobInter_SetupAllMobsByVisual ("ORE_GROUND.ASC", "MINING", "", "ITMWPICKAXE");
 */
func void oCMobInter_SetupAllMobsByVisual (var string searchVisual, var string onStateFunc, var string conditionFunc, var string useWithItem) {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	if (!SearchVobsByClass ("oCMobInter", vobListPtr)) {
		MEM_Info ("oCMobInter_SetupAllMobsByVisual: No oCMobInter objects found.");
		MEM_ArrayFree (vobListPtr);
		return;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	var string mobVisualName;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		//Get visual name
		mobVisualName = Vob_GetVisualName (vobPtr);

		if (Hlp_StrCmp (mobVisualName, searchVisual)) {
			oCMobInter_SetOnStateFuncName (vobPtr, onStateFunc);
			oCMobInter_SetConditionFunc (vobPtr, conditionFunc);
			oCMobInter_SetUseWithItem (vobPtr, useWithItem);
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);
};

/*
 *	oCMobContainer_SearchByPortalRoom
 *	 - function returns first pointer to chest with searchVisual located in portal room searchPortalRoom
 */
func int oCMobContainer_SearchByPortalRoom (var string searchVisual, var string searchPortalRoom) {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	if (!SearchVobsByClass ("oCMobContainer", vobListPtr)) {
		MEM_Info ("oCMobContainer_SearchByPortalRoom: No oCMobContainer objects found.");
		MEM_ArrayFree (vobListPtr);
		return 0;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	var string mobVisualName;
	var string mobPortalRoom;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		//Get visual name
		mobVisualName = Vob_GetVisualName (vobPtr);

		if (Hlp_StrCmp (mobVisualName, searchVisual)) {
			mobPortalRoom = Vob_GetPortalName (vobPtr);

			if (Hlp_StrCmp (mobPortalRoom, searchPortalRoom)) {
				MEM_ArrayFree (vobListPtr);
				return vobPtr;
			};
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);
	return 0;
};

func void test_G2A_InsertItemsToChestsInOldCampCastle () {
	var int chestPtr;

	chestPtr = oCMobContainer_SearchByPortalRoom ("CHESTBIG_OCCHESTLARGELOCKED.MDS", "KI1");

	if (chestPtr) {
		FillMobContainer (chestPtr, "ItMi_Nugget:10");
	};

	chestPtr = oCMobContainer_SearchByPortalRoom ("CHESTBIG_OCCHESTLARGE.MDS", "KI3");

	if (chestPtr) {
		FillMobContainer (chestPtr, "ItMi_Nugget:12");
	};
};

/*
 *
 *	Vob list functions
 *
 */

//zCArray *
func int Npc_CollectVobsInRange (var int slfInstance, var int range) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) {
		return 0;
	};

	//Get Npc position
	var int fromPos[3];
	if (!zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos))) {
		return 0;
	};

	//Collect all vobs in range
	var int arrPtr; arrPtr = Wld_CollectVobsInRange (_@ (fromPos), mkf (range));

	return + arrPtr;
};

/*
 *	Npc_DetectMobByScemeName
 *	 - function returns pointer to *nearest* available mob with specified scemeName with specified state within specified verticalLimit
 */
func int Npc_DetectMobByScemeName (var int slfInstance, var int range, var string scemeNames, var int state, var int availabilityCheck, var int searchFlags, var int distLimit, var int verticalLimit) {
	var int dist;
	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int maxDist; maxDist = mkf (999999);

	//Get Npc
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) {
		return 0;
	};

	//Collect vobs in range
	var int arrPtr; arrPtr = Npc_CollectVobsInRange (slf, range);
	if (!arrPtr) {
		return 0;
	};

	//Get Npc position
	var int fromPos[3];
	var int retVal; retVal = zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos));

	//Target position
	var int toPos[3];
	var int routePtr;

	var string scemeName;
	var int scemeNameCount; scemeNameCount = STR_SplitCount (scemeNames, "|");

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray); var int i;
		var int vobPtr; vobPtr = MEM_ReadIntArray (vobList.array, i);

		if (availabilityCheck) {
			if (!oCMobInter_IsAvailable (vobPtr, slf)) {
				continue;
			};
		} else {
			if (!Hlp_Is_oCMobInter (vobPtr)) {
				continue;
			};
		};

		if (searchFlags & SEARCHVOBLIST_CANSEE) {
			//if (!oCNpc_CanSee (slfInstance, vobPtr, 1)) {
			if (!oCNpc_FreeLineOfSight (slfInstance, vobPtr)) {
				continue;
			};
		};

		//Check for portal room owner
		if (searchFlags & SEARCHVOBLIST_CHECKPORTALROOMOWNER) {
			var string portalName; portalName = Vob_GetPortalName (vobPtr);

			//If portal room is owned by Npc
			if (Wld_PortalGetOwnerInstanceID (portalName) > -1) {
				//If this portal is not owned by me - ignore - pretend we don't see it :)
				if (!Wld_PortalIsOwnedByNPC (portalName, slf)) {
					continue;
				};
			};
		};

		if ((abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalLimit) || (verticalLimit == -1)) {

			repeat (j, scemeNameCount); var int j;
				scemeName = STR_Split (scemeNames, "|", j);

				if (STR_StartsWith (oCMobInter_GetScemeName (vobPtr), scemeName)) {
					var oCMobInter mob; mob = _^ (vobPtr);
					if ((mob.state == state) || (state == -1)) {
						//Find route from Npc to vob - get total distance if Npc travels by waynet
						if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
							retVal = zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos));

							routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
							dist = zCRoute_GetLength (routePtr); //float
							zCRoute_Delete (routePtr);

							dist = RoundF (dist);
						} else {
							dist = Npc_GetDistToVobPtr (slfInstance, vobPtr); //int
						};

						if ((dist <= distLimit) || (distLimit == -1)) {
							if (!firstPtr) { firstPtr = vobPtr; };

							if (dist < maxDist) {
								nearestPtr = vobPtr;
								maxDist = dist;
							};
						};
					};
				};
			end;
		};
	end;

	//Free array
	MEM_Free (arrPtr);

	if (nearestPtr) {
		return nearestPtr;
	};

	return firstPtr;
};

/*
 *	Npc_DetectVobByVisual
 *	 - function returns pointer to *nearest* vob with specified searchVisualName within specified verticalLimit
 */
func int Npc_DetectVobByVisual (var int slfInstance, var int range, var string searchVisualName, var int searchFlags, var int distLimit, var int verticalLimit) {
	var int dist;
	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int maxDist; maxDist = mkf (999999);

	var string visualName;

	//Get Npc
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) {
		return 0;
	};

	//Collect vobs in range
	var int arrPtr; arrPtr = Npc_CollectVobsInRange (slf, range);
	if (!arrPtr) {
		return 0;
	};

	//Get Npc position
	var int fromPos[3];
	var int retVal; retVal = zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos));

	//Target position
	var int toPos[3];
	var int routePtr;

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray); var int i;
		var int vobPtr; vobPtr = MEM_ReadIntArray (vobList.array, i);

		if (searchFlags & SEARCHVOBLIST_CANSEE) {
			//if (!oCNPC_CanSee (slfInstance, vobPtr, 1)) {
			if (!oCNpc_FreeLineOfSight (slfInstance, vobPtr)) {
				continue;
			};
		};

		//Check for portal room owner
		if (searchFlags & SEARCHVOBLIST_CHECKPORTALROOMOWNER) {
			var string portalName; portalName = Vob_GetPortalName (vobPtr);

			//If portal room is owned by Npc
			if (Wld_PortalGetOwnerInstanceID (portalName) > -1) {
				//If this portal is not owned by me - ignore - pretend we don't see it :)
				if (!Wld_PortalIsOwnedByNPC (portalName, slf)) {
					continue;
				};
			};
		};

		if ((abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalLimit) || (verticalLimit == -1)) {
			visualName = Vob_GetVisualName (vobPtr);

			if (Hlp_StrCmp (visualName, searchVisualName)) {
				//Find route from Npc to vob - get total distance if Npc travels by waynet
				if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
					retVal = zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos));

					routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
					dist = zCRoute_GetLength (routePtr); //float
					zCRoute_Delete (routePtr);

					dist = RoundF (dist);
				} else {
					dist = NPC_GetDistToVobPtr (slfInstance, vobPtr); //int
				};

				if ((dist <= distLimit) || (distLimit == -1)) {
					if (!firstPtr) { firstPtr = vobPtr; };

					if (dist < maxDist) {
						nearestPtr = vobPtr;
						maxDist = dist;
					};
				};
			};
		};
	end;

	//Free array
	MEM_Free (arrPtr);

	if (nearestPtr) {
		return nearestPtr;
	};

	return firstPtr;
};

/*
 *	Npc_DetectItem
 *	 - function returns pointer to *nearest* item with specified mainflag and flags within specified verticalLimit
 *	 - vob list has to be generated prior calling this function (oCNpc_ClearVobList (self); oCNpc_CreateVobList (self, rangeF);)
 */
func int Npc_DetectItem (var int slfInstance, var int range, var int mainflag, var int excludeMainFlag, var int flags, var int excludeFlags, var int searchFlags, var int distLimit, var int verticalLimit) {
	var int dist;
	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int maxDist; maxDist = mkf (999999);

	var oCItem itm;

	//Get Npc
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) {
		return 0;
	};

	//Collect vobs in range
	var int arrPtr; arrPtr = Npc_CollectVobsInRange (slf, range);
	if (!arrPtr) {
		return 0;
	};

	//Get Npc position
	var int fromPos[3];
	var int retVal; retVal = zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos));

	//Target position
	var int toPos[3];
	var int routePtr;

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray); var int i;
		var int vobPtr; vobPtr = MEM_ReadIntArray (vobList.array, i);

		if (!Hlp_Is_oCItem (vobPtr)) {
			continue;
		};

		if (searchFlags & SEARCHVOBLIST_CANSEE) {
			//if (!oCNPC_CanSee (slfInstance, vobPtr, 1)) {
			if (!oCNpc_FreeLineOfSight (slfInstance, vobPtr)) {
				continue;
			};
		};

		//Check for portal room owner
		if (searchFlags & SEARCHVOBLIST_CHECKPORTALROOMOWNER) {
			var string portalName; portalName = Vob_GetPortalName (vobPtr);

			//If portal room is owned by Npc
			if (Wld_PortalGetOwnerInstanceID (portalName) > -1) {
				//If this portal is not owned by me - ignore - pretend we don't see it :)
				if (!Wld_PortalIsOwnedByNPC (portalName, slf)) {
					continue;
				};
			};
		};

		if ((abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalLimit) || (verticalLimit == -1)) {
			itm = _^ (vobPtr);
			if (Hlp_IsValidItem (itm)) {
				if (((!mainflag) || (itm.mainflag == mainflag))
				&& ((!excludeMainFlag) || (itm.mainflag != excludeMainFlag)))
				{
					if (((!flags) || (itm.flags & flags))
					&& ((!excludeFlags) || (!(itm.flags & excludeFlags))))
					{
						//Find route from Npc to vob - get total distance if Npc travels by waynet
						if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
							retVal = zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos));

							routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
							dist = zCRoute_GetLength (routePtr); //float
							zCRoute_Delete (routePtr);

							dist = RoundF (dist);
						} else {
							dist = NPC_GetDistToVobPtr (slfInstance, vobPtr); //int
						};

						if ((dist <= distLimit) || (distLimit == -1)) {
							if (!firstPtr) { firstPtr = vobPtr; };

							if (dist < maxDist) {
								nearestPtr = vobPtr;
								maxDist = dist;
							};
						};
					};
				};
			};
		};
	end;

	//Free array
	MEM_Free (arrPtr);

	if (nearestPtr) {
		return nearestPtr;
	};

	return firstPtr;
};

func int Npc_DetectNpc (var int slfInstance, var int range, var string stateName, var int searchFlags, var int distLimit, var int verticalLimit) {
	var int dist;
	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int maxDist; maxDist = mkf (999999);

	var oCNPC npc;

	//Get Npc
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) {
		return 0;
	};

	var int slfPtr; slfPtr = _@ (slf);

	//Collect vobs in range
	var int arrPtr; arrPtr = Npc_CollectVobsInRange (slf, range);
	if (!arrPtr) {
		return 0;
	};

	//Get Npc position
	var int fromPos[3];
	var int retVal; retVal = zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos));

	//Target position
	var int toPos[3];
	var int routePtr;

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray); var int i;
		var int vobPtr; vobPtr = MEM_ReadIntArray (vobList.array, i);

		//Ignore self
		if (vobPtr == slfPtr) {
			continue;
		};

		if (!Hlp_Is_oCNpc (vobPtr)) {
			continue;
		};

		if (searchFlags & SEARCHVOBLIST_CANSEE) {
			//if (!oCNPC_CanSee (slfInstance, vobPtr, 1)) {
			if (!oCNpc_FreeLineOfSight (slfInstance, vobPtr)) {
				continue;
			};
		};

		//Check for portal room owner
		if (searchFlags & SEARCHVOBLIST_CHECKPORTALROOMOWNER) {
			var string portalName; portalName = Vob_GetPortalName (vobPtr);

			//If portal room is owned by Npc
			if (Wld_PortalGetOwnerInstanceID (portalName) > -1) {
				//If this portal is not owned by me - ignore - pretend we don't see it :)
				if (!Wld_PortalIsOwnedByNPC (portalName, slf)) {
					continue;
				};
			};
		};

		if ((abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalLimit) || (verticalLimit == -1)) {
			npc = _^ (vobPtr);

			if (Npc_IsInStateName (npc, stateName)) {
				//Find route from Npc to vob - get total distance if Npc travels by waynet
				if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
					retVal = zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos));

					routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
					dist = zCRoute_GetLength (routePtr); //float
					zCRoute_Delete (routePtr);

					dist = RoundF (dist);
				} else {
					dist = NPC_GetDistToVobPtr (slfInstance, vobPtr); //int
				};

				if ((dist <= distLimit) || (distLimit == -1)) {
					if (!firstPtr) { firstPtr = vobPtr; };

					if (dist < maxDist) {
						nearestPtr = vobPtr;
						maxDist = dist;
					};
				};
			};
		};
	end;

	//Free array
	MEM_Free (arrPtr);

	if (nearestPtr) {
		return nearestPtr;
	};

	return firstPtr;
};

func int Npc_DetectVobByName (var int slfInstance, var int range, var string objectName, var int searchFlags, var int distLimit, var int verticalLimit) {
	var int dist;
	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int maxDist; maxDist = mkf (999999);

	objectName = STR_Upper (objectName);

	//Get Npc
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) {
		return 0;
	};

	//Collect vobs in range
	var int arrPtr; arrPtr = Npc_CollectVobsInRange (slf, range);
	if (!arrPtr) {
		return 0;
	};

	//Get Npc position
	var int fromPos[3];
	var int retVal; retVal = zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos));

	//Target position
	var int toPos[3];
	var int routePtr;

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray); var int i;
		var int vobPtr; vobPtr = MEM_ReadIntArray (vobList.array, i);

		if (!vobPtr) {
			continue;
		};

		if (searchFlags & SEARCHVOBLIST_CANSEE) {
			//if (!oCNPC_CanSee (slfInstance, vobPtr, 1)) {
			if (!oCNpc_FreeLineOfSight (slfInstance, vobPtr)) {
				continue;
			};
		};

		//Check for portal room owner
		if (searchFlags & SEARCHVOBLIST_CHECKPORTALROOMOWNER) {
			var string portalName; portalName = Vob_GetPortalName (vobPtr);

			//If portal room is owned by Npc
			if (Wld_PortalGetOwnerInstanceID (portalName) > -1) {
				//If this portal is not owned by me - ignore - pretend we don't see it :)
				if (!Wld_PortalIsOwnedByNPC (portalName, slf)) {
					continue;
				};
			};
		};

		if ((abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalLimit) || (verticalLimit == -1)) {
			var zCVob vob; vob = _^ (vobPtr);

			if (Hlp_StrCmp (STR_Upper (vob._zCObject_objectName), objectName)) {
				//Find route from Npc to vob - get total distance if Npc travels by waynet
				if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
					retVal = zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos));

					routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
					dist = zCRoute_GetLength (routePtr); //float
					zCRoute_Delete (routePtr);

					dist = RoundF (dist);
				} else {
					dist = NPC_GetDistToVobPtr (slfInstance, vobPtr); //int
				};

				if ((dist <= distLimit) || (distLimit == -1)) {
					if (!firstPtr) { firstPtr = vobPtr; };

					if (dist < maxDist) {
						nearestPtr = vobPtr;
						maxDist = dist;
					};
				};
			};
		};
	end;

	//Free array
	MEM_Free (arrPtr);

	if (nearestPtr) {
		return nearestPtr;
	};

	return firstPtr;
};

func void NPC_VobListRemoveDeadNpcs (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int vobPtr;
	var int i; i = slf.vobList_numInArray;

	while (i > 0);
		vobPtr = MEM_ReadIntArray (slf.vobList_array, i);

		if (Hlp_Is_oCNpc (vobPtr)) {
			var oCNPC npc; npc = _^ (vobPtr);

			if (Npc_IsDead (npc)) {
				oCNpc_RemoveFromVobList (slfInstance, vobPtr);
			};
		};

		i -= 1;
	end;
};

/*
 *	zCVob_GetNearest_AtPos
 *	 - function returns first pointer to object closest to fromPosPtr
 */
func int zCVob_GetNearest_AtPos (var string className, var int fromPosPtr) {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	if (!SearchVobsByClass (className, vobListPtr)) {
		var string msg;
		msg = ConcatStrings ("zCVob_GetNearest_AtPos: No ", className);
		msg = ConcatStrings (msg, " objects found.");
		MEM_Info (msg);
		MEM_ArrayFree (vobListPtr);
		return 0;
	};

	var int dist;
	var int maxDist; maxDist = mkf (999999);

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	var int dir[3];
	var int posPtr;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (vobPtr) {
			if (!firstPtr) { firstPtr = vobPtr; };

			posPtr = zCVob_GetPositionWorld (vobPtr);
			SubVectors (_@ (dir), fromPosPtr, posPtr);
			MEM_Free (posPtr);

			dist = zVEC3_LengthApprox (_@ (dir));

			if (lf (dist, maxDist)) {
				nearestPtr = vobPtr;
				maxDist = dist;
			};
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);

	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};

//--

func int GetSymbolIntValue (var int symbolIndex) {
	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (symbolIndex);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);

		if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INT)
		|| ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_FLOAT) {
			return symb.content;
		};
	};

	return 0;
};

func void SetSymbolIntValue (var int symbolIndex, var int value) {
	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (symbolIndex);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);

		if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INT)
		|| ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_FLOAT) {
			symb.content = value;
		};
	};
};

func string GetSymbolStringValue (var int symbolIndex) {
	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (symbolIndex);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);

		if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_STRING) {
			var string s; s = MEM_ReadString(symb.content);
			return s;
		};
	};

	return "";
};

func void SetSymbolStringValue (var int symbolIndex, var string s) {
	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (symbolIndex);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);

		if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_STRING) {
			MEM_WriteString(symb.content, s);
		};
	};
};

func string API_GetSymbolStringValue (var string symbolName, var string defaultValue) {
	var int symbID; symbID = MEM_GetSymbolIndex (symbolName);

	if (symbID == -1) {
		MEM_Info (ConcatStrings ("API_GetSymbolStringValue symbol not found: ", symbolName));
		return defaultValue;
	};

	var string s; s = GetSymbolStringValue (symbID);
	return s;
};

func int API_GetSymbolIntValue (var string symbolName, var int defaultValue) {
	var int symbID; symbID = MEM_GetSymbolIndex (symbolName);

	if (symbID == -1) {
		MEM_Info (ConcatStrings ("API_GetSymbolIntValue symbol not found: ", symbolName));
		return defaultValue;
	};

	return + GetSymbolIntValue (symbID);
};

/*
 *	 - wrapper function that converts value from hex to RGBA
 */
func int API_GetSymbolHEX2RGBAValue (var string symbolName, var string defaultValue) {
	var int symbID; symbID = MEM_GetSymbolIndex (symbolName);

	if (symbID == -1) {
		MEM_Info (ConcatStrings ("API_GetSymbolHEX2RGBAValue symbol not found: ", symbolName));
		return + HEX2RGBA (defaultValue);
	};

	var string s; s = GetSymbolStringValue (symbID);
	return + HEX2RGBA (s);
};

/*
 *	Basically copy of MEM_CallByString - without any error messaging
 */
func void API_CallByString (var string fnc) {
    var int symbID;
    const string cacheFunc = ""; const int cacheSymbID = 0;

    if (Hlp_StrCmp (cacheFunc, fnc)) {
        symbID = cacheSymbID;
    } else {
        symbID = MEM_FindParserSymbol (fnc);

        if (symbID == -1) {
           return;
        };

        cacheFunc = fnc; cacheSymbID = symbID;
    };

    MEM_CallByID (symbID);
};

//--

func string AlphaBlendFuncTypeToString (var int rndAlphaBlendFunc) {
	const int zRND_ALPHA_FUNC_MAT_DEFAULT = 0;
	const int zRND_ALPHA_FUNC_NONE        = 1;
	const int zRND_ALPHA_FUNC_BLEND       = 2;
	const int zRND_ALPHA_FUNC_ADD         = 3;
	const int zRND_ALPHA_FUNC_SUB         = 4;
	const int zRND_ALPHA_FUNC_MUL         = 5;
	const int zRND_ALPHA_FUNC_MUL2        = 6;
	const int zRND_ALPHA_FUNC_TEST        = 7;
	const int zRND_ALPHA_FUNC_BLEND_TEST  = 8;

	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_MAT_DEFAULT) { return "zRND_ALPHA_FUNC_MAT_DEFAULT"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_NONE) { return "zRND_ALPHA_FUNC_NONE"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_BLEND) { return "zRND_ALPHA_FUNC_BLEND"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_ADD) { return "zRND_ALPHA_FUNC_ADD"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_SUB) { return "zRND_ALPHA_FUNC_SUB"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_MUL) { return "zRND_ALPHA_FUNC_MUL"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_MUL2) { return "zRND_ALPHA_FUNC_MUL2"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_TEST) { return "zRND_ALPHA_FUNC_TEST"; };
	if (rndAlphaBlendFunc == zRND_ALPHA_FUNC_BLEND_TEST) { return "zRND_ALPHA_FUNC_BLEND_TEST"; };

	return "NONE";
};

func int zCRenderer_GetAlphaBlendFunc (var int ptr) {
	//0x00713A90 public: virtual enum zTRnd_AlphaBlendFunc __thiscall zCRenderer::GetAlphaBlendFunc(void)const
	const int zCRenderer__GetAlphaBlendFunc_G1 = 7420560;

	//0x0064A1E0 public: virtual enum zTRnd_AlphaBlendFunc __thiscall zCRenderer::GetAlphaBlendFunc(void)const
	const int zCRenderer__GetAlphaBlendFunc_G2 = 6595040;

	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall(_@(ptr), MEMINT_SwitchG1G2 (zCRenderer__GetAlphaBlendFunc_G1, zCRenderer__GetAlphaBlendFunc_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Pos_ToScreenXYF (float)
 *	 - converts 3D coordinates in the world to screen coordinates
 */
func void Pos_ToScreenXYF (var int posPtr, var int ptrXF, var int ptrYF) {

	var int activeCam; activeCam = zCCamera_Get_activeCam ();
	zCCamera_Activate (activeCam);

	zMAT4_Mul_zVEC3 (_@ (MEM_Camera.camMatrix), posPtr, posPtr);

	zCCamera_ProjectF (activeCam, posPtr, ptrXF, ptrYF);
};

func void Pos_ToScreenXY (var int posPtr, var int ptrX, var int ptrY) {

	var int activeCam; activeCam = zCCamera_Get_activeCam ();
	zCCamera_Activate (activeCam);

	zMAT4_Mul_zVEC3 (_@ (MEM_Camera.camMatrix), posPtr, posPtr);

	zCCamera_Project (activeCam, posPtr, ptrX, ptrY);
};

//--

/*
 *	Npc_SetAIStateToPos
 *	 - function sets aiStatePosition to specified position
 */
func void Npc_SetAIStateToPos (var int slfInstance, var int posPtr) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);

	var int statePtr; statePtr = NPC_GetNPCState (slf);
	if (!statePtr) { return; };
	var oCNPC_States state; state = _^ (statePtr);

	if (state.hasRoutine) { return; };

	//Update aiStateDriven - to kick in ai state
	state.aiStateDriven = 1;

	//Update ai position - to desired position
	MEM_CopyBytes (posPtr, _@ (slf.state_aiStatePosition[0]), 12);

	//Update also spawn node position
	var int spawnNodePtr; spawnNodePtr = oCSpawnManager_GetNodePtr (_@ (slf));

	if (spawnNodePtr) {
		var oSSpawnNode spawnNode; spawnNode = _^ (spawnNodePtr);
		MEM_CopyBytes (posPtr, _@ (spawnNode.spawnPos[0]), 12);
	};
};

/*
 *	Npc_GetCurrentWorldPos
 *	 - function gets current world position of an Npc (either from Routine manager or using spawnPoint in case of aiStateDriven logic)
 */
func void Npc_GetCurrentWorldPos (var int slfInstance, var int targetPosPtr) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Get NPC state
	var int statePtr; statePtr = NPC_GetNPCState (slf);
	if ((statePtr) && (!Npc_IsPlayer (slf))) {
		var oCNPC_States state; state = _^ (statePtr);

		//Get routine position
		if (state.hasRoutine) {
			var int posPtr; posPtr = oCRtnManager_GetRoutinePos (slf);
			MEM_CopyBytes (posPtr, targetPosPtr, 12);
			MEM_Free (posPtr);
		} else {
			//Get AI state position
			MEM_CopyBytes (_@ (slf.state_aiStatePosition), targetPosPtr, 12);
		};
	} else {
		//No state --> get current world pos
		if (zCVob_GetPositionWorldToPos (_@ (slf), targetPosPtr)) {
		};
	};
};

/*
 *	Wld_EnableNpc
 *	 - Enable Npc in the world on its current position
 */
func void Wld_EnableNpc (var int slfInstance) {
	var int pos[3];

	//Get target Npc current world position
	Npc_GetCurrentWorldPos (slfInstance, _@ (pos));

	//oCNpc::Enable @ position
	oCNpc_Enable (slfInstance, _@ (pos));

	//Hard-update position (I am also using this function to change spawnPoint mid-game, for such cases I need to 'physically' update also Npcs position)
	var zCVob vob; vob = Hlp_GetNPC (slfInstance);
	vob.trafoObjToWorld[3] = pos[0];
	vob.trafoObjToWorld[7] = pos[1];
	vob.trafoObjToWorld[11] = pos[2];

	zCVob_PositionUpdated (_@ (vob));
};

/*
 *	NPC_TeleportToNpc
 *	 - function teleports one Npc to another Npc
 */
func void NPC_TeleportToNpc (var int slfInstance, var int npcInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var oCNpc npc; npc = Hlp_GetNpc (npcInstance);
	if (!Hlp_IsValidNPC (npc)) { return; };

	var int pos[3];

	//Default position - current world position
	if (zCVob_GetPositionWorldToPos (_@ (slf), _@ (pos))) {
		//...
	};

	//Get target Npc current world position
	Npc_GetCurrentWorldPos (npc, _@ (pos));

	//Hard-update position
	var zCVob vob; vob = Hlp_GetNPC (slf);
	vob.trafoObjToWorld[3] = pos[0];
	vob.trafoObjToWorld[7] = pos[1];
	vob.trafoObjToWorld[11] = pos[2];

	zCVob_PositionUpdated (_@ (vob));

	//oCNpc::Enable @ position (if not player - this will clear AI queue)
	if (!Npc_IsPlayer (slf)) {
		oCNpc_Enable (slf, _@ (pos));
	};

	if (!Npc_IsPlayer (npc)) {
		oCNpc_Enable (npc, _@ (pos));
	};
};

/*
 *	Npc_EM_SendTozSpy
 *	 - list current events in AI queue to zSpy
 */
func void Npc_EM_SendTozSpy (var int slfInstance) {
	var int count; count = NPC_EM_GetEventCount (slfInstance);

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);

	var string s;

	s = ConcatStrings ("Npc_EM_SendTozSpy: ", GetSymbolName (Hlp_GetInstanceID (slf)));
	s = ConcatStrings (s, " -->");

	zSpy_Info (s);

	if (count) {
		var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

		repeat (i, count); var int i;
			var string eventName;
			eventName = NPC_EM_GetEventName (slfInstance, i);

			var int eMsg;
			eMsg = zCEventManager_GetEventMessage (eMgr, i);

			if (zCEventMessage_IsHighPriority (eMsg)) {
				eventName = ConcatStrings (eventName, " (high prio)");
			};

			if (zCEventMessage_IsOverlay (eMsg)) {
				eventName = ConcatStrings (eventName, " (overlay)");
			};

			if (zCEventMessage_IsDeleted (eMsg)) {
				eventName = ConcatStrings (eventName, " (deleted)");
			};

			if (zCEventManager_IsRunning (eMgr, eMsg)) {
				eventName = ConcatStrings (eventName, " (running)");
			};

			if ((slf.lastLookMsg == eMsg) && (eMsg)) {
				eventName = ConcatStrings (eventName, " (lastLookMsg)");
			};

			zSpy_Info (eventName);
		end;
	} else {
		zSpy_Info ("AI queue is empty.");
	};

	zSpy_Info ("<--");
};
