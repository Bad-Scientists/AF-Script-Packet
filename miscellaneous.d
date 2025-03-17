/*
 *	Miscellaneous functions
 *	 - these functions are very useful, but I felt they should not be in same files as other more 'generic' functions.
 */

/*
 *	Function traverses through all oCMobInter objects and updates onStateFunc, conditionFunc and useWithItem for all objects, which do have specified visual name.
 *	Usage:
 *
 *	oCMobInter_SetupAllMobsByVisual ("ORE_GROUND.ASC", "MINING", STR_EMPTY, "ITMWPICKAXE");
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

	var int count; count = vobList.numInArray;

	var string mobVisualName;

	repeat(i, count); var int i;
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		//Get visual name
		mobVisualName = Vob_GetVisualName (vobPtr);

		if (Hlp_StrCmp (mobVisualName, searchVisual)) {
			oCMobInter_SetOnStateFuncName (vobPtr, onStateFunc);
			oCMobInter_SetConditionFunc (vobPtr, conditionFunc);
			oCMobInter_SetUseWithItem (vobPtr, useWithItem);
		};
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

	var int count; count = vobList.numInArray;

	var string mobVisualName;
	var string mobPortalRoom;

	repeat(i, count); var int i;
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

//Additional filters
var string _searchFilter_Visuals;

func void Npc_DetectVobSetSearchByVisuals(var string visualNames) {
	_searchFilter_Visuals = visualNames;
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

	//Reset global visual filter
	var string visualNames; visualNames = _searchFilter_Visuals; _searchFilter_Visuals = STR_EMPTY;
	var int checkVisual; checkVisual = STR_Len(visualNames);

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
	var int scemeNameCount; scemeNameCount = STR_SplitCount (scemeNames, STR_PIPE);

	var string searchVisual;
	var string vobVisualName;
	var int visualNameCount; visualNameCount = STR_SplitCount (visualNames, STR_PIPE);

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);

	repeat(i, vobList.numInArray); var int i;
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

		if (Hlp_Is_oCMobLockable(vobPtr)) {
			var oCMobLockable mobLockable;
			if (searchFlags & SEARCHVOBLIST_ONLYLOCKED) {
				mobLockable = _^(vobPtr);
				if ((mobLockable.bitfield & oCMobLockable_bitfield_locked) != oCMobLockable_bitfield_locked) {
					continue;
				};
			};
			if (searchFlags & SEARCHVOBLIST_ONLYUNLOCKED) {
				mobLockable = _^(vobPtr);
				if ((mobLockable.bitfield & oCMobLockable_bitfield_locked) == oCMobLockable_bitfield_locked) {
					continue;
				};
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

			repeat(j, scemeNameCount); var int j;
				scemeName = STR_Split (scemeNames, STR_PIPE, j);

				if (STR_StartsWith (oCMobInter_GetScemeName (vobPtr), scemeName)) {
					if (checkVisual) {
						var int visualMatch; visualMatch = FALSE;

						repeat(k, visualNameCount); var int k;
							searchVisual = STR_Split(visualNames, STR_PIPE, k);
							vobVisualName = Vob_GetVisualName(vobPtr);

							if (Hlp_StrCmp(searchVisual, vobVisualName)) {
								visualMatch = TRUE;
								break;
							};
						end;

						if (!visualMatch) {
							break;
						};
					};

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
 *	 - function returns pointer to *nearest* vob with specified visualNames within specified verticalLimit
 */
