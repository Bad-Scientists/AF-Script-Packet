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

/*
 *
 */
func void oCNPC_DropUnconscious (var int slfInstance, var int attackerInstance) {
	//0x00692C10 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNPC__DropUnconscious_G1 = 6892560;

	//0x00735EB0 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNPC__DropUnconscious_G2 = 7560880;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int attackerPtr; attackerPtr = 0;
	var oCNPC attacker; attacker = Hlp_GetNPC (attackerInstance);
	if (Hlp_IsValidNPC (attacker)) {
		attackerPtr = _@ (attacker);
	};

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (attackerPtr));
		CALL_FloatParam (_@ (FLOATNULL));	//???
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__DropUnconscious_G1, oCNPC__DropUnconscious_G2));
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

	var int attackerPtr; attackerPtr = 0;
	var oCNPC attacker; attacker = Hlp_GetNPC (attackerInstance);
	if (Hlp_IsValidNPC (attacker)) {
		attackerPtr = _@ (attacker);
	};

	var int slfPtr; slfPtr = _@ (slf);

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
func int oCNpc_DoTakeVob (var int slfInstance, var int itemPtr) {
	//0x006A0D10 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G1 = 6950160;

	//0x007449C0 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G2 = 7621056;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	if (!Hlp_Is_oCItem (itemPtr)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoTakeVob_G1, oCNpc__DoTakeVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
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

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__OpenDeadNpc_G1, oCNPC__OpenDeadNpc_G2));
		call = CALL_End();
	};
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

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__CloseDeadNpc_G1, oCNPC__CloseDeadNpc_G2));
		call = CALL_End();
	};
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

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		if (MEMINT_SwitchG1G2 (0, 1)) {
			CALL_IntParam (_@ (param1));
		};

		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__OpenInventory_G1, oCNPC__OpenInventory_G2));
		call = CALL_End();
	};
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

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__CloseInventory_G1, oCNPC__CloseInventory_G2));
		call = CALL_End();
	};
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
	if (!Hlp_IsValidNPC (slf)) { return 0; };

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
	if (!Hlp_IsValidNPC (slf)) { return 0; };

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
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DoExchangeTorch_G1, oCNpc__DoExchangeTorch_G2));
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
func int oCNPC_CanSee (var int slfInstance, var int vobPtr, var int lineOfSight){
	//0x0069E010 public: int __thiscall oCNpc::CanSee(class zCVob *,int)
	const int oCNPC__CanSee_G1 = 6938640;

	//0x00741C10 public: int __thiscall oCNPC::CanSee(class zCVob *,int)
	const int oCNPC__CanSee_G2 = 7609360;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (lineOfSight));
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__CanSee_G1, oCNPC__CanSee_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

func int oCNPC_FreeLineOfSight (var int slfInstance, var int vobPtr){
	//0x0069DE50 public: int __thiscall oCNpc::FreeLineOfSight(class zCVob *)
	const int oCNPC__FreeLineOfSight_G1 = 6938192;

	//0x007418E0 public: int __thiscall oCNpc::FreeLineOfSight(class zCVob *)
	const int oCNPC__FreeLineOfSight_G2 = 7608544;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__FreeLineOfSight_G1, oCNPC__FreeLineOfSight_G2));
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

func void oCNPC_DropAllInHand (var int slfInstance)
{
	//0x00694230 public: void __thiscall oCNpc::DropAllInHand(void)
	const int oCNPC__DropAllInHand_G1 = 6898224;

	//0x007375E0 public: void __thiscall oCNpc::DropAllInHand(void)
	const int oCNPC__DropAllInHand_G2 = 7566816;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__DropAllInHand_G1, oCNPC__DropAllInHand_G2));
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
	const int oCNPC__GetAnglesVob_G1 = 7651536;

	//0x00681680 public: void __thiscall oCNpc::GetAngles(class zCVob *,float &,float &)
	const int oCNPC__GetAnglesVob_G2 = 6821504;

	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {

		CALL_PtrParam (_@ (angleYPtr));
		CALL_PtrParam (_@ (angleXPtr));

		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__GetAnglesVob_G1, oCNPC__GetAnglesVob_G2));
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
	const int oCNPC__DoThrowVob_G1 = 6951872;

	//0x007450B0 public: virtual int __thiscall oCNPC::DoThrowVob(class zCVob *,float)
	const int oCNPC__DoThrowVob_G2 = 7622832;

	if (!vobPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (speedF));
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__DoThrowVob_G1, oCNPC__DoThrowVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCNPC_FindMobInter (var int slfInstance, var string scemeName) {
	//0x0069C720 public: class oCMobInter * __thiscall oCNpc::FindMobInter(class zSTRING const &)
	const int oCNPC__FindMobInter_G1 = 6932256;

	//0x0073FE70 public: class oCMobInter * __thiscall oCNpc::FindMobInter(class zSTRING const &)
	const int oCNPC__FindMobInter_G2 = 7601776;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	scemeName = STR_Upper (scemeName);

	CALL_zStringPtrParam (scemeName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__FindMobInter_G1, oCNPC__FindMobInter_G2));

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
