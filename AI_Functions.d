/*
 *	AI functions
 *	 - dependencies:
		EngineClasses_G1/2\zEventMan.d
		EngineClasses_G1/2\zCVobSpot.d

		vectors.d
		vobFunctions.d

		ScriptBin\insertAnything.d

		ObjectFactory\oCMsgMovement.d
		ObjectFactory\oCMsgManipulate.d

		eventManager_engine.d
		eventManager.d

		world_engine.d
 */

/*
 *	AI_TurnToPos
 *	 - same as AI_TurnToNPC, but allows us to use position
 */
func void AI_TurnToPos (var int slfInstance, var int posPtr) {
/*
	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	slf.soundPosition[0] = MEM_ReadIntArray(posPtr, 0);
	slf.soundPosition[1] = MEM_ReadIntArray(posPtr, 1);
	slf.soundPosition[2] = MEM_ReadIntArray(posPtr, 2);

	AI_TurnToSound (slf);
*/
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!posPtr) { return; };

	//Create new message
	var int eMsg; eMsg = oCMsgMovement_Create (EV_TURNTOPOS, "", 0, posPtr, mkf (0), 0);

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	AI_TurnAwayPos
 *	 - same as AI_TurnAway, but allows us to use position
 */
func void AI_TurnAwayPos (var int slfInstance, var int posPtr) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!posPtr) { return; };

	var int posSelf[3];	//position - slf
	var int dir[3];		//direction - slf - wp

	var int pos[3];		//position - vob
	copyVector (posPtr, _@ (pos));

	//get position of slf
	TrfToPos (_@ (slf._zCVob_trafoObjToWorld), _@ (posSelf));

	//subtract posSelf from pos - to get 'direction vector'
	SubVectors (_@ (dir), _@(pos), _@ (posSelf));

	//subtract direction vector from posSelf - should be basically pos rotated by 180 around self pos
	SubVectors (_@ (pos), _@ (posSelf), _@ (dir));

	AI_TurnToPos (slf, _@ (pos));
};

/*
 *	AI_TurnToWP
 *	 - same as AI_TurnToNPC, but allows us to use vob waypoint
 */
func void AI_TurnToWP (var int slfInstance, var string waypoint) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int wpPtr; wpPtr = SearchWaypointByName (waypoint);
	if (!wpPtr) { return; };

	var zCWaypoint wp; wp = _^ (wpPtr);
	AI_TurnToPos (slf, _@ (wp.pos));
};

/*
	AI_TurnAwayWP
	 - same as AI_TurnAway, but allows us to use waypoint

							[waypoint]
						/
					/
				[self]			([dir vector] = [waypoint] - [self])
			/
		/
	[pos]						(pos = [self] - [dir vector])
*/
func void AI_TurnAwayWP (var int slfInstance, var string waypoint) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int wpPtr; wpPtr = SearchWaypointByName (waypoint);

	if (!wpPtr) { return; };

	var zCWaypoint wp; wp = _^ (wpPtr);
	AI_TurnAwayPos (slf, _@ (wp.pos));
};

/*
 *	AI_TurnToVobPtr
 *	 - same as AI_TurnToNPC, but allows us to use vob pointer
 */
func void AI_TurnToVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);

	var int pos[3];
	TrfToPos (_@(vob.trafoObjToWorld), _@ (pos));

	AI_TurnToPos (slf, _@ (pos));
};

/*
 *	AI_TurnAwayVobPtr
 *	 - same as AI_TurnAway, but allows us to use vob pointer
 */
func void AI_TurnAwayVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);

	var int pos[3];		//position - vob
	TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));

	AI_TurnAwayPos (slf, _@ (pos));
};

/*
 *	AI_GotoPos
 *	 - same as AI_GotoNPC, but allows us to define position to which NPC should walk to
 */
func void AI_GotoPos (var int slfInstance, var int posPtr) {
/*
	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	slf.soundPosition[0] = MEM_ReadIntArray(posPtr, 0);
	slf.soundPosition[1] = MEM_ReadIntArray(posPtr, 1);
	slf.soundPosition[2] = MEM_ReadIntArray(posPtr, 2);

	AI_GotoSound (slf);
*/
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!posPtr) { return; };

	//Create new message
	var int eMsg; eMsg = oCMsgMovement_Create (EV_GOTOPOS, "", 0, posPtr, mkf (0), 0);

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	AI_GotoVobPtr_EvalWaynetUse
 *	 - function evaluates whether to use or not waynet system to navigate to vob (this way Npc should be behaving slightly more inteligent)
 *
 *	Rules:
 *	 - Npc has to be standing close to waypoint (x meters), waypoint has to be visible to Npc
 *	 - vob has to be close to waypoint (x meters), waypoint has to be visible to vob
 *	 - if vob is visible to Npc - then waynet distance cannot be longer than 120% of 'air' distance to vob
 *	 - if any chasm is detected - then waynet will be used by default
 *	 - if vob is not visible to Npc - then waynet will be used by default
 */

