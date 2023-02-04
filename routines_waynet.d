/*
 *	Global variables
 */

var oCRtnManager MEM_RtnMan;

/*
 *	zCVobSpot / FreePoint engine functions
 */
func void zCVobSpot_MarkAsUsed (var int vobSpotPtr, var int timeDeltaF, var int vobPtr) {
	//0x007094A0 public: void __thiscall zCVobSpot::MarkAsUsed(float,class zCVob *)
	const int zCVobSpot__MarkAsUsed_G1 = 7378080;

	//0x007B31A0 public: void __thiscall zCVobSpot::MarkAsUsed(float,class zCVob *)
	const int zCVobSpot__MarkAsUsed_G2 = 8073632;

	if (!Hlp_Is_zCVobSpot (vobSpotPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_FloatParam (_@ (timeDeltaF));
		CALL__thiscall (_@ (vobSpotPtr), MEMINT_SwitchG1G2 (zCVobSpot__MarkAsUsed_G1, zCVobSpot__MarkAsUsed_G2));
		call = CALL_End();
	};
};

//Function updates availability if there is no vob on vobSpot (freepoint) --> this will proactively clears freepoint availability
func int zCVobSpot_IsAvailable (var int vobSpotPtr, var int vobPtr) {
	//0x00709320 public: int __thiscall zCVobSpot::IsAvailable(class zCVob *)
	const int zCVobSpot__IsAvailable_G1 = 7377696;

	//0x007B3020 public: int __thiscall zCVobSpot::IsAvailable(class zCVob *)
	const int zCVobSpot__IsAvailable_G2 = 8073248;

	if (!Hlp_Is_zCVobSpot (vobSpotPtr)) { return 0; };

	var int retVal;

	const int call = 0;

	if (CALL_Begin (call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (vobSpotPtr), MEMINT_SwitchG1G2 (zCVobSpot__IsAvailable_G1, zCVobSpot__IsAvailable_G2));
		call = CALL_End ();
	};

	return + retVal;
};

/*
 *	MEM_RtnMan init function
 */
//0x008DC220 class oCRtnManager rtnMan
const int MEMINT_RtnMan_Address_G1 = 9290272;

//0x00AB31C8 class oCRtnManager rtnMan
const int MEMINT_RtnMan_Address_G2 = 11219400;

func void MEM_RtnMan_Init () {
	MEM_RtnMan = _^ (MEMINT_SwitchG1G2 (MEMINT_RtnMan_Address_G1, MEMINT_RtnMan_Address_G2));
};


/*
 *	zCWaypoint_GetName
 *	 - returns waypoints name
 */
func string zCWaypoint_GetName (var int wpPtr) {
	if (!Hlp_Is_zCWaypoint (wpPtr)) { return ""; };

	var zCWaypoint wp; wp = _^ (wpPtr);
	return wp.Name;

	//0x00706110 public: class zSTRING const & __thiscall zCWaypoint::GetName(void)
	//const int zCWaypoint__GetName_G1 = 7364880;

	//0x007AFD10 public: class zSTRING const & __thiscall zCWaypoint::GetName(void)
	//const int zCWaypoint__GetName_G2 = 8060176;

	//var int strPtr;
	//CALL__thiscall (wpPtr, MEMINT_SwitchG1G2 (zCWaypoint__GetName_G1, zCWaypoint__GetName_G2));
	//strPtr = CALL_RetValAsPtr ();
	//return MEM_ReadString (strPtr);
};

/*
 *	zCVobWaypoint_GetWaypoint
 *	 - returns pointer to waypoint
 */
func int zCVobWaypoint_GetWaypoint (var int vobPtr) {
	if (!Hlp_Is_zCVobWaypoint (vobPtr)) { return 0; };
	var string vobWaypointName; vobWaypointName = zCVob_GetName (vobPtr);
	return + SearchWaypointByName (vobWaypointName);
};

/*
 *
 */
func void oCRtnManager_RemoveEntry (var int rtnEntryPtr) {
	//0x006CE040 public: void __thiscall oCRtnManager::RemoveEntry(class oCRtnEntry *)
	const int oCRtnManager__RemoveEntry_G1 = 7135296;

	//0x00775E70 public: void __thiscall oCRtnManager::RemoveEntry(class oCRtnEntry *)
	const int oCRtnManager__RemoveEntry_G2 = 7822960;

	const int call = 0;
	if (CALL_Begin (call)) {
		var int rtnManPtr; rtnManPtr = MEMINT_SwitchG1G2 (MEMINT_RtnMan_Address_G1, MEMINT_RtnMan_Address_G2);
		CALL_PtrParam (_@ (rtnEntryPtr));
		CALL__thiscall (_@ (rtnManPtr), MEMINT_SwitchG1G2 (oCRtnManager__RemoveEntry_G1, oCRtnManager__RemoveEntry_G2));
		call = CALL_End ();
	};
};

/*
 *
 */
func void oCRtnManager_RemoveRoutine (var int npcPtr) {
	//0x006CE0C0 public: void __thiscall oCRtnManager::RemoveRoutine(class oCNpc *)
	const int oCRtnManager__RemoveRoutine_G1 = 7135424;

	//0x00775EF0 public: void __thiscall oCRtnManager::RemoveRoutine(class oCNpc *)
	const int oCRtnManager__RemoveRoutine_G2 = 7823088;

	const int call = 0;
	if (CALL_Begin (call)) {
		var int rtnManPtr; rtnManPtr = MEMINT_SwitchG1G2 (MEMINT_RtnMan_Address_G1, MEMINT_RtnMan_Address_G2);
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall (_@ (rtnManPtr), MEMINT_SwitchG1G2 (oCRtnManager__RemoveRoutine_G1, oCRtnManager__RemoveRoutine_G2));
		call = CALL_End ();
	};
};

func int oCRtnManager_FindRoutine (var int slfInstance, var int rtnBeforePtr, var int rtnNowPtr) {
	//0x006CD720 public: int __thiscall oCRtnManager::FindRoutine(class oCNpc *,class oCRtnEntry * &,class oCRtnEntry * &)
	const int oCRtnManager__FindRoutine_G1 = 7132960;

	//0x00775580 public: int __thiscall oCRtnManager::FindRoutine(class oCNpc *,class oCRtnEntry * &,class oCRtnEntry * &)
	const int oCRtnManager__FindRoutine_G2 = 7820672;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	If (!Hlp_IsValidNPC (slf)) { return FALSE; };

	//--> safety check: function can be called only when NPC has routine - otherwise game will crash!
	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return FALSE; };

	var oCNPC_States state; state = _^ (statePtr);
	if (!state.hasRoutine) { return FALSE; };
	//<--

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		var int rtnManPtr; rtnManPtr = MEMINT_SwitchG1G2 (MEMINT_RtnMan_Address_G1, MEMINT_RtnMan_Address_G2);

		CALL_PutRetValTo (_@ (retVal));

		CALL_PtrParam (_@ (rtnNowPtr));
		CALL_PtrParam (_@ (rtnBeforePtr));
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (rtnManPtr), MEMINT_SwitchG1G2 (oCRtnManager__FindRoutine_G1, oCRtnManager__FindRoutine_G2));
		call = CALL_End ();
	};

	return + retVal;
};

