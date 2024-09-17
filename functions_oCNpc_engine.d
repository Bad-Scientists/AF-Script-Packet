/*
 *	Author: mud-freak
 */
func void oCNpc_SetFocusVob (var int slfInstance, var int focusPtr) {
	//0x0068FF70 public: void __thiscall oCNpc::SetFocusVob(class zCVob *)
	const int oCNpc__SetFocusVob_G1 = 6881136;

	//0x00732B60 public: void __thiscall oCNpc::SetFocusVob(class zCVob *)
	const int oCNpc__SetFocusVob_G2 = 7547744;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
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

func void oCNpc_SetInteractItem(var int slfInstance, var int itemPtr) {
	//0x006A6670 public: void __thiscall oCNpc::SetInteractItem(class oCItem *)
	const int oCNpc__SetInteractItem_G1 = 6973040;

	//0x0074ACC0 public: void __thiscall oCNpc::SetInteractItem(class oCItem *)
	const int oCNpc__SetInteractItem_G2 = 7646400;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(itemPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2(oCNpc__SetInteractItem_G1, oCNpc__SetInteractItem_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void oCNpc_SetEnemy (var int slfInstance, var int focusPtr) {
	//0x00691A80 public: void __thiscall oCNpc::SetEnemy(class oCNpc *)
	const int oCNpc__SetEnemy_G1 = 6888064;

	//0x00734BC0 public: void __thiscall oCNpc::SetEnemy(class oCNpc *)
	const int oCNpc__SetEnemy_G2 = 7556032;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(focusPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetEnemy_G1, oCNpc__SetEnemy_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void oCNpc_DropUnconscious (var int slfInstance, var int attackerInstance) {
	//0x00692C10 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNpc__DropUnconscious_G1 = 6892560;

	//0x00735EB0 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNpc__DropUnconscious_G2 = 7560880;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	var int attackerPtr; attackerPtr = 0;
	var oCNPC attacker; attacker = Hlp_GetNPC (attackerInstance);
	if (Hlp_IsValidNPC (attacker)) {
		attackerPtr = _@ (attacker);
	};

	//Safety check - game crashes if called with Npc that is not in active vob list
	if (!VobPtr_IsInActiveVobList (slfPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (attackerPtr));
		CALL_FloatParam (_@ (FLOATNULL));	//???
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DropUnconscious_G1, oCNpc__DropUnconscious_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void oCNpc_DoDie (var int slfInstance, var int attackerInstance) {
	//0x006934A0 public: virtual void __thiscall oCNpc::DoDie(class oCNpc *)
	const int oCNpc__DoDie_G1 = 6894752;

	//0x00736760 public: virtual void __thiscall oCNpc::DoDie(class oCNpc *)
	const int oCNpc__DoDie_G2 = 7563104;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	var int attackerPtr; attackerPtr = 0;
	var oCNPC attacker; attacker = Hlp_GetNPC (attackerInstance);
	if (Hlp_IsValidNPC (attacker)) {
		attackerPtr = _@ (attacker);
	};

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (attackerPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoDie_G1, oCNpc__DoDie_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func int oCNpc_DoTakeVob (var int slfInstance, var int vobPtr) {
	//0x006A0D10 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G1 = 6950160;

	//0x007449C0 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G2 = 7621056;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	if (!vobPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoTakeVob_G1, oCNpc__DoTakeVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

/*
 *
 */
func void oCNpc_OpenDeadNpc (var int slfInstance) {
	//0x006BB890 public: void __thiscall oCNpc::OpenDeadNpc(void)
	const int oCNpc__OpenDeadNpc_G1 = 7059600;

	//0x00762970 public: void __thiscall oCNpc::OpenDeadNpc(void)
	const int oCNpc__OpenDeadNpc_G2 = 7743856;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__OpenDeadNpc_G1, oCNpc__OpenDeadNpc_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void oCNpc_CloseDeadNpc (var int slfInstance) {
	//0x006BBAA0 public: void __thiscall oCNpc::CloseDeadNpc(void)
	const int oCNpc__CloseDeadNpc_G1 = 7060128;

	//0x00762B40 public: void __thiscall oCNpc::CloseDeadNpc(void)
	const int oCNpc__CloseDeadNpc_G2 = 7744320;
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__CloseDeadNpc_G1, oCNpc__CloseDeadNpc_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void oCNpc_OpenInventory (var int slfInstance, var int param1) {
	//0x006BB0A0 public: void __thiscall oCNpc::OpenInventory(void)
	const int oCNpc__OpenInventory_G1 = 7057568;

	//0x00762250 public: void __thiscall oCNpc::OpenInventory(int)
	const int oCNpc__OpenInventory_G2 = 7742032;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		if (MEMINT_SwitchG1G2 (0, 1)) {
			CALL_IntParam (_@ (param1));
		};

		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__OpenInventory_G1, oCNpc__OpenInventory_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void oCNpc_CloseInventory (var int slfInstance) {
	//0x006BB2F0 public: void __thiscall oCNpc::CloseInventory(void)
	const int oCNpc__CloseInventory_G1 = 7058160;

	//0x00762410 public: void __thiscall oCNpc::CloseInventory(void)
	const int oCNpc__CloseInventory_G2 = 7742480;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__CloseInventory_G1, oCNpc__CloseInventory_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func int oCNpc_UseItem (var int slfInstance, var int itemPtr) {
	//0x00698810 public: int __thiscall oCNpc::UseItem(class oCItem *)
	const int oCNpc__UseItem_G1 = 6916112;

	//0x0073BC10 public: int __thiscall oCNPC::UseItem(class oCItem *)
	const int oCNpc__UseItem_G2 = 7584784;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__UseItem_G1, oCNpc__UseItem_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

/*
 *
 */
func int oCNpc_GetSlotItem (var int slfInstance, var string slotName)  {

	//0x0068F4F0 public: class oCItem * __thiscall oCNpc::GetSlotItem(class zSTRING const &)
	const int oCNpc__GetSlotItem_G1 = 6878448;

	//0x00731F90 public: class oCItem * __thiscall oCNpc::GetSlotItem(class zSTRING const &)
	const int oCNpc__GetSlotItem_G2 = 7544720;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__GetSlotItem_G1, oCNpc__GetSlotItem_G2));

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
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoExchangeTorch_G1, oCNpc__DoExchangeTorch_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCNpc_HasTorch (var int slfInstance) {
	//0x00697EC0 public: int __thiscall oCNpc::HasTorch(void)
	const int oCNpc__HasTorch_G1 = 6913728;

	//0x0073B2C0 public: int __thiscall oCNpc::HasTorch(void)
	const int oCNpc__HasTorch_G2 = 7582400;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__HasTorch_G1, oCNpc__HasTorch_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};


/*
const int FMODE_NONE = 0;
const int FMODE_FIST = 1;
const int FMODE_MELEE = 2;
const int FMODE_FAR = 5;
const int FMODE_MAGIC = 7;
*/

func void oCNpc_SetWeaponMode (var int slfInstance, var int weaponMode) {
	//0x00696550 public: virtual void __thiscall oCNpc::SetWeaponMode(int)
	const int oCNpc__SetWeaponMode_G1 = 6907216;

	//0x00739940 public: virtual void __thiscall oCNpc::SetWeaponMode(int)
	const int oCNpc__SetWeaponMode_G2 = 7575872;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (weaponMode));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetWeaponMode_G1, oCNpc__SetWeaponMode_G2));
		call = CALL_End();
	};
};

func void oCNpc_SetWeaponMode2 (var int slfInstance, var int weaponMode) {
	//0x00695A60 public: virtual void __thiscall oCNpc::SetWeaponMode2(int)
	const int oCNpc__SetWeaponMode2_G1 = 6904416;

	//0x00738E80 public: virtual void __thiscall oCNpc::SetWeaponMode2(int)
	const int oCNpc__SetWeaponMode2_G2 = 7573120;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (weaponMode));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetWeaponMode2_G1, oCNpc__SetWeaponMode2_G2));
		call = CALL_End();
	};
};

func int oCNpc_GetWeaponMode (var int slfInstance) {
	//0x00695820 public: int __thiscall oCNpc::GetWeaponMode(void)
	const int oCNpc__GetWeaponMode_G1 = 6903840;

	//0x00738C40 public: int __thiscall oCNpc::GetWeaponMode(void)
	const int oCNpc__GetWeaponMode_G2 = 7572544;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetWeaponMode_G1, oCNpc__GetWeaponMode_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

/*
 *	NPC vob list
 */

/*
 *	oCNpc_CreateVobList (var int slfInstance, var int rangeF)
 *	Pretty much same as NPC_PerceiveAll - however allows you to control rangeF in which Vobs will be collected.
 *	When used all collected vobs will be available in slf.vobList_array.
 */
func void oCNpc_CreateVobList (var int slfInstance, var int rangeF) {
	//0x006B7110 public: void __thiscall oCNpc::CreateVobList(float)
	const int oCNpc__CreateVobList_G1 = 7041296;

	//0x0075DA40 public: void __thiscall oCNpc::CreateVobList(float)
	const int oCNpc__CreateVobList_G2 = 7723584;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (rangeF));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__CreateVobList_G1, oCNpc__CreateVobList_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_ClearVobList (var int slfInstance)
 *	Clears slf.vobList_array
 */
func void oCNpc_ClearVobList (var int slfInstance) {
	//0x006B6EB0 public: void __thiscall oCNpc::ClearVobList(void)
	const int oCNpc__ClearVobList_G1 = 7040688;

	//0x0075D7F0 public: void __thiscall oCNpc::ClearVobList(void)
	const int oCNpc__ClearVobList_G2 = 7722992;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__ClearVobList_G1, oCNpc__ClearVobList_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_InsertInVobList (var int slfInstance, var int vobPtr)
 *	Adds specific vobPtr from slf.vobList_array
 */
func void oCNpc_InsertInVobList (var int slfInstance, var int vobPtr) {
	//0x006B6F30 public: void __thiscall oCNpc::InsertInVobList(class zCVob *)
	const int oCNpc__InsertInVobList_G1 = 7040816;

	//0x0075D870 public: void __thiscall oCNpc::InsertInVobList(class zCVob *)
	const int oCNpc__InsertInVobList_G2 = 7723120;

	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__InsertInVobList_G1, oCNpc__InsertInVobList_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_RemoveFromVobList (var int slfInstance, var int vobPtr)
 *	Removes specific vobPtr from slf.vobList_array
 */
func void oCNpc_RemoveFromVobList (var int slfInstance, var int vobPtr) {
	//0x006B7080 public: void __thiscall oCNpc::RemoveFromVobList(class zCVob *)
	const int oCNpc__RemoveFromVobList_G1 = 7041152;

	//0x0075D9B0 public: void __thiscall oCNpc::RemoveFromVobList(class zCVob *)
	const int oCNpc__RemoveFromVobList_G2 = 7723440;

	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__RemoveFromVobList_G1, oCNpc__RemoveFromVobList_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func int oCNpc_CanSee (var int slfInstance, var int vobPtr, var int ignoreAngles){
	//0x0069E010 public: int __thiscall oCNpc::CanSee(class zCVob *,int)
	const int oCNpc__CanSee_G1 = 6938640;

	//0x00741C10 public: int __thiscall oCNPC::CanSee(class zCVob *,int)
	const int oCNpc__CanSee_G2 = 7609360;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (ignoreAngles));
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__CanSee_G1, oCNpc__CanSee_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

func int oCNpc_FreeLineOfSight (var int slfInstance, var int vobPtr){
	//0x0069DE50 public: int __thiscall oCNpc::FreeLineOfSight(class zCVob *)
	const int oCNpc__FreeLineOfSight_G1 = 6938192;

	//0x007418E0 public: int __thiscall oCNpc::FreeLineOfSight(class zCVob *)
	const int oCNpc__FreeLineOfSight_G2 = 7608544;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__FreeLineOfSight_G1, oCNpc__FreeLineOfSight_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

func int oCNpc_DoDropVob (var int slfInstance, var int vobPtr) {
	//0x006A10F0 public: virtual int __thiscall oCNpc::DoDropVob(class zCVob *)
	const int oCNpc__DoDropVob_G1 = 6951152;

	//0x00744DD0 public: virtual int __thiscall oCNpc::DoDropVob(class zCVob *)
	const int oCNpc__DoDropVob_G2 = 7622096;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoDropVob_G1, oCNpc__DoDropVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

func void oCNpc_DropAllInHand (var int slfInstance)
{
	//0x00694230 public: void __thiscall oCNpc::DropAllInHand(void)
	const int oCNpc__DropAllInHand_G1 = 6898224;

	//0x007375E0 public: void __thiscall oCNpc::DropAllInHand(void)
	const int oCNpc__DropAllInHand_G2 = 7566816;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DropAllInHand_G1, oCNpc__DropAllInHand_G2));
		call = CALL_End();
	};
};

func void oCNpc_SetRightHand (var int slfInstance, var int vobPtr) {
	//0x00697DC0 public: void __thiscall oCNpc::SetRightHand(class oCVob *)
	const int oCNpc__SetRightHand_G1 = 6913472;

	//0x0073B1C0 public: void __thiscall oCNpc::SetRightHand(class oCVob *)
	const int oCNpc__SetRightHand_G2 = 7582144;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetRightHand_G1, oCNpc__SetRightHand_G2));
		call = CALL_End();
	};
};

func void oCNpc_SetLeftHand (var int slfInstance, var int vobPtr) {
	//0x00697CC0 public: void __thiscall oCNpc::SetLeftHand(class oCVob *)
	const int oCNpc__SetLeftHand_G1 = 6913216;

	//0x0073B0C0 public: void __thiscall oCNpc::SetLeftHand(class oCVob *)
	const int oCNpc__SetLeftHand_G2 = 7581888;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetLeftHand_G1, oCNpc__SetLeftHand_G2));
		call = CALL_End();
	};
};

/*	angleX
 *	 - negative number vob is on lefthand-side
 *	 - 0 vob is directly in front of npc
 *	 - positive number vob is on righthand-side
 *	angleY
 *	 - negative number vob is below npc
 *	 - 0 vob is directly in front of NPC
 *	 - positive number vob is above npc
 */
func void oCNpc_GetAnglesVob (var int slfInstance, var int vobPtr, var int angleXPtr, var int angleYPtr) {
	//0x0074C0D0 public: void __thiscall oCNpc::GetAngles(class zCVob *,float &,float &)
	const int oCNpc__GetAnglesVob_G1 = 7651536;

	//0x00681680 public: void __thiscall oCNpc::GetAngles(class zCVob *,float &,float &)
	const int oCNpc__GetAnglesVob_G2 = 6821504;

	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {

		CALL_PtrParam (_@ (angleYPtr));
		CALL_PtrParam (_@ (angleXPtr));

		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetAnglesVob_G1, oCNpc__GetAnglesVob_G2));
		call = CALL_End();
	};
};

func void oCNpc_GetAngles (var int slfInstance, var int posPtr, var int angleXPtr, var int angleYPtr) {
	//0x0074BD00 public: void __thiscall oCNpc::GetAngles(class zVEC3 &,float &,float &)
	const int oCNpc__GetAngles_G1 = 7650560;

	//0x006812B0 public: void __thiscall oCNpc::GetAngles(class zVEC3 &,float &,float &)
	const int oCNpc__GetAngles_G2 = 6820528;

	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {

		CALL_PtrParam (_@ (angleYPtr));
		CALL_PtrParam (_@ (angleXPtr));

		CALL_PtrParam (_@ (posPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetAngles_G1, oCNpc__GetAngles_G2));
		call = CALL_End();
	};
};

func int NPC_IsVobPtrInAngleX (var int slfInstance, var int vobPtr, var int angle) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (!vobPtr) { return FALSE; };

	var int angleX;
	var int angleY;

	oCNpc_GetAnglesVob (slfInstance, vobPtr, _@ (angleX), _@ (angleY));

	if (gef (angleX, negf (mkf (angle))))
	&& (lef (angleX, mkf (angle)))
	{
		return TRUE;
	};

	return FALSE;
};

func int NPC_IsVobPtrInAngleY (var int slfInstance, var int vobPtr, var int angle) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (!vobPtr) { return FALSE; };

	var int angleX;
	var int angleY;

	oCNpc_GetAnglesVob (slfInstance, vobPtr, _@ (angleX), _@ (angleY));

	if (gef (angleY, negf (mkf (angle))))
	&& (lef (angleY, mkf (angle)))
	{
		return TRUE;
	};

	return FALSE;
};

