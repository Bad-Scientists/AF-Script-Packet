/***
	2021-01-04 Weapon Stacking v0.01
	Authors: Auronen & Fawkes
	This little package allows you to use ITEM_MULTI flag with melee weapons in Gothic 1.
	Hooked functions oCNpc::EquipWeapon & oCNPC::UnequipItem will emulate same behaviour as you can see in G2A. If you have 10 weapons in 1 item slot, when equipped 1 weapon will move to it's own slot.
	You can then sell 9 unequipped items without additional hassle of well ... unequipping :)
***/

//Removes flags from oCItem pointer
//	itemPtr			item pointer
//	removeFlags		flag(s) to be removed
func void oCItem_RemoveFlags (var int itemPtr, var int removeFlags) {
	if (!itemPtr) { return; };
	var oCItem itm; itm = _^ (itemPtr);
	itm.flags = (itm.flags & ~ (removeFlags));
};

//Adds flags to oCItem pointer
//	itemPtr			item pointer
//	addFlags		flag(s) to be added
func void oCItem_AddFlags (var int itemPtr, var int addFlags) {
	if (!itemPtr) { return; };
	var oCItem itm; itm = _^ (itemPtr);
	itm.flags = (itm.flags | (addFlags));
};

//Returns pointer to currently drawn weapon (weapon in hand)
//	slfInstance		NPC instance
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

//Removes from NPV inventory item (by item pointer) with specified qty and returns pointer to removed item
//	slfInstance		NPC instance
//	itemPtr			item pointer
//	qty			quantity
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

//Puts item to inventory (by item pointer)
//	slfInstance		NPC instance
//	itemPtr			item pointer
func int oCNpc_PutInInv (var int slfInstance, var int itemPtr) {
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

//Equips item by item pointer
//	slfInstance		NPC instance
//	itemPtr			item pointer
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

//Unequips item by item pointer
//	slfInstance		NPC instance
//	itemPtr			item pointer
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

	Functions specifically created for Weapon Stacking, probably not useful for anything else

*/

//Returns pointer to specific weapon item instance in NPC's inventory
func int NPC_GetWeaponPtrByInstance (var int slfInstance, var int itmInstance){
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var oCItem itm;
	var zCListSort list;

	//INV_WEAPON
	var int ptr; ptr = slf.inventory2_inventory1_next;

	//
	while (ptr);
		list = _^ (ptr);
		
		if (list.data) {
			itm = _^ (list.data);
			if (Hlp_GetInstanceID (itm) == itmInstance) {
				return list.data;
			};
		};

		ptr = list.next;
	end;

	return 0;
};

//Splits weapons, which are equipped and have more than > 1 piece in 1 slot
func void NPC_SplitMultipleEquippedWeapons (var int slfInstance){
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//We can't run item splitting when weapon is drawn!
	var int readyWeaponPtr; readyWeaponPtr = oCNpc_GetWeaponPtr (slf);
	if (readyWeaponPtr) { return; };

/*
	//Last displayed inventory?
	//ptr = slf.inventory2_oCItemContainer_contents;

	B_Msg_Add (IntToString (slf.inventory2_inventory0_next)); //??
	B_Msg_Add (IntToString (slf.inventory2_inventory1_next)); //INV_WEAPON
	B_Msg_Add (IntToString (slf.inventory2_inventory2_next)); //INV_ARMOR
	B_Msg_Add (IntToString (slf.inventory2_inventory3_next)); //INV_RUNE
	B_Msg_Add (IntToString (slf.inventory2_inventory4_next)); //INV_MAGIC
	B_Msg_Add (IntToString (slf.inventory2_inventory5_next)); //INV_FOOD
	B_Msg_Add (IntToString (slf.inventory2_inventory6_next)); //INV_POTION
	B_Msg_Add (IntToString (slf.inventory2_inventory7_next)); //INV_DOC
	B_Msg_Add (IntToString (slf.inventory2_inventory8_next)); //INV_MISC
*/

	var oCItem itm;
	var zCListSort list;

	//INV_WEAPON
	var int ptr; ptr = slf.inventory2_inventory1_next;

	while (ptr);
		list = _^ (ptr);
		var int itemPtr; itemPtr = list.data;
		
		if (itemPtr){
			itm = _^ (itemPtr);
			
			//Check equipped weapons
			if ((itm.mainflag & ITEM_KAT_NF) || (itm.mainflag & ITEM_KAT_FF))
			&& ((itm.flags & ITEM_ACTIVE_G1) == ITEM_ACTIVE_G1){
				//Is there more than 1 piece equipped? Re-equip!
				if (itm.amount > 1){
					//pointers will be scrambled when oCNPC_EquipPtr and oCNPC_UnequipItemPtr are used! (because of hooked oCNPC_Equip, oCNPC_Unequip functions)
					//That is why we have to use item instance
					var int itemInstance; itemInstance = Hlp_GetInstanceID (itm);
					
					//Re-equip
					oCNPC_UnequipItemPtr (slf, itemPtr);

					//We have to get new pointer to itemInstance
					itemPtr = NPC_GetWeaponPtrByInstance (slf, itemInstance);

					oCNPC_EquipPtr (slf, itemPtr);

					//Reset pointer for next loop
					ptr = slf.inventory2_inventory1_next;
				};
			};
		};

		ptr = list.next;
	end;
};

//Function loops through all weapon slots.
//If weapon has flags that should be removed or if some flags have to be added then it will adjust them and will re-insert weapon instances back to inventory
func void NPC_WeaponInstanceRemoveAddFlags (var int slfInstance, var int itemInstance, var int removeFlags, var int addFlags){
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCListSort list;

	//INV_WEAPON
	var int ptr; ptr = slf.inventory2_inventory1_next;

	var int itemPtr;
	var oCItem itm;
	
	while (ptr);
		list = _^ (ptr);
		
		itemPtr = list.data;
		ptr = list.next;
		
		if (itemPtr) {
			itm = _^ (itemPtr);
			
			if (Hlp_GetInstanceID (itm) == itemInstance) {
				if (itm.flags & removeFlags) {
					//Replace flags
					oCItem_RemoveFlags (itemPtr, removeFlags);
					oCItem_AddFlags (itemPtr, addFlags);

					//Re-insert to inventory
					itemPtr = oCNpc_RemoveFromInvByPtr (slf, itemPtr, itm.amount);
					itemPtr = oCNpc_PutInInv (slf, itemPtr);

					//Reset pointer for next loop
					ptr = slf.inventory2_inventory1_next;
				} else {
					if (itm.flags & addFlags != addFlags) {
						oCItem_AddFlags (itemPtr, addFlags);

						//Re-insert to inventory
						itemPtr = oCNpc_RemoveFromInvByPtr (slf, itemPtr, itm.amount);
						itemPtr = oCNpc_PutInInv (slf, itemPtr);

						//Reset pointer for next loop
						ptr = slf.inventory2_inventory1_next;
					};
				};
			};
		};
	end;
};