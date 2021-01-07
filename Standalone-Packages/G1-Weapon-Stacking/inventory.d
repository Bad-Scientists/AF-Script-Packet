/*
 *	Functions specifically created for Weapon Stacking, probably not useful for anything else
 */

/*
 *	2021-01-07 Weapon Stacking v0.01 for Gothic 1
 *
 *	Authors: Auronen & Fawkes
 *	This little package allows you to use ITEM_MULTI flag with melee weapons in Gothic 1.
 *	Hooked functions oCNpc::EquipWeapon & oCNPC::UnequipItem will emulate same behaviour as you can see in G2A. If you have 10 weapons in 1 item slot, when equipped 1 weapon will move to it's own slot.
 *	You can then sell 9 unequipped items without additional hassle of well ... unequipping :)
 */

/*
 *	Splits weapons, which are equipped and have more than > 1 piece in 1 slot
 *		slfInstance		NPC instance
 */
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
			&& ((itm.flags & ITEM_ACTIVE_LEGO) == ITEM_ACTIVE_LEGO){
				//Is there more than 1 piece equipped? Re-equip!
				if (itm.amount > 1){
					//pointers will be scrambled when oCNPC_EquipPtr and oCNPC_UnequipItemPtr are used! (because of hooked oCNPC_Equip, oCNPC_Unequip functions)
					//That is why we have to use item instance
					var int itemInstance; itemInstance = Hlp_GetInstanceID (itm);
					
					//Re-equip
					oCNPC_UnequipItemPtr (slf, itemPtr);

					//We have to get new pointer to itemInstance
					itemPtr = NPC_GetItemPtrByInstance (slf, INV_WEAPON, itemInstance);

					oCNPC_EquipPtr (slf, itemPtr);

					//Reset pointer for next loop
					ptr = slf.inventory2_inventory1_next;
				};
			};
		};

		ptr = list.next;
	end;
};

/*
 *	Function loops through all weapon slots.
 *	If weapon has flags that should be removed or if some flags have to be added then it will adjust them and will re-insert weapon instances back to inventory
 *		slfInstance		NPC instance
 *		itemInstance		item instance
 *		removeFlags		flag(s) to be removed
 *		addFlags		flag(s) to be added
 */
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
					itemPtr = oCNpc_PutInInvPtr (slf, itemPtr);

					//Reset pointer for next loop
					ptr = slf.inventory2_inventory1_next;
				} else {
					if (itm.flags & addFlags != addFlags) {
						oCItem_AddFlags (itemPtr, addFlags);

						//Re-insert to inventory
						itemPtr = oCNpc_RemoveFromInvByPtr (slf, itemPtr, itm.amount);
						itemPtr = oCNpc_PutInInvPtr (slf, itemPtr);

						//Reset pointer for next loop
						ptr = slf.inventory2_inventory1_next;
					};
				};
			};
		};
	end;
};