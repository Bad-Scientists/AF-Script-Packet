/*
 *	Item splitting - formerly known as Weapon-stacking :)
 *		- automatically stacks weapons, amulets and rings to one inventory slot
 *		- when item is equipped - feature will split this equipped item into separate inventory slot
 */

/*
 *	GetInventoryPtr__WeaponStacking
 *	 - returns pointer to current inventory
 */
func int GetInventoryPtr__ItemSplitting() {
	var oCNpc slf; slf = Hlp_GetNpc(hero);

	//INV_WEAPON
	if (slf.inventory2_invnr == 1) { return slf.inventory2_inventory1_next; };

	//INV_MAGIC
	if (slf.inventory2_invnr == 4) { return slf.inventory2_inventory4_next; };

	return 0;
};

/*
 *	DoMergeInventoryItems
 *	 - loops through inventory
 *	 - items w/o ITEM_MULTI & w/o ITEM_ACTIVE_LEGO flag will be re-inserted into inventory with ITEM_MULTI flag
 */
func void DoMergeInventoryItems__ItemSplitting() {
	const int ITM_FLAG_BELT = 1 << 24; //G2A only - available for G1 tho :)

	var zCListSort list;

	var oCItem itm;

	var int itemPtr;
	var int itemMergePtr;

	var int itemInstanceID; itemInstanceID = -1;
	var int itemLastInstanceID;

	var oCNpc slf; slf = Hlp_GetNpc(hero);
	var int npcInventoryPtr; npcInventoryPtr = _@(slf.inventory2_vtbl);

	var int ptr; ptr = GetInventoryPtr__ItemSplitting();

	while (ptr);
		list = _^(ptr);

		itemPtr = list.data;
		ptr = list.next;

		if (itemPtr) {
			itm = _^(itemPtr);

			//Melee, ranged, amulets & rings
			if ((itm.mainflag & ITEM_KAT_NF) || (itm.mainflag & ITEM_KAT_FF) || (itm.flags & ITEM_AMULET) || (itm.flags & ITEM_RING) || (itm.flags & ITM_FLAG_BELT))
			{
			} else
			{
				continue;
			};

			itemLastInstanceID = itemInstanceID;
			itemInstanceID = Hlp_GetInstanceID(itm);

			//By default add ITEM_MULTI flag
			oCItem_AddFlags(itemPtr, ITEM_MULTI);

			//Only items that are not equipped (safety check)
			if ((itm.flags & ITEM_ACTIVE_LEGO) != ITEM_ACTIVE_LEGO) {
				//Only duplicate entries
				if (itemInstanceID == itemLastInstanceID) {
					//Re-insert to inventory
					oCItemContainer_Remove(npcInventoryPtr, itemPtr);
					itemPtr = oCNpcInventory_Insert(npcInventoryPtr, itemPtr);

					//Reset loop
					itemInstanceID = -1;
					ptr = GetInventoryPtr__ItemSplitting();
				};
			};
		};
	end;
};

/*
 *	DoSplitInventoryItems
 *	 - loops through inventory
 *	 - equipped items with more than 1 piece will be split and re-inserted into inventory
 */
