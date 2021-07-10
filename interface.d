/*
 *	Detection for Ctrl key
 */
var int PC_ActionButtonPressed;

func void _hook_oCAIHuman_PC_ActionMove () {
	PC_ActionButtonPressed = MEM_ReadInt (ESP + 4);
};

func void G12_GetActionButton_Init () {
	const int once = 0;
	if (!once) {
		//G1 hook len 13, G2A hook len = 9
		HookEngine (oCAIHuman__PC_ActionMove, MEMINT_SwitchG1G2 (13, 9), "_hook_oCAIHuman_PC_ActionMove");
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
			if (eMsg_MD_GetSubType (eMsg) == 15) {
				var oCMsgManipulate msgManipulate; msgManipulate = _^ (eMsg);
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
		HookEngine (oCNpc__OnMessage, 7, "_hook_oCNpc_OnMessage");
	};
};
