/*
 *	Required files:
 *		inventory_oCNpc_engine.d
 *
 */
 
/*
 *	Removes flags from oCItem pointer
 *		itemPtr			item pointer
 *		removeFlags		flag(s) to be removed
 */
func void oCItem_RemoveFlags (var int itemPtr, var int removeFlags) {
	if (!itemPtr) { return; };
	var oCItem itm; itm = _^ (itemPtr);
	itm.flags = (itm.flags & ~ (removeFlags));
};

/*
 *	Adds flags to oCItem pointer
 *		itemPtr			item pointer
 *		addFlags		flag(s) to be added
 */
func void oCItem_AddFlags (var int itemPtr, var int addFlags) {
	if (!itemPtr) { return; };
	var oCItem itm; itm = _^ (itemPtr);
	itm.flags = (itm.flags | (addFlags));
};

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

	var oCItem itm;
	var zCListSort list;

	var int ptr; ptr = 0;

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
		ptr = MEM_ReadInt (_@ (slf) + 1528 + (12 * invCat));	// 0x05F8
	} else {
		/*
		G2A oCNPC - inventory offset
			var int    inventory2_inventory_next;		// 0x0718 zCListSort<oCItem>*
		*/
		//G2A has single inventory
		ptr = MEM_ReadInt (_@ (slf) + 1816);			// 0x0718
	};
	//
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
 *		slfinstance		NPC instance
 *		instanceName		item instance name
 */
func int NPC_HasItemInstanceName (var int slfinstance, var string instanceName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfinstance);
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
