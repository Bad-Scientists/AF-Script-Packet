/*
 *	Author: mud-freak
 */
func void oCNpc_SetFocusVob (var int slfInstance, var int focusPtr) {
	//0068FF70  .text     Debug data           ?SetFocusVob@oCNpc@@QAEXPAVzCVob@@@Z
	const int oCNpc__SetFocusVob_G1 = 6881136;

	//0x00732B60 public: void __thiscall oCNpc::SetFocusVob(class zCVob *)
	const int oCNpc__SetFocusVob_G2 = 7547744;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPc (slf)) { return; };
	
	var int slfPtr; slfPtr = _@ (slf);

	// Update the focus vob (properly, mind the reference counter)
	if (focusPtr != slf.focus_vob) {
		const int call = 0;

		if (CALL_Begin(call)) {
			CALL_PtrParam(_@(focusPtr)); 
			CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetFocusVob_G1, oCNpc__SetFocusVob_G2));
			call = CALL_End();
		};
	};
};

func void oCNPC_DropUnconscious (var int slfInstance, var int attackerInstance)
{
	//00692C10  .text     Debug data           ?DropUnconscious@oCNPC@@QAEXMPAV1@@Z
	const int oCNPC__DropUnconscious_G1 = 6892560;
	
	//0x00735EB0 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNPC__DropUnconscious_G2 = 7560880;
	
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	var oCNPC attacker; attacker = Hlp_GetNPC (attackerInstance);
	
	var int attackerPtr; attackerPtr = 0;
	
	if (Hlp_IsValidNPC (attacker)) {
		attackerPtr = _@ (attacker);
	};
	
	CALL_PtrParam (attackerPtr);
	CALL_FloatParam (mkf (0));	//???
	CALL__thiscall (MEM_InstToPtr (slf), MEMINT_SwitchG1G2 (oCNPC__DropUnconscious_G1, oCNPC__DropUnconscious_G2));
};

func void oCNpc_DoDie (var int slfInstance, var int attackerInstance)
{
	//006934A0  .text     Debug data           ?DoDie@oCNpc@@UAEXPAV1@@Z
	const int oCNpc__DoDie_G1 = 6894752;

	//0x00736760 public: virtual void __thiscall oCNpc::DoDie(class oCNpc *)
	const int oCNpc__DoDie_G2 = 7563104;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	var oCNPC attacker; attacker = Hlp_GetNPC (attackerInstance);
	
	var int attackerPtr; attackerPtr = 0;
	
	if (Hlp_IsValidNPC (attacker)) {
		attackerPtr = _@ (attacker);
	};

	CALL_PtrParam (attackerPtr);
	CALL__thiscall (MEM_InstToPtr (slf), MEMINT_SwitchG1G2 (oCNpc__DoDie_G1, oCNpc__DoDie_G2));
};

func void oCNpc_DoTakeVob (var int slfInstance, var int itemPtr) {
	//006A0D10  .text     Debug data           ?DoTakeVob@oCNpc@@UAEHPAVzCVob@@@Z
	const int oCNpc__DoTakeVob_G1 = 6950160;
	
	//0x007449C0 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G2 = 7621056;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!Hlp_Is_oCItem (itemPtr)) { return; };
	
	CALL_PtrParam (itemPtr);
	CALL__thiscall (MEM_InstToPtr (slf), MEMINT_SwitchG1G2 (oCNpc__DoTakeVob_G1, oCNpc__DoTakeVob_G2));
	
	var int retVal;
	retVal = CALL_RetValAsInt ();
};
