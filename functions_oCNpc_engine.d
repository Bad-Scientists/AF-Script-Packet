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

/*
 *
 */
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
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__DropUnconscious_G1, oCNPC__DropUnconscious_G2));
};

/*
 *
 */
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
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__DoDie_G1, oCNpc__DoDie_G2));
};

/*
 *
 */
func void oCNpc_DoTakeVob (var int slfInstance, var int itemPtr) {
	//006A0D10  .text     Debug data           ?DoTakeVob@oCNpc@@UAEHPAVzCVob@@@Z
	const int oCNpc__DoTakeVob_G1 = 6950160;
	
	//0x007449C0 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G2 = 7621056;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!Hlp_Is_oCItem (itemPtr)) { return; };
	
	CALL_PtrParam (itemPtr);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__DoTakeVob_G1, oCNpc__DoTakeVob_G2));
	
	var int retVal;
	retVal = CALL_RetValAsInt ();
};

/*
 *
 */
func void oCNPC_OpenDeadNpc (var int slfInstance) {
	//0x006BB890 public: void __thiscall oCNpc::OpenDeadNpc(void) 
	const int oCNPC__OpenDeadNpc_G1 = 7059600;
	
	//0x00762970 public: void __thiscall oCNpc::OpenDeadNpc(void)
	const int oCNPC__OpenDeadNpc_G2 = 7743856;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return; };
	
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__OpenDeadNpc_G1, oCNPC__OpenDeadNpc_G2));
};

/*
 *
 */
func void oCNPC_CloseDeadNpc (var int slfInstance) {
	//0x006BBAA0 public: void __thiscall oCNpc::CloseDeadNpc(void) 
	const int oCNPC__CloseDeadNpc_G1 = 7060128;
	
	//0x00762B40 public: void __thiscall oCNpc::CloseDeadNpc(void)
	const int oCNPC__CloseDeadNpc_G2 = 7744320;
	
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return; };

	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__CloseDeadNpc_G1, oCNPC__CloseDeadNpc_G2));
};

/*
 *
 */
func void oCNPC_OpenInventory (var int slfInstance, var int param1) {
	//0x006BB0A0 public: void __thiscall oCNpc::OpenInventory(void) 
	const int oCNPC__OpenInventory_G1 = 7057568;
	
	//0x00762250 public: void __thiscall oCNpc::OpenInventory(int)
	const int oCNPC__OpenInventory_G2 = 7742032;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (MEMINT_SwitchG1G2 (0, 1)) {
		CALL_IntParam (param1);
	};

	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__OpenInventory_G1, oCNPC__OpenInventory_G2));
};

/*
 *
 */
func void oCNPC_CloseInventory (var int slfInstance) {
	//0x006BB2F0 public: void __thiscall oCNpc::CloseInventory(void) 
	const int oCNPC__CloseInventory_G1 = 7058160;
	
	//0x00762410 public: void __thiscall oCNpc::CloseInventory(void)
	const int oCNPC__CloseInventory_G2 = 7742480;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return; };

	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__CloseInventory_G1, oCNPC__CloseInventory_G2));
};

/*
 *
 */
func int oCNpc_UseItem (var int slfInstance, var int itemPtr) {
	//0x00698810 public: int __thiscall oCNpc::UseItem(class oCItem *) 
	const int oCNPC__UseItem_G1 = 6916112;

	//0x0073BC10 public: int __thiscall oCNPC::UseItem(class oCItem *)
	const int oCNPC__UseItem_G2 = 7584784;
	
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPc (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr)); 
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__UseItem_G1, oCNPC__UseItem_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

/*
 *
 */
func int oCNpc_GetSlotItem (var int slfInstance, var string slotName)  {
	
	//0x0068F4F0 public: class oCItem * __thiscall oCNpc::GetSlotItem(class zSTRING const &) 
	const int oCNPC__GetSlotItem_G1 = 6878448;
	
	//0x00731F90 public: class oCItem * __thiscall oCNpc::GetSlotItem(class zSTRING const &) 
	const int oCNPC__GetSlotItem_G2 = 7544720;
	
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPc (slf)) { return 0; };

	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__GetSlotItem_G1, oCNPC__GetSlotItem_G2));

	return CALL_RetValAsPtr ();
};

/*
 *
 */
func int oCNpc_DoExchangeTorch (var int slfInstance)
{
	//0x006A1680 public: virtual int __thiscall oCNpc::DoExchangeTorch(void) 
	const int oCNpc__DoExchangeTorch_G1 = 6952576;

	//0x00745370 public: virtual int __thiscall oCNpc::DoExchangeTorch(void)
	const int oCNpc__DoExchangeTorch_G2 = 7623536;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPc (slf)) { return 0; };

	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__DoExchangeTorch_G1, oCNpc__DoExchangeTorch_G2));
	
	return CALL_RetValAsInt ();
};
