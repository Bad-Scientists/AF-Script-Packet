/*
 *	Detection for Action key press
 */
var int PC_ActionKeyPressed;
var int PC_ActionKeyPressedLast;
var int PC_ActionKeyHeld;

var int _PlayerActionKeyHeld_Event;
var int _PlayerActionKeyReleased_Event;

func void FF_CheckActionKey () {
	var int actionKey; actionKey = MEM_GetKey ("keyAction"); actionKey = MEM_KeyState (actionKey);
	var int secondaryActionKey; secondaryActionKey = MEM_GetSecondaryKey ("keyAction"); secondaryActionKey = MEM_KeyState (secondaryActionKey);

	PC_ActionKeyPressed = FALSE;

	if (((actionKey == KEY_PRESSED) || (actionKey == KEY_HOLD)) || ((secondaryActionKey == KEY_PRESSED) || (secondaryActionKey == KEY_HOLD))) {
		PC_ActionKeyPressed = TRUE;
	};

	if (PC_ActionKeyPressed != PC_ActionKeyPressedLast) {
		if (!PC_ActionKeyPressed) {
			if (_PlayerActionKeyReleased_Event) {
				Event_Execute (_PlayerActionKeyReleased_Event, 0);
			};
		};
	} else {
		if (PC_ActionKeyPressed) {
			PC_ActionKeyHeld = TRUE;
			if (_PlayerActionKeyHeld_Event) {
				Event_Execute (_PlayerActionKeyHeld_Event, 0);
			};
		};
	};

	PC_ActionKeyPressedLast = PC_ActionKeyPressed;

	if (!PC_ActionKeyPressed) {
		FF_Remove (FF_CheckActionKey);
	};
};

/*
 *
 */
func void _hook_oCAIHuman_PC_ActionMove () {
	PC_ActionKeyPressed = MEM_ReadInt (ESP + 4);

	//If actionKey is pressed together with other keys ... then this function no longer register actionKey as pressed :-/
	//So we will add frame function that will check if keyAction is pressed / held there
	if (PC_ActionKeyPressed) {
		if (PC_ActionKeyPressed != PC_ActionKeyPressedLast) {
			FF_ApplyOnceExtGT (FF_CheckActionKey, 0, -1);
		};
	};
};

func void PlayerActionKeyHeldEvent_AddListener (var func f) {
	Event_AddOnce (_PlayerActionKeyHeld_Event, f);
};

func void PlayerActionKeyHeldEvent_RemoveListener (var func f) {
	Event_Remove (_PlayerActionKeyHeld_Event, f);
};

func void PlayerActionKeyReleasedEvent_AddListener (var func f) {
	Event_AddOnce (_PlayerActionKeyReleased_Event, f);
};

func void PlayerActionKeyReleasedEvent_RemoveListener (var func f) {
	Event_Remove (_PlayerActionKeyReleased_Event, f);
};

func void G12_GetActionKey_Init () {
	PC_ActionKeyPressed = 0;
	PC_ActionKeyPressedLast = PC_ActionKeyPressed;

	if (!_PlayerActionKeyHeld_Event) {
		_PlayerActionKeyHeld_Event = Event_Create ();
	};

	if (!_PlayerActionKeyReleased_Event) {
		_PlayerActionKeyReleased_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//G1 hook len 13, G2A hook len = 9
		HookEngine (oCAIHuman__PC_ActionMove, MEMINT_SwitchG1G2 (13, 9), "_hook_oCAIHuman_PC_ActionMove");
		once = 1;
	};
};

/*
 *	Interception of event messages.
 *	I am using this to cancel animation: T_DONTKNOW
 *	Dirty solution, but gets work done.
 */

var int PC_IgnoreAnimations;

var int _PlayerUseItemToStateStart_Event;
var int _PlayerUseItemToStateUse_Event;

