//0x004841A0 public: virtual void __thiscall zCAIBase::ReportCollisionToAI(class zCCollisionReport const &)
//0x00617E80 public: virtual void __thiscall oCAIVobMove::ReportCollisionToAI(class zCCollisionReport const &)

func void _hook_oCAIVobMove_ReportCollisionToAI () {
	PrintS ("_hook_oCAIVobMove_ReportCollisionToAI");
};

func void _hook_oCAIVobMoveTorch_DoAI () {
	//0x006182D0 protected: int __thiscall oCAIVobMoveTorch::CheckWater(void)
	const int oCAIVobMoveTorch__CheckWater_G1 = 6390480;

	const int oCAIVobMoveTorch__CheckWater_G2 = 0;

	var int checkWater;

	var int ai; ai = ECX;
	CALL__thiscall (ai, MEMINT_SwitchG1G2 (oCAIVobMoveTorch__CheckWater_G1, oCAIVobMoveTorch__CheckWater_G2));

	checkWater = CALL_RetValAsInt ();

	//Most likely not working - always returns 0
	PrintS (IntToString (checkWater));
};

func string ItMiNuggetInstanceName () {
	if (MEMINT_SwitchG1G2 (1, 0)) {
		return "ItMiNugget";
	};

	return "ItMi_Nugget";
};

/*
 *	Function, that throws item from fromPosPtr to targetPosPtr (#peknyObluk :) )
 */
func void Vob_ThrowFromPosPtrToPosPtr (var int vobPtr, var int fromPosPtr, var int targetPosPtr, var int angle) {

	var int trafo[16];
	NewTrafo (_@(trafo));

	//dir - vector smeru
	var int dir[3];
	SubVectors (_@ (dir), targetPosPtr, fromPosPtr);

	NormalizeVector (_@ (dir));
	VectorDirToTrf (_@ (dir), _@ (trafo));

	//X axis rotation, in order to turn vektor up we have to use negative value for angle
	zMAT4_PostRotateX (_@ (trafo), negf (mkf (angle)));

	//Velocity calculation

	/*
	Thank you helpo1 :)
	SQRT(
		(1/2 * ABS(tiažové zrýchlenie))
	      * (dolet^2 / COS(elevačný uhol)^2)
	      * (1 / (výškový rozdiel + TG(elevačný uhol) * dolet))
	    )
	*/

	//9,823
	var int g; g = mkf (450); //900 seems to be Gothics gravity acceleration
	var int d; d = GetVectorDist (fromPosPtr, targetPosPtr);
	var int b; b = divf (sqrf (d), sqrf (cos (TRF_Deg2Rad (angle))));
	var int h; h = GetVectorDistY (fromPosPtr, targetPosPtr);
	var int c; c = divf (mkf(1), addf (h, mulf (tan (TRF_Deg2Rad (angle)), d)));
	var int speed; speed = mulf (mulf (g, b),c);

	//
	if lf (speed, floatnull) {
		speed = floatone;
	} else {
		speed = sqrtf (speed);
	};

	//
	TrfDirToVector (_@ (trafo), _@ (dir));

	NormalizeVector (_@ (dir));
	MulVector (_@ (dir), speed);

	//Set physics enabled
	zCVob_SetPhysicsEnabled (vobPtr, 1);
	zCVob_SetSleeping (vobPtr, 0);

	var int rigidBodyPtr; rigidBodyPtr = zCVob_GetRigidBody (vobPtr);

	//Apply 'velocity'
	zCRigidBody_SetVelocity (rigidBodyPtr, _@ (dir));
};

/*
 *	Test for Engine function oCNpc_DoThrowVob (var int slfInstance, var int vobPtr, var int speedF)
 *
 *	Conclusion: seems like this does not work in G2A
 *	Maybe in G2A there is missing throw range constant, which I have no idea how to find, only thing I found about throw range was console command `SET THROW`
 */
func void testThrow () {
	var int vobPtr;
	var oCNPC her; her = Hlp_GetNPC (hero);
	vobPtr = her.focus_vob;

	var int retVal; retVal = oCNpc_DoThrowVob (hero, vobPtr, mkf (1000));
};