func int NPC_IsNpcInAngleX (var int slfInstance, var int npcInstance, var int angle) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var oCNPC npc; npc = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (npc)) { return FALSE; };

	return + (NPC_IsVobPtrInAngleX (slfInstance, _@ (npc), angle));
};

func int NPC_IsNpcInAngleY (var int slfInstance, var int npcInstance, var int angle) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var oCNPC npc; npc = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (npc)) { return FALSE; };

	return + (NPC_IsVobPtrInAngleY (slfInstance, _@ (npc), angle));
};

/*
 *
 */
func int oCNpc_DoThrowVob (var int slfInstance, var int vobPtr, var int speedF) {
	//0x006A13C0 public: virtual int __thiscall oCNpc::DoThrowVob(class zCVob *,float)
	const int oCNpc__DoThrowVob_G1 = 6951872;

	//0x007450B0 public: virtual int __thiscall oCNPC::DoThrowVob(class zCVob *,float)
	const int oCNpc__DoThrowVob_G2 = 7622832;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (speedF));
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoThrowVob_G1, oCNpc__DoThrowVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCNpc_FindMobInter (var int slfInstance, var string scemeName) {
	//0x0069C720 public: class oCMobInter * __thiscall oCNpc::FindMobInter(class zSTRING const &)
	const int oCNpc__FindMobInter_G1 = 6932256;

	//0x0073FE70 public: class oCMobInter * __thiscall oCNpc::FindMobInter(class zSTRING const &)
	const int oCNpc__FindMobInter_G2 = 7601776;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	scemeName = STR_Upper (scemeName);

	CALL_zStringPtrParam (scemeName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__FindMobInter_G1, oCNpc__FindMobInter_G2));

	return CALL_RetValAsPtr ();
};