func int oCRtnManager_GetRoutinePos (var int slfInstance) {
	//0x006CD970 public: class zVEC3 __thiscall oCRtnManager::GetRoutinePos(class oCNpc *)
	const int oCRtnManager__GetRoutinePos_G1 = 7133552;

	//0x007757D0 public: class zVEC3 __thiscall oCRtnManager::GetRoutinePos(class oCNpc *)
	const int oCRtnManager__GetRoutinePos_G2 = 7821264;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	If (!Hlp_IsValidNPC (slf)) { return 0; };

	var int rtnManPtr; rtnManPtr = MEMINT_SwitchG1G2 (MEMINT_RtnMan_Address_G1, MEMINT_RtnMan_Address_G2);

	CALL_RetValIsStruct (12);
	CALL_PtrParam (_@ (slf));
	CALL__thiscall (rtnManPtr, MEMINT_SwitchG1G2 (oCRtnManager__GetRoutinePos_G1, oCRtnManager__GetRoutinePos_G2));
	return CALL_RetValAsPtr ();
};

func void oCRtnManager_RemoveAllRoutines () {
	MEM_RtnMan_Init ();

	var zCListSort list;

	var int rtnPtr; rtnPtr = MEM_RtnMan.rtnList_next;
	while (rtnPtr);
		list = _^ (rtnPtr);

		if (list.data) {
			var oCRtnEntry rtn; rtn = _^ (list.data);
			oCRtnManager_RemoveRoutine (rtn.npc);
		};

		rtnPtr = MEM_RtnMan.rtnList_next;
	end;
};

func int oCRtnManager_GetNpcRoutines (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	MEM_RtnMan_Init ();

	var int rtnArrayPtr; rtnArrayPtr = MEM_ArrayCreate ();

	var zCListSort list;

	var int rtnPtr; rtnPtr = MEM_RtnMan.rtnList_next;
	while (rtnPtr);
		list = _^ (rtnPtr);

		if (list.data) {
			var oCRtnEntry rtn; rtn = _^ (list.data);
			if (rtn.npc == slfPtr) {
				MEM_ArrayInsert (rtnArrayPtr, list.data);
			};
		};

		rtnPtr = list.next;
	end;

	return rtnArrayPtr;
};

/*
 *
 */
func int zCWay_GetGoalWaypoint (var int wayPtr, var int wpPtr) {
	//0x00704EA0 public: class zCWaypoint * __thiscall zCWay::GetGoalWaypoint(class zCWaypoint *)
	const int zCWay__GetGoalWaypoint_G1 = 7360160;

	//0x007AEA90 public: class zCWaypoint * __thiscall zCWay::GetGoalWaypoint(class zCWaypoint *)
	const int zCWay__GetGoalWaypoint_G2 = 8055440;

	if (!wpPtr) { return 0; };
	if (!wayPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (wayPtr), MEMINT_SwitchG1G2 (zCWay__GetGoalWaypoint_G1, zCWay__GetGoalWaypoint_G2));
		call = CALL_End ();
	};

	return +retVal;
};

/*
 *	zCWay_EstimateCost
 *	 - returns zCWay 'manhattan' distance
 */
func void zCWay_EstimateCost (var int wayPtr) {
	//0x00704EB0 protected: void __thiscall zCWay::EstimateCost(void)
	const int zCWay__EstimateCost_G1 = 7360176;

	//0x007AEAA0 protected: void __thiscall zCWay::EstimateCost(void)
	const int zCWay__EstimateCost_G2 = 8055456;

	if (!wayPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (wayPtr), MEMINT_SwitchG1G2 (zCWay__EstimateCost_G1, zCWay__EstimateCost_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWay_GetLength
 *	 - returns zCWay 'air' distance
 */
func int zCWay_GetLength (var int wayPtr) {
	//0x00704F20 public: float __thiscall zCWay::GetLength(void)
	const int zCWay__GetLength_G1 = 7360288;

	//0x007AEB10 public: float __thiscall zCWay::GetLength(void)
	const int zCWay__GetLength_G2 = 8055568;

	if (!wayPtr) { return FLOATNULL; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (wayPtr), MEMINT_SwitchG1G2 (zCWay__GetLength_G1, zCWay__GetLength_G2));
		call = CALL_End ();
	};

	return + retVal;
};

/*
 *	zCRoute_InitWayNode
 *	 - for some reason wayNode is un-initialized, so here we will initialize it
 *	 - we will also setup first target --> it should be starting waypoint
 */
func void zCRoute_InitWayNode (var int rt) {
	//Safety check
	if (!rt) { return; };

	var zCRoute route; route = _^ (rt);
	if (!route.wayNode) {
		route.wayNode = route.wayList_next;
		route.target = route.startWp;
	};
};

func int zCWayNet_FindRoute_Positions (var int fromPosPtr, var int toPosPtr, var int vobPtr) {
	//0x007068D0 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zVEC3 const &,class zCVob const *)
	const int zCWayNet__FindRoute_G1 = 7366864;

	//0x007B04D0 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zVEC3 const &,class zCVob const *)
	const int zCWayNet__FindRoute_G2 = 8062160;

	if (!toPosPtr) { return 0; };
	if (!fromPosPtr) { return 0; };
	if (!MEM_World.wayNet) { return 0; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (toPosPtr));
		CALL_PtrParam (_@ (fromPosPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__FindRoute_G1, zCWayNet__FindRoute_G2));
		call = CALL_End ();
	};

	zCRoute_InitWayNode (retVal);
	return +retVal;
};

func int zCWayNet_FindRoute_PosToWp (var int fromPosPtr, var int toWaypointPtr, var int vobPtr) {
	//0x00706960 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zCWaypoint *,class zCVob const *)
	const int zCWayNet__FindRoute_G1 = 7367008;

	//0x007B0560 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zCWaypoint *,class zCVob const *)
	const int zCWayNet__FindRoute_G2 = 8062304;

	if (!toWaypointPtr) { return 0; };
	if (!fromPosPtr) { return 0; };
	if (!MEM_World.wayNet) { return 0; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (toWaypointPtr));
		CALL_PtrParam (_@ (fromPosPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__FindRoute_G1, zCWayNet__FindRoute_G2));
		call = CALL_End ();
	};

	zCRoute_InitWayNode (retVal);
	return +retVal;
};

