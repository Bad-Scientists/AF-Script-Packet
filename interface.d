//========================================
// Interface scaling
// Author: szapp (Mud-freak)
//========================================

//Not yet published, 
func int _getInterfaceScaling () {
    //Super cheap, but effective and versatile: Just take (actual width) / (default width) of the health bar
    //MEM_InitGlobalInst();
    var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
    return fracf(hpBar.zCView_vsizex, Print_ToVirtual(180, PS_X));
};

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

//0x006A69E0 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *) 
func void _hook_oCNpc_OnMessage () {
	if (!PC_IgnoreAnimations) { return; };

	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNPC npc; npc = _^ (ECX);

	if (!NPC_IsPlayer (npc)) { return; };

	var int eMsg; eMsg = MEM_ReadInt (ESP + 4);
	
	if (Hlp_Is_oCMsgConversation (eMsg)) {
		var oCMsgConversation msgConversation; msgConversation = _^ (eMsg);
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
		//&& (Hlp_StrCmp (msgConversation.name, "T_DONTKNOW")) {
			PC_IgnoreAnimations -= 1;
			msgConversation.name = "";
		};
	};
};

func void G12_InterceptNpcEventMessages_Init () {
	const int once = 0;
	if (!once) {
		HookEngine (oCNpc__OnMessage, 7, "_hook_oCNpc_OnMessage");
	};
};