func int oCNpc_DropFromSlot (var int slfInstance, var string slotName) {
	//0x006A61A0 public: class oCVob * __thiscall oCNpc::DropFromSlot(class zSTRING const &)
	const int oCNpc__DropFromSlot_G1 = 6971808;

	//0x0074A590 public: class oCVob * __thiscall oCNpc::DropFromSlot(class zSTRING const &)
	const int oCNpc__DropFromSlot_G2 = 7644560;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__DropFromSlot_G1, oCNpc__DropFromSlot_G2));

	return CALL_RetValAsPtr ();
};

func int oCNpc_GetTalkingWith (var int slfInstance) {
	//0x006335D0 public: class oCNpc * __thiscall oCNpc::GetTalkingWith(void)
	const int oCNpc__GetTalkingWith_G1 = 6501840;

	//0x006BCF60 public: class oCNpc * __thiscall oCNpc::GetTalkingWith(void)
	const int oCNpc__GetTalkingWith_G2 = 7065440;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetTalkingWith_G1, oCNpc__GetTalkingWith_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func int oCNpc_BeamTo (var int slfInstance, var string targetVob) {
	//0x00693B10 public: int __thiscall oCNpc::BeamTo(class zSTRING const &)
	const int oCNpc__BeamTo_G1 = 6896400;

	//0x00736EE0 public: int __thiscall oCNpc::BeamTo(class zSTRING const &)
	const int oCNpc__BeamTo_G2 = 7565024;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	CALL_zstringPtrParam (targetVob);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__BeamTo_G1, oCNpc__BeamTo_G2));
	return CALL_RetValAsInt ();
};

func void oCNpc_Enable (var int slfInstance, var int posPtr) {
	//0x006A2000 public: virtual void __thiscall oCNpc::Enable(class zVEC3 &)
	const int oCNpc__Enable_G1 = 6955008;

	//0x00745D40 public: virtual void __thiscall oCNpc::Enable(class zVEC3 &)
	const int oCNpc__Enable_G2 = 7626048;

	if (!posPtr) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@ (posPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__Enable_G1, oCNpc__Enable_G2));
		call = CALL_End();
	};
};

func void oCNpc_Disable (var int slfInstance) {
	//0x006A1D20 public: virtual void __thiscall oCNpc::Disable(void)
	const int oCNpc__Disable_G1 = 6954272;

	//0x00745A20 public: virtual void __thiscall oCNpc::Disable(void)
	const int oCNpc__Disable_G2 = 7625248;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__Disable_G1, oCNpc__Disable_G2));
		call = CALL_End();
	};
};

func void oCNpc_ClearEM (var int slfInstance) {
	//0x006A2610 public: void __thiscall oCNpc::ClearEM(void)
	const int oCNpc__ClearEM_G1 = 6956560;

	//0x00746400 public: void __thiscall oCNpc::ClearEM(void)
	const int oCNpc__ClearEM_G2 = 7627776;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__ClearEM_G1, oCNpc__ClearEM_G2));
		call = CALL_End();
	};
};

