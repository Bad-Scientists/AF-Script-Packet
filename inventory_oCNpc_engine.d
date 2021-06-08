/*
 *	Returns pointer to currently drawn weapon (weapon in hand)
 *		slfInstance		NPC instance
 */
func int oCNpc_GetWeaponPtr (var int slfInstance) {
	//0x006943F0 public: class oCItem * __thiscall oCNpc::GetWeapon(void)
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
	//0x006A5260 public: class oCItem * __thiscall oCNpc::RemoveFromInv(class oCItem *,int)
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
	//0x006A4FF0 public: class oCItem * __thiscall oCNpc::PutInInv(class oCItem *)
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
	//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
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
	//0x0068FBC0 public: void __thiscall oCNpc::UnequipItem(class oCItem *)
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
	//0x00694580 public: class oCItem * __thiscall oCNpc::GetEquippedMeleeWeapon(void)
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
	//0x006A5180 public: class oCItem * __thiscall oCNpc::PutInInv(int,int)
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
 *	Function returns pointer to item in inventory
 *    		npcInstance		NPC instance
 *    		itemInstance		item instance
 *    		qty			qty?
 */
func int oCNpc_GetFromInv (var int slfInstance, var int itemInstance, var int qty) {
	//0x006A4E20 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	const int oCNpc__GetFromInv_G1 = 6966816;
	
	//0x00749180 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	const int oCNpc__GetFromInv_G2 = 7639424;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (qty));
		CALL_IntParam (_@ (itemInstance));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetFromInv_G1, oCNpc__GetFromInv_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

//G1 only
func int oCNpcInventory_SwitchToCategory (var int npcInventoryPtr, var int invCategory) {
	//0x0066DE60 public: int __thiscall oCNpcInventory::SwitchToCategory(int)
	const int oCNpc__SwitchToCategory_G1 = 6741600;
	
	//There is no G2A function
	const int oCNpc__SwitchToCategory_G2 = 0;

	if (!npcInventoryPtr) { return 0; };

	//return 0 in G2A
	if (MEMINT_SwitchG1G2 (0, 1)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (invCategory));
		CALL__thiscall (_@ (npcInventoryPtr), oCNpc__SwitchToCategory_G1);
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCItemContainer_IsActive (var int ptr) {
	//0x006665A0 public: virtual int __thiscall oCItemContainer::IsActive(void)
	const int oCItemContainer__IsActive_G1 = 6710688;

	//0x007050D0 public: virtual int __thiscall oCItemContainer::IsActive(void)
	const int oCItemContainer__IsActive_G2 = 7360720;

	if (!ptr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__IsActive_G1, oCItemContainer__IsActive_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};
