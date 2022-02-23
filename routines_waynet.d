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

// sizeof 20h
class zCWay {
	var int cost;	//int cost;          // sizeof 04h    offset 04h
	var int usedCtr;	//int usedCtr;       // sizeof 04h    offset 08h
	var int chasmDepth;	//float chasmDepth;  // sizeof 04h    offset 0Ch
	var int chasm;	//int chasm;         // sizeof 04h    offset 10h
	var int jump;	//int jump;          // sizeof 04h    offset 14h
	var int left;	//zCWaypoint* left;  // sizeof 04h    offset 18h
	var int right;	//zCWaypoint* right; // sizeof 04h    offset 1Ch
};

instance zCWay@ (zCWay);

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
 *	zCRoute_InitWayNode
 *	 - for some reason wayNode is un-initialized, so here we will initialize it
 *	 - we will also setup first target --> it should be starting waypoint
 */
func void zCRoute_InitWayNode (var int rt) {
	var zCRoute route; route = _^ (rt);
	if (!route.wayNode) {
		route.wayNode = route.wayList_next;
		route.target = route.startWp;
	};
};

//0x007069D0 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zSTRING const &,class zCVob const *)

func int zCWayNet_FindRoute_Positions (var int fromPosPtr, var int toPosPtr, var int vobPtr) {
	//0x007068D0 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zVEC3 const &,class zCVob const *)
	const int zCWayNet__FindRoute_G1 = 7366864;

	//0x007B04D0 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zVEC3 const &,class zCVob const *)
	const int zCWayNet__FindRoute_G2 = 8062160;

	if (!vobPtr) { return 0; };
	if (!toPosPtr) { return 0; };
	if (!fromPosPtr) { return 0; };
	if (!MEM_World.wayNet) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (toPosPtr));
		CALL_PtrParam (_@ (fromPosPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (MEM_World.wayNet), MEMINT_SwitchG1G2 (zCWayNet__FindRoute_G1, zCWayNet__FindRoute_G2));
		call = CALL_End ();
	};

	zCRoute_InitWayNode (retVal);
	return +retVal;
};

func int zCWayNet_FindRoute_PosToWp (var int fromPosPtr, var int toWaypointPtr, var int vobPtr) {
	//0x00706960 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zCWaypoint *,class zCVob const *)
	const int zCWayNet__FindRoute_G1 = 7366864;

	//0x007B0560 public: class zCRoute * __thiscall zCWayNet::FindRoute(class zVEC3 const &,class zCWaypoint *,class zCVob const *)
	const int zCWayNet__FindRoute_G2 = 8062304;

	if (!toWaypointPtr) { return 0; };
	if (!fromPosPtr) { return 0; };
	if (!MEM_World.wayNet) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (toWaypointPtr));
		CALL_PtrParam (_@ (fromPosPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (MEM_World.wayNet), MEMINT_SwitchG1G2 (zCWayNet__FindRoute_G1, zCWayNet__FindRoute_G2));
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

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (toWaypointPtr));
		CALL_PtrParam (_@ (fromWaypointPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (MEM_World.wayNet), MEMINT_SwitchG1G2 (zCWayNet__FindRoute_G1, zCWayNet__FindRoute_G2));
		call = CALL_End ();
	};

	zCRoute_InitWayNode (retVal);
	return +retVal;
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

	//Remember target
	var int target; target = rt.target;

	var int list; list = rt.wayNode;

	if (!list) { return 0; };

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
		var zCWaypoint nextWP;
		nextWP = _^ (nextWPPtr);
		return nextWP.name;
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

	//0x0074C7C0 public: void __thiscall oCNpc::SetRoute(class zCRoute *)
	const int oCNpc__SetRoute_G1 = 7653312;

	//0x00681D70 public: void __thiscall oCNpc::SetRoute(class zCRoute *)
	const int oCNpc__SetRoute_G2 = 6823280;

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (routePtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetRoute_G1, oCNpc__SetRoute_G2));
		call = CALL_End ();
	};
};

/*
 *	Function returns waypoint from last routine entry
 *	 - if there is no routine available, then function returns current routine entry waypoint
 */