func int zCWayNet_FindRoute_Waypoints (var int fromWaypointPtr, var int toWaypointPtr, var int vobPtr) {
	//0x00706A40 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zCWaypoint *,class zCWaypoint *,class zCVob const *)
	const int zCWayNet__FindRoute_G1 = 7367232;

	//0x007B0640 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zCWaypoint *,class zCWaypoint *,class zCVob const *)
	const int zCWayNet__FindRoute_G2 = 8062528;

	if (!toWaypointPtr) { return 0; };
	if (!fromWaypointPtr) { return 0; };
	if (!MEM_World.wayNet) { return 0; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (toWaypointPtr));
		CALL_PtrParam (_@ (fromWaypointPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__FindRoute_G1, zCWayNet__FindRoute_G2));
		call = CALL_End ();
	};

	zCRoute_InitWayNode (retVal);
	return +retVal;
};

func string zCRoute_GetDesc (var int routePtr) {
	//0x00708C80 public: class zSTRING __thiscall zCRoute::GetDesc(void)
	const int zCRoute__GetDesc_G1 = 7376000;

	//0x007B2980 public: class zSTRING __thiscall zCRoute::GetDesc(void)
	const int zCRoute__GetDesc_G2 = 8071552;

	if (!routePtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (routePtr, MEMINT_SwitchG1G2 (zCRoute__GetDesc_G1, zCRoute__GetDesc_G2));
	return CALL_RetValAszstring ();
};

/*
 *	zCRoute_GetCost // int
 *	 - function iterates through zCWay list - and calculates total 'cost'
 */
func int zCRoute_GetCost (var int routePtr) {
	if (!routePtr) { return 0; };
	var zCRoute rt; rt = _^ (routePtr);

	//Loop through wayNodes
	var int list; list = rt.wayNode;
	if (!list) { return 0; };

	var int totalCost; totalCost = 0;

	while (list);
		var zCList l; l = _^ (list);

		if (l.data) {
			zCWay_EstimateCost (l.data);

			var zCWay way; way = _^ (l.data);
			totalCost += way.cost;
		};

		list = l.next;
	end;

	return totalCost;
};

/*
 *	zCRoute_GetLength // float
 *	 - function iterates through zCWay list - and calculates total length
 */
func int zCRoute_GetLength (var int routePtr) {
	if (!routePtr) { return FLOATNULL; };
	var zCRoute rt; rt = _^ (routePtr);

	//Loop through wayNodes
	var int list; list = rt.wayNode;
	if (!list) { return FLOATNULL; };

	var int totalCost; totalCost = FLOATNULL;

	while (list);
		var zCList l; l = _^ (list);

		if (l.data) {
			totalCost = addF (totalCost, zCWay_GetLength (l.data));
		};

		list = l.next;
	end;

	return totalCost;
};

/*
 *	zCRoute_GetWP
 *	 - function iterates through wayList data and finds which waypoint NPC will visit next (@ index)
 */
func int zCRoute_GetWP (var int routePtr, var int index) {
	if (!routePtr) { return 0; };
	var zCRoute rt; rt = _^ (routePtr);

	if (index <= 0) { index = 1; };

	//If we are looking for next waypoint - return target
	if (index == 1) { return rt.target; };

	//Loop through wayNodes
	var int list; list = rt.wayNode;
	if (!list) { return 0; };

	//Remember target
	var int target; target = rt.target;

	index += 1;
	repeat (i, index); var int i;
		var zCList l; l = _^ (list);

		if (l.data) {
			var zCWay way; way = _^ (l.data);

			//Get next waypoint
			target = zCWay_GetGoalWaypoint (l.data, target);

			if (i == index - 1) {
				return +target;
			};
		};

		list = l.next;

		//Exit loop if there are no wayNodes
		if (!list) { return 0; };
	end;

	return 0;
};

func int NPC_Route_GetWP (var int slfInstance, var int index) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };
	return +zCRoute_GetWP (slf.route, index);
};

func string NPC_Route_GetWPName (var int slfInstance, var int index) {
	var int nextWPPtr;
	nextWPPtr = NPC_Route_GetWP (slfInstance, index);

	if (nextWPPtr) {
		return zCWaypoint_GetName (nextWPPtr);
	};

	return "";
};

func void NPC_FindRoute (var int slfInstance, var string fromWP, var string toWP) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int wp1;
	var int wp2;

	//If first waypoint is not supplied - then take nearest
	if (!STR_Len (fromWP)) {
		fromWP = Npc_GetNearestWP (slf);
	};

	wp1 = SearchWaypointByName (fromWP);
	if (!wp1) { return; };

	wp2 = SearchWaypointByName (toWP);
	if (!wp2) { return; };

	var int routePtr; routePtr = zCWayNet_FindRoute_Waypoints (wp1, wp2, 0);

	if (!routePtr) { return; };

	oCNpc_SetRoute (slfInstance, routePtr);
};

/*
 *	Function returns waypoint from last routine entry
 */
func string NPC_GetLastRoutineWP (var int slfInstance) {
	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return ""; };

	var oCNPC_States state; state = _^ (statePtr);
	if (!state.hasRoutine) { return ""; };

	//If rtnBefore == rtnNow - then return blank string
	if (state.rtnBefore == state.rtnNow) { return ""; };

	// Unused engine variables
	// state.walkmode_routine
	// state.weaponmode_routine

	// state.aiStateDriven

//

	if (state.rntChangeCount == 0) {
		state.walkmode_routine = TRUE;
	};

	if (state.walkmode_routine) {
		if (Hlp_Is_oCNpc (state.npc)) {
			var oCNpc slf; slf = _^ (state.npc);
			if (Hlp_StrCmp (Npc_GetNearestWP (slf), slf.wpName)) {
				state.walkmode_routine = FALSE;
			};
		} else {
			state.walkmode_routine = FALSE;
		};
	};

	if (state.walkmode_routine) {
		return "";
	};

	var int rtnEntryPtr; rtnEntryPtr = state.rtnBefore;
	if (!rtnEntryPtr) { return ""; };

	var oCRtnEntry rtnEntry; rtnEntry = _^ (rtnEntryPtr);
	return rtnEntry.wpname;
};

/*
 *	Custom function for searching freepoints
 *	 - allows us to search for freepoints
 *	 - parameter deprioritizeFreePoint will basically put freepoints with certain strings to the 'end of the list'
 *	   for example we can search for freepoints SMALLTALK and we can deprioritize those freepoints that also contain string _RAIN:
 *		vobSpotPtr = NPC_GetFreepoint (self, freePoint, "_RAIN", mkf (1200));
 *		function will prefer freePoint FP_SMALLTALK_XYZ before FP_SMALLTALK_RAIN_XYZ, however if freePoint FP_SMALLTALK_XYZ is marked as used ... function returns FP_SMALLTALK_RAIN_XYZ
 */