func void AI_GotoVobPtr_EvalWaynetUse (var int slfInstance, var int vobPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);

	//zSpy_Info ("--> AI_GotoVobPtr_EvalWaynetUse");


	var int posNpc[3];
	var int posVob[3];

	if (!zCVob_GetPositionWorldToPos (_@ (slf), _@ (posNpc)))
	|| (!zCVob_GetPositionWorldToPos (vobPtr, _@ (posVob)))
	{
		return;
	};

	//-- Get nearest waypoint to vob
	//var string toWp; toWp = WP_GetNearestWPAtVob (vobPtr);

	var string toWp; toWp = WP_GetByPosAndPortalRoom (_@ (posVob), "", SEARCHVOBLIST_CANSEE, vobPtr, 500, 500, 400);

	//if vob is not visible from waypoint ... ignore
	if (!STR_Len (toWp)) {
		//zSpy_Info ("... target waypoint - can't see vob. Waynet might not be reliable.");
		//zSpy_Info ("<--");
		return;
	};

	var int wpDistToVob;
	wpDistToVob = WP_GetDistToVob (toWp, vobPtr); //float
	wpDistToVob = RoundF (wpDistToVob);

	//-- Get nearest waypoint to Npc
	//var string fromWp; fromWp = WP_GetNearestWPAtVob (_@ (slf));
	var string fromWp; fromWp = WP_GetByPosAndPortalRoom (_@ (posNpc), "", SEARCHVOBLIST_CANSEE, _@ (slf), 500, 500, 400);

	//if vob is not visible from waypoint ... ignore
	if (!STR_Len (fromWp)) {
		//zSpy_Info ("... npc waypoint - can't see npc. Waynet might not be reliable.");
		//zSpy_Info ("<--");
		return;
	};

	var int wpDistToNpc;
	wpDistToNpc = WP_GetDistToVob (fromWp, _@ (slf)); //float
	wpDistToNpc = RoundF (wpDistToNpc);

	//-- Get 'air' distance to vob
	var int distToVob;
	distToVob = zCVob_GetDistanceToVob (_@ (slf), vobPtr); //float

	var int npcDistToVobWp;
	npcDistToVobWp = Npc_GetDistToWP (slf, toWp); //int

	var int vobDistToFromWp;
	vobDistToFromWp = WP_GetDistToVob (fromWp, vobPtr); //float

//-- Evaluate waynet route

	//multiply by 120%
	var int distToVobTolerance; distToVobTolerance = distToVob;
	distToVobTolerance = mulf (distToVobTolerance, mkf (120));
	distToVobTolerance = divf (distToVobTolerance, mkf (100));
	distToVobTolerance = RoundF (distToVobTolerance);

	var int fromWpPtr; fromWpPtr = SearchWaypointByName (fromWp);
	var int toWpPtr; toWpPtr = SearchWaypointByName (toWp);

	var int routePtr;
	routePtr = zCWayNet_FindRoute_Waypoints (fromWpPtr, toWpPtr, 0);

	var int distWaynet;
	distWaynet = zCRoute_GetLength (routePtr); //float
	distWaynet = RoundF (distWaynet);

	var int isTooFar; isTooFar = (distWaynet > distToVobTolerance);

	//zSpy_Info (ConcatStrings ("... dist air: ", IntToString (RoundF (distToVob))));
	//zSpy_Info (ConcatStrings ("... dist tolerance (120% air dist): ", IntToString (distToVobTolerance)));
	//zSpy_Info (ConcatStrings ("... dist waynet: ", IntToString (distWaynet)));
	//zSpy_Info (ConcatStrings ("... ", zCRoute_GetDesc (routePtr)));