func int Npc_DetectVobByVisual (var int slfInstance, var int range, var string visualNames, var int searchFlags, var int distLimit, var int verticalLimit) {
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

	var string searchVisual;
	var string vobVisualName;
	var int visualNameCount; visualNameCount = STR_SplitCount (visualNames, STR_PIPE);

	//Loop through list
	var zCArray vobList; vobList = _^ (arrPtr);

	repeat(i, vobList.numInArray); var int i;
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
			repeat(j, visualNameCount); var int j;
				searchVisual = STR_Split (visualNames, STR_PIPE, j);

				vobVisualName = Vob_GetVisualName (vobPtr);

				if (Hlp_StrCmp (searchVisual, vobVisualName)) {
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

	repeat(i, vobList.numInArray); var int i;
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

	repeat(i, vobList.numInArray); var int i;
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

	repeat(i, vobList.numInArray); var int i;
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

	var int count; count = vobList.numInArray;

	var int dir[3];
	var int posPtr;

	repeat(i, count); var int i;
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

	return STR_EMPTY;
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
	//This does not work - seems like we cannot use global constant when initializing local one?
	//const string cacheFunc = STR_EMPTY;
	const string cacheFunc = "";
	const int cacheSymbID = 0;

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
	var int pos[3]; MEM_CopyBytes(posPtr, _@(pos), 12);
	if (!pos[2]) { return; }; //Division by 0 safetycheck!

	var int activeCam; activeCam = zCCamera_Get_activeCam ();
	//zCCamera_Activate (activeCam);
	zMAT4_Mul_zVEC3 (_@ (MEM_Camera.camMatrix), posPtr, posPtr);
	zCCamera_ProjectF (activeCam, posPtr, ptrXF, ptrYF);
};

func void Pos_ToScreenXY (var int posPtr, var int ptrX, var int ptrY) {
	var int pos[3]; MEM_CopyBytes(posPtr, _@(pos), 12);
	if (!pos[2]) { return; }; //Division by 0 safetycheck!

	var int activeCam; activeCam = zCCamera_Get_activeCam ();
	//zCCamera_Activate (activeCam);
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

func void Npc_SetAIStateToCurrentPos (var int slfInstance) {
	var int pos[3];
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (zCVob_GetPositionWorldToPos (_@ (slf), _@ (pos[0]))) {
		Npc_SetAIStateToPos (slf, _@ (pos[0]));
	};
};

func void Npc_SetAIStatePosToVobName (var int slfInstance, var string vobName) {
	var int pos[3];

	//Is this waypoint?
	var int wpPtr; wpPtr = SearchWaypointByName (vobName);
	if (wpPtr) {
		var zCWaypoint wp; wp = _^ (wpPtr);
		MEM_CopyBytes (_@ (wp.pos[0]), _@ (pos[0]), 12);
	} else {
		//Is this vob?
		var int vobPtr; vobPtr = MEM_SearchVobByName (vobName);

		if (vobPtr) {
			if (zCVob_GetPositionWorldToPos (vobPtr, _@ (pos[0]))) {
			};
		};
	};

	Npc_SetAIStateToPos (slfInstance, _@ (pos[0]));
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
 *	Wld_DespawnNpc
 */
func void Wld_DespawnNpc(var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return; };

	zSpy_Info(ConcatStrings("Wld_DespawnNpc: despawning: ", GetSymbolName(Hlp_GetInstanceID(slf))));

	slf._zCVob_groundPoly = 0;

	var int slfPtr; slfPtr = _@(slf);

	//Remove as enemy... if any Npc has this npc as enemy then game would crash (there is no safety check in engine)
	repeat(i, MEM_World.activeVobList_numInArray); var int i;
		var int ptr; ptr = MEM_ReadIntArray(MEM_World.activeVobList_array, i);

		if (Hlp_Is_oCNpc (ptr)) {
			var oCNpc npc; npc = _^ (ptr);
			if (Hlp_IsValidNpc(npc)) {
				if (npc.enemy == slfPtr) {
					//Remove enemy
					oCNpc_SetEnemy(npc, 0);

					//Remove hitTarget
					if (npc.aniCtrl) {
						var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (npc.aniCtrl);
						aniCtrl.hitTarget = 0;
					};
				};
			};
		};
	end;

	//Stop all effects
	//var int retVal; retVal = Wld_StopEffect_Ext (STR_EMPTY, 0, slf, TRUE);

	//Remove horcruxes!
	var int vobListPtr; vobListPtr = MEM_ArrayCreate();

	if (SearchVobsByClass("zCVob", vobListPtr)) {
		var zCArray vobList; vobList = _^(vobListPtr);

		repeat(i, vobList.numInArray);
			var int vobPtr; vobPtr = MEM_ArrayRead(vobListPtr, i);

			if (vobPtr) {
				var zCVob vob; vob = _^(vobPtr);

				if (Hlp_Is_oCAIVobMove(vob.callback_ai)) {
					var oCAIVobMove ai; ai = _^(vob.callback_ai);

					if (ai.owner == slfPtr) {
						zCVob_SetAI(vobPtr, 0);
					};
				};
			};
		end;
	};

	MEM_ArrayFree(vobListPtr);

	//Remove routines
	oCRtnManager_RemoveRoutine(slfPtr);

	//Remove from players focus
	var oCNpc her; her = Hlp_GetNpc(hero);
	if (her.focus_vob == slfPtr) {
		oCNpc_SetFocusVob(her, 0);
	};

	//Remove focus_vob
	//oCNpc_SetFocusVob(slf, 0);

	//Clear voblist
	//oCNpc_ClearVobList(slf);

	//Remove enemy reference
	oCNpc_SetEnemy(slf, 0);

	//Clear event manager
	oCNpc_ClearEM(slf);

	//Disable npc (ClearVobList, AvoidShrink, Interrupt, ClearPerceptionLists(ClearFocusVob, ClearVobList), SetSleeping true, state.CloseCutscenes,
	oCNpc_Disable(slf);

	//Delete npc
	oCSpawnManager_DeleteNpc(slfPtr);
};

/*
 *	Wld_ClearNpcBeforeExport
 *	 - function removes redundant information from Npc before exporting to .ZEN file
 */
func void Wld_ClearNpcBeforeExport(var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return; };

	//Clear event manager
	//oCNpc_SetFocusVob(slf, 0);

	//Clear voblist
	//oCNpc_ClearVobList(slf);

	//Remove enemy reference
	oCNpc_SetEnemy(slf, 0);

	//Clear event manager
	oCNpc_ClearEM(slf);

	//Disable npc (ClearVobList, AvoidShrink, Interrupt, ClearPerceptionLists(ClearFocusVob, ClearVobList), SetSleeping true, state.CloseCutscenes,
	oCNpc_Disable(slf);
};

/*
 *	Wld_ExportVobPtr
 *	 - function exports vob to .ZEN file
 *	 - appendMode allows you to append objects into single file
 */
func void Wld_ExportVobPtr(var int vobPtr, var string fileName, var int appendMode) {
	if (!vobPtr) { return; };

	var int arrPtr; arrPtr = 0;

	zSpy_Info("Wld_ExportVobPtr");

	var int filePtr; filePtr = zFILE_FILE_GetByFilePath(fileName);
	if (zFILE_FILE_Exists(filePtr)) {
		//Load all objects
		if (appendMode) {
			//Open for reading
			if (zFILE_FILE_Open(filePtr, 0) != 0) {
				zSpy_Info("   fatal: file could not be open!");
				zSpy_Info(fileName);
				zFILE_FILE_Release(filePtr);
				return;
			};

			//Create array
			arrPtr = MEM_ArrayCreate();

			//Read objects and insert them into an array
			zSpy_Info("   reading array.");
			var int archR; archR = zCArchiverFactory_CreateArchiverRead(filePtr, zARC_MODE_ASCII);
			var int eoa; eoa = zCArchiverGeneric_EndOfArchive(archR);

			if (eoa) {
				zSpy_Info("   archive is empty.");
			} else {
				while(!eoa);
					var int vobPtrR; vobPtrR = zCArchiverGeneric_ReadObject(archR, 0);
					MEM_ArrayInsert(arrPtr, vobPtrR);
					eoa = zCArchiverGeneric_EndOfArchive(archR);
				end;
			};

			//Close archiver
			zCArchiverGeneric_Close(arch);
			if (zFILE_FILE_Close(filePtr) != 0) {
				zSpy_Info("   fatal: file couldn't be closed.");
				zSpy_Info(fileName);
				if (arrPtr) { MEM_ArrayFree(arrPtr); arrPtr = 0; };
				return;
			};
		};

		//Delete file
		if (zFILE_FILE_FileDelete(filePtr)) {
			zSpy_Info("   deleting file.");
			zSpy_Info(fileName);
		};
	};

	//Create new file
	if (zFILE_FILE_Create(filePtr) != 0) {
		zSpy_Info("   fatal: file couldn't be created.");
		zSpy_Info(fileName);
		zFILE_FILE_Release(filePtr);

		if (arrPtr) { MEM_ArrayFree(arrPtr); arrPtr = 0; };
		return;
	};

	//Create archiver for writing
	var int arch; arch = zCArchiverFactory_CreateArchiverWrite(filePtr, zARC_MODE_ASCII, 1, zARC_FLAG_WRITE_HEADER);

	zSpy_Info("   writing objects:");

	var int count; count = 0;

	//Write array first
	if (arrPtr) {
		var zCArray arr; arr = _^(arrPtr);

		repeat(i, arr.numInArray); var int i;
			vobPtrR = MEM_ArrayRead(arrPtr, i);
			zCArchiverGeneric_WriteObject(arch, vobPtrR);
			count += 1;
		end;

		MEM_ArrayFree(arrPtr); arrPtr = 0;
	};

	//Write new object
	zCArchiverGeneric_WriteObject(arch, vobPtr);
	zCArchiverGeneric_Close(arch);
	zFILE_FILE_Release(filePtr);

	count += 1;
	zSpy_Info(ConcatStrings("   ", IntToString(count)));

	zSpy_Info("   exported.");
	zSpy_Info(fileName);
};

/*
 *	Wld_ImportVobPtr
 *	 - function imports vobs from .ZEN file
 *	 - function creates array and returns in the array all loaded vobs
 */
func int Wld_ImportVobPtr(var string fileName) {
	zSpy_Info("Wld_ImportVobPtr");

	var int arrPtr; arrPtr = MEM_ArrayCreate();

	var int filePtr;

	if (Files_LookAtVDFS) {
		filePtr = zFILE_VDFS_GetByFilePath(fileName);
	} else {
		filePtr = zFILE_FILE_GetByFilePath(fileName);
	};

	var int fileExists;

	if (Files_LookAtVDFS) {
		fileExists = zFILE_VDFS_Exists(filePtr);
	} else {
		fileExists = zFILE_FILE_Exists(filePtr);
	};

	if (!fileExists) {
		zSpy_Info("   fatal: file does not exist!");
		zSpy_Info(fileName);

		if (Files_LookAtVDFS) {
			zFILE_VDFS_Release(filePtr);
		} else {
			zFILE_FILE_Release(filePtr);
		};

		if (arrPtr) { MEM_ArrayFree(arrPtr); arrPtr = 0; };
		return 0;
	};

	var int fileOpened;

	if (Files_LookAtVDFS) {
		//Read-only mode
		fileOpened = zFILE_VDFS_Open(filePtr, 0);
	} else {
		fileOpened = zFILE_FILE_Open(filePtr, 0);
	};

	//Non-zero is error
	if (fileOpened != 0) {
		zSpy_Info("   fatal: file could not be open!");
		zSpy_Info(fileName);

		if (Files_LookAtVDFS) {
			zFILE_VDFS_Release(filePtr);
		} else {
			zFILE_FILE_Release(filePtr);
		};

		if (arrPtr) { MEM_ArrayFree(arrPtr); arrPtr = 0; };
		return 0;
	};

	var int arch; arch = zCArchiverFactory_CreateArchiverRead(filePtr, zARC_MODE_ASCII);
	var int eoa; eoa = zCArchiverGeneric_EndOfArchive(arch);

	var int count; count = 0;

	if (eoa) {
		zSpy_Info("   archive is empty.");
	} else {
		zSpy_Info("   reading objects:");
		while(!eoa);
			var int vobPtr; vobPtr = zCArchiverGeneric_ReadObject(arch, 0);
			//First set world position otherwise zCVob::BeginMovement crashes when vob is added to the world
			var int retVal;
			var int pos[3];

			var int trafo[16];
			zCVob_GetTrafo(vobPtr, _@(trafo));
			zCVob_SetTrafo(vobPtr, _@(trafo));

			count += 1;
			zSpy_Info(ConcatStrings("   enabling vob: ", IntToString(count)));

			oCWorld_EnableVob(vobPtr, 0);
			MEM_ArrayInsert(arrPtr, vobPtr);

			eoa = zCArchiverGeneric_EndOfArchive(arch);
		end;

		zSpy_Info(ConcatStrings("   total: ", IntToString(count)));
	};

	zCArchiverGeneric_Close(arch);

	if (Files_LookAtVDFS) {
		zFILE_VDFS_Release(filePtr);
	} else {
		zFILE_FILE_Release(filePtr);
	};

	zSpy_Info("   done.");
	zSpy_Info(fileName);

	return + arrPtr;
};

/*
 *	Wld_ImportVobPtr_VDFS
 *	 - same as Wld_ImportVobPtr, but looks at VDF files
 */
func int Wld_ImportVobPtr_VDFS(var string fileName) {
	var int arrPtr;

	var int b; b = Files_LookAtVDFS;
	Files_LookAtVDFS = TRUE;
	arrPtr = Wld_ImportVobPtr(fileName);
	Files_LookAtVDFS = b;

	return + arrPtr;
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