func void DoSplitInventoryItems__ItemSplitting() {
	const int ITM_FLAG_BELT = 1 << 24; //G2A only - available for G1 tho :)

	//-- If Union MultiSlotWeapons feature is enabled - exit
	//(even tho my implementation is slightly better because of inventory sorting ;-P )

	const int unionMultiSlotEnabled = -1;

	if (unionMultiSlotEnabled == -1) {
		unionMultiSlotEnabled = STR_ToInt(zCOption_SystemPack_GetOption("PARAMETERS", "MultiSlotWeapons")) | STR_ToInt(zCOption_SystemPack_GetOption("PARAMETERS", "MultiSlotMagic"));
	};

	if (unionMultiSlotEnabled) {
		return;
	};

	//--

	DoMergeInventoryItems__ItemSplitting();

	var oCNpc slf; slf = Hlp_GetNpc(hero);
	var int npcInventoryPtr; npcInventoryPtr = _@(slf.inventory2_vtbl);

	var zCListSort list;

	var int ptr; ptr = GetInventoryPtr__ItemSplitting();

	var oCItem itm;

	var int itemPtr;
	var int itemSplitPtr;

	while (ptr);
		list = _^(ptr);

		itemPtr = list.data;
		ptr = list.next;

		if (itemPtr) {
			itm = _^(itemPtr);

			//Melee, ranged, amulets & rings
			if ((itm.mainflag & ITEM_KAT_NF) || (itm.mainflag & ITEM_KAT_FF) || (itm.flags & ITEM_AMULET) || (itm.flags & ITEM_RING) || (itm.flags & ITM_FLAG_BELT))
			{
			} else
			{
				continue;
			};

			//Split equipped items
			if ((itm.flags & ITEM_ACTIVE_LEGO) == ITEM_ACTIVE_LEGO)
			&& (itm.amount > 1) {
				//Order of re-insertion is important!
				//Items with ITEM_MULTI will be 'stacked' together
				//Items without ITEM_MULTI will be inserted to the list in a new slot
				//1. we remove n items from equipped slot & remove ITEM_MULTI flag from them
				//2. insert n items to inventory
				//3. swap flags: remove ITEM_MULTI flag from equipped item & add ITEM_MULTI to the rest of the items

				//This creates item in game world
				itemSplitPtr = oCItem_SplitItemPtr(itemPtr, itm.amount - 1);

				//Re-insert equipped item to inventory
				oCItem_RemoveFlags(itemPtr, ITEM_MULTI);
				oCItemContainer_Remove(npcInventoryPtr, itemPtr);
				itemPtr = oCNpcInventory_Insert(npcInventoryPtr, itemPtr);

				//Remove ITEM_MULTI flag (yes - even though this is [n] items - this will make sure item is inserted into its own slot)
				oCItem_RemoveFlags(itemSplitPtr, ITEM_MULTI);
				oCItem_RemoveFlags(itemSplitPtr, ITEM_ACTIVE_LEGO);

				//1. insert items without ITEM_MULTI into inventory (oCNpcInventory_Insert sorts items)
				//This will insert item into separate inventory slot
				itemSplitPtr = oCNpcInventory_Insert(npcInventoryPtr, itemSplitPtr);

				//2. swap flags
				//Redundant - equipped item already has this one
				oCItem_AddFlags(itemPtr, ITEM_ACTIVE_LEGO);
				oCItem_RemoveFlags(itemPtr, ITEM_MULTI);

				oCItem_AddFlags(itemSplitPtr, ITEM_MULTI);

				//Reset loop
				ptr = GetInventoryPtr__ItemSplitting();
			};
		};
	end;
};

//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
func void _eventEquipItem__ItemSplitting (var int dummyVariable){
	if (!Hlp_Is_oCNpc(ECX)) { return; };
	var oCNPC slf; slf = _^(ECX);
	if (!Npc_IsPlayer(slf)) { return; };

	//INV_WEAPON or INV_MAGIC
	if ((slf.inventory2_invnr == 1) || (slf.inventory2_invnr == 4)) {
		AI_Function(hero, DoSplitInventoryItems__ItemSplitting);
	};
};

//0x0068FBC0 public: void __thiscall oCNpc::UnequipItem(class oCItem *)
func void _eventUnEquipItem__ItemSplitting (var int dummyVariable){
	if (!Hlp_Is_oCNpc(ECX)) { return; };
	var oCNPC slf; slf = _^(ECX);
	if (!Npc_IsPlayer(slf)) { return; };

	//INV_WEAPON or INV_MAGIC
	if ((slf.inventory2_invnr == 1) || (slf.inventory2_invnr == 4)) {
		AI_Function(hero, DoSplitInventoryItems__ItemSplitting);
	};
};

//0x0066DE60 public: int __thiscall oCNpcInventory::SwitchToCategory(int)
func void _hook_oCNpcInventory_SwitchToCategory__ItemSplitting() {
	var int invCat; invCat = MEM_ReadInt(ESP + 4);
	//INV_WEAPON or INV_MAGIC
	if ((invCat == 1) || (invCat == 4)) {
		AI_Function(hero, DoSplitInventoryItems__ItemSplitting);
	};
};

func void _eventOpenInventory__ItemSplitting(var int dummyVariable) {
	AI_Function(hero, DoSplitInventoryItems__ItemSplitting);
};

func void G1_ItemSplitting_Init (){
	G1_EnhancedInventorySorting_Init();

	G12_EquipItemEvent_Init();
	EquipItemEvent_AddListener(_eventEquipItem__ItemSplitting);

	G12_UnEquipItemEvent_Init();
	UnEquipItemEvent_AddListener(_eventUnEquipItem__ItemSplitting);

	G12_OpenInventoryEvent_Init();
	OpenInventoryEvent_AddListener(_eventOpenInventory__ItemSplitting);

	const int once = 0;

	if (!once) {
		const int oCNpcInventory__SwitchToCategory_G1 = 6741600;
		HookEngine(oCNpcInventory__SwitchToCategory_G1, 7, "_hook_oCNpcInventory_SwitchToCategory__ItemSplitting");

		once = 1;
	};
};