//-- Detect chasms

	/*
	 *	Here we will create waypoint - move it towards vob and detect possible issues with ground. (chasm detection)
	 *	It is more convenient to use waypoint, because we can move it around and use zCWaypoint_CorrectHeight to easily align it to ground.
	 */

	var int dir[3];

	var int chasmDetected; chasmDetected = 0;

	//Get direction vector (total distance)
	SubVectors (_@ (dir), _@ (posVob), _@ (posNpc));

	//Copy vector - we will use vec to move waypoint towards vob
	var int vec[3];
	CopyVector (_@ (dir), _@ (vec));

	//Normalize vector
	zVEC3_NormalizeSafe (_@ (vec));

	//Multiply by 50 (to get 0.5 m length)
	MulVector (_@ (vec), mkf (50));

	//Waypoint pointer
	var int wpPtr; wpPtr = 0;

	var int lastPos[3];
	var int newPos[3];

	var int i; i = 0;

	var int newDistToVob;

	CopyVector (_@ (posNpc), _@ (newPos));

	//Debugging - generate and leave waypoints for investigation :)
	const int Debug_GenerateWaypoints = 0;

	var string wpName;
	if (!STR_Len (wpName)) {
		wpName = "WP_TEMP_DETECTCHASM_001";
	};

	while (true);
		var zCWaypoint wp;

		if (Debug_GenerateWaypoints) {
			//Create new waypoint
			if (i == 0) {
				//First waypoint
				wpPtr = zCWayNet_GetNearestWaypoint (_@ (posNpc));
			} else {
				//Generate new name
				wpName = WP_GenerateNewName (wpName);
			};

			wpPtr = WP_Create (wpName, _@ (newPos), wpPtr);
			wp = _^ (wpPtr);

			//Get last position of waypoint
			CopyVector (_@ (wp.pos), _@ (lastPos));
		} else {
			//Create single waypoint
			if (!wpPtr) {
				wpPtr = WP_Create (wpName, _@ (newPos), 0);
				wp = _^ (wpPtr);
			};
		};

		//Move waypoint towards vob
		AddVectors (_@ (wp.pos), _@ (wp.pos), _@ (vec));

		//Correct waypoint height - align to ground properly
		zCWaypoint_CorrectHeight (wpPtr);

		//Get new position of waypoint
		CopyVector (_@ (wp.pos), _@ (newPos));

		//Get vector from Npc to new position of waypoint (to get length)
		SubVectors (_@ (dir), _@ (newPos), _@ (posNpc));

		//Get length
		var int distNew; distNew = zVEC3_LengthApprox (_@ (dir));

		//If we are behind vob position - we can exit loop - no chasms detected so far
		if (gef (distNew, distToVob)) {
			break;
		};

		//Detect chasms underneath waypoint
		dir[0] = FLOATNULL;
		dir[1] = mkf (100);
		dir[2] = FLOATNULL;

		var int distF; distF = mkf (100);
		var int cdNormal[3];

		//oCAniCtrl_Human_DetectChasm (var int aniCtrlPtr, var int posPtr, var int dirPtr, var int distPtrF, var int cdNormalPtr) {
		chasmDetected = oCAniCtrl_Human_DetectChasm (slf.aniCtrl, _@ (newPos), _@ (dir), _@ (distF), _@ (cdNormal));

		//Chasm detected - exit loop
		if (chasmDetected) {
			break;
		};

		if (Debug_GenerateWaypoints) {
			//zSpy_Info (ConcatStrings ("... chasmDetected", IntToString (chasmDetected)));
			//zSpy_Info (ConcatStrings ("... distF", toStringF (distF)));

			if (i > 0) {
				var int heightDelta;
				var int lastHeightDelta;

				heightDelta = roundf (subf (lastPos[1], newPos[1]));

				//heightDelta = heightDelta - lastHeightDelta;

				//zSpy_Info (ConcatStrings ("... height check ", IntToString (heightDelta)));

				if (abs (heightDelta) > 50) {
					chasmDetected = TRUE;
					//break;
				};
			};

			lastHeightDelta = heightDelta;

			CopyVector (_@ (wp.pos), _@ (newPos));
		};

		i += 1;
	end;

	if (!Debug_GenerateWaypoints) {
		//Delete waypoint
		zCWayNet_DeleteWaypoint_ByPtr (wpPtr);
	} else {
		//Connect last waypoint to vob waypoint
		if (!chasmDetected) {
			zCWayNet_CreateWay (wpPtr, SearchWaypointByName (toWp));
		};
	};

