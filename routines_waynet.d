/*
 *	Class definitions
 */
class oCRtnEntry {
	var int hour1; //int hour1;
	var int min1; //int min1;
	var int hour2; //int hour2;
	var int min2; //int min2;
	var int f_script; //int f_script;
	var string wpname; //zSTRING wpname;
	var int inst; //int instance;
	var int poi; //zCVob* poi;
	var int npc; //oCNpc* npc;
	var int cutscene; //oCRtnCutscene* cutscene;
	var int overlay; //int overlay;
};

instance oCRtnEntry@ (oCRtnEntry);

//As always no idea if this is correct conversion to primitive types :)
class oCRtnManager {
/*
	struct TRtn_WayBoxLimit {
	public:
	int begin;
	zTBBox3D bbox;
	float value;
	oCNpc* npc;

	// user API
	#include "oCRtnManager_TRtn_WayBoxLimit.inl"
	};
*/

/*
	struct TRtn_WayBox {
	public:
	zTBBox3D bbox;
	oCNpc* npc;
	int found;

	// user API
	#include "oCRtnManager_TRtn_WayBox.inl"
	};
*/

	var int indexStart[3];	//int
	var int indexEnd[3];	//int
	var int world;		//zCWorld*
	var int nextEntryNode;	//zCListSort<oCRtnEntry>*

	//zCListSort<oCRtnEntry> rtnList;
	var int rtnList_compare;
	var int rtnList_data;	//oCRtnEntry*
	var int rtnList_next;

	//zCListSort<TRtn_WayBox> wayboxListX;
	var int wayboxListX_compare;
	var int wayboxListX_data;
	var int wayboxListX_next;

	//zCListSort<TRtn_WayBox> wayboxListY;
	var int wayboxListY_compare;
	var int wayboxListY_data;
	var int wayboxListY_next;

	//zCListSort<TRtn_WayBox> wayboxListZ;
	var int wayboxListZ_compare;
	var int wayboxListZ_datal;
	var int wayboxListZ_next;

	//zCList<oCNpc> activeList;
	var int activeList_data;
	var int activeList_next;

	//zCArraySort<TRtn_WayBoxLimit*> wayboxList[3];
	var int wayboxList0_array;
	var int wayboxList0_numAlloc;
	var int wayboxList0_numInArray;
	var int wayboxList0_compare;

	var int wayboxList1_array;
	var int wayboxList1_numAlloc;
	var int wayboxList1_numInArray;
	var int wayboxList1_compare;

	var int wayboxList2_array;
	var int wayboxList2_numAlloc;
	var int wayboxList2_numInArray;
	var int wayboxList2_compare;
};

/*
 *	Global variables
 */

var oCRtnManager MEM_RtnMan;

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
 */
func void zCRoute_InitWayNode (var int rt) {
	var zCRoute route; route = _^ (rt);
	if (!route.wayNode) {
		route.wayNode = route.wayList_next;
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

	if (!vobPtr) { return 0; };
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

	if (!vobPtr) { return 0; };
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