/*
enum {
	FOCUS_NORMAL,
	FOCUS_MELEE,
	FOCUS_RANGED,
	FOCUS_THROW_ITEM,
	FOCUS_THROW_MOB,
	FOCUS_MAGIC
};
*/
class oCNpcFocus {
	var int n_range3; //float
	var int n_range1; //float
	var int n_range2; //float
	var int n_azi; //float
	var int n_elev1; //float
	var int n_elev2; //float
	var int n_prio; //int
	var int i_range1; //float
	var int i_range2; //float
	var int i_azi; //float
	var int i_elev1; //float
	var int i_elev2; //float
	var int i_prio; //int
	var int m_range1; //float
	var int m_range2; //float
	var int m_azi; //float
	var int m_elev1; //float
	var int m_elev2; //float
	var int m_prio; //int
	var int max_range; //float
};

/*
 *	Another idea was that maybe there is something special in Focus_Throw_Item setup between G1 / G2A ... but when I tested that below, it was same
 *	We cannot work directly with instance Focus_Throw_Item ... because C_Focus does not have attribute max_range
 *	Therefore we have to convert instance to pointer and use our own class definition oCNpcFocus to access attribute max_range
 */
func void testFocusThrowItem () {
 	var int ptr; ptr = MEM_InstToPtr (Focus_Throw_Item);
	PrintS (IntToString (ptr));

	if (!ptr) { return; };

	var oCNpcFocus npcFocus;
	npcFocus = _^ (ptr);
	PrintS (toStringF (npcFocus.max_range)); //G1 1500, G2A 1500 hmmm
};

/*
 *	Test for our own custom function that makes sure item will be thrown from point A to point B
 *	function calculates vector/speed for specified angle
 *	In some cases it might not be possible to throw items using this function (wrong angles)
 *
 *	Vob_ThrowFromPosPtrToPosPtr (var int vobPtr, var int fromPosPtr, var int targetPosPtr, var int angle)
 *
 *	Conclusion: works fine in both G1 & G2A
 */
func void testThrowHelpo () {
	var int vobPtr;

	var int posFrom[3];	//from position
	var int posTarget[3];	//target position

	var oCNPC her; her = Hlp_GetNPC (hero);
	vobPtr = her.focus_vob;

	if (!Hlp_Is_oCItem (vobPtr)) { return; };

	//if npc is not in active vob list and we call NPC_GetNodePositionWorld game will crash
	if (!NPC_IsInActiveVobList (hero)) { return; };

	//Poloha hracovej pravej ruky
	CopyVector (NPC_GetNodePositionWorld (hero, "ZS_RIGHTHAND"), _@ (posFrom));

	//In G1 we want to throw items to Diego, in G2A we want to throw them to Xardas :)
	var int npcInstance;
	if (MEMINT_SwitchG1G2 (1, 0)) {
		npcInstance = MEM_GetSymbolIndex ("PC_THIEF");
	} else {
		npcInstance = MEM_GetSymbolIndex ("NONE_100_XARDAS");
	};

	var oCNPC npc; npc = Hlp_GetNPC (npcInstance);
	if (!NPC_IsInActiveVobList (npc)) { return; };

	//CopyVector (zCVob_GetPositionWorld (_@ (npc)), _@ (posTarget));
	CopyVector (NPC_GetNodePositionWorld (npc, "BIP01"), _@ (posTarget));

	//Trafo for insertion of an item
	/*
	var int trafo[16];
	NewTrafo (_@ (trafo));
	PosDirToTrf (_@ (posFrom), 0, _@ (trafo));

	//Insert item (this requires waypoint TOT!)
	vobPtr = InsertItem (ItMiNuggetInstanceName(), 1, _@ (trafo));
	*/

	CopyVector (zCVob_GetPositionWorld (vobPtr), _@ (posFrom));

	//Throw item
	Vob_ThrowFromPosPtrToPosPtr (vobPtr, _@ (posFrom), _@ (posTarget), 45);
};

/*
NicoDE: OutVector (AtVector) ist die "Blickrichtung" und Translation ist die "Position".
https://forum.worldofplayers.de/forum/threads/635427-daedalus-Direkter-Zugriff-auf-ZenGin-Objekte?p=11866629&viewfull=1#post11866629

   +   |       0       |      1     |      2      |       3       |
-------+---------------+------------+-------------+---------------+
 0 * 4 | RightVector X | UpVector X | OutVector X | Translation X |
-------+---------------+------------+-------------+---------------+
 1 * 4 | RightVector Y | UpVector Y | OutVector Y | Translation Y |
-------+---------------+------------+-------------+---------------+
 2 * 4 | RightVector Z | UpVector Z | OutVector Z | Translation Z |
-------+---------------+------------+-------------+---------------+
 3 * 4 |               |            |             |               |
-------+---------------+------------+-------------+---------------+
*/