//--
	if (!chasmDetected) {
		//if waypoint is too far from vob & it is not on the way to vob ... ignore
		if ((wpDistToVob > 300) && (npcDistToVobWp > RoundF (distToVob))) {
			//zSpy_Info ("... target waypoint too far");
			//zSpy_Info ("<--");
			return;
		};

		//if waypoint is too far from Npc & it is not on the way to vob ... ignore
		if ((wpDistToNpc > 300) && (RoundF (vobDistToFromWp) > RoundF (distToVob))) {
			//zSpy_Info ("... npc waypoint too far");
			//zSpy_Info ("<--");
			return;
		};

		//If Npc can see vob - and if waynet navigation is longer then air distance - ignore ...
		if (oCNpc_CanSee (slfInstance, vobPtr, 1) && isTooFar) {
			//zSpy_Info ("... npc can see vob + distance through waynet navigation > air distance");
			//zSpy_Info ("<--");
			return;
		};

		if (isTooFar) {
			//zSpy_Info ("... distance through waynet navigation > air distance ... but npc can't see vob - using waynet");
		};
	} else {
		//zSpy_Info ("... chasm detected!");
	};

	if ((!Hlp_StrCmp (fromWp, toWp)) || isTooFar || chasmDetected) {
		//var string s; s = "... navigating using waynet, from: ";
		//s = ConcatStrings (s, fromWp);
		//s = ConcatStrings (s, " to: ");
		//s = ConcatStrings (s, toWp);
		//zSpy_Info (s);

		AI_GotoWp (slf, toWp);
	};

	//zSpy_Info ("<--");
};

/*
 *	AI_GotoFpPtr
 *	 - same as AI_GotoFP, but allows us to define freePoint pointer
 */
func void AI_GotoFpPtr (var int slfInstance, var int vobSpotPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!Hlp_Is_zCVobSpot (vobSpotPtr)) { return; };

	AI_GotoVobPtr_EvalWaynetUse (slfInstance, vobSpotPtr);

	//Flag temporarily as used - so no other NPC will try to go to the same freePoint
	var int timeDeltaF; timeDeltaF = mkf (6000);
	var int vobPtr; vobPtr = _@ (slf);

//func void zCVobSpot_MarkAsUsed (var int vobSpotPtr, var int timeDeltaF, var int vobPtr) {
	//0x007094A0 public: void __thiscall zCVobSpot::MarkAsUsed(float,class zCVob *)
	const int zCVobSpot__MarkAsUsed_G1 = 7378080;

	//0x007B31A0 public: void __thiscall zCVobSpot::MarkAsUsed(float,class zCVob *)
	const int zCVobSpot__MarkAsUsed_G2 = 8073632;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_FloatParam (_@ (timeDeltaF));
		CALL__thiscall (_@ (vobSpotPtr), MEMINT_SwitchG1G2 (zCVobSpot__MarkAsUsed_G1, zCVobSpot__MarkAsUsed_G2));
		call = CALL_End();
	};
//};

	var zCVobSpot vobSpot; vobSpot = _^ (vobSpotPtr);

	//Create new message
	//EV_GOTOFP does not save targetVob into savefile! we have to use targetName
	var int eMsg; eMsg = oCMsgMovement_Create (EV_GOTOFP, vobSpot._zCObject_objectName, vobSpotPtr, 0, mkf (0), 0);

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	AI_GotoVobPtr
 *	 - same as AI_GotoNPC, but allows us to use any vob pointer
 */
func void AI_GotoVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);

	var int pos[3];
	TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));

	AI_GotoVobPtr_EvalWaynetUse (slfInstance, vobPtr);
	AI_GotoPos (slf, _@ (pos));
};

func void _AI_TeleportKeepQueue (var string vobName) {
	self = _^ (ECX); //wont be required with future LeGo version (> 2.7.1)

	var int pos[3];

	var zCVob vob;
	var int vobPtr;

	//Search for vob Name
	vobPtr = MEM_SearchVobByName (vobName);

	//if vob does not exist - search for waypoint
	if (!vobPtr) {
		var int wpPtr; wpPtr = SearchWaypointByName (vobName);

		//if waypoint does not exist - exit
		if (!wpPtr) { return; };

		var zCWaypoint wp; wp = _^ (wpPtr);
		copyVector (_@ (wp.pos), _@ (pos));
	} else {
		vob = _^ (vobPtr);
		TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));
	};

	vob = Hlp_GetNPC (self);

	//Update hero's position
	//TODO: teleport to Vob needs to be updated
	vob.trafoObjToWorld[3] = pos[0];
	vob.trafoObjToWorld[7] = pos[1];
	vob.trafoObjToWorld[11] = pos[2];

	Wld_PlayEffect ("SPELLFX_TELEPORT_RING", hero, hero, 0, 0, 0, FALSE);
};

func string _AI_GetAniName_T_MAGRUN_2_HEASHOOT () {
	//G1 version has much cooler teleportation animation with particle effects ;-)
	if (MEMINT_SwitchG1G2 (1, 0)) {
		return "T_STAND_2_TELEPORT";
	};

	//G2A teleportation animation
	return "T_MAGRUN_2_HEASHOOT";
};