func int NPC_GetFreepoint (var int slfInstance, var string freePoint, var string deprioritizeFreePoint, var int searchFlags, var int range, var int distLimit, var int verticalLimit) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int i;
	var int vobPtr;

	var int slfPtr; slfPtr = _@ (slf);

	var int dist;
	var int dist2;

	var int maxDist; maxDist = 999999;
	var int maxDist2; maxDist2 = 999999;

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;
	var int nearestPtr2; nearestPtr2 = 0;

	var int canSee;

	//Get Npc position
	var int fromPos[3];
	if (!zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos))) { return 0; };

	//Target position
	var int toPos[3];
	var int routePtr;

	//Collect all vobs in range
	var int arrPtr; arrPtr = Wld_CollectVobsInRange (_@ (fromPos), mkf (range));
	if (!arrPtr) { return 0; };

	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray);
		vobPtr = MEM_ReadIntArray (vobList.array, i);

		//Seems like engine still returns true when NPC is standing on freepoint
		//(this function also checks if object is zCVobSpot)
		if (zCVobSpot_IsAvailable (vobPtr, slfPtr)) {
			if (searchFlags & SEARCHVOBLIST_CANSEE) {
				canSee = oCNPC_CanSee (slfInstance, vobPtr, 1);
			} else {
				canSee = TRUE;
			};

			//Check for portal room owner
			if (searchFlags & SEARCHVOBLIST_CHECKPORTALROOMOWNER) {
				var string portalName; portalName = Vob_GetPortalName (vobPtr);

				//If portal room is owned by Npc
				if (Wld_PortalGetOwnerInstanceID (portalName) > -1) {
					//If this portal is not owned by me - ignore - pretend we don't see it :)
					if (!Wld_PortalIsOwnedByNPC (portalName, slf)) {
						canSee = FALSE;
					};
				};
			};

			if (canSee) {
				if ((abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalLimit) || (verticalLimit == -1)) {
					var zCVobSpot vobSpot; vobSpot = _^ (vobPtr);

					var int index1; index1 = STR_IndexOf (vobSpot._zCObject_objectName, freePoint);
					var int index2; index2 = STR_IndexOf (vobSpot._zCObject_objectName, deprioritizeFreePoint);

					//Matching freePoint name
					if (index1 > -1) {
						//Find route from Npc to vob - get total distance if Npc travels by waynet
						if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
							if (zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos))) {
								routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
								dist = zCRoute_GetLength (routePtr); //float
								dist = RoundF (dist);
							};
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

					//Matching freePoint name (not matching deprioritizeFreePoint)
					if ((index1 > -1) && (index2 == -1) && (STR_Len (deprioritizeFreePoint) > 0)) {

						//Find route from Npc to vob - get total distance if Npc travels by waynet
						if (searchFlags & SEARCHVOBLIST_USEWAYNET) {
							if (zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos))) {
								routePtr = zCWayNet_FindRoute_Positions (_@ (fromPos), _@ (toPos), 0);
								dist2 = zCRoute_GetLength (routePtr); //float
								dist2 = RoundF (dist2);
							};
						} else {
							dist2 = NPC_GetDistToVobPtr (slfInstance, vobPtr); //int
						};

						if ((dist2 <= distLimit) || (distLimit == -1)) {
							if (dist2 < maxDist2) {
								nearestPtr2 = vobPtr;
								maxDist2 = dist2;
							};
						};
					};
				};
			};
		};
	end;

	MEM_Free (arrPtr);

	if (nearestPtr2) { return nearestPtr2; };
	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};

/*
 *	Function returns freepoint which NPC is using
 */
func int NPC_GetCurrentFreepoint (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int i;
	var int vobPtr;

	var int slfPtr; slfPtr = _@ (slf);

	//Get Npc position
	var int fromPos[3];
	if (!zCVob_GetPositionWorldToPos (_@ (slf), _@ (fromPos))) { return 0; };

	//Collect all vobs in range
	var int arrPtr; arrPtr = Wld_CollectVobsInRange (_@ (fromPos), mkf (100));
	if (!arrPtr) { return 0; };

	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray);
		vobPtr = MEM_ReadIntArray (vobList.array, i);

		if (Hlp_Is_zCVobSpot (vobPtr)) {
			//Seems like engine still returns true when NPC is standing on freepoint (also it updates freepoint if Npc is standing on it)
			if (zCVobSpot_IsAvailable (vobPtr, slfPtr)) {
				var zCVobSpot vobSpot; vobSpot = _^ (vobPtr);
				if (vobSpot.inUseVob == slfPtr) {
					MEM_Free (arrPtr);
					return vobPtr;
				};
			};
		};
	end;

	MEM_Free (arrPtr);
	return 0;
};

/*
 *	Function returns freepoint name
 */
func string FP_GetFreePointName (var int vobSpotPtr) {
	if (!Hlp_Is_zCVobSpot (vobSpotPtr)) { return ""; };

	var zCVobSpot vobSpot; vobSpot = _^ (vobSpotPtr);
	return vobSpot._zCObject_objectName;
};

/*
 *	Following format of freepoints is expected
 *	FP_STAND
 *	FP_STAND_RAIN
 *	FP_STAND_RAIN_XYZ123
 *
 *	 - function returns freePoint name STAND
 */
func string FP_GetCleanName (var string freePoint) {
	var int len; len = STR_Len (freePoint);

	//Remove prefix
	if (STR_StartsWith (freePoint, "FP_")) {
		freePoint = mySTR_SubStr (freePoint, 3, len - 3);
	};

	var int index; index = STR_IndexOf (freePoint, "_");
	if (index > -1) {
		freePoint = mySTR_SubStr (freePoint, 0, index);
	};

	return freePoint;
};

/*
 *	zCWaypoint_SetName
 *	 - function updates waypoint name
 */
func void zCWaypoint_SetName (var int wpPtr, var string waypointName) {
	//0x00705FB0 public: void __thiscall zCWaypoint::SetName(class zSTRING &)
	const int zCWaypoint__SetName_G1 = 7364528;

	//0x007AFBB0 public: void __thiscall zCWaypoint::SetName(class zSTRING &)
	const int zCWaypoint__SetName_G2 = 8059824;

	if (!wpPtr) { return; };

	CALL_zStringPtrParam (waypointName);
	CALL__thiscall (wpPtr, MEMINT_SwitchG1G2 (zCWaypoint__SetName_G1, zCWaypoint__SetName_G2));
};

func int zCWaypoint_HasWay (var int wpPtr1, var int wpPtr2) {
	//0x007065B0 public: class zCWay * __thiscall zCWaypoint::HasWay(class zCWaypoint *)
	const int zCWaypoint__HasWay_G1 = 7366064;

	//0x007B01B0 public: class zCWay * __thiscall zCWaypoint::HasWay(class zCWaypoint *)
	const int zCWaypoint__HasWay_G2 = 8061360;

	if (!wpPtr1) { return 0; };
	if (!wpPtr2) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (wpPtr2));
		CALL__thiscall (_@ (wpPtr1), MEMINT_SwitchG1G2 (zCWaypoint__HasWay_G1, zCWaypoint__HasWay_G2));
		call = CALL_End ();
	};

	return +retVal;
};