//0x00639840 private: virtual void __thiscall oCGame::SetAsPlayer(class zSTRING const &)
//0x006C3D20 private: virtual void __thiscall oCGame::SetAsPlayer(class zSTRING const &)

func void oCNpc_SetAsPlayer (var int slfInstance) {
	//0x0069EAE0 public: virtual void __thiscall oCNpc::SetAsPlayer(void)
	const int oCNpc__SetAsPlayer_G1 = 6941408;

	//0x007426A0 public: virtual void __thiscall oCNpc::SetAsPlayer(void)
	const int oCNpc__SetAsPlayer_G2 = 7612064;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetAsPlayer_G1, oCNpc__SetAsPlayer_G2));
		call = CALL_End();
	};
};

func string oCNpc_GetVisualBody (var int slfInstance) {
	//0x006953A0 public: class zSTRING __thiscall oCNpc::GetVisualBody(void)
	const int oCNpc__GetVisualBody_G1 = 6902688;

	//0x007387C0 public: class zSTRING __thiscall oCNpc::GetVisualBody(void)
	const int oCNpc__GetVisualBody_G2 = 7571392;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return STR_EMPTY; };

	CALL_RetValIszString ();
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__GetVisualBody_G1, oCNpc__GetVisualBody_G2));
	return CALL_RetValAszstring ();
};

func void oCNpc_ResetPos (var int slfInstance, var int posPtr) {
	//0x0074CED0 public: virtual void __thiscall oCNpc::ResetPos(class zVEC3 &)
	const int oCNPC__ResetPos_G1 = 7655120;

	//0x006824D0 public: virtual void __thiscall oCNpc::ResetPos(class zVEC3 &)
	const int oCNPC__ResetPos_G2 = 6825168;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam(_@ (posPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__ResetPos_G1, oCNPC__ResetPos_G2));
		call = CALL_End();
	};
};

func int oCNpc_HasPerception (var int slfInstance, var int percType) {
	//0x006B7AA0 public: int __thiscall oCNpc::HasPerception(int)
	const int oCNpc__HasPerception_G1 = 7043744;

	//0x0075E3C0 public: int __thiscall oCNpc::HasPerception(int)
	const int oCNpc__HasPerception_G2 = 7726016;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (percType));
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__HasPerception_G1, oCNpc__HasPerception_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int oCNpc_GetPerceptionFunc (var int slfInstance, var int percType) {
	//0x006B7AE0 public: int __thiscall oCNpc::GetPerceptionFunc(int)
	const int oCNpc__GetPerceptionFunc_G1 = 7043808;

	//0x0075E400 public: int __thiscall oCNpc::GetPerceptionFunc(int)
	const int oCNpc__GetPerceptionFunc_G2 = 7726080;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (percType));
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetPerceptionFunc_G1, oCNpc__GetPerceptionFunc_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void oCNpc_EnablePerception (var int slfInstance, var int percType, var int funcID) {
	//0x006B7900 public: void __thiscall oCNpc::EnablePerception(int,int)
	const int oCNpc__EnablePerception_G1 = 7043328;

	//0x0075E220 public: void __thiscall oCNpc::EnablePerception(int,int)
	const int oCNpc__EnablePerception_G2 = 7725600;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (funcID));
		CALL_IntParam (_@ (percType));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__EnablePerception_G1, oCNpc__EnablePerception_G2));
		call = CALL_End();
	};
};

func void oCNpc_SetRoute (var int slfInstance, var int routePtr) {
	//0x0074C7C0 public: void __thiscall oCNpc::SetRoute(class zCRoute *)
	const int oCNpc__SetRoute_G1 = 7653312;

	//0x00681D70 public: void __thiscall oCNpc::SetRoute(class zCRoute *)
	const int oCNpc__SetRoute_G2 = 6823280;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (routePtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetRoute_G1, oCNpc__SetRoute_G2));
		call = CALL_End ();
	};
};

func void oCNpc_PutInSlot_Fixed (var int slfInstance, var string slotName, var int vobPtr, var int inInv) {
	//0x006A5940 public: void __thiscall oCNpc::PutInSlot(class zSTRING const &,class oCVob *,int)
	const int oCNpc__PutInSlot_G1 = 6969664;

	//0x00749CB0 public: void __thiscall oCNpc::PutInSlot(class zSTRING const &,class oCVob *,int)
	const int oCNpc__PutInSlot_G2 = 7642288;

	if (!vobPtr) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	slotName = STR_Upper (slotName);

	CALL_IntParam(inInv);
	CALL_PtrParam(vobPtr);
	CALL_zStringPtrParam (slotName);
	CALL__thiscall (slfPtr, MEMINT_SwitchG1G2 (oCNpc__PutInSlot_G1, oCNpc__PutInSlot_G2));
};