func string _AI_GetAniName_T_HEASHOOT_2_STAND () {
	//G1 version has much cooler teleportation animation with particle effects ;-)
	if (MEMINT_SwitchG1G2 (1, 0)) {
		return "T_TELEPORT_2_STAND";
	};

	//G2A teleportation animation
	return "T_HEASHOOT_2_STAND";
};

/*
 *	AI_TeleportKeepQueue
 *	 - function performs teleportation without clearing AI queue (use carefully!)
 */
func void AI_TeleportKeepQueue (var int slfInstance, var string vobName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	AI_PlayAni (slf, _AI_GetAniName_T_MAGRUN_2_HEASHOOT ());
	AI_Function_S (slf, _AI_TeleportKeepQueue, vobName);
	AI_PlayAni (slf, _AI_GetAniName_T_HEASHOOT_2_STAND ());
};

/*
 *	AI_TeleportToWorld
 *	 - function allows teleportation between worlds
 */
func void AI_TeleportToWorld (var int slfInstance, var string levelName, var string vobName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var string thisLevelName; thisLevelName = oCWorld_GetWorldFilename ();

	if (Hlp_StrCmp (thisLevelName, levelName)) {
		AI_TeleportKeepQueue (slfInstance, vobName);
	} else {
		AI_PlayAni (slf, _AI_GetAniName_T_MAGRUN_2_HEASHOOT ());
		AI_Function_SS (slf, oCGame_TriggerChangeLevel, levelName, vobName);
	};
};

/*
 *	An alternative that will turn to vob only when not within acceptable angle
 */
func void AI_TurnToVobPtrAngleX (var int slfInstance, var int vobPtr, var int angle) {
	var int angleX; var int angleXPtr; angleXPtr = _@ (angleX);
	var int angleY; var int angleYPtr; angleYPtr = _@ (angleY);

//func void oCNpc_GetAnglesVob (var int slfInstance, var int vobPtr, var int angleXPtr, var int angleYPtr) {
	//0x0074C0D0 public: void __thiscall oCNpc::GetAngles(class zCVob *,float &,float &)
	const int oCNPC__GetAnglesVob_G1 = 7651536;

	//0x00681680 public: void __thiscall oCNpc::GetAngles(class zCVob *,float &,float &)
	const int oCNPC__GetAnglesVob_G2 = 6821504;

	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {

		CALL_PtrParam (_@ (angleYPtr));
		CALL_PtrParam (_@ (angleXPtr));

		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__GetAnglesVob_G1, oCNPC__GetAnglesVob_G2));
		call = CALL_End();
	};
//};

//func int NPC_IsVobPtrInAngleX (var int slfInstance, var int vobPtr, var int angle) {
//	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
//	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

//	if (!vobPtr) { return FALSE; };

//	var int angleX;
//	var int angleY;

//	oCNpc_GetAnglesVob (slfInstance, vobPtr, _@ (angleX), _@ (angleY));

	if (gef (angleX, negf (mkf (angle))))
	&& (lef (angleX, mkf (angle)))
	{
		return;
	};

	AI_TurnToVobPtr (slfInstance, vobPtr);
};

/*
 *	Scans for ideal positions, finds free positions and sends there NPC
 *	Function returns TRUE if successfull, FALSE if not
 */
func int AI_GotoMobPtr (var int slfInstance, var int mobPtr) {
//func void oCMobInter_ScanIdealPositions (var int mobPtr) {
	//0x0067C9C0 protected: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G1 = 6801856;

	//0x0071DC30 public: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G2 = 7461936;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return FALSE; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__ScanIdealPositions_G1, oCMobInter__ScanIdealPositions_G2));
		call = CALL_End();
	};
//};

