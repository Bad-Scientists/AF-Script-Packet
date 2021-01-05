/*
 *	Required files:
 *		inventory_oCMob_engine.d
 *
 *	This package 'sparkled' from Neconspictor's post about 'Mob_RemoveAllItems' function.
 *	Original post here: https://forum.worldofplayers.de/forum/threads/1449528-Mob_RemoveItems?p=24599541&viewfull=1#post24599541
 *
 *	func int oCMobContainer_GetItemPtrBySlot (var int mobPtr, var int itemSlot)
 *	func void Mob_RemoveAllItems (var int mobPtr)
 *	func void Mob_RemoveItems (var int mobPtr, var int itemInstance, var int qty)
 *	func void Mob_TransferItemsToNPC (var int mobPtr, var int slfInstance)
 */

/*
 *	Returns pointer to oCItem in a specific inventory slot in a chest
 *		mobPtr			pointer to oCMobContainer
 *		itemSlot		slot number (starts with 0)
 *	Usage:
 *		itemPtr = oCMobContainer_GetItemPtrBySlot (her.focus_vob, 0);
 */
func int oCMobContainer_GetItemPtrBySlot (var int mobPtr, var int itemSlot){
	if (!mobPtr) { return 0 ; };

	var int ptr;
	var int itmPtr;
	var zCListSort list;
	var oCMobContainer container; container = _^ (mobPtr);
	var int i; i = 0;

	ptr = container.containList_next;

	while (ptr);
		list = _^ (ptr);
		itmPtr = list.data;
		
		if (itmPtr) {
			if (itemSlot == i) {
				return itmPtr;
			};

			i += 1;
		};

		ptr = list.next;
	end;

	return 0;
};

/*
 *	Removes from oCMobContainer all items
 *		mobPtr			pointer to oCMobContainer
 *		itemSlot		slot number (starts with 0)
 *	Usage:
 *		Mob_RemoveAllItems (her.focus_vob);
 */
func void Mob_RemoveAllItems (var int mobPtr){
	if (!mobPtr) { return; };

	var int ptr;
	var oCMobContainer container; container = _^(mobPtr);
	var zCListSort list;

	ptr = container.containList_next;
	
	while (ptr != 0);
		list = _^(ptr);
		var int itmPtr; itmPtr = list.data;
		
		if (itmPtr == 0) {
			ptr  = list.next;
		} else {
			oCMobContainer_Remove(mobPtr, itmPtr);
			ptr = container.containList_next;
		};
	end;
};

/*
 *	Removes from oCMobContainer 1 item 
 *		mobPtr			pointer to oCMobContainer
 *		itemInstance		item instance
 *		qty			qty to be removed
 *	Usage:
 *		Mob_RemoveItems (her.focus_vob, ItarScrollFireBolt, 1);
 */
func void Mob_RemoveItems (var int mobPtr, var int itemInstance, var int qty){
	if (!mobPtr) { return; };

	var oCItem itm;

	var int itmPtr; itmPtr = 1;
	var int i; i = 0;

	//Loop through all inventory slots to find itemInstance
	while (itmPtr);
		itmPtr = oCMobContainer_GetItemPtrBySlot (mobPtr, i);
		
		if (itmPtr) {
			itm = _^ (itmPtr);

			if (Hlp_GetInstanceID (itm) == itemInstance) {
				if (itm.amount > qty) {
					//Adjust qty - is this okay?
					itm.amount = (itm.amount - qty);
				} else {
					//Remove everything
					oCMobContainer_Remove (mobPtr, itmPtr);
				};
				
				return;
			};
		};

		i += 1;
	end;
};

/*
 *	Transfers all items from oCMobContainer to NPC
 *		mobPtr			pointer to oCMobContainer
 *		slfInstance		NPC instance
 *	Usage:
 *		Mob_TransferItemsToNPC (her.focus_vob, hero);
 */
func void Mob_TransferItemsToNPC (var int mobPtr, var int slfInstance){
	if (!mobPtr) { return; };

	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var oCItem itm;
	var int i;

	var int ptr;
	var oCMobContainer container; container = _^ (mobPtr);
	var zCListSort list;

	ptr = container.containList_next;
	
	while (ptr != 0);
		list = _^(ptr);
		var int itmPtr; itmPtr = list.data;
		
		if (itmPtr == 0) {
			ptr  = list.next;
		} else {
			itm = _^ (itmPtr);

			i = 0;
			while (i<itm.amount);
				//We have to create items in a loop using CreateInvItem function (because of items without ITEM_MULTI flag)
				CreateInvItem (slf, Hlp_GetInstanceID (itm));
				i += 1;
			end;

			oCMobContainer_Remove(mobPtr, itmPtr);
			ptr = container.containList_next;
		};
	end;
};