//0x006A5A10 public: void __thiscall oCNpc::PutInSlot(struct TNpcSlot *,class oCVob *,int)
//0x00749D80 public: void __thiscall oCNpc::PutInSlot(struct TNpcSlot *,class oCVob *,int)

func void oCNpc_PutItemInSlot (var int slfInstance, var string slotName, var int itemInstanceID) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (Npc_HasItems (slf, itemInstanceID)) {
		oCNpc_PutInSlot_Fixed (slf, slotName, _@ (item), 1);
	};
};

/*
 *	spellType --> spellID
 */
func int oCNpc_AssessMagic_S (var int slfInstance, var int othInstance, var int spellType) {
	//0x006B62F0 public: int __thiscall oCNpc::AssessMagic_S(class oCNpc *,int)
	const int oCNpc__AssessMagic_S_G1 = 7037680;

	//0x0075CC30 public: int __thiscall oCNpc::AssessMagic_S(class oCNpc *,int)
	const int oCNpc__AssessMagic_S_G2 = 7719984;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	var int slfPtr; slfPtr = _@ (slf);

	var oCNpc oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return FALSE; };
	var int othPtr; othPtr = _@ (oth);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (spellType));
		CALL_PtrParam (_@ (othPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__AssessMagic_S_G1, oCNpc__AssessMagic_S_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int oCNpc_AssessStopMagic_S (var int slfInstance, var int othInstance) {
	//0x006B65F0 public: int __thiscall oCNpc::AssessStopMagic_S(class oCNpc *,int)
	const int oCNpc__AssessStopMagic_S_G1 = 7038448;

	//0x0075CF30 public: int __thiscall oCNpc::AssessStopMagic_S(class oCNpc *,int)
	const int oCNpc__AssessStopMagic_S_G2 = 7720752;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	var int slfPtr; slfPtr = _@ (slf);

	var oCNpc oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return FALSE; };
	var int othPtr; othPtr = _@ (oth);

	//spellType is redundant
	var int spellType; spellType = 0;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (spellType));
		CALL_PtrParam (_@ (othPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__AssessStopMagic_S_G1, oCNpc__AssessStopMagic_S_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void oCNpc_UnreadySpell (var int slfInstance) {
	//0x0074B090 public: int __thiscall oCNpc::UnreadySpell(void)
	const int oCNpc__UnreadySpell_G1 = 7647376;

	//0x00680480 public: int __thiscall oCNpc::UnreadySpell(void)
	const int oCNpc__UnreadySpell_G2 = 6816896;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__UnreadySpell_G1, oCNpc__UnreadySpell_G2));
		call = CALL_End();
	};
};

func void oCNpc_RbtInit (var int slfInstance, var int posPtr, var int vobPtr) {
	//0x00750720 public: void __thiscall oCNpc::RbtInit(class zVEC3 &,class zCVob *)
	const int oCNpc__RbtInit_G1 = 7669536;

	//0x00686670 public: void __thiscall oCNpc::RbtInit(class zVEC3 &,class zCVob *)
	const int oCNpc__RbtInit_G2 = 6841968;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (posPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__RbtInit_G1, oCNpc__RbtInit_G2));
		call = CALL_End();
	};
};

func void oCNpc_SetBodyState (var int slfInstance, var int bodyState) {
	//0x006B8000 public: void __thiscall oCNpc::SetBodyState(int)
	const int oCNpc__SetBodyState_G1 = 7045120;

	//0x0075E920 public: void __thiscall oCNpc::SetBodyState(int)
	const int oCNpc__SetBodyState_G2 = 7727392;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int BS_ONLY_STATE = 127;
	var int bs; bs = bodyState & BS_ONLY_STATE;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (bs));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetBodyState_G1, oCNpc__SetBodyState_G2));
		call = CALL_End();
	};
};

func void Npc_StartFlyDamage (var int slfInstance, var int damageF, var int vecPtr) {
	//0x00616140 public: void __thiscall oCAIHuman::StartFlyDamage(float,class zVEC3 &)
	const int oCAIHuman__StartFlyDamage_G1 = 6381888;

	//0x0069D940 public: void __thiscall oCAIHuman::StartFlyDamage(float,class zVEC3 &)
	const int oCAIHuman__StartFlyDamage_G2 = 6936896;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!slf.human_ai) { return; };

	var int slfAIPtr; slfAIPtr = slf.human_ai;

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vecPtr));
		CALL_FloatParam (_@ (damageF));
		CALL__thiscall(_@(slfAIPtr), MEMINT_SwitchG1G2 (oCAIHuman__StartFlyDamage_G1, oCAIHuman__StartFlyDamage_G2));
		call = CALL_End();
	};
};

