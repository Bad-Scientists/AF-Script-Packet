/*
 *	AI functions
 *	 - dependencies:
		EngineClasses_G1/2\zEventMan.d

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
func void AI_TurnToPos (var int slfinstance, var int posPtr) {
/*
	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
func void AI_TurnAwayPos (var int slfinstance, var int posPtr) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
 *	AI_TurnToVobPtr
 *	 - same as AI_TurnToNPC, but allows us to use vob waypoint
 */
func void AI_TurnToWP (var int slfinstance, var string waypoint) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
func void AI_TurnAwayWP (var int slfinstance, var string waypoint) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
func void AI_TurnToVobPtr (var int slfinstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
func void AI_TurnAwayVobPtr (var int slfinstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
func void AI_GotoPos (var int slfinstance, var int posPtr) {
/*
	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
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
 *	AI_GotoVobPtr
 *	 - same as AI_GotoNPC, but allows us to use any vob pointer
 */
func void AI_GotoVobPtr (var int slfinstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);

	var int pos[3];
	TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));

	AI_GotoPos (slf, _@ (pos));
};

func void _AI_TeleportKeepQueue (var string vobName) {
	self = _^ (ECX); //wont be required with future LeGo version (> 2.7.1)

	var int pos[3];

	var zCVob Vob;
	var int vobPtr;

	//Search for Vob Name
	vobPtr = MEM_SearchVobByName (vobName);

	//if Vob does not exist - search for waypoint
	if (!vobPtr) {
		var int wpPtr; wpPtr = SearchWaypointByName (vobName);

		//if waypoint does not exist - exit
		if (!wpPtr) { return; };

		var zCWaypoint wp;
		wp = _^ (wpPtr);
		copyVector (_@ (wp.pos), _@ (pos));
	} else {
		Vob = _^ (vobPtr);
		TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));
	};

	Vob = Hlp_GetNPC (self);

	//Update hero's position
	//TODO: teleport to Vob needs to be updated
	Vob.trafoObjToWorld[3] = pos[0];
	Vob.trafoObjToWorld[7] = pos[1];
	Vob.trafoObjToWorld[11] = pos[2];
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
func void AI_TeleportKeepQueue (var int slfinstance, var string vobName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	AI_PlayAni (slf, _AI_GetAniName_T_MAGRUN_2_HEASHOOT ());
	AI_Function_S (slf, _AI_TeleportKeepQueue, vobName);
	AI_PlayAni (slf, _AI_GetAniName_T_HEASHOOT_2_STAND ());
};

/*
 *	AI_TeleportToWorld
 *	 - function allows teleportation between worlds
 */
func void AI_TeleportToWorld (var int slfinstance, var string levelName, var string vobName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var string thisLevelName; thisLevelName = oCWorld_GetWorldFilename ();

	thisLevelName = STR_Upper (thisLevelName);
	levelName = STR_Upper (levelName);

	if (Hlp_StrCmp (thisLevelName, levelName)) {
		AI_TeleportKeepQueue (slfinstance, vobName);
	} else {
		AI_PlayAni (slf, _AI_GetAniName_T_MAGRUN_2_HEASHOOT ());
		AI_Function_SS (slf, oCGame_TriggerChangeLevel, levelName, vobName);
	};
};

/*
 *	An alternative that will turn to vob only when not within acceptable angle
 */
func void AI_TurnToVobPtrAngleX (var int slfinstance, var int vobPtr, var int angle) {
	var int angleX;
	var int angleY;

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

		CALL_PtrParam (_@ (angleY));
		CALL_PtrParam (_@ (angleX));

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

	AI_TurnToVobPtr (slfinstance, vobPtr);
};

/*
 *	Scans for ideal positions, finds free positions and sends there NPC
 *	Function returns TRUE if successfull, FALSE if not
 */
func int AI_GotoMobPtr (var int slfinstance, var int mobPtr) {
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

	AI_GotoPos (slf, _@ (pos));

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
