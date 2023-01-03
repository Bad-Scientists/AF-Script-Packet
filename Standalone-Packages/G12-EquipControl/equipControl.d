/*
 *	Equip Control
 *	 - allows us to control which items can be equipped (e.g. to control how many rings player can equip or enable belts for G1 ... or allow you to equip anything you want :))
 */

/*
 *	Npc_SimpleEquip
 *	 - function adds all effect & calls on_equip function
 */
func void Npc_SimpleEquip (var int slfInstance, var int itemPtr) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	oCNpc_AddItemEffects (slfInstance, itemPtr);
	oCItem_SetFlag (itemPtr, ITM_FLAG_ACTIVE);
};

/*
 *	Npc_SimpleUnequip
 *	 - function adds all effect & calls on_unequip function
 */
func void Npc_SimpleUnequip (var int slfInstance, var int itemPtr) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	oCNpc_RemoveItemEffects (slfInstance, itemPtr);
	oCItem_ClearFlag (itemPtr, ITM_FLAG_ACTIVE);
};

func int Npc_GetCountEquippedItemsByFlag (var int slfInstance, var int category, var int searchFlag) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	if (category == -1) { return 0; };

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

	var int count; count = 0;

	//Unpack inventory
	oCNpcInventory_UnpackCategory (npcInventoryPtr, category);

	//Loop through all items - count how many equipped items we already have
	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * category));

	while (ptr);
		list = _^ (ptr);

		if (Hlp_Is_oCItem (list.data)) {
			if (oCItem_HasFlag (list.data, searchFlag)) {
				if (oCItem_HasFlag (list.data, ITM_FLAG_ACTIVE)) {
					count += 1;
				};
			};
		};

		ptr = list.next;
	end;

	return + count;
};

func int Npc_GetCountEquippedItemsByInstance (var int slfInstance, var int category, var int itemInstanceID) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	if (category == -1) { return 0; };

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

	var int count; count = 0;

	//Unpack inventory
	oCNpcInventory_UnpackCategory (npcInventoryPtr, category);

	//Loop through all items - count how many equipped items we already have
	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * category));

	while (ptr);
		list = _^ (ptr);

		if (Hlp_Is_oCItem (list.data)) {
			itm = _^ (list.data);
			if (Hlp_GetInstanceID (itm) == itemInstanceID) {
				if (oCItem_HasFlag (list.data, ITM_FLAG_ACTIVE)) {
					count += 1;
				};
			};
		};

		ptr = list.next;
	end;

	return + count;
};

func void _hook_oCNpc_EquipControl () {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCItem (itemPtr)) { return; };

	var oCNpc slf; slf = _^ (ECX);

	const int symbID = 0;
	var int retVal; retVal = 0;

	if (!symbID) {
		symbID = MEM_FindParserSymbol ("C_NpcCanEquip");
	};

	if (symbID != -1) {
		MEM_PushInstParam (slf);
		MEM_PushIntParam (itemPtr);

		MEM_CallByID (symbID);
		retVal = MEM_PopIntResult ();
	};

	if (retVal) {
		//Null item pointer - this will cancel equip action (everything handled from function C_NpcCanEquip - no need to let engine do it)
		MEM_WriteInt (ESP + 4, 0);
	};
};

func void G12_EquipControl_Init () {
	const int once = 0;
	if (!once) {
		//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
		const int oCNpc__Equip_G1 = 6908144;

		//0x00739C90 public: void __thiscall oCNpc::Equip(class oCItem *)
		const int oCNpc__Equip_G2 = 7576720;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__Equip_G1, oCNpc__Equip_G2), 5, "_hook_oCNpc_EquipControl");

		once = 1;
	};
};