func int oCNpc_IsBodyStateInterruptable (var int slfInstance) {
	//0x006B8600 public: int __thiscall oCNpc::IsBodyStateInterruptable(void)
	const int oCNpc__IsBodyStateInterruptable_G1 = 7046656;

	//0x0075EFA0 public: int __thiscall oCNpc::IsBodyStateInterruptable(void)
	const int oCNpc__IsBodyStateInterruptable_G2 = 7729056;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__IsBodyStateInterruptable_G1, oCNpc__IsBodyStateInterruptable_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void oCNpc_SetBodyStateModifier (var int slfInstance, var int bodyStateModifier) {
	//0x006B8270 public: void __thiscall oCNpc::SetBodyStateModifier(int)
	const int oCNpc__SetBodyStateModifier_G1 = 7045744;

	//0x0075EC10 public: void __thiscall oCNpc::SetBodyStateModifier(int)
	const int oCNpc__SetBodyStateModifier_G2 = 7728144;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (bodyStateModifier));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetBodyStateModifier_G1, oCNpc__SetBodyStateModifier_G2));
		call = CALL_End ();
	};
};

func void oCNpc_ClrBodyStateModifier (var int slfInstance, var int bodyStateModifier) {
	//0x006B82A0 public: void __thiscall oCNpc::ClrBodyStateModifier(int)
	const int oCNpc__ClrBodyStateModifier_G1 = 7045792;

	//0x0075EC40 public: void __thiscall oCNpc::ClrBodyStateModifier(int)
	const int oCNpc__ClrBodyStateModifier_G2 = 7728192;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (bodyStateModifier));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__ClrBodyStateModifier_G1, oCNpc__ClrBodyStateModifier_G2));
		call = CALL_End ();
	};
};

func int oCNpc_HasBodyStateModifier (var int slfInstance, var int bodyStateModifier) {
	//0x006B8250 public: int __thiscall oCNpc::HasBodyStateModifier(int)
	const int oCNpc__HasBodyStateModifier_G1 = 7045712;

	//0x0075EBF0 public: int __thiscall oCNpc::HasBodyStateModifier(int)
	const int oCNpc__HasBodyStateModifier_G2 = 7728112;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (bodyStateModifier));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__HasBodyStateModifier_G1, oCNpc__HasBodyStateModifier_G2));
		call = CALL_End ();
	};

	return + retVal;
};

func int oCNpc_HasVobDetected (var int slfInstance, var int vobPtr) {
	//0x0069CE90 public: int __thiscall oCNpc::HasVobDetected(class zCVob *)
	const int oCNpc__HasVobDetected_G1 = 6934160;

	//0x007405B0 public: int __thiscall oCNpc::HasVobDetected(class zCVob *)
	const int oCNpc__HasVobDetected_G2 = 7603632;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall(_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__HasVobDetected_G1, oCNpc__HasVobDetected_G2));
		call = CALL_End();
	};

	return +retVal;
};

func int oCNpc_StopFaceAni (var int slfInstance, var string faceAni) {
	//0x00695730 public: int __thiscall oCNpc::StopFaceAni(class zSTRING const &)
	const int oCNpc__StopFaceAni_G1 = 6903600;

	//0x00738B50 public: int __thiscall oCNpc::StopFaceAni(class zSTRING const &)
	const int oCNpc__StopFaceAni_G2 = 7572304;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	var int slfPtr; slfPtr = _@ (slf);

	CALL_zstringPtrParam (faceAni);
	CALL__thiscall (slfPtr, MEMINT_SwitchG1G2 (oCNpc__StopFaceAni_G1, oCNpc__StopFaceAni_G2));

	return CALL_RetValAsInt();
};