func string NPC_GetLastRoutineWP (var int slfInstance) {
	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return ""; };

	var oCNPC_States state; state = _^ (statePtr);

	//If rtnBefore == rtnNow - then return blank string
	if (state.rtnBefore == state.rtnNow) { return ""; };

	var int rtnEntryPtr; rtnEntryPtr = state.rtnBefore;
	if (!rtnEntryPtr) { return ""; };

	var oCRtnEntry rtnEntry; rtnEntry = _^ (rtnEntryPtr);
	return rtnEntry.wpname;
};

/*
 *	Custom function for searching freepoints
 *	 - allows us to search for freepoints in specified rangeF
 *	 - parameter deprioritizeFreePoint will basically put freepoints with certain strings to the 'end of the list'
 *	   for example we can search for freepoints SMALLTALK and we can deprioritize those freepoints that also contain string _RAIN:
 *		vobSpotPtr = NPC_GetFreepoint (self, freePoint, "_RAIN", mkf (1200));
 *		function will prefer freePoint FP_SMALLTALK_XYZ before FP_SMALLTALK_RAIN_XYZ, however if freePoint FP_SMALLTALK_XYZ is marked as used ... function returns FP_SMALLTALK_RAIN_XYZ
 */
func int NPC_GetFreepoint (var int slfInstance, var string freePoint, var string deprioritizeFreePoint, var int rangeF) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	oCNpc_ClearVobList (slf);
	oCNpc_CreateVobList (slf, rangeF);

	var int vobPtr; vobPtr = _@ (slf);
	var int vobSpotPtr;

	var int dist;
	var int dist2;

	var int maxDist; maxDist = mkf (999999);
	var int maxDist2; maxDist2 = mkf (999999);

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;
	var int nearestPtr2; nearestPtr2 = 0;

	var int i; i = 0;

	while (i < slf.vobList_numInArray);
		vobSpotPtr = MEM_ReadIntArray (slf.vobList_array, i);
		if (Hlp_Is_zCVobSpot (vobSpotPtr)) {
			//Seems like engine still returns true when NPC is standing on freepoint
			if (zCVobSpot_IsAvailable (vobSpotPtr, vobPtr)) {
				var zCVobSpot vobSpot; vobSpot = _^ (vobSpotPtr);

				var int index1; index1 = STR_IndexOf (vobSpot._zCObject_objectName, freePoint);
				var int index2; index2 = STR_IndexOf (vobSpot._zCObject_objectName, deprioritizeFreePoint);

				//Matching freePoint name
				if (index1 > -1) {
					if (!firstPtr) { firstPtr = vobSpotPtr; };

					dist = NPC_GetDistToVobPtr (slfInstance, vobSpotPtr);

					if (lf (dist, maxDist)) {
						nearestPtr = vobSpotPtr;
						maxDist = dist;
					};
				};

				//Matching freePoint name (not matching deprioritizeFreePoint)
				if ((index1 > -1) && (index2 == -1) && (STR_Len (deprioritizeFreePoint) > 0)) {

					dist2 = NPC_GetDistToVobPtr (slfInstance, vobSpotPtr);

					if (lf (dist2, maxDist2)) {
						nearestPtr2 = vobSpotPtr;
						maxDist2 = dist2;
					};
				};
			};
		};
		i += 1;
	end;

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

	oCNpc_ClearVobList (slf);
	oCNpc_CreateVobList (slf, mkf (300)); //Is this far enough ?

	var int vobPtr; vobPtr = _@ (slf);
	var int vobSpotPtr;
	var int i; i = 0;

	while (i < slf.vobList_numInArray);
		vobSpotPtr = MEM_ReadIntArray (slf.vobList_array, i);
		if (Hlp_Is_zCVobSpot (vobSpotPtr)) {
			//Seems like engine still returns true when NPC is standing on freepoint
			if (zCVobSpot_IsAvailable (vobSpotPtr, vobPtr)) {
				var zCVobSpot vobSpot; vobSpot = _^ (vobSpotPtr);
				if (vobSpot.inUseVob == vobPtr) {
					return vobSpotPtr;
				};
			};
		};
		i += 1;
	end;

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