func void testOutVector () {
	var oCNPC her; her = Hlp_GetNPC (hero);

	var int pos[3];

	//Get players position
	CopyVector (zCVob_GetPositionWorld (_@ (hero)), _@ (pos));

//---

	var int dir[3];

	//Out vector --> player's facing direction
	//TrfDirToVector (_@ (her._zCVob_trafoObjToWorld), _@ (dir));

	//Get camera
	var zCVob camVob; camVob = _^ (MEM_Game._zCSession_camVob);

	//Get facing vector from camera
	TrfDirToVector (_@ (camVob.trafoObjToWorld), _@ (dir));

	//Vector is already normalized
	//NormalizeVector (_@ (dir));

//---	This will insert item right in front of player


	//Trafo for item insertion
	var int trafo[16];
	NewTrafo (_@(trafo));
	PosDirToTrf (_@ (pos), 0, _@ (trafo));

	//Insert item (we need waypoint TOT!)
	var int vobPtr; vobPtr = InsertItem (ItMiNuggetInstanceName(), 1, _@ (trafo));

//---
	var int trafoRot[16];
	NewTrafo (_@(trafoRot));

	//X axis rotation, in order to turn vektor up we have to use negative value for angle
	var int angle; angle = 45;
	VectorDirToTrf (_@ (dir), _@ (trafoRot));
	zMAT4_PostRotateX (_@ (trafoRot), negf (mkf (angle)));
	TrfDirToVector (_@ (trafoRot), _@ (dir));

	var int speed; speed = mkf (1000);

	NormalizeVector (_@ (dir));
	MulVector (_@ (dir), speed);

	//Set physics enabled
	zCVob_SetPhysicsEnabled (vobPtr, 1);
	zCVob_SetSleeping (vobPtr, 0);

	var int rigidBodyPtr; rigidBodyPtr = zCVob_GetRigidBody (vobPtr);

	//Apply 'velocity'
	zCRigidBody_SetVelocity (rigidBodyPtr, _@ (dir));
};

func void _eventGameHandleEvent__ThrowItems (var int dummyVariable) {
	var int cancel; cancel = FALSE;
	var int key; key = MEM_ReadInt (ESP + 4);
	if (!key) { return; };

	//Insert an item to right hand
	if (key == key_U) {
		var int vobPtr;
		vobPtr = oCNpc_GetSlotItem (hero, "ZS_RIGHTHAND");

		if (!vobPtr) {
			var int instanceID; instanceID = MEM_GetSymbolIndex (ItMiNuggetInstanceName ());

			if (!Npc_HasItems (hero, instanceID)) {
				CreateInvItems (hero, instanceID, 1);
			};

			vobPtr = NPC_GetItemPtrByInstance (hero, INV_MISC, instanceID);
			vobPtr = oCNpc_RemoveFromInvByPtr (hero, vobPtr, 1);
			oCNpc_SetRightHand (hero, vobPtr);
		};
	};
};

func void G12_VobThrowing_Testing_Init () {
	//Init Game key events
	G12_GameHandleEvent_Init ();

	//Add listener for key events
	GameHandleEvent_AddListener (_eventGameHandleEvent__ThrowItems);

	const int once = 0;
	if (!once) {
		//0x00617E80 public: virtual void __thiscall oCAIVobMove::ReportCollisionToAI(class zCCollisionReport const &)
		const int oCAIVobMove__ReportCollisionToAI_G1 = 6389376;

		//0x0069FA30 public: virtual void __thiscall oCAIVobMove::ReportCollisionToAI(class zCCollisionReport const &)
		const int oCAIVobMove__ReportCollisionToAI_G2 = 6945328;

		//G2A HookLen 7
		HookEngine (MEMINT_SwitchG1G2 (oCAIVobMove__ReportCollisionToAI_G1, oCAIVobMove__ReportCollisionToAI_G2), MEMINT_SwitchG1G2 (6, 7), "_hook_oCAIVobMove_ReportCollisionToAI");

		//0x006182A0 public: virtual void __thiscall oCAIVobMoveTorch::DoAI(class zCVob *,int &)
		//const int oCAIVobMoveTorch__DoAI_G1 = 6390432;

		//const int oCAIVobMoveTorch__DoAI_G2 = 0;

		//HookEngine (MEMINT_SwitchG1G2 (oCAIVobMoveTorch__DoAI_G1, oCAIVobMoveTorch__DoAI_G2), 5, "_hook_oCAIVobMoveTorch_DoAI");

		once = 1;
	};
};
