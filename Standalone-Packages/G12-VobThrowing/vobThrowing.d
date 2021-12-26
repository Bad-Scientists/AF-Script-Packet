/*
 *	Vob Throwing 0.1 [WIP]
 *
 *	This feature allows you to throw items in both G1 and G2A:
 *	 - if player has an item in hand and presses actionKey then throwing mode is activated
 *	 - with keyUp player can increase velocity of thrown item
 *
 *	-- TODO: --
 *
 *	We definitelly need to draw trajectory of thrown item that will help us figure out where item falls :)
 *
 *	-- Dev-notes: --
 *
 *	oCNpc::GetRightHand is called whenever player presses action key.
 *	If player has any vob in hand in G1 animation changes to T_STAND_2_IAIM --> S_IAIM
 *
 *	Seems like there is *hardcoded* logic for animation S_IAIM
 *	 - player can turn around
 *	 - when player presses actionKey + upKey item is thrown by oCNpc::DoThrowVob
 *
 *	-- How does this feature work: --
 *
 *	 - we are hooking oCNpc::GetRightHand with our own function, by default we always return in EAX register value 0 - this way engine never changes animation to T_STAND_2_IAIM & S_IAIM
 *	 - our hooked function checks if player has anything in hand, if it is item, it 'activates' throwing mode ... and plays animation T_STAND_2_ITEMAIM (which is same as T_STAND_2_IAIM)
 *	 	!!! Important note: if you want to use this feature, you need to make sure that in your mod you are able to insert items into players right hand !!!
 *	 - player can turn (thanks to code from Gothic Free Aim) around with mouse and aim
 *	 - player can increase strength/charge by holding upKey
 *	 - as soon as actionKey is released vob will be thrown away in facing direction
 *
 *	-- How to update HUMANS.MDS: --
 *
 *	You will need to update HUMANS.MDS file and add following animations into it:

// ---------------------------------------------------------------------------------------------------------------
// Item Throwing
// ---------------------------------------------------------------------------------------------------------------
		ani	("t_Stand_2_ItemAim"		1	"s_ItemAim"	0.1	0.1	M.	"Hum_ItemThrow_M01.asc"		F	1	6)
		ani	("c_ItemAim_1"			4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	47	47)
		ani	("c_ItemAim_2"			4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	8	8)
		ani	("c_ItemAim_3"			4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	125	125)
		ani	("c_ItemAim_4"			4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	86	86)

		aniComb	("s_ItemAim"			1	"s_ItemAim"	0.2	0.2	M.	"c_ItemAim_"			4)

		aniAlias("t_ItemAim_2_Stand"		1	""		0.1	0.1	M.	"t_Stand_2_ItemAim"		R)

		ani	("c_ItemAim_2_ItemThrow_1"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	48	58)
		ani	("c_ItemAim_2_ItemThrow_2"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	9	19)
		ani	("c_ItemAim_2_ItemThrow_3"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	126	136)
		ani	("c_ItemAim_2_ItemThrow_4"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	87	97)

		aniComb	("t_ItemAim_2_ItemThrow"	1	"s_ItemThrow"	0.2	0.2	M.	"c_ItemAim_2_ItemThrow_"			4)

		ani	("c_ItemThrow_1"		4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	59	59)
		ani	("c_ItemThrow_2"		4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	20	20)
		ani	("c_ItemThrow_3"		4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	137	137)
		ani	("c_ItemThrow_4"		4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	98	98)
		aniComb ("s_ItemThrow"			1	"s_ItemThrow"	0.2	0.2	M.	"c_ItemThrow_"					4)

		ani	("c_ItemThrow_2_Stand_1"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	60	83)
		ani	("c_ItemThrow_2_Stand_2"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	21	44)
		ani	("c_ItemThrow_2_Stand_3"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	138	161)
		ani	("c_ItemThrow_2_Stand_4"	4	""		0.0	0.0	.	"Hum_ItemThrow_M01.asc"		F	99	122)

		aniComb	("t_ItemThrow_2_Stand"		1	""		0.2	0.2	M.	"c_ItemThrow_2_Stand_"		4)

 */

//Global variables
var int PC_VobThrowing_Activated;
var int PC_VobThrowing_Velocity;
var int PC_VobThrowing_Charging;
var int PC_VobThrowing_Time;
var int PC_VobThrowing_Timer;