func void zCWaypoint_CorrectHeight (var int wpPtr) {
	//0x007064A0 public: void __thiscall zCWaypoint::CorrectHeight(class zCWorld *)
	const int zCWaypoint__CorrectHeight_G1 = 7365792;

	//0x007B00A0 public: void __thiscall zCWaypoint::CorrectHeight(class zCWorld *)
	const int zCWaypoint__CorrectHeight_G2 = 8061088;

	if (!wpPtr) { return; };

	var int worldPtr; worldPtr = _@ (MEM_World);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (worldPtr));
		CALL__thiscall (_@ (wpPtr), MEMINT_SwitchG1G2 (zCWaypoint__CorrectHeight_G1, zCWaypoint__CorrectHeight_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_GetNearestWaypoint
 *	 - returns nearest waypoint to pos pointer
 */
func int zCWayNet_GetNearestWaypoint (var int posPtr) {
	//0x00703A50 public: class zCWaypoint * __fastcall zCWayNet::GetNearestWaypoint(class zVEC3 const &)
	const int zCWayNet__GetNearestWaypoint_G1 = 7354960;

	//0x007AD660 public: class zCWaypoint * __fastcall zCWayNet::GetNearestWaypoint(class zVEC3 const &)
	const int zCWayNet__GetNearestWaypoint_G2 = 8050272;

	if (!posPtr) { return 0; };
	if (!MEM_World.wayNet) { return 0; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__fastcall (_@ (wayNetPtr) , _@ (posPtr), MEMINT_SwitchG1G2 (zCWayNet__GetNearestWaypoint_G1, zCWayNet__GetNearestWaypoint_G2));
		call = CALL_End ();
	};

	return + retVal;
};

/*
 *	zCWayNet_InsertWaypoint
 *	 - creates waypoint at xyz coordinates
 */

// !!! Do not add to waynet waypoints with this function ... further below explanation in WP_Create function

//func int zCWayNet_InsertWaypoint (var int x, var int y, var int z) {
//	//0x007033E0 public: class zCWaypoint * __thiscall zCWayNet::InsertWaypoint(float,float,float)
//	const int zCWayNet__InsertWaypoint_G1 = 7353312;

//	//0x007ACFF0 public: class zCWaypoint * __thiscall zCWayNet::InsertWaypoint(float,float,float)
//	const int zCWayNet__InsertWaypoint_G2 = 8048624;

//	if (!MEM_World.wayNet) { return 0; };

//	//MEM_Waynet
//	CALL_FloatParam (z);
//	CALL_FloatParam (y);
//	CALL_FloatParam (x);
//	CALL__thiscall (MEM_World.wayNet, MEMINT_SwitchG1G2 (zCWayNet__InsertWaypoint_G1, zCWayNet__InsertWaypoint_G2));

//	return CALL_RetValAsPtr ();
//};

/*
 *	zCWayNet_InsertWaypoint_ByPtr
 *	 - function inserts waypoint to waynet
 */
func void zCWayNet_InsertWaypoint_ByPtr (var int wpPtr) {
	//0x007034F0 public: void __thiscall zCWayNet::InsertWaypoint(class zCWaypoint *)
	const int zCWayNet__InsertWaypoint_G1 = 7353584;

	//0x007AD100 public: void __thiscall zCWayNet::InsertWaypoint(class zCWaypoint *)
	const int zCWayNet__InsertWaypoint_G2 = 8048896;

	if (!wpPtr) { return; };
	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__InsertWaypoint_G1, zCWayNet__InsertWaypoint_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_HasWaypoint
 *	 - checks if waypoint is in waynet
 */
func int zCWayNet_HasWaypoint (var int wpPtr) {
	//0x00703360 public: int __thiscall zCWayNet::HasWaypoint(class zCWaypoint *)
	const int zCWayNet__HasWaypoint_G1 = 7353184;

	//0x007ACF70 public: int __thiscall zCWayNet::HasWaypoint(class zCWaypoint *)
	const int zCWayNet__HasWaypoint_G2 = 8048496;

	if (!wpPtr) { return FALSE; };
	if (!MEM_World.wayNet) { return FALSE; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr));
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__HasWaypoint_G1, zCWayNet__HasWaypoint_G2));
		call = CALL_End ();
	};

	return + retVal;
};

func void zCWaypoint_Free (var int wpPtr) {
	//0x00705E10 protected: void __thiscall zCWaypoint::Free(void)
	const int zCWaypoint__Free_G1 = 7353184;

	//0x007AFA10 protected: void __thiscall zCWaypoint::Free(void)
	const int zCWaypoint__Free_G2 = 8048496;

	if (!wpPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (wpPtr), MEMINT_SwitchG1G2 (zCWaypoint__Free_G1, zCWaypoint__Free_G2));
		call = CALL_End ();
	};
};