//0x006A69E0 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
//0x0074B020 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
func void _hook_oCNpc_OnMessage () {
//	if (!PC_IgnoreAnimations) { return; };

	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var int eMsg; eMsg = MEM_ReadInt (ESP + 4);

	var oCNPC npc; npc = _^ (ECX);

	var oCMsgManipulate msgManipulate;

/*
	//EV_DODGE - nothing happens when you call AI_Dodge on monster NPC
	if (Hlp_Is_oCMsgMovement (eMsg)) {
		enum TMovementSubType {
			EV_ROBUSTTRACE,
			EV_GOTOPOS,
			EV_GOTOVOB,
			EV_GOROUTE,
			EV_TURN,
			EV_TURNTOPOS,
			EV_TURNTOVOB,
			EV_TURNAWAY,
			EV_JUMP,
			EV_SETWALKMODE,
			EV_WHIRLAROUND,
			EV_STANDUP,
			EV_CANSEENPC,
			EV_STRAFE,
			EV_GOTOFP,
			EV_DODGE,
			EV_BEAMTO,
			EV_ALIGNTOFP,
			EV_MOVE_MAX
		};

		//C_NPCIsMonster
		if (eMsg_MD_GetSubType (eMsg) == 15) {
			var int model; model = oCNPC_GetModel (npc);
			var int aniID; aniID = zCModel_GetAniIdFromAniName (model, "T_FISTJUMPB");

			PrintS (ConcatStrings ("aniID ", IntToString (aniID)));

			var oCMsgMovement msgMovement; msgMovement = _^ (eMsg);

			MEM_Info (ConcatStrings ("objectName ", msgMovement.objectName));
			MEM_Info (ConcatStrings ("targetVobName ", msgMovement.targetVobName));
			MEM_Info (ConcatStrings ("targetName ", msgMovement.targetName));
			MEM_Info (ConcatStrings ("bitfield_oCNpcMessage ", IntToString (msgMovement.bitfield_oCNpcMessage)));
			MEM_Info (ConcatStrings ("route ", IntToString (msgMovement.route)));
			MEM_Info (ConcatStrings ("targetVob ", IntToString (msgMovement.targetVob)));
			MEM_Info (ConcatStrings ("angle ", toStringF (msgMovement.angle)));
			MEM_Info (ConcatStrings ("timer ", toStringF (msgMovement.timer)));
			MEM_Info (ConcatStrings ("targetMode ", IntToString (msgMovement.targetMode)));
			MEM_Info (ConcatStrings ("ani ", IntToString (msgMovement.ani)));

			msgMovement.ani = aniID;
		};
	};
*/
	if (PC_IgnoreAnimations) {
		if (NPC_IsPlayer (npc)) {
			if (Hlp_Is_oCMsgConversation (eMsg)) {
				/*
				enum TConversationSubType {
					EV_PLAYANISOUND,
					EV_PLAYANI,
					EV_PLAYSOUND,
					EV_LOOKAT,
					EV_OUTPUT,
					EV_OUTPUTSVM,
					EV_CUTSCENE,
					EV_WAITTILLEND,
					EV_ASK,
					EV_WAITFORQUESTION,
					EV_STOPLOOKAT,
					EV_STOPPOINTAT,
					EV_POINTAT,
					EV_QUICKLOOK,
					EV_PLAYANI_NOOVERLAY,
					EV_PLAYANI_FACE,
					EV_PROCESSINFOS,
					EV_STOPPROCESSINFOS,
					EV_OUTPUTSVM_OVERLAY,
					EV_CONV_MAX
				};
				*/

				//EV_PLAYANI
				if (eMsg_MD_GetSubType (eMsg) == 1) {
					var oCMsgConversation msgConversation; msgConversation = _^ (eMsg);
					//&& (Hlp_StrCmp (msgConversation.name, "T_DONTKNOW")) {
					PC_IgnoreAnimations -= 1;
					msgConversation.name = "";
				};
			};
		};
	};

	//Item interaction
	if (NPC_IsPlayer (npc)) {
		var int eventUseItemToState;

		if (Hlp_Is_oCMsgManipulate (eMsg)) {
			/*
			enum TManipulateSubType {
				EV_TAKEVOB,
				EV_DROPVOB,
				EV_THROWVOB,
				EV_EXCHANGE,
				EV_USEMOB,
				EV_USEITEM,
				EV_INSERTINTERACTITEM,
				EV_REMOVEINTERACTITEM,
				EV_CREATEINTERACTITEM,
				EV_DESTROYINTERACTITEM,
				EV_PLACEINTERACTITEM,
				EV_EXCHANGEINTERACTITEM,
				EV_USEMOBWITHITEM,
				EV_CALLSCRIPT,
				EV_EQUIPITEM,
				EV_USEITEMTOSTATE,
				EV_TAKEMOB,
				EV_DROPMOB,
				EV_MANIP_MAX
			};
			*/
			//EV_USEITEMTOSTATE
			if (eMsg_MD_GetSubType (eMsg) == EV_USEITEMTOSTATE) {
				msgManipulate = _^ (eMsg);
				if (msgManipulate.npcSlot == 0) {
					if (eventUseItemToState == 0) {
						eventUseItemToState = 1;
						if (_PlayerUseItemToStateStart_Event) {
							Event_Execute (_PlayerUseItemToStateStart_Event, 0);
						};
					};
				} else
				if (msgManipulate.npcSlot == -1) {
					if (eventUseItemToState == 1) {
						eventUseItemToState = 0;
						if (_PlayerUseItemToStateUse_Event) {
							Event_Execute (_PlayerUseItemToStateUse_Event, 0);
						};
					};
				};
			};

			//EV_USEMOB
			if (eMsg_MD_GetSubType (eMsg) == EV_USEMOB) {
				//PrintS ("EV_USEMOB");

				msgManipulate = _^ (eMsg);
				if (Hlp_Is_oCMobInter (msgManipulate.targetVob)) {
					var oCMobInter mob; mob = _^ (msgManipulate.targetVob);

					if ((msgManipulate.targetState == -1) && (mob.state == 1)) {
						oCMobInter_SetInteractWith (msgManipulate.targetVob, 0);
					};
				};

			};
		};
	} else {
		//Additional logic for NPCs
		if (Hlp_Is_oCMsgManipulate (eMsg)) {

			if (eMsg_MD_GetSubType (eMsg) == EV_USEMOB) {
				msgManipulate = _^ (eMsg);

				//NPC will be able to unlock & lock oCMobLockable objects
				if (Hlp_Is_oCMobLockable (msgManipulate.targetVob)) {
					if ((msgManipulate.targetVob == npc.interactMob) || (msgManipulate.targetState == -1)) {
						var oCMobLockable lock; lock = _^ (msgManipulate.targetVob);

						if (Hlp_StrCmp (msgManipulate.name, "LOCK")) {
							if (!(lock.bitfield & oCMobLockable_bitfield_locked)) {
								lock.bitfield = (lock.bitfield | oCMobLockable_bitfield_locked);
								//PrintS ("locking!");
							};
						};

						if (Hlp_StrCmp (msgManipulate.name, "UNLOCK")) {
							if (lock.bitfield & oCMobLockable_bitfield_locked) {
								lock.bitfield = (lock.bitfield & ~ oCMobLockable_bitfield_locked);
								//PrintS ("unlocking!");
							};
						};
					};
				};
			};
		};
	};
};

