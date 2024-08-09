/*
 *	Equip control
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (define your own rules and logic for equipping)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

/*
 *	In this example we woll allow player to equip 5 rings at a time
 */

const int MAX_EQUIPPED_RINGS = 5;
const int MAX_EQUIPPED_AMULETS = 1;
const int MAX_EQUIPPED_BELTS = 1;

//API function
//Here we can define whether item can be equipped or not
func int C_Npc_CanEquip(var C_NPC slf, var int itemPtr) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	const int ITM_FLAG_RING = 1 << 11;
	const int ITM_FLAG_AMULET = 1 << 22;

	//G2A only - available for G1 tho :)
	const int ITM_FLAG_BELT = 1 << 24;

	var int countEquipped;
	var int category; category = Npc_ItemGetCategory(slf, itemPtr);

	//-- Rings

	if (oCItem_HasFlag(itemPtr, ITM_FLAG_RING)) {
		//Equip
		if (!oCItem_HasFlag(itemPtr, ITM_FLAG_ACTIVE)) {
			countEquipped = Npc_GetCountEquippedItemsByFlag(slf, category, ITM_FLAG_RING);

			if (countEquipped < MAX_EQUIPPED_RINGS) {
				Npc_SimpleEquip(slf, itemPtr);
			};

			//Was handled by this hook (this will cancel engine equip!)
			return TRUE;
		} else {
			//Unequip ... commented out ... we can just let engine do it ...
			//Npc_SimpleUnequip(slf, itemPtr);

			//Was handled by this hook (this will cancel engine equip!)
			//return TRUE;
		};
	};

	//-- Amulets

	if (oCItem_HasFlag(itemPtr, ITM_FLAG_AMULET)) {
		//Equip
		if (!oCItem_HasFlag(itemPtr, ITM_FLAG_ACTIVE)) {
			countEquipped = Npc_GetCountEquippedItemsByFlag(slf, category, ITM_FLAG_AMULET);

			if (countEquipped < MAX_EQUIPPED_AMULETS) {
				Npc_SimpleEquip(slf, itemPtr);
			};

			//Was handled by this hook (this will cancel engine equip!)
			return TRUE;
		} else {
			//Unequip ... commented out ... we can just let engine do it ...
			//Npc_SimpleUnequip(slf, itemPtr);

			//Was handled by this hook (this will cancel engine equip!)
			//return TRUE;
		};
	};

	//-- Belts - both G1 & G2A (if modder chooses to use them for G1 :) )

	if (oCItem_HasFlag(itemPtr, ITM_FLAG_BELT)) {
		//Equip
		if (!oCItem_HasFlag(itemPtr, ITM_FLAG_ACTIVE)) {
			countEquipped = Npc_GetCountEquippedItemsByFlag(slf, category, ITM_FLAG_BELT);

			if (countEquipped < MAX_EQUIPPED_BELTS) {
				Npc_SimpleEquip(slf, itemPtr);
			};

			//Was handled by this hook (this will cancel engine equip!)
			return TRUE;
		} else {
			//Unequip ... commented out ... we can just let engine do it ...
			//Npc_SimpleUnequip(slf, itemPtr);

			//Was handled by this hook (this will cancel engine equip!)
			//return TRUE;
		};
	};

	//-- Just some random item - e.g. item_Shoes, which have ITEM_KAT_NONE :)

	var oCItem itm;
	if (Hlp_Is_oCItem(itemPtr)) {
		itm = _^(itemPtr);

		if (Hlp_GetInstanceID(itm) == item_Shoes) {
			//Equip
			if (!oCItem_HasFlag(itemPtr, ITM_FLAG_ACTIVE)) {
				countEquipped = Npc_GetCountEquippedItemsByInstance(slf, category, item_Shoes);

				if (countEquipped < 1) {
					Npc_SimpleEquip(slf, itemPtr);
				};
			} else {
				//Unequip
				Npc_SimpleUnequip(slf, itemPtr);
			};

			//Was handled by this hook (this will cancel engine equip!)
			return TRUE;
		};
	};

	//Continue with engine equip-handling
	return FALSE;
};