func int oCNpc_CanDrawWeapon (var int slfInstance) {
	//0x0074B1F0 public: int __thiscall oCNpc::CanDrawWeapon(void)
	const int oCNpc__CanDrawWeapon_G1 = 7647728;

	//0x006805C0 public: int __thiscall oCNpc::CanDrawWeapon(void)
	const int oCNpc__CanDrawWeapon_G2 = 6817216;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall(_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__CanDrawWeapon_G1, oCNpc__CanDrawWeapon_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	oCNpc_StopTheft
 *	 - engine function closes steal inventory
 *	 - if parameter victimIsAware is true then it also sends perception PERC_CATCHTHIEF to victim
 */
func void oCNpc_StopTheft (var int slfInstance, var int thiefPtr, var int victimIsAware) {
	//0x006BAFD0 public: void __thiscall oCNpc::StopTheft(class oCNpc *,int)
	const int oCNpc__StopTheft_G1 = 7057360;

	//0x00762160 public: void __thiscall oCNpc::StopTheft(class oCNpc *,int)
	const int oCNpc__StopTheft_G2 = 7741792;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (victimIsAware));
		CALL_PtrParam (_@ (thiefPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__StopTheft_G1, oCNpc__StopTheft_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_SetMovLock
 */
func void oCNpc_SetMovLock (var int slfInstance, var int on) {
	//0x00694C50 public: void __thiscall oCNpc::SetMovLock(int)
	const int oCNpc__SetMovLock_G1 = 6900816;

	//0x007380B0 public: void __thiscall oCNpc::SetMovLock(int)
	const int oCNpc__SetMovLock_G2 = 7569584;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (on));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetMovLock_G1, oCNpc__SetMovLock_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_DoDoAniEvents
 */
func int oCNpc_DoDoAniEvents(var int slfInstance) {
	//0x0069EDF0 public: virtual int __thiscall oCNpc::DoDoAniEvents(void)
	const int oCNpc__DoDoAniEvents_G1 = 6942192;

	//0x00742A20 public: virtual int __thiscall oCNpc::DoDoAniEvents(void)
	const int oCNpc__DoDoAniEvents_G2 = 7612960;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoDoAniEvents_G1, oCNpc__DoDoAniEvents_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCNpc_GetInMovement
 */
func int oCNpc_GetInMovement(var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC(slf)) { return 0; };

	var int isInMovementMode; isInMovementMode = slf.bitfield[1] & zCVob_bitfield1_isInMovementMode;
	/*
	enum zTMovementMode {
		zVOB_MOVE_MODE_NOTINBLOCK,
		zVOB_MOVE_MODE_INBLOCK,
		zVOB_MOVE_MODE_INBLOCK_NOCD
	};
	*/
	const int zVOB_MOVE_MODE_NOTINBLOCK = 0;
	return (isInMovementMode != zVOB_MOVE_MODE_NOTINBLOCK);
};

/*
 *	oCNpc_Turn
 */
func int oCNpc_Turn(var int slfInstance, var int posPtr) {
	//0x0074DA70 public: float __thiscall oCNpc::Turn(class zVEC3 &)
	const int oCNpc__Turn_G1 = 7658096;

	//0x00683000 public: float __thiscall oCNpc::Turn(class zVEC3 &)
	const int oCNpc__Turn_G2 = 6828032;

	if (!posPtr) { return FLOATNULL; };

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC(slf)) { return FLOATNULL; };

	var int slfPtr; slfPtr = _@(slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam(_@(posPtr));
		CALL__thiscall (_@(slfPtr), MEMINT_SwitchG1G2(oCNpc__Turn_G1, oCNpc__Turn_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	oCNpc_InterpolateAimVobPtr
 *	 - allows aiming at vobPtr. Engine version of the function sends by default AssessThreat_S - which crashes if no Npc is used
 *	 - returns true once Npc is aiming at vobPtr
 */
func int oCNpc_InterpolateAimVobPtr(var int slfInstance, var int vobPtr, var int disperse) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);

	if (!Hlp_IsValidNPC(slf)) { return 0; };
	if (!slf.aniCtrl) { return 0; };

	var oCAniCtrl_Human aniCtrl; aniCtrl = _^(slf.aniCtrl);

	var int slfPtr; slfPtr = _@(slf);

	var int inMove; inMove = oCNpc_GetInMovement(slfInstance);
	if (inMove) {
		zCVob_EndMovement (slfPtr, FALSE);
	};

	var int fAzimuth; fAzimuth = FLOATNULL;
	var int fElevation; fElevation = FLOATNULL;

	oCNpc_GetAnglesVob(slf, vobPtr, _@(fAzimuth), _@(fElevation));

	var int fX; fX = addf(divf(fAzimuth, mkf (90)), FLOATHALF);
	var int fY; fY = subf(FLOATONE, addf(divf(fElevation, mkf(90)), FLOATHALF));

	if ((lf(fX, FLOATNULL)) || (gf (fX, FLOATONE)) || (lf(fY, FLOATNULL)) || (gf (fY, FLOATONE)))
	{
		slf.hasLockedEnemy = FALSE;
		var int pos[3];

		if (zCVob_GetPositionWorldToPos(vobPtr, _@(pos))) {
			oCNpc_Turn(slf, _@(pos));
		};

		return FALSE;
	};

	slf.hasLockedEnemy = TRUE;

	if (inMove) {
		zCVob_BeginMovement(slfPtr);
	};

	if (disperse) {
		if (Hlp_Random (100) > 90) {
			var int fXx; fXx = divf (mkf (Hlp_Random (10)), mkf (1000));
			var int fYy; fYy = divf (mkf (Hlp_Random (10)), mkf (1000));

			if (Hlp_Random (2) == 0) {
				fXx = negf (fXx);
			};

			if (Hlp_Random (2) == 0) {
				fYy = negf (fYy);
			};

			fX = addf (fX, fXx);
			fY = addf (fY, fYy);
		};
	};

	oCAniCtrl_Human_InterpolateCombineAni(slf.aniCtrl, fX, fY, aniCtrl._s_aim);

	return TRUE;
};

/*
 *	oCNpc_DoShootArrow
 */
func int oCNpc_DoShootArrow(var int slfInstance, var int autoAim) {
	//0x006A09F0 public: virtual int __thiscall oCNpc::DoShootArrow(int)
	const int oCNpc__DoShootArrow_G1 = 6949360;

	//0x007446B0 public: virtual int __thiscall oCNpc::DoShootArrow(int)
	const int oCNpc__DoShootArrow_G2 = 7620272;

	var oCNpc slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNPC(slf)) { return FALSE; };

	var int slfPtr; slfPtr = _@(slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam(_@(autoAim));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2(oCNpc__DoShootArrow_G1, oCNpc__DoShootArrow_G2));
		call = CALL_End();
	};

	return +retVal;
};