func void _hook_oCNpc_GetRightHand__VobThrowing () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);

	if (!Npc_IsPlayer (slf)) { return; };

	//Don't do anything while in fight mode
	if (!Npc_IsInFightMode (hero, FMODE_NONE)) {
		return;
	};

	//Do we have anything in right hand ?
	var int vobPtr; vobPtr = oCNpc_GetSlotItem (hero, "ZS_RIGHTHAND");

	//If we do have an item ...
	if (Hlp_Is_oCItem (vobPtr)) {
		//And Vob throwing is not yet activated
		if (!PC_VobThrowing_Activated) {
			//Activate it
			PC_VobThrowing_Activated = TRUE;

			//If we use AI_PlayAni, it freezes AI! and this function is no longer called --> therefore we cannot use this function for power charging :-/
			//Another problem - if we hold action key, we cannot turn anymore!

			AI_PlayAni (hero, "T_STAND_2_ITEMAIM");
		};
	};
};

//keyUp while holding actionKey --> Charge throw power
func void _eventPlayerActionKeyHeld__VobThrowing () {
	if (PC_VobThrowing_Activated) {
		var int keyUp; keyUp = MEM_GetKey ("keyUp"); keyUp = MEM_KeyState (keyUp);
		var int keySecondaryUp; keySecondaryUp = MEM_GetSecondaryKey ("keyUp"); keySecondaryUp = MEM_KeyState (keySecondaryUp);

		if (((keyUp == KEY_PRESSED) || (keyUp == KEY_HOLD)) || ((keySecondaryUp == KEY_PRESSED) || (keySecondaryUp == KEY_HOLD))) {

			if (PC_VobThrowing_Charging == FALSE) {
				PC_VobThrowing_Charging = TRUE;
				PC_VobThrowing_Timer = MEM_Timer.totalTime;
			};

			PC_VobThrowing_Time = MEM_Timer.totalTime - PC_VobThrowing_Timer;

			PC_VobThrowing_Velocity = PC_VobThrowing_Time;

			if (PC_VobThrowing_Velocity > 2000) {
				PC_VobThrowing_Velocity = 2000;
			};

			var int timer1s; timer1s += MEM_Timer.frameTime;
			if (timer1s >= 500) {
				timer1s -= 500;
				PrintS (ConcatStrings ("Charging ", IntToString (PC_VobThrowing_Velocity)));
			};
		};
	};
};

//actionKey release --> throw vob
func void _eventPlayerActionKeyReleased__VobThrowing () {
	if (PC_VobThrowing_Activated) {
		//If player pressed upKey then we want to throw item
		if (PC_VobThrowing_Charging) {
			//Throw
			AI_PlayAni (hero, "T_ITEMAIM_2_ITEMTHROW");
			AI_Function (hero, DoThrowVob__VobThrowing);
			AI_PlayAni (hero, "T_ITEMTHROW_2_STAND");

			PC_VobThrowing_Charging = FALSE;
		} else {
			//Go back to stand position
			AI_PlayAni(hero, "T_ITEMAIM_2_STAND");
		};

		PC_VobThrowing_Activated = FALSE;
	};
};