func void zCWaypoint_Destructor (var int wpPtr) {
	//0x00705E80 protected: virtual __thiscall zCWaypoint::~zCWaypoint(void)
	const int zCWaypoint__zCWaypoint_G1 = 7364224;

	//0x007AFA80 protected: virtual __thiscall zCWaypoint::~zCWaypoint(void)
	const int zCWaypoint__zCWaypoint_G2 = 8059520;

	if (!wpPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (wpPtr), MEMINT_SwitchG1G2 (zCWaypoint__zCWaypoint_G1, zCWaypoint__zCWaypoint_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWaypoint_Delete
 *	 - function deletes waypoint
 */
func void zCWaypoint_Delete (var int wpPtr) {
	zCWaypoint_Free (wpPtr);
	zCWaypoint_Destructor (wpPtr);
};

func void zCWayNet_DeleteWaypoint_ByPtr (var int wpPtr) {
	//0x007036A0 public: void __thiscall zCWayNet::DeleteWaypoint(class zCWaypoint *)
	const int zCWayNet__DeleteWaypoint_G1 = 7354016;

	//0x007AD2B0 public: void __thiscall zCWayNet::DeleteWaypoint(class zCWaypoint *)
	const int zCWayNet__DeleteWaypoint_G2 = 8049328;

	if (!wpPtr) { return; };
	if (!MEM_World.wayNet) { return; };

	//If waypoint is not in waynet - delete directly
	if (!zCWayNet_HasWaypoint (wpPtr)) {
		zCWaypoint_Delete (wpPtr);
		return;
	};

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__DeleteWaypoint_G1, zCWayNet__DeleteWaypoint_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_CreateWay
 *	 - connects 2 waypoints together
 */
func void zCWayNet_CreateWay (var int wpPtr1, var int wpPtr2) {
	//0x00703810 public: void __thiscall zCWayNet::CreateWay(class zCWaypoint *,class zCWaypoint *)
	const int zCWayNet__CreateWay_G1 = 7354384;

	//0x007AD420 public: void __thiscall zCWayNet::CreateWay(class zCWaypoint *,class zCWaypoint *)
	const int zCWayNet__CreateWay_G2 = 8049696;

	if (!wpPtr1) { return; };
	if (!wpPtr2) { return; };
	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr2));
		CALL_PtrParam (_@ (wpPtr1));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__CreateWay_G1, zCWayNet__CreateWay_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_DeleteWay
 *	 - Disconnects 2 waypoints
 */
func void zCWayNet_DeleteWay (var int wpPtr1, var int wpPtr2) {
	//0x007038E0 public: void __thiscall zCWayNet::DeleteWay(class zCWaypoint *,class zCWaypoint *)
	const int zCWayNet__DeleteWay_G1 = 7354592;

	//0x007AD4F0 public: void __thiscall zCWayNet::DeleteWay(class zCWaypoint *,class zCWaypoint *)
	const int zCWayNet__DeleteWay_G2 = 8049904;

	if (!wpPtr1) { return; };
	if (!wpPtr2) { return; };
	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr2));
		CALL_PtrParam (_@ (wpPtr1));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__DeleteWay_G1, zCWayNet__DeleteWay_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_ClearVobDependencies
 *	 - function deletes VobWaypoints from waypoints in waynet
 */
func void zCWayNet_ClearVobDependencies () {
	//0x00703EE0 public: void __thiscall zCWayNet::ClearVobDependencies(void)
	const int zCWayNet__ClearVobDependencies_G1 = 7356128;

	//0x007ADAF0 public: void __thiscall zCWayNet::ClearVobDependencies(void)
	const int zCWayNet__ClearVobDependencies_G2 = 8051440;

	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__ClearVobDependencies_G1, zCWayNet__ClearVobDependencies_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_CreateVobDependencies
 *	 - function creates VobWaypoints for waypoint in waynet
 */
func void zCWayNet_CreateVobDependencies (var int worldPtr) {
	//0x007040E0 public: void __thiscall zCWayNet::CreateVobDependencies(class zCWorld *)
	const int zCWayNet__CreateVobDependencies_G1 = 7356640;

	//0x007ADCF0 public: void __thiscall zCWayNet::CreateVobDependencies(class zCWorld *)
	const int zCWayNet__CreateVobDependencies_G2 = 8051952;

	if (!worldPtr) { return; };
	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (worldPtr));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__CreateVobDependencies_G1, zCWayNet__CreateVobDependencies_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_UpdateVobDependencies
 *	 - function updates position of VobWaypoints aligns position with waypoints
 */
func void zCWayNet_UpdateVobDependencies () {
	//0x00703C90 public: void __thiscall zCWayNet::UpdateVobDependencies(void)
	const int zCWayNet__UpdateVobDependencies_G1 = 7355536;

	//0x007AD8A0 public: void __thiscall zCWayNet::UpdateVobDependencies(void)
	const int zCWayNet__UpdateVobDependencies_G2 = 8050848;

	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__UpdateVobDependencies_G1, zCWayNet__UpdateVobDependencies_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_CorrectHeight
 *	 - function updates waypoints height
 */
func void zCWayNet_CorrectHeight () {
	//0x00703BA0 public: void __thiscall zCWayNet::CorrectHeight(void)
	const int zCWayNet__CorrectHeight_G1 = 7355296;

	//0x007AD7B0 public: void __thiscall zCWayNet::CorrectHeight(void)
	const int zCWayNet__CorrectHeight_G2 = 8050608;

	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__CorrectHeight_G1, zCWayNet__CorrectHeight_G2));
		call = CALL_End ();
	};
};

/*
 *	zCWayNet_AddWays
 *	 - connects together all connections of 2 waypoints
 */
func void zCWayNet_AddWays (var int wpPtr1, var int wpPtr2) {
	//0x00704B40 public: void __thiscall zCWayNet::AddWays(class zCWaypoint *,class zCWaypoint *)
	const int zCWayNet__AddWays_G1 = 7359296;

	//0x007AE730 public: void __thiscall zCWayNet::AddWays(class zCWaypoint *,class zCWaypoint *)
	const int zCWayNet__AddWays_G2 = 8054576;

	if (!wpPtr1) { return; };
	if (!wpPtr2) { return; };
	if (!MEM_World.wayNet) { return; };

	var int waynetPtr; waynetPtr = MEM_World.wayNet;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (wpPtr2));
		CALL_PtrParam (_@ (wpPtr1));
		CALL__thiscall (_@ (waynetPtr), MEMINT_SwitchG1G2 (zCWayNet__AddWays_G1, zCWayNet__AddWays_G2));
		call = CALL_End ();
	};
};

/*
 *	WP_Create
 *	 - wrapper function that creates waypoint at posPtr and connects it with connectWithWpPtr (it wont connect if pointer is null)
 */
func int WP_Create (var string waypointName, var int posPtr, var int connectWithWpPtr) {
	if (!posPtr) { return 0; };

	var int x; x = MEM_ReadIntArray (posPtr, 0);
	var int y; y = MEM_ReadIntArray (posPtr, 1);
	var int z; z = MEM_ReadIntArray (posPtr, 2);

	//We cannot use this function, waynet waypoint list is sorted list (zCListSort)
	//When new waypoint is inserted into waynet - it is sorted by its name ...
	//Problem with this function below is - created waypoint at this point does not have any name :)
	//Waypoint is therefore inserted to the end of the list - and engine function is unable to find it (because of binary string comparison search method)
	//List of waypoints is sorted and works fine only after save/load afterwards
	//newWpPtr = zCWayNet_InsertWaypoint (x, y, z);
	//if (!newWpPtr) { return 0; };

	//Here we will instead use our own function - that will create waypoint with name and will insert it to waynet only afterwards
	//That way waypoints are working fine immediately
	var int newWpPtr; newWpPtr = zCWaypoint_Create ();

	if (!newWpPtr) { return 0; };

	var int trafo[16];
	NewTrafo (_@(trafo));
	PosDirToTrf (posPtr, 0, _@ (trafo));

	var int vobWp; vobWp = InsertObject ("zCVobWaypoint", waypointName, "", _@ (trafo), 0);

	zCWaypoint_Init (newWpPtr, waypointName, vobWp, x, y, z);
	zCWayNet_InsertWaypoint_ByPtr (newWpPtr);

	//var zCWaypoint newWP; newWP = _^ (newWpPtr);
	//newWP.name = waypointName;
	//newWP._zCObject_objectName = waypointName;

	//Here I was hoping zCWaypoint.wpvob can be set as a child object of another object ...
	//And I was hoping we can use that for waypoint alignment with other objects (e.g. with houses)
	//However ... it seems like game is removing all of these objects with zCWayNet::ClearVobDependencies when game is saved!
	//Therefore child-parent reference is gone ... so this would be pointless ;-/

	//Create zCVobWaypoint object
	//if (!newWP.wpvob) {
	//	var int trafo[16];
	//	NewTrafo (_@(trafo));
	//	PosDirToTrf (_@ (newWP.pos), _@ (newWP.dir), _@ (trafo));

	//	InsertObject(string class, string objName, string visual, int trafoPtr, int parentVobPtr)
	//	newWP.wpvob = InsertObject ("zCVobWaypoint", waypointName, "", _@ (trafo), parentVobPtr);
	//};

	//Set waypoint name
	//zCWaypoint_SetName (newWpPtr, waypointName);

	if (connectWithWpPtr) {
		zCWayNet_CreateWay (newWpPtr, connectWithWpPtr);
	};

	return newWpPtr;
};