/*
//func int oCMobInter_SearchFreePosition (var int mobPtr, var int slfInstance) {
	var int freePosPtr;

	//0x0067CD60 protected: virtual struct TMobOptPos * __thiscall oCMobInter::SearchFreePosition(class oCNpc *)
	const int oCMobInter__SearchFreePosition_G1 = 6802784;

	//0x0071DFC0 public: virtual struct TMobOptPos * __thiscall oCMobInter::SearchFreePosition(class oCNpc *,float)
	const int oCMobInter__SearchFreePosition_G2 = 7462848;

	var int rangeF; rangeF = mkf (1000);

	const int call2 = 0;
	if (CALL_Begin(call2)) {
		//G2A has 1 extra parameter - I assume range
		if (MEMINT_SwitchG1G2 (0, 1)) {
			CALL_PtrParam (_@ (rangeF));
		};

		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SearchFreePosition_G1, oCMobInter__SearchFreePosition_G2));
		call2 = CALL_End();
	};

	freePosPtr = CALL_RetValAsPtr ();
//};

	if (!freePosPtr) { return FALSE; };


//class TMobOptPos {
//	var int trafo[16];	//zMAT4
//	var int distance;	//int
//	var int npc;		//oCNpc*
//	var string nodeName;	//zSTRING
//};

	//TMobOptPos.trafo is at offset 0, so we can read trafo directly from freePosPtr
	var int pos[3];
	TrfPosToVector (freePosPtr, _@ (pos));
	AI_GotoPos (slf, _@ (pos));
*/

//func int oCMobInter_GetFreePosition (var int mobPtr, var int slfInstance, var int vecPtr) {
	//0x0067CD00 public: int __thiscall oCMobInter::GetFreePosition(class oCNpc *,class zVEC3 &)
	const int oCMobInter__GetFreePosition_G1 = 6802688;

	//0x0071DF50 public: int __thiscall oCMobInter::GetFreePosition(class oCNpc *,class zVEC3 &)
	const int oCMobInter__GetFreePosition_G2 = 7462736;

	var int pos[3]; var int posPtr; posPtr = _@ (pos);

	const int call2 = 0;
	if (CALL_Begin(call2)) {
		CALL_PtrParam (_@ (posPtr));
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__GetFreePosition_G1, oCMobInter__GetFreePosition_G2));
		call2 = CALL_End();
	};

	var int retVal; retVal = CALL_RetValAsInt ();
//};

	if (!retVal) { return FALSE; };

	AI_GotoVobPtr_EvalWaynetUse (slfInstance, mobPtr);
	AI_GotoPos (slfInstance, _@ (pos));

	return TRUE;
};

/*
 *	Scans for ideal positions, finds position with specified nodeName and sends there NPC
 *	Function returns TRUE if successfull, FALSE if not
 */
func int AI_GotoMobPtrNodeName (var int slfInstance, var int mobPtr, var string nodeName) {
//func void oCMobInter_ScanIdealPositions (var int mobPtr) {
	//0x0067C9C0 protected: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G1 = 6801856;

	//0x0071DC30 public: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G2 = 7461936;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return FALSE; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__ScanIdealPositions_G1, oCMobInter__ScanIdealPositions_G2));
		call = CALL_End();
	};
//};

	var int pos[3];
	var int nodeNameFound; nodeNameFound = FALSE;

	//Search optimalPosList and find nodeName
	var oCMobInter mob; mob = _^ (mobPtr);

	var int ptr;
	var zCList list;
	ptr = mob.optimalPosList_next;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			var TMobOptPos mobOptPos;
			mobOptPos = _^ (ptr);

			//ZS_POS0_FRONT, ZS_POS0_BACK
			if (STR_EndsWith (mobOptPos.nodeName, nodeName)) {
				pos[0] = mobOptPos.trafo[03];
				pos[1] = mobOptPos.trafo[07];
				pos[2] = mobOptPos.trafo[11];

				nodeNameFound = TRUE;
				break;
			};
		};

		ptr = list.next;
	end;

	if (!nodeNameFound) { return FALSE; };

	AI_GotoVobPtr_EvalWaynetUse (slfInstance, mobPtr);
	AI_GotoPos (slfInstance, _@ (pos));

	return TRUE;
};

/*
 *
 */
func void _AI_MobSetIdealPosition () {
//func void NPC_MobSetIdealPosition (var int slfInstance) {
	//This function is called from AI_Function where ECX is pointer to NPC
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);

	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!slf.interactMob) { return; };

	//oCMobInter_ScanIdealPositions (slf.interactMob);

	var oCMobInter mob; mob = _^ (slf.interactMob);

	if (mob.optimalPosList_next) {
		var int ptr;
		var zCList list;

		ptr = mob.optimalPosList_next;

		while (ptr);
			list = _^ (ptr);
			ptr = list.data;

			if (ptr) {
				//TMobOptPos.trafo is at offset 0, so we can read trafo directly from ptr

				//AlignVobAt (_@ (slf), ptr); --> copying whole function here - in order to have this file 'standalone'

				var int trfPtr; trfPtr = ptr;
				var int vobPtr; vobPtr = _@ (slf);

				//0x005EE760 public: void __thiscall zCVob::SetTrafoObjToWorld(class zMAT4 const &)
				const int zCVob__SetTrafoObjToWorld_G1 = 6219616;

				//0x0061BC80 public: void __thiscall zCVob::SetTrafoObjToWorld(class zMAT4 const &)
				const int zCVob__SetTrafoObjToWorld_G2 = 6405248;

				// Lift collision
				var zCVob vob; vob = _^ (vobPtr);
				var int bits; bits = vob.bitfield[0];
				vob.bitfield[0] = vob.bitfield[0] & ~zCVob_bitfield0_collDetectionStatic & ~zCVob_bitfield0_collDetectionDynamic;

				const int call = 0;
				if (CALL_Begin(call)) {
					CALL_PtrParam(_@(trfPtr));
					CALL__thiscall(_@(vobPtr), MEMINT_SwitchG1G2(zCVob__SetTrafoObjToWorld_G1, zCVob__SetTrafoObjToWorld_G2));
					call = CALL_End();
				};

				// Restore bits
				vob.bitfield[0] = bits;
				//<--
				return;
			};

			ptr = list.next;
		end;
	};
