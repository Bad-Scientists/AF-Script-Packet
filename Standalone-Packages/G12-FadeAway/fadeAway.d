/*
 *	FadeAway
 *	 - will slowly 'fade-away' NPC (will slowly get transparent) - as soon as NPC is invisible engine function oCNPC::FadeAway removes NPC from the world
 *
 *	Usage:
 *   - define function C_Npc_IsSummoned - defines which Npcs are spawned
 *	 - call from ZS_Dead state following code - if you want your dead NPCs to fade-away:

	//Is this summoned NPC?
	if (C_Npc_IsSummoned (self)) {
		//Is it fading away?
		if (!oCNpc_IsFadingAway (self)) {
			//Start fading away effect:
			Wld_PlayEffect("SPELLFX_MASSDEATH_TARGET", self, self, 0, 0, 0, FALSE);
			oCNpc_StartFadeAway (self);
		};
	};
 */

//-- Internal variables

var int _fadeAway_DropWeapon;
var int _fadeAway_DropInventory;
var int _fadeAway_DontDropFlags;
var int _fadeAway_DontDropMainFlag;

var string _fadeAway_ItemSlotName;

//--

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

	//Safety-net - always kill Npc
	if (slf.attribute[ATR_HITPOINTS] > 0) { slf.attribute[ATR_HITPOINTS] = 0; };

	//Drop inventory into the world
	if (_fadeAway_DropInventory) {
		Npc_DropInventory (slf, _fadeAway_ItemSlotName, _fadeAway_DontDropFlags, _fadeAway_DontDropMainFlag);
	};

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

//0x006A6270 public: class oCVob * __thiscall oCNpc::DropFromSlot(struct TNpcSlot *)
func void _event_DropFromSlot_FadeAway (var int dummyVariable) {
	//Customization
	if (_fadeAway_DropWeapon) { return; };

	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNpc slf; slf = _^ (ECX);

	var int isSummoned; isSummoned = FALSE;

	//Custom function checking whether Npc is summoned or not
	//oCNpc_bitfield0_isSummoned is not saved in save-file! :-/
	const int symbID = 0;
	if (!symbID) {
		symbID = MEM_GetSymbolIndex ("C_Npc_IsSummoned");
	};

	if (symbID != -1) {
		MEM_PushInstParam (slf);
		MEM_CallByID (symbID);

		isSummoned = MEM_PopIntResult ();
	};

	//Keeping it here for 'compatibility' ...
	if (!isSummoned) {
		//Is this summoned NPC ?
		if (NPC_GetBitfield (slf, oCNpc_bitfield0_isSummoned)) {
			isSummoned = TRUE;
		};
	};

	if (isSummoned) {
		var int vobSlotPtr; vobSlotPtr = MEM_ReadInt (ESP + 4);

		//By overriding first parameter (at ESP + 4) we will stop NPC from dropping an item
		//oCNpc::DropFromSlot(struct TNpcSlot *)
		if (vobSlotPtr) {
			var TNpcSlot vobSlot; vobSlot = _^ (vobSlotPtr);

			var int vobPtr; vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");

			if (vobSlot.vob == vobPtr) {
				MEM_WriteInt (ESP + 4, 0);
			};
		};
	};
};

func void G12_FadeAway_Init () {
	//DoDrop events
	G12_DoDropVobEvent_Init ();

	//Register new listener for DropFromSlot event
	DropFromSlotEvent_AddListener (_event_DropFromSlot_FadeAway);

	//-- Load API values / init default values

	_fadeAway_DropWeapon = API_GetSymbolIntValue ("FADEAWAY_DROPWEAPON", FALSE);
	_fadeAway_DropInventory = API_GetSymbolIntValue ("FADEAWAY_DROPINVENTORY", TRUE);
	_fadeAway_DontDropFlags = API_GetSymbolIntValue ("FADEAWAY_DONTDROPFLAGS", 0);
	_fadeAway_DontDropMainFlag = API_GetSymbolIntValue ("FADEAWAY_DONTDROPMAINFLAG", 0);

	_fadeAway_ItemSlotName = API_GetSymbolStringValue ("FADEAWAY_ITEMSLOTNAME", "BIP01");

	//--

	const int once = 0;

	if (!once) {
		//0x00615A50 public: virtual void __thiscall oCAIHuman::DoAI(class zCVob *,int &)
		//615B90
		const int oCAIHuman__DoAI_IsDead_G1 = 6380432;

		//0x0069BAB0 public: virtual void __thiscall oCAIHuman::DoAI(class zCVob *,int &)
		const int oCAIHuman__DoAI_IsDead_G2 = 6929568;

		HookEngine (MEMINT_SwitchG1G2 (oCAIHuman__DoAI_IsDead_G1, oCAIHuman__DoAI_IsDead_G2), 5, "_hook_oCAIHuman_DoAI_IsDead__FadeAway");

		once = 1;
	};
};