/*
 *	Wrapper / convenience functions
 */

/*
 *	WP_GetNearestWPAtPos
 *	 - finds nearest waypoint to specified position
 */
func string WP_GetNearestWPAtPos (var int posPtr) {
	var int wpPtr; wpPtr = zCWayNet_GetNearestWaypoint (posPtr);
	return zCWaypoint_GetName (wpPtr);
};

/*
 *	WP_GetNearestWPAtVob
 *	 - finds nearest waypoint to specified vob pointer
 */
func string WP_GetNearestWPAtVob (var int vobPtr) {
	var int pos[3];
	if (!zCVob_GetPositionWorldToPos (vobPtr, _@ (pos))) {
		return "";
	};

	return WP_GetNearestWPAtPos (_@ (pos));
};

/*
 *	WP_GetDistToPos // float
 *	 - returns distance from waypoint to specified position
 */
func int WP_GetDistToPos (var string waypointName, var int posPtr) {
	if (!posPtr) { return FLOATNULL; };

	var int wpPtr; wpPtr = SearchWaypointByName (waypointName);
	if (!wpPtr) { return FLOATNULL; };

	var zCWaypoint wp; wp = _^ (wpPtr);

	return + Pos_GetDistToPos (_@ (wp.pos), posPtr);
};

/*
 *	WP_GetDistToVob // float
 *	 - returns distance from waypoint to specified vob pointer
 */
func int WP_GetDistToVob (var string waypointName, var int vobPtr) {
	var int pos[3];
	if (!zCVob_GetPositionWorldToPos (vobPtr, _@ (pos))) {
		return FLOATNULL;
	};

	var int wpPtr; wpPtr = SearchWaypointByName (waypointName);
	if (!wpPtr) { return FLOATNULL; };

	var zCWaypoint wp; wp = _^ (wpPtr);

	return + Pos_GetDistToPos (_@ (wp.pos), _@ (pos));
};

/*
 *	zCWaypoint_CanSee
 *	 - can we see vob from waypoint?
 */
func int zCWaypoint_CanSee (var int wpPtr, var int vobPtr) {
	if (!Hlp_Is_zCWaypoint (wpPtr)) { return 0; };

	var int pos[3];
	if (!zCVob_GetPositionWorldToPos (vobPtr, _@ (pos))) { return 0; };

	var zCWaypoint wp; wp = _^ (wpPtr);

	var int ignoreListPtr; ignoreListPtr = MEM_ArrayCreate ();
	MEM_ArrayInsert (ignoreListPtr, vobPtr);

	pos[1] = addf (pos[1], mkf (100));

	var int dir[3];
	SubVectors (_@ (dir), _@ (pos), _@ (wp.pos));
	var int f; f = divf (mkf (95), mkf (100));
	MulVector (_@ (dir), f);

//enum zTTraceRayFlags {
	const int zTRACERAY_VOB_IGNORE_NO_CD_DYN = 1 << 0;
	const int zTRACERAY_VOB_IGNORE = 1 << 1;
	const int zTRACERAY_VOB_BBOX = 1 << 2;
	const int zTRACERAY_VOB_OBB = 1 << 3;
	const int zTRACERAY_STAT_IGNORE = 1 << 4;
	const int zTRACERAY_STAT_POLY = 1 << 5;
	const int zTRACERAY_STAT_PORTALS = 1 << 6;
	const int zTRACERAY_POLY_NORMAL = 1 << 7;
	const int zTRACERAY_POLY_IGNORE_TRANSP = 1 << 8;
	const int zTRACERAY_POLY_TEST_WATER = 1 << 9;
	const int zTRACERAY_POLY_2SIDED = 1 << 10;
	const int zTRACERAY_VOB_IGNORE_CHARACTER = 1 << 11;
	const int zTRACERAY_FIRSTHIT = 1 << 12;
	const int zTRACERAY_VOB_TEST_HELPER_VISUALS = 1 << 13;

	//G2A only!
	const int zTRACERAY_VOB_IGNORE_PROJECTILES = 1 << 14;
//};

	var int retVal; retVal = !zCWorld_TraceRayFirstHit (_@ (wp.pos), _@ (dir), ignoreListPtr, zTRACERAY_STAT_POLY | zTRACERAY_POLY_IGNORE_TRANSP);

	MEM_ArrayFree (ignoreListPtr);

	return + retVal;
};

/*
 *	WP_CanSee
 *	 - can we see vob from waypoint?
 */
func int WP_CanSee (var string waypointName, var int vobPtr) {
	var int wpPtr; wpPtr = SearchWaypointByName (waypointName);
	return + zCWaypoint_CanSee (wpPtr, vobPtr);
};

func int oCAniCtrl_Human_DetectChasm (var int aniCtrlPtr, var int posPtr, var int dirPtr, var int distPtrF, var int cdNormalPtr) {
	//0x0062D2F0 public: int __thiscall oCAniCtrl_Human::DetectChasm(class zVEC3 const &,class zVEC3 const &,float &,class zVEC3 &)
	const int oCAniCtrl_Human__DetectChasm_G1 = 6476528;

	//0x006B6A90 public: int __thiscall oCAniCtrl_Human::DetectChasm(class zVEC3 const &,class zVEC3 const &,float &,class zVEC3 &)
	const int oCAniCtrl_Human__DetectChasm_G2 = 7039632;

	if (!aniCtrlPtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (cdNormalPtr));
		CALL_FloatParam (_@ (distPtrF));
		CALL_PtrParam (_@ (dirPtr));
		CALL_PtrParam (_@ (posPtr));
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__DetectChasm_G1, oCAniCtrl_Human__DetectChasm_G2));
		call = CALL_End();
	};
	return + retVal;
};

