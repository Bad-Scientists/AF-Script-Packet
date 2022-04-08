/*
 *	Required files:
 *		inventory_oCNpc_engine.d
 *
 */

/*
 *	Returns pointer to specific item instance in NPC's inventory
 *		slfInstance		NPC instance
 *		invCat			inventory category
 *		itemInstance		item instance
 */
func int NPC_GetItemPtrByInstance (var int slfInstance, var int invCat, var int itemInstance){
	if (invCat < 0) || (invCat >= INV_CAT_MAX) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	var oCItem itm;
	var zCListSort list;

	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		/*
		if (invCat == INV_WEAPON)	{ ptr = slf.inventory2_inventory1_next; } else
		if (invCat == INV_ARMOR)	{ ptr = slf.inventory2_inventory2_next; } else
		if (invCat == INV_RUNE)		{ ptr = slf.inventory2_inventory3_next; } else
		if (invCat == INV_MAGIC)	{ ptr = slf.inventory2_inventory4_next; } else
		if (invCat == INV_FOOD)		{ ptr = slf.inventory2_inventory5_next; } else
		if (invCat == INV_POTION)	{ ptr = slf.inventory2_inventory6_next; } else
		if (invCat == INV_DOC)		{ ptr = slf.inventory2_inventory7_next; } else
		if (invCat == INV_MISC)		{ ptr = slf.inventory2_inventory8_next; };
		*/

		/*
		G1 oCNPC - inventory offset
			var int    inventory2_inventory0_next;		// 0x05F8 zCListSort<oCItem>*
			var int    inventory2_inventory1_next;		// 0x0604 zCListSort<oCItem>*
			var int    inventory2_inventory2_next;		// 0x0610 zCListSort<oCItem>*
			var int    inventory2_inventory3_next;		// 0x061C zCListSort<oCItem>*
			var int    inventory2_inventory4_next;		// 0x0628 zCListSort<oCItem>*
			var int    inventory2_inventory5_next;		// 0x0634 zCListSort<oCItem>*
			var int    inventory2_inventory6_next;		// 0x0640 zCListSort<oCItem>*
			var int    inventory2_inventory7_next;		// 0x064C zCListSort<oCItem>*
			var int    inventory2_inventory8_next;		// 0x0658 zCListSort<oCItem>*
		*/
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
	} else {
		/*
		G2A oCNPC - inventory offset
			var int    inventory2_inventory_next;		// 0x0718 zCListSort<oCItem>*
		*/
		//G2A has single inventory
		offset = 1816;
	};

	oCNpcInventory_UnpackCategory (npcInventoryPtr, invCat);

	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

	while (ptr);
		list = _^ (ptr);

		if (list.data) {
			itm = _^ (list.data);
			if (Hlp_GetInstanceID (itm) == itemInstance) {
				return list.data;
			};
		};

		ptr = list.next;
	end;

	return 0;
};

/*
 *	Returns number of items in inventory by item instance name
 *		slfInstance		NPC instance
 *		instanceName		item instance name
 */
func int NPC_HasItemInstanceName (var int slfInstance, var string instanceName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int symbID; symbID = MEM_GetSymbolIndex (instanceName);
	if (symbID > 0) && (symbID < currSymbolTableLength) {
		//if (NPC_GetInventoryItem (slf, symbID))
		if (NPC_GetInvItem (slf, symbID)) {
			return (NPC_HasItems (slf, Hlp_GetinstanceID (item)));
		};
	};

	return 0;
};

func void NPC_RemoveInventoryCategory (var int slfInstance, var int invCategory, var int flagsKeepItems, var int mainFlagsKeepItems) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int amount;
	var int itmInstance;

	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);

	while (amount > 0);
		itmInstance = Hlp_GetinstanceID (item);

		//Chceme tieto itemy odstranit ?
		//Zbroj - neodstranujeme taku, co je equipnuta
		if ((item.Flags & flagsKeepItems) || (item.MainFlag & mainFlagsKeepItems) || ((invCategory == INV_ARMOR) && (NPC_GetArmor (slf) == itmInstance)))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		var int ptr; ptr = _@ (item);

		var oCItem itm; itm = _^ (ptr);

		if (itm.amount == 1) {
			oCNPC_UnequipItemPtr (slf, ptr);
			NPC_RemoveInvItem (slf, itmInstance);
		} else {
			NPC_RemoveInvItems (slf, itmInstance, itm.amount);
		};

		amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
	end;
};

func void NPC_RemoveInventory (var C_NPC slf, var int flagsKeepItems, var int mainFlagsKeepItems) {
	NPC_RemoveInventoryCategory (slf, INV_WEAPON, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_ARMOR, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_RUNE, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_MAGIC, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_FOOD, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_POTION, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_DOC, flagsKeepItems, mainFlagsKeepItems);
	NPC_RemoveInventoryCategory (slf, INV_MISC, flagsKeepItems, mainFlagsKeepItems);
};

var int _NpcTransferItemPrint_Event;
var int _NpcTransferItemPrint_Event_Enabled;

func void NpcTransferItemPrintEvent_Init () {
	if (!_NpcTransferItemPrint_Event) {
		_NpcTransferItemPrint_Event = Event_Create ();
	};
};