func void DoThrowVob__VobThrowing () {
	var oCNPC her; her = Hlp_GetNPC (hero);

	var int vobPtr; vobPtr = oCNpc_GetSlotItem (hero, "ZS_RIGHTHAND");

	//One more check
	if (!vobPtr) { return; };

	var int velocity; velocity = mkf (PC_VobThrowing_Velocity);

	//Get position of players right hand
	var int pos[3]; CopyVector (NPC_GetNodePositionWorld (hero, "ZS_RIGHTHAND"), _@ (pos));

	//Trafo for item insertion == position of right hand
	/*
	var int trafo[16];
	NewTrafo (_@(trafo));
	PosDirToTrf (_@ (pos), 0, _@ (trafo));

	//Remove item from hand
	vobPtr = oCNpc_RemoveFromSlot_Fixed (hero, "ZS_RIGHTHAND", 0);

	//Safety check
	if (!vobPtr) { return; };

	//Get instance name & amount
	var int amount;
	var string itemInstanceName;

	var oCItem itm; itm = _^ (vobPtr);
	itemInstanceName = GetSymbolName (itm.instanz);
	amount = itm.amount;

	//Remove from world (no idea how to re-insert vobPtr back to world properly!)
	RemoveoCVobSafe (vobPtr, 0);

	//Create new item
	vobPtr = InsertItem (itemInstanceName, amount, _@ (trafo));
*/

	//We will use oCNpc_DoThrowVob:
	// - it removes an item from hand, inserts it back to the world
	// - most likely attaches correct 'AI' (oCAIVobMove) to thrown item (seems like without AI PERC_ASSESSQUIETSOUND would not fire - NPCs would not 'recognize' that item dropped somewhere)
	var int retVal; retVal = oCNpc_DoThrowVob (hero, vobPtr, FLOATNULL);

	//Get camera
	var zCVob camVob; camVob = _^ (MEM_Game._zCSession_camVob);

	//Get facing vector from camera
	var int dir[3]; TrfDirToVector (_@ (camVob.trafoObjToWorld), _@ (dir));

	var int trafoRot[16];
	NewTrafo (_@(trafoRot));

	VectorDirToTrf (_@ (dir), _@ (trafoRot));

/*
	var int posCamera[3];
	posCamera[0] = camVob.trafoObjToWorld[3];
	posCamera[1] = camVob.trafoObjToWorld[7];
	posCamera[2] = camVob.trafoObjToWorld[11];

	//Get directional vector - from camera to hand
	SubVectors (_@ (dir), _@ (pos),  _@ (posCamera));

	NormalizeVector (_@ (dir));

	//Trafo for rotation around X axis
	var int trafoRot[16];
	NewTrafo (_@(trafoRot));

	TrfDirToVector (_@ (her._zCVob_trafoObjToWorld), _@ (dir));
*/

	//X axis rotation, in order to turn vektor up we have to use negative value for angle
	var int angle; angle = 45;
	VectorDirToTrf (_@ (dir), _@ (trafoRot));
	zMAT4__PostRotateX (_@ (trafoRot), negf (mkf (angle)));
	TrfDirToVector (_@ (trafoRot), _@ (dir));

	MulVector (_@ (dir), velocity);

	//Set physics enabled
	zCVob_SetPhysicsEnabled (vobPtr, 1);
	zCVob_SetSleeping (vobPtr, 0);

	var int rigidBodyPtr; rigidBodyPtr = zCVob_GetRigidBody (vobPtr);

	//Apply 'velocity'
	zCRigidBody_SetVelocity (rigidBodyPtr, _@ (dir));


//-->	AI testing

/*
 *	Seems like with AI below we can easily achieve what we've done above :) (only in G1)
 */

	//var int ai;

	//oCAIVobMove

	//This does not work in G2A! Item falls straight down

	//ai = oCAIVobMove_Create ();
	//oCAIVobMove_Init (ai, vobPtr, _@ (hero), _@ (pos), mkf(45), velocity, _@ (trafoRot));

	//oCAIVobMoveTorch
	//Will not detect collision with NPC

	//This does not work in G2A! Item falls straight down

	//ai = oCAIVobMoveTorch_Create ();
	//oCAIVobMoveTorch_Init (ai, vobPtr, _@ (hero), _@ (pos), mkf(45), velocity, _@ (trafoRot));

/*
	var oCAIVobMoveTorch vobMoveTorch; vobMoveTorch = _^ (ai);
	PrintS (IntToString (vobMoveTorch.ignoreVobList_next));

	var int ptr;
	var zCList list;
	var int ignoreVobPtr;

	ptr = vobMoveTorch.ignoreVobList_next;

	while (ptr);
		list = _^ (ptr);

		ignoreVobPtr = list.data;

		if (Hlp_Is_oCNpc (ignoreVobPtr)) {
			var oCNPC npc;
			npc = _^ (ignoreVobPtr);

			PrintS (npc.Name); //seems like only NPC in ignoreVobList_next is hero
		};

		ptr = list.next;
	end;
*/

	//oCAIDrop

	//Simple item 'drop', we can use both angle and velocity - with this AI we can also throw items
	//Will not detect collision with NPC

	//This will crash the game in G2A!

	//ai = oCAIDrop_Create ();
	//oCAIDrop_Init (ai, vobPtr, _@ (hero), _@ (pos), mkf(45), velocity);

	//oCAIArrow

	//Quite interesting AI :-)
	//It detects collision with NPC, but has a lot of other issues (I have no clue how to use it proerly)
	//var C_NPC Diego; Diego = Hlp_GetNPC (PC_Thief);

	//ai = oCAIArrow_Create ();
	//oCAIArrow_Init (ai, vobPtr, _@ (hero), _@ (Diego));

//<--
	//Seems like we don't need to add ai with this function
	//zCVob_SetAI (vobPtr, ai);

	//Reset timer
	PC_VobThrowing_Timer = MEM_Timer.totalTime;
};

/*
 *	This is altered version of function from Gothic Free Aim (Original function: GFA_TurnPlayerModel)
 *	Code used here was originally created by mud-freak (@szapp)
  *	mud-freak's Gothic Free Aim repository:
 *	https://github.com/szapp/GothicFreeAim
 */
func void _eventMouseUpdate_VobThrowing_TurnPlayerModel () {
	//Don't do anything if throwing is not activated
	if (!PC_VobThrowing_Activated) { return; };

	var oCNPC her; her = Hlp_GetNPC (hero);

	const float ROTATION_SCALE     = 0.16; // Turn rate while aiming (changes Gothic 1 controls only)
	const float MAX_TURN_RATE_G1   = 2.0; // Gothic 1 has a maximum turn rate (engine default: 2.0)

	// The _Cursor class from LeGo is used here. It is not necessarily a cursor: it holds mouse properties
	var _Cursor mouse; mouse = _^ (Cursor_Ptr);

	// Retrieve horizontal mouse movement (along x-axis) and apply mouse sensitivity
	var int deltaX; deltaX = mulf(mkf(mouse.relX), MEM_ReadInt(Cursor_sX));
	if (deltaX == FLOATNULL) || (Cursor_NoEngine) {
		// Only rotate if there was movement along x position and if mouse movement is not disabled
		return;
	};

	// Apply turn rate
	deltaX = mulf(deltaX, castToIntf(ROTATION_SCALE));

	// Gothic 1 has a maximum turn rate
	if (GOTHIC_BASE_VERSION == 1) {
		// Also add another multiplier for Gothic 1 (mouse is faster)
		deltaX = mulf(deltaX, castToIntf(0.5));

		if (gf(deltaX, castToIntf(MAX_TURN_RATE_G1))) {
			deltaX = castToIntf(MAX_TURN_RATE_G1);
		} else if (lf(deltaX, negf(castToIntf(MAX_TURN_RATE_G1)))) {
			deltaX = negf(castToIntf(MAX_TURN_RATE_G1));
		};
	};

	const int oCAniCtrl_Human__Turn_G1 = 6445616; //0x625A30
	const int oCAniCtrl_Human__Turn_G2 = 7005504; //0x6AE540

	// Turn player model
	var int hAniCtrl; hAniCtrl = her.anictrl;
	const int call = 0; var int zero;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(zero)); // 0 = disable turn animation (there is none while aiming anyways)
		CALL_FloatParam(_@(deltaX));
		CALL_PutRetValTo(0);
		CALL__thiscall(_@(hAniCtrl), MEMINT_SwitchG1G2 (oCAniCtrl_Human__Turn_G1, oCAniCtrl_Human__Turn_G2));
		call = CALL_End();
	};
};

func void G12_VobThrowing_Init () {
	//Init mouse events
	G12_MouseUpdate_Init ();

	MouseUpdateEvent_AddListener (_eventMouseUpdate_VobThrowing_TurnPlayerModel);

	//Init Action key detection
	G12_GetActionKey_Init ();

	//We have to use Action key event --> because of mouse interaction
	//GameHandleEvent would register only mouse-down event, while our hook fires even when we hold left mouse button
	PlayerActionKeyHeldEvent_AddListener (_eventPlayerActionKeyHeld__VobThrowing);
	PlayerActionKeyReleasedEvent_AddListener (_eventPlayerActionKeyReleased__VobThrowing);

	const int once = 0;

	if (!once) {
		//0x00697750 public: class oCVob * __thiscall oCNpc::GetRightHand(void)
		const int oCNpc__GetRightHand_G1 = 6911824;

		//0x0073AB50 public: class oCVob * __thiscall oCNpc::GetRightHand(void)
		const int oCNpc__GetRightHand_G2 = 7580496;

		//We actually cannot replace engine function, otherwise we screw up mob interaction :)
		//ReplaceEngineFunc (MEMINT_SwitchG1G2 (oCNpc__GetRightHand_G1, oCNpc__GetRightHand_G2), 0, "_hook_oCNpc_GetRightHand__VobThrowing");

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__GetRightHand_G1, oCNpc__GetRightHand_G2), 10, "_hook_oCNpc_GetRightHand__VobThrowing");

		once = 1;
	};
};