func void PlayerUseItemToStateStartEvent_AddListener (var func f) {
	Event_AddOnce (_PlayerUseItemToStateStart_Event, f);
};

func void PlayerUseItemToStateStartEvent_RemoveListener (var func f) {
	Event_Remove (_PlayerUseItemToStateStart_Event, f);
};

func void PlayerUseItemToStateUseEvent_AddListener (var func f) {
	Event_AddOnce (_PlayerUseItemToStateUse_Event, f);
};

func void PlayerUseItemToStateUseEvent_RemoveListener (var func f) {
	Event_Remove (_PlayerUseItemToStateUse_Event, f);
};

func void G12_InterceptNpcEventMessages_Init () {
	//Special events detecting item usage event type EV_USEITEMTOSTATE - start and actual item usage (when onstate[0] function is called)
	//These will be called only for player!!
	if (!_PlayerUseItemToStateStart_Event) {
		_PlayerUseItemToStateStart_Event = Event_Create ();
	};

	if (!_PlayerUseItemToStateUse_Event) {
		_PlayerUseItemToStateUse_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x006A69E0 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
		const int oCNpc__OnMessage_G1 = 6973920;

		//0x0074B020 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
		const int oCNpc__OnMessage_G2 = 7647264;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__OnMessage_G1, oCNpc__OnMessage_G2), 7, "_hook_oCNpc_OnMessage");
		once = 1;
	};
};

var int _MouseUpdate_Event;

func void MouseUpdateEvent_AddListener (var func f) {
	Event_AddOnce (_MouseUpdate_Event, f);
};

func void MouseUpdateEvent_RemoveListener (var func f) {
	Event_Remove (_MouseUpdate_Event, f);
};

func void _hook_mouseUpdate_Event () {
	if (_MouseUpdate_Event) {
		Event_Execute (_MouseUpdate_Event, 0);
	};
};

func void G12_MouseUpdate_Init () {
	if (!_MouseUpdate_Event) {
		_MouseUpdate_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		/*
			Code used here was originally created by mud-freak (@szapp)
			Originally this was used in Gothic Free Aim
			mud-freak's repository:
			https://github.com/szapp/GothicFreeAim
		*/
		const int mouseUpdate_G1 =  5013602; //0x4C8062 // Hook len 5
		const int mouseUpdate_G2 =  5062907; //0x4D40FB // Hook len 5

		HookEngine (MEMINT_SwitchG1G2 (mouseUpdate_G1, mouseUpdate_G2), 5, "_hook_mouseUpdate_Event");
		once = 1;
	};
};