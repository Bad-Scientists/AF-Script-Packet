/*
 *	FadeAway
 *	 - will slowly 'fade-away' NPC (will update its transparency) - as soon as NPC is invisible engine function oCNPC::FadeAway removes NPC from the world
 *	 - by default this feature prevents summoned NPCs to drop items!
 *
 *	Usage:
 *	 - call from ZS_Dead state following code - if you want your dead NPCs to fade-away:

	//Is this summoned NPC?
	if (NPC_GetBitfield (self, oCNpc_bitfield0_isSummoned)) {
		//Is it fading away?
		if (!oCNpc_IsFadingAway (self)) {
			//Start fading away effect:
			Wld_PlayEffect("SPELLFX_MASSDEATH_TARGET", self, self, 0, 0, 0, FALSE);
			oCNpc_StartFadeAway (self);
		};
	};
 */

/*
 *	We have to define this ZS state - as long as it is running (_LOOP function returns LOOP_CONTINUE) engine function oCAIHuman::DoAI will be active
 */
func void ZS_FadeAway () {
	Npc_SetPercTime (self, 1);
};

func int ZS_FadeAway_Loop () {
	return LOOP_CONTINUE;
};

func void ZS_FadeAway_End () {
};

/*
 *	oCNpc_FadeAway
 *	 - function returns true when NPC is removed from world
 */
func int oCNpc_FadeAway (var int slfInstance) {
	//0x00693A70 public: int __thiscall oCNpc::FadeAway(void)
	const int oCNpc__FadeAway_G1 = 6896240;

	//0x00736E40 public: int __thiscall oCNpc::FadeAway(void)
	const int oCNpc__FadeAway_G2 = 7564864;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FALSE; };

	var int retVal;

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__FadeAway_G1, oCNpc__FadeAway_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCNpc_StartFadeAway
 *	 - function initializes fade-away effect
 */
func void oCNpc_StartFadeAway (var int slfInstance) {
	//0x00693970 public: void __thiscall oCNpc::StartFadeAway(void)
	const int oCNpc__StartFadeAway_G1 = 6895984;

	//0x00736D40 public: void __thiscall oCNpc::StartFadeAway(void)
	const int oCNpc__StartFadeAway_G2 = 7564608;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__StartFadeAway_G1, oCNpc__StartFadeAway_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_IsFadingAway
 *	 - returns true if NPC is already fading away
 */
func int oCNpc_IsFadingAway (var int slfInstance) {
	//0x00693A60 public: int __thiscall oCNpc::IsFadingAway(void)
	const int oCNpc__IsFadingAway_G1 = 6896224;

	//0x00736E30 public: int __thiscall oCNpc::IsFadingAway(void)
	const int oCNpc__IsFadingAway_G2 = 7564848;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FALSE; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__IsFadingAway_G1, oCNpc__IsFadingAway_G2));
		call = CALL_End();
	};

	return + retVal;
};


func void _hook_oCAIHuman_DoAI_IsDead__FadeAway () {
	//ECX 0x007DCBEC const oCGame::`vftable'
	//EDX 0x007DDF34 const oCNpc::`vftable'
	//ESI 0x007DC814 const oCAIHuman::`vftable'
	//EDI 0x007D3FEC const zCModel::`vftable'

	//class oCAIHuman : public oCAniCtrl_Human {
	//Class oCAIHuman inherits all properties from oCAniCtrl_Human ... so we can use oCAniCtrl_Human here for our purposes (to get to NPC information)
	var int aniCtrlPtr; aniCtrlPtr = ESI;
	if (!aniCtrlPtr) { return; };

	var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (aniCtrlPtr);

	var int npcPtr; /*npcPtr = EDX;*/ npcPtr = aniCtrl.npc;
	if (!Hlp_Is_oCNpc (npcPtr)) { return; };

	var oCNpc slf; slf = _^ (npcPtr);

	if (oCNpc_IsFadingAway (slf)) {
		//Ignored by traceray (we will not be able to focus it)
		VobTree_SetBitfield (npcPtr, zCVob_bitfield0_ignoredByTraceRay, 1);

		//Remove shadow casting
		VobTree_SetBitfield (npcPtr, zCVob_bitfield0_castDynShadow, 0);

		//Remove from players focus
		NPC_RemoveFromFocus (hero, npcPtr);

		//Fade away Npc
		var int retVal; retVal = oCNpc_FadeAway (slf);
	};
};

func void _event_DropFromSlot_FadeAway (var int dummyVariable) {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNpc slf; slf = _^ (ECX);

	//Is this summoned NPC ?
	if (NPC_GetBitfield (slf, oCNpc_bitfield0_isSummoned)) {
		//If summoned - don't drop any items!
		//By overriding first parameter (at ESP + 4) we will stop NPC from dropping an item
		//oCNpc::DropFromSlot(struct TNpcSlot *)
		MEM_WriteInt (ESP + 4, 0);
	};
};

func void G12_FadeAway_Init () {
	//DoDrop events
	G12_DoDropVobEvent_Init ();

	//Register new listener for DropFromSlot event
	DropFromSlotEvent_AddListener (_event_DropFromSlot_FadeAway);

	const int once = 0;

	if (!once) {
		//0x00615A50 public: virtual void __thiscall oCAIHuman::DoAI(class zCVob *,int &)
		const int oCAIHuman__DoAI_IsDead_G1 = 6380432;

		//0x0069BAB0 public: virtual void __thiscall oCAIHuman::DoAI(class zCVob *,int &)
		const int oCAIHuman__DoAI_IsDead_G2 = 6929568;

		HookEngine (MEMINT_SwitchG1G2 (oCAIHuman__DoAI_IsDead_G1, oCAIHuman__DoAI_IsDead_G2), 5, "_hook_oCAIHuman_DoAI_IsDead__FadeAway");

		once = 1;
	};
};