func void NpcTransferItemPrintEvent_AddListener (var func f) {
	Event_AddOnce (_NpcTransferItemPrint_Event, f);
};

func void NpcTransferItemPrintEvent_RemoveListener (var func f) {
	Event_Remove (_NpcTransferItemPrint_Event, f);
};

func void NPC_TransferInventoryCategory (var int slfInstance, var int othInstance, var int invCategory, var int transferEquippedArmor, var int transferEquippedItems, var int transferMissionItems) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var C_NPC oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return; };

	var int amount;
	var int itmInstance;

	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);

	while (amount > 0);
		itmInstance = Hlp_GetinstanceID (item);

		//Ignore equipped armor
		if (!transferEquippedArmor)
		&& (NPC_GetArmor (slf) == itmInstance) //&& (item.Flags & ITEM_ACTIVE_LEGO))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		//Ignore equipped items
		if (!transferEquippedItems)
		&& (((NPC_GetMeleeWeapon (slf) == itmInstance) || (NPC_GetRangedWeapon (slf) == itmInstance)) && (item.Flags & ITEM_ACTIVE_LEGO))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		//Ignore mission items
		if (!transferMissionItems)
		&& (item.Flags & ITEM_MISSION)
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		//Convert to oCItem to get amount property
		var int itmPtr; itmPtr = _@ (item);
		var oCItem itm; itm = _^ (itmPtr);

		//Custom prints for transferred items
		if ((_NpcTransferItemPrint_Event) && (_NpcTransferItemPrint_Event_Enabled)) {
			Event_Execute (_NpcTransferItemPrint_Event, itmPtr);
		};

		if (itm.amount == 1) {
			CreateInvItem (oth, itmInstance);
			NPC_RemoveInvItem (slf, itmInstance);
		} else {
			CreateInvItems (oth, itmInstance, itm.amount);
			NPC_RemoveInvItems (slf, itmInstance, itm.amount);
		};

		amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
	end;
};

func void NPC_TransferInventory (var int slfInstance, var int othInstance, var int transferEquippedArmor, var int transferEquippedItems, var int transferMissionItems) {
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_WEAPON, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_ARMOR, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_RUNE, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_MAGIC, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_FOOD, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_POTION, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_DOC, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	NPC_TransferInventoryCategory (slfInstance, othInstance, INV_MISC, transferEquippedArmor, transferEquippedItems, transferMissionItems);
};

func void NPC_UnEquipInventoryCategory (var int slfinstance, var int invCategory) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int amount;
	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);

	//Loop
	while (amount > 0);
		oCNPC_UnequipItemPtr (slf, _@ (item));

		itmSlot = itmSlot + 1;
		amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
	end;

};

func void NPC_UnEquipInventory (var int slfinstance) {
	NPC_UnEquipInventoryCategory (slfinstance, INV_WEAPON);
	NPC_UnEquipInventoryCategory (slfinstance, INV_ARMOR);
	NPC_UnEquipInventoryCategory (slfinstance, INV_RUNE);
	NPC_UnEquipInventoryCategory (slfinstance, INV_MAGIC);
	NPC_UnEquipInventoryCategory (slfinstance, INV_FOOD);
	NPC_UnEquipInventoryCategory (slfinstance, INV_POTION);
	NPC_UnEquipInventoryCategory (slfinstance, INV_DOC);
	NPC_UnEquipInventoryCategory (slfinstance, INV_MISC);
};

/*
 *	NPC_InventoryIsEmpty
 *	 - function checks whether inventory is empty
 */
func int NPC_InventoryIsEmpty (var int slfInstance, var int ignoreFlags, var int ignoreMainFlags, var int ignoreArmor) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	//NPC_GetArmor requires C_NPC ... ;-/
	var C_NPC _slf; _slf = Hlp_GetNpc (slf);
	var int armorID; armorID = NPC_GetArmor (_slf);

	repeat (invCat, noOfCategories); var int invCat;
		oCNpcInventory_UnpackCategory (npcInventoryPtr, invCat);
		ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

		while (ptr);
			list = _^ (ptr);

			if (list.data) {
				itm = _^ (list.data);
				if ((itm.Flags & ignoreFlags) || (itm.MainFlag & ignoreMainFlags) || ((invCat == INV_ARMOR) && (armorID == Hlp_GetInstanceID (itm)) && (ignoreArmor))) {
					ptr = list.next;
					continue;
				};

				return FALSE;
			};

			ptr = list.next;
		end;
	end;

	return TRUE;
};

/*
 *	NPC_HasMissionItem
 *	 - checks whether NPC has any mission items
 *	 - adding here as an alternative, because we are replacing engine version of function oCNpc::HasMissionItem!
 */
func int NPC_HasMissionItem (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	//NPC_GetArmor requires C_NPC ... ;-/
	var C_NPC _slf; _slf = Hlp_GetNpc (slf);
	var int armorID; armorID = NPC_GetArmor (_slf);

	repeat (invCat, noOfCategories); var int invCat;
		oCNpcInventory_UnpackCategory (npcInventoryPtr, invCat);
		ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

		while (ptr);
			list = _^ (ptr);

			if (list.data) {
				itm = _^ (list.data);
				if (itm.mainflag & ITEM_MISSION) {
					return TRUE;
				};
			};

			ptr = list.next;
		end;
	end;

	return FALSE;
};