//};
};

/*
 *	Function alligns NPC at ideal position of mob
 */
func void AI_MobSetIdealPosition (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	AI_Function (slf, _AI_MobSetIdealPosition);
};

/*
 *	Same as AI_Function - but using EV_CALLSCRIPT ... do we need this? :thinking:
 *	Advantage - self is set to NPC, other is always player ...
 *	Disadvantage - we don't have any parameters here!
 */
func void AI_CallFunc (var int slfInstance, var string funcName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Create new message
	funcName = STR_Upper (funcName);
	var int eMsg; eMsg = oCMsgManipulate_Create (EV_CALLSCRIPT, funcName, 0, -1, "", "");

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	Same as AI_UseMob - but you can specify vob pointer
 */
func void AI_UseMobPtr (var int slfInstance, var int vobPtr, var int targetState) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!Hlp_Is_oCMobInter (vobPtr)) { return; };

	//var oCMobInter mob; mob = _^ (vobPtr);

	//Create new message
	//var int eMsg; eMsg = oCMsgManipulate_Create (EV_USEMOB, mob.sceme, vobPtr, targetState, "", "");
	var int eMsg; eMsg = oCMsgManipulate_Create (EV_USEMOB, oCMobInter_GetScemeName (vobPtr), vobPtr, targetState, "", "");

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	Same as AI_UseMob - but you can specify vob pointer + additional action in name string (UNLOCK, LOCK)
 */
func void AI_UseMobPtr_Ext (var int slfInstance, var int vobPtr, var int targetState, var string name) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!Hlp_Is_oCMobInter (vobPtr)) { return; };

	//var oCMobInter mob; mob = _^ (vobPtr);

	//Create new message
	//var int eMsg; eMsg = oCMsgManipulate_Create (EV_USEMOB, mob.sceme, vobPtr, targetState, "", "");
	var int eMsg; eMsg = oCMsgManipulate_Create (EV_USEMOB, oCMobInter_GetScemeName (vobPtr), vobPtr, targetState, name, "");

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	Same as AI_DropItem - but you can specify vob pointer
 */
func void AI_DropVobPtr (var int slfInstance, var int vobPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!vobPtr) { return; };

	//Create new message
	var int eMsg; eMsg = oCMsgManipulate_Create (EV_DROPVOB, "", vobPtr, 0, "", "");

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	Allows item equipping using AI queue
 */
func void AI_EquipItemPtr (var int slfInstance, var int vobPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!vobPtr) { return; };

	//Create new message
	var int eMsg; eMsg = oCMsgManipulate_Create (EV_EQUIPITEM, "", vobPtr, 0, "", "");

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	Unequips melee weapon using AI queue
 */
func void AI_UnequipMeleeWeapon (var int slfInstance) {
	var int itemPtr; itemPtr = oCNpc_GetEquippedMeleeWeapon (slfInstance);
	if (itemPtr) {
		//Equipping equipped item will unequip it :)
		AI_EquipItemPtr (slfInstance, itemPtr);
	};
};

/*
 *	Unequips ranged weapon using AI queue
 */
func void AI_UnequipRangedWeapon (var int slfInstance) {
	var int itemPtr; itemPtr = oCNpc_GetEquippedRangedWeapon (slfInstance);
	if (itemPtr) {
		//Equipping equipped item will unequip it :)
		AI_EquipItemPtr (slfInstance, itemPtr);
	};
};

