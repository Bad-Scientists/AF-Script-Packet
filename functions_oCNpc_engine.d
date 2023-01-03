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
func void oCNpc_DropUnconscious (var int slfInstance, var int attackerInstance) {
	//0x00692C10 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNpc__DropUnconscious_G1 = 6892560;

	//0x00735EB0 public: void __thiscall oCNpc::DropUnconscious(float,class oCNpc *)
	const int oCNpc__DropUnconscious_G2 = 7560880;

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
func int oCNpc_DoTakeVob (var int slfInstance, var int vobPtr) {
	//0x006A0D10 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G1 = 6950160;

	//0x007449C0 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
	const int oCNpc__DoTakeVob_G2 = 7621056;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	if (!vobPtr) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

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
func int oCNpc_CanSee (var int slfInstance, var int vobPtr, var int lineOfSight){
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
		CALL_IntParam (_@ (lineOfSight));
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

func void oCNpc_MakeSpellBook (var int slfInstance) {
	//0x006B86A0 public: void __thiscall oCNpc::MakeSpellBook(void)
	const int oCNpc__MakeSpellBook_G1 = 7046816;

	//0x0075F040 public: void __thiscall oCNpc::MakeSpellBook(void)
	const int oCNpc__MakeSpellBook_G2 = 7729216;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__MakeSpellBook_G1, oCNpc__MakeSpellBook_G2));
		call = CALL_End();
	};
};

func int oCNpc_GetSpellBook (var int slfInstance) {
	//0x0069B3C0 public: class oCMag_Book * __thiscall oCNpc::GetSpellBook(void)
	const int oCNpc__GetSpellBook_G1 = 6927296;

	//0x0073EA00 public: class oCMag_Book * __thiscall oCNpc::GetSpellBook(void)
	const int oCNpc__GetSpellBook_G2 = 7596544;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetSpellBook_G1, oCNpc__GetSpellBook_G2));
		call = CALL_End();
	};

	return + retVal;
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
	if (!Hlp_IsValidNPC (slf)) { return ""; };

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

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

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

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

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

func void oCNpc_PutItemInSlot (var int slfInstance, var string slotName, var int itemInstanceID) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (Npc_HasItems (slf, itemInstanceID)) {
		oCNpc_PutInSlot_Fixed (slf, slotName, _@ (item), 1);
	};
};
func void oCNpc_AddItemEffects (var int slfInstance, var int itemPtr) {
	//0x0068F640 public: void __thiscall oCNpc::AddItemEffects(class oCItem *)
	const int oCNpc__AddItemEffects_G1 = 6878784;

	//0x007320F0 public: void __thiscall oCNpc::AddItemEffects(class oCItem *)
	const int oCNpc__AddItemEffects_G2 = 7545072;

	if (!itemPtr) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(itemPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__AddItemEffects_G1, oCNpc__AddItemEffects_G2));
		call = CALL_End();
	};
};

func void oCNpc_RemoveItemEffects (var int slfInstance, var int itemPtr) {
	//0x0068F7D0 public: void __thiscall oCNpc::RemoveItemEffects(class oCItem *)
	const int oCNpc__RemoveItemEffects_G1 = 6879184;

	//0x00732270 public: void __thiscall oCNpc::RemoveItemEffects(class oCItem *)
	const int oCNpc__RemoveItemEffects_G2 = 7545456;

	if (!itemPtr) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(itemPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__RemoveItemEffects_G1, oCNpc__RemoveItemEffects_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_Equip_Safe
 *	 - when compared to LeGo function this has safety checks, also does not use npc pointer, other than that it's same
 */
func void oCNpc_Equip_Safe (var int slfInstance, var int itemPtr) {
	//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
	const int oCNpc__Equip_G1 = 6908144;

	//0x00739C90 public: void __thiscall oCNpc::Equip(class oCItem *)
	const int oCNpc__Equip_G2 = 7576720;

	if (!Hlp_Is_oCItem (itemPtr)) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(itemPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__Equip_G1, oCNpc__Equip_G2));
		call = CALL_End();
	};
};