func int Npc_DetectChasm (var int slfInstance, var int posPtr, var int dirPtr, var int distF, var int cdNormalPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (!slf.aniCtrl) { return FALSE; };

	return + oCAniCtrl_Human_DetectChasm (slf.aniCtrl, posPtr, dirPtr, distF, cdNormalPtr);
};

/*
 *	WP_GenerateNewName
 *	 - WP_GenerateNewName ("WP_3")); //Output "WP_004"
	 - WP_GenerateNewName ("WP_002")); //Output "WP_003"
	 - WP_GenerateNewName ("WP")); //Output "WP_001"
 */
func string WP_GenerateNewName (var string waypointName) {
	var int i;
	var int len; len = STR_Len (waypointName);

	i = len;

	while (i > 0);
		if (Hlp_StrCmp (mySTR_SubStr (waypointName, i, 1), "_")) {
			break;
		};

		i -= 1;
	end;

	var string s;
	var int index; index = 1;

	if (i > 0) {
		s = mySTR_SubStr (waypointName, i + 1, STR_Len (waypointName) - i + 1);
		if (STR_IsNumeric (s)) {
			index = STR_ToInt (s);
			index += 1;
		} else {
			i = len;
		};
	} else {
		i = len;
	};

	s = IntToString (index);

	if (index < 10) {
		s = ConcatStrings ("00", s);
	} else
	if (index < 100) {
		s = ConcatStrings ("0", s);
	};

	if (i < len) {
		waypointName = mySTR_SubStr (waypointName, 0, i + 1);
	} else {
		waypointName = ConcatStrings (waypointName, "_");
	};

	waypointName = ConcatStrings (waypointName, s);
	return waypointName;
};

/*
 *	zCVobWaypoint_GetByPortalRoom
 *	 - *requires* initialization of G12_VobWaypoints_Init () from Init_Global () !
 *
 *	 - search vobWaypoint from position
 *	 - allows more precise waypoint search - by using VobWaypoints - we can search fairly quickly
 *
 *	Parameters:
 *	 - fromPosPtr - position from which vobs will be collected
 *	 - searchByPortalName - portal in which vobWaypoint has to be located
 *	 - searchFlags - supported flags: SEARCHVOBLIST_CANSEE (checks if canSeeVobPtr is visible from waypoint)
 *	 - canSeeVobPtr - not required - only in combination with searchFlags: SEARCHVOBLIST_CANSEE
 *	 - range - in which vobs will be collected
 *	 - distLimit - max air distance to the vob
 *	 - verticalLimit - max vertical distance to the vob
 */
func int zCVobWaypoint_GetByPortalRoom (var int fromPosPtr, var string searchByPortalName, var int searchFlags, var int canSeeVobPtr, var int range, var int distLimit, var int verticalLimit) {
	var int i;
	var int vobPtr;

	var int dist;
	var int maxDist; maxDist = 999999;

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int canSee;

	if (!fromPosPtr) { return 0; };

	var int fromPos[3];
	MEM_CopyBytes (fromPosPtr, _@ (fromPos), 12);

	//Target position
	var int toPos[3];

	searchByPortalName = STR_Trim (searchByPortalName, " ");
	searchByPortalName = STR_Upper (searchByPortalName);

	var int checkPortalName; checkPortalName = STR_Len (searchByPortalName);

	//Collect all vobs in range
	var int arrPtr; arrPtr = Wld_CollectVobsInRange (fromPosPtr, mkf (range));
	if (!arrPtr) { return 0; };

	var zCArray vobList; vobList = _^ (arrPtr);
	repeat (i, vobList.numInArray);
		vobPtr = MEM_ReadIntArray (vobList.array, i);

		if (Hlp_Is_zCVobWaypoint (vobPtr)) {
			if (searchFlags & SEARCHVOBLIST_CANSEE) {
				var int wpPtr; wpPtr = zCVobWaypoint_GetWaypoint (vobPtr);
				canSee = zCWaypoint_CanSee (wpPtr, canSeeVobPtr);
			} else {
				canSee = TRUE;
			};

			if (checkPortalName) {
				var string portalName; portalName = Vob_GetPortalName (vobPtr);

				if (!Hlp_StrCmp (portalName, searchByPortalName)) {
					canSee = FALSE;
				};
			};

			if (canSee) {
				if (zCVob_GetPositionWorldToPos (vobPtr, _@ (toPos))) {
					var int verticalDist; verticalDist = RoundF (SubF (toPos[1], fromPos[1]));

					if ((abs (verticalDist) < verticalLimit) || (verticalLimit == -1)) {
						var int dir[3];
						SubVectors (_@ (dir), _@ (fromPos), _@ (toPos));
						dist = zVEC3_LengthApprox (_@ (dir));
						dist = RoundF (dist);

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

	MEM_Free (arrPtr);

	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};

func int zCWaypoint_GetByPosAndPortalRoom (var int fromPosPtr, var string searchByPortalName, var int searchFlags, var int canSeeVobPtr, var int range, var int distLimit, var int verticalLimit) {
	var int vobPtr; vobPtr = zCVobWaypoint_GetByPortalRoom (fromPosPtr, searchByPortalName, searchFlags, canSeeVobPtr, range, distLimit, verticalLimit);
	return + zCVobWaypoint_GetWaypoint (vobPtr);
};

/*
 *	WP_GetByPortalRoom
 *	 - wrapper function to get nearest waypoint from certain position + possibility to filter by portal room
 */
func string WP_GetByPosAndPortalRoom (var int fromPosPtr, var string searchByPortalName, var int searchFlags, var int canSeeVobPtr, var int range, var int distLimit, var int verticalLimit) {
	var int wpPtr; wpPtr = zCWaypoint_GetByPosAndPortalRoom (fromPosPtr, searchByPortalName, searchFlags, canSeeVobPtr, range, distLimit, verticalLimit);
	return zCWaypoint_GetName (wpPtr);
};

/*
 *	Npc_GetNearestWP_ByPortalRoom
 *	 - wrapper function to get nearest waypoint from Npc in a portal room
 */
func string Npc_GetNearestWP_ByPortalRoom (var int slfInstance, var string searchByPortalName, var int searchFlags, var int range, var int distLimit, var int verticalLimit) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	var int pos[3];
	if (!zCVob_GetPositionWorldToPos (_@ (slf), _@ (pos))) { return ""; };

	return WP_GetByPosAndPortalRoom (_@ (pos), searchByPortalName, searchFlags, _@ (slf), range, distLimit, verticalLimit);
};

/*
 *	G12_VobWaypoints_Init
 *	 - this will create vob waypoints
 *	 - we can use vobWaypoints to detect waypoints by using Wld_CollectVobsInRange - without looping through waynet
 *	 - also we can use vobWaypoints to detect portal room in which waypoints are available
 */
func void G12_VobWaypoints_Init () {
	zCWayNet_ClearVobDependencies ();
	zCWayNet_CreateVobDependencies (_@ (MEM_World));
};