/*
 *	Same as AI_DrawWeapon, but allows you to specify target mode (also allows you to switch to fist mode)
 *	AI_DrawWeapon_Ext (slf, FMODE_FIST, 1); //Melee - fists
 *	AI_DrawWeapon_Ext (slf, FMODE_FIST, 0); //Melee
 *	AI_DrawWeapon_Ext (slf, FMODE_FAR, 0); //Ranged
 */
func void AI_DrawWeapon_Ext (var int slfInstance, var int targetMode, var int useFist) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Create new message
	var int eMsg; eMsg = oCMsgWeapon_Create (EV_DRAWWEAPON, targetMode, useFist);

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	AI_WhirlAroundToPos
 *	 - same as AI_WhirlAround, but allows us to use position
 */
func void AI_WhirlAroundToPos (var int slfInstance, var int posPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!posPtr) { return; };

	//Create new message
	var int eMsg; eMsg = oCMsgMovement_Create (EV_WHIRLAROUND, "", 0, posPtr, mkf (0), 0);

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
 *	AI_ResetStateTime
 *	 - resets state time - using AI queue
 */
func void _AI_ResetStateTime () {
	Npc_SetStateTime (self, 0);
};

func void AI_ResetStateTime (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	AI_Function (slf, _AI_ResetStateTime);
};

/*
 *	AI_SyncNpc
 *	 - function syncs AI queues
 */
func void AI_SyncNpc (var int slfInstance, var int othInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	var C_NPC oth; oth = Hlp_GetNPC (othInstance);

	AI_WaitTillEnd (slf, oth);
	AI_WaitTillEnd (oth, slf);
};

/*
 *	AI_DiaSync
 *	 - synchronizes AI queues for Npcs within dialogue
 */
func void AI_DiaSync () {
	if (!MEM_Game.infoman) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
	var C_NPC oth; oth = _^ (MEM_InformationMan.player);

	AI_SyncNpc (slf, oth);
};

/*
 *	AI_PutInSlot
 *	 - puts item into slot from inventory
 */
func void _AI_PutInSlot (var string slotName, var int itemInstanceID) {
	if (Npc_GetInvItem (self, itemInstanceID)) {
		oCNpc_PutInSlot_Fixed (self, slotName, _@ (item), 1);
	};
};

func void AI_PutInSlot (var int slfInstance, var string slotName, var int itemInstanceID) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	AI_Function_SI (slf, _AI_PutInSlot, slotName, itemInstanceID);
};

/*
 *	AI_CreateItemInSlot
 *	 - creates item and inserts it into slot
 */
func void _AI_CreateItemInSlot (var string slotName, var int itemInstanceID) {
	//CreateInvItem (self, itemInstanceID);
	//if (Npc_GetInvItem (self, itemInstanceID)) {
	//	var int itemPtr; itemPtr = _@ (item);
	//	itemPtr = oCNpc_RemoveFromInvByPtr (self, itemPtr, 1);
	//	oCNpc_PutInSlot_Fixed (self, slotName, itemPtr, 0);
	//};
	var string itemName; itemName = GetSymbolName (itemInstanceID);
	var int trafo[16];
	NewTrafo(_@(trafo));
	var int itemPtr; itemPtr = InsertItem (itemName, 1, _@ (trafo));
	oCNpc_PutInSlot_Fixed (self, slotName, itemPtr, 0);
};

func void AI_CreateItemInSlot (var int slfInstance, var string slotName, var int itemInstanceID) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	AI_Function_SI (slf, _AI_CreateItemInSlot, slotName, itemInstanceID);
};

/*
 *	AI_PutInInvFromSlot
 *	 - puts item from slot back to inventory
 */
func void _AI_PutInInvFromSlot (var string slotName) {
	var int itemPtr; itemPtr = oCNpc_RemoveFromSlot_Fixed (self, slotName, 0, 1);
	itemPtr = oCNpc_PutInInvPtr (self, itemPtr);
};

func void AI_PutInInvFromSlot (var int slfInstance, var string slotName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	AI_Function_S (slf, _AI_PutInInvFromSlot, slotName);
};

/*
 *	AI_RemoveItemFromSlot
 *	 - removes item from slot
 */
func void _AI_RemoveItemFromSlot (var string slotName) {
	var int itemPtr; itemPtr = oCNpc_RemoveFromSlot_Fixed (self, slotName, 1, 1);
	//var C_Item itm; itm = _^ (itemPtr);
	//Wld_RemoveItem (itm);
	RemoveoCVobSafe (itemPtr, 1);
};

func void AI_RemoveItemFromSlot (var int slfInstance, var string slotName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	AI_Function_S (slf, _AI_RemoveItemFromSlot, slotName);
};
