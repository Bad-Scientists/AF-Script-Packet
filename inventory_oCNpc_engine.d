/*
 *	Returns pointer to currently drawn weapon (weapon in hand)
 *		slfInstance		NPC instance
 */
func int oCNpc_GetWeaponPtr (var int slfInstance) {
	//006943F0  .text     Debug data           ?GetWeapon@oCNpc@@QAEPAVoCItem@@XZ
	const int oCNpc__GetWeapon_G1 = 6898672;
	
	//0x007377A0 public: class oCItem * __thiscall oCNpc::GetWeapon(void)
	const int oCNpc__GetWeapon_G2 = 7567264;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetWeapon_G1, oCNpc__GetWeapon_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *	Removes from NPC inventory item with specified qty and returns pointer to removed item
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 *		qty			quantity
 */
func int oCNpc_RemoveFromInvByPtr (var int slfInstance, var int itemPtr, var int qty) {
	//006A5260  .text     Debug data           ?RemoveFromInv@oCNpc@@QAEPAVoCItem@@PAV2@H@Z
	const int oCNpc__RemoveFromInv_G1 = 6967904;
	
	//0x007495A0 public: class oCItem * __thiscall oCNpc::RemoveFromInv(class oCItem *,int)
	const int oCNpc__RemoveFromInv_G2 = 7640480;

	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (qty));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__RemoveFromInv_G1, oCNpc__RemoveFromInv_G2));

		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *	Puts item to NPC's inventory
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 */
func int oCNpc_PutInInvPtr (var int slfInstance, var int itemPtr) {
	//006A4FF0  .text     Debug data           ?PutInInv@oCNpc@@QAEPAVoCItem@@PAV2@@Z
	const int oCNpc__PutInInv_G1 = 6967280;
	
	//0x00749350 public: class oCItem * __thiscall oCNpc::PutInInv(class oCItem *)
	const int oCNpc__PutInInv_G2 = 7639888;

	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__PutInInv_G1, oCNpc__PutInInv_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *	Equips item by item pointer
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 */
func void oCNPC_EquipPtr (var int slfInstance, var int itemPtr) {
	//006968F0  .text     Debug data           ?Equip@oCNpc@@QAEXPAVoCItem@@@Z
	const int oCNPC__Equip_G1 = 6908144;

	//0x00739C90 public: void __thiscall oCNpc::Equip(class oCItem *)
	const int oCNPC__Equip_G2 = 7576720;
	
	if (!itemPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__Equip_G1, oCNPC__Equip_G2));
		call = CALL_End();
	};
};

/*
 *	Unequips item by item pointer
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 */
func void oCNPC_UnequipItemPtr (var int slfInstance, var int itemPtr){
	//0068FBC0  .text     Debug data           ?UnequipItem@oCNPC@@QAEXPAVoCItem@@@Z
	const int oCNPC__UnequipItem_G1 = 6880192;
	
	//0x007326C0 public: void __thiscall oCNPC::UnequipItem(class oCItem *)
	const int oCNPC__UnequipItem_G2 = 7546560;

	if (!itemPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__UnequipItem_G1, oCNPC__UnequipItem_G2));
		call = CALL_End();
	};
};

/*
 *	Gets pointer of equipped melee weapon
 *    		npcInstance		NPC instance
 */
func int oCNpc_GetEquippedMeleeWeapon (var int npcInstance){
	//00694580  .text     Debug data           ?GetEquippedMeleeWeapon@oCNpc@@QAEPAVoCItem@@XZ
	const int oCNpc__GetEquippedMeleeWeapon_G1 = 6899072;
	
	//0x00737930 public: class oCItem * __thiscall oCNpc::GetEquippedMeleeWeapon(void) 
	const int oCNpc__GetEquippedMeleeWeapon_G2 = 7567664;
	
	var oCNPC slf; slf = Hlp_GetNPC (npcInstance);
	if (!slf) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2(oCNpc__GetEquippedMeleeWeapon_G1, oCNpc__GetEquippedMeleeWeapon_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr();
};

/*
 *	TODO: test this one
 *    		npcInstance		NPC instance
 *    		itemPtr			item pointer?
 *    		qty			qty?
 */
func int oCNpc_PutInInvPtrAmount (var int npcInstance, var int itemPtr, var int qty){
	//006A5180  .text     Debug data           ?PutInInv@oCNpc@@QAEPAVoCItem@@HH@Z
	const int oCNpc__PutInInv_G1 = 6967680;

	//0x007494C0 public: class oCItem * __thiscall oCNpc::PutInInv(int,int)
	const int oCNpc__PutInInv_G2 = 7640256;
	
	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (qty));
		CALL_IntParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__PutInInv_G1, oCNpc__PutInInv_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr();
};

/*
 *	TODO: test this one
 *    		npcInstance		NPC instance
 *    		itemPtr			item pointer?
 *    		qty			qty?
 */
func int oCNpc_GetFromInvPtr (var int slfInstance, var int itemPtr, var int qty) {
	//006A4E20  .text     Debug data           ?GetFromInv@oCNpc@@QAEPAVoCItem@@HH@Z
	const int oCNpc__GetFromInv_G1 = 6966816;
	
	//0x00749180 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	const int oCNpc__GetFromInv_G2 = 7639424;

	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (qty));
		CALL_IntParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetFromInv_G1, oCNpc__GetFromInv_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		flag			flag to be tested?
 */
func int oCItem_HasFlag (var int itemPtr, var int flag){
	//00671FC0  .text     Debug data           ?HasFlag@oCItem@@QAEHH@Z
	const int oCItem__HasFlag_G1 = 6758336;
	
	//0x007126D0 public: int __thiscall oCItem::HasFlag(int)
	const int oCItem__HasFlag_G2 = 7415504;

	if (!itemPtr) { return 0; };
	
	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (flag));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2(oCItem__HasFlag_G1, oCItem__HasFlag_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		flag			flag to be set?
 */
func void oCItem_SetFlag (var int itemPtr, var int flag){
	//00672000  .text     Debug data           ?SetFlag@oCItem@@QAEXH@Z
	const int oCItem__SetFlag_G1 = 6758400;
	
	//0x00712710 public: void __thiscall oCItem::SetFlag(int)
	const int oCItem__SetFlag_G2 = 7415568;
	
	if (!itemPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (flag));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2(oCItem__SetFlag_G1, oCItem__SetFlag_G2));
		call = CALL_End();
	};
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		flag			flag to be removed?
 */
func void oCItem_ClearFlag (var int itemPtr, var int flag){
	//00671FE0  .text     Debug data           ?ClearFlag@oCItem@@QAEXH@Z
	const int oCItem__ClearFlag_G1 = 6758368;
	
	//0x007126F0 public: void __thiscall oCItem::ClearFlag(int)
	const int oCItem__ClearFlag_G2 = 7415536;
	
	if (!itemPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (flag));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2(oCItem__ClearFlag_G1, oCItem__ClearFlag_G2));
		call = CALL_End();
	};
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		qty			quantity?
 */
func int oCItem_SplitItemPtr (var int itemPtr, var int qty){
	//00672440  .text     Debug data           ?SplitItem@oCItem@@QAEPAV1@H@Z
	const int oCItem__SplitItem_G1 = 6759488;
	
	//0x00712BA0 public: class oCItem * __thiscall oCItem::SplitItem(int)
	const int oCItem__SplitItem_G2 = 7416736;

	if (!itemPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (qty));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2 (oCItem__SplitItem_G1, oCItem__SplitItem_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr();
};

