/*
 *	Sort_Weapons: INV_WEAPON
 *	New sorting logic
 *		ITEM_KAT_NF > damageTotal > value > Hlp_GetInstanceID (in case of items with same instance ID item without ITEM_ACTIVE_LEGO flag > item with ITEM_ACTIVE_LEGO flag)
 *		ITEM_KAT_FF > CBOW > BOW, damageTotal > value > Hlp_GetInstanceID (in case of items with same instance ID item without ITEM_ACTIVE_LEGO flag > item with ITEM_ACTIVE_LEGO flag)
 *		ITEM_KAT_MUN > CBOW > BOW, value > Hlp_GetInstanceID
 */

//itm1 > itm2 returns -1
//itm1 < itm2 returns 1
func void inventory2_inventory1_Compare_SortingLogic () {
	var int itmPtr1; itmPtr1 = MEM_ReadInt(ESP + 4);
	var int itmPtr2; itmPtr2 = MEM_ReadInt(ESP + 8);

	if (!itmPtr1) || (!itmPtr2) { return; };

	var oCItem itm1; itm1 = _^(itmPtr1);
	var oCItem itm2; itm2 = _^(itmPtr2);

	//Melee > Ranged > Ammo
	if (itm1.mainflag & ITEM_KAT_NF){
		//Ranged
		if (itm2.mainflag & ITEM_KAT_FF){
			EAX = -1; return;
		};

		//Ammo
		if (itm2.mainflag & ITEM_KAT_MUN){
			EAX = -1; return;
		};

		//Melee
		//Total damage
		if (itm1.damageTotal > itm2.damageTotal) {
			EAX = -1; return;
		};

		if (itm1.damageTotal < itm2.damageTotal) {
			EAX = 1; return;
		};
	};

	//Ranged < Melee
	//Ranged > Ammo
	if (itm1.mainflag & ITEM_KAT_FF){
		//Melee
		if (itm2.mainflag & ITEM_KAT_NF){
			EAX = 1; return;
		};

		//Ammo
		if (itm2.mainflag & ITEM_KAT_MUN){
			EAX = -1; return;
		};

		//Ranged
		//Crossbow > Bow
		if (itm1.flags & ITEM_CROSSBOW) {
			if (itm2.flags & ITEM_BOW) {
				EAX = -1; return;
			};
		};

		if (itm1.flags & ITEM_BOW) {
			if (itm2.flags & ITEM_CROSSBOW) {
				EAX = 1; return;
			};
		};

		//Total damage
		if (itm1.damageTotal > itm2.damageTotal) {
			EAX = -1; return;
		};

		if (itm1.damageTotal < itm2.damageTotal) {
			EAX = 1; return;
		};
	};

	//Ammo
	if (itm1.mainflag & ITEM_KAT_MUN) {
		if (itm2.mainflag & ITEM_KAT_MUN) {
			//Crossbow ammo > bow ammo
			if (itm1.flags & ITEM_CROSSBOW) {
				if (itm2.flags & ITEM_BOW) {
					EAX = -1; return;
				};
			};

			if (itm1.flags & ITEM_BOW) {
				if (itm2.flags & ITEM_CROSSBOW) {
					EAX = 1; return;
				};
			};

			//Value
			if (itm1.value > itm2.value) {
				EAX = -1; return;
			};

			if (itm1.value < itm2.value) {
				EAX = 1; return;
			};

			EAX = 1; return;
		};
	};

	//Item value
	if (itm1.value > itm2.value) {
		EAX = -1; return;
	};

	if (itm1.value < itm2.value) {
		EAX = 1; return;
	};

	//Instance ID
	if (Hlp_GetInstanceID(itm1) > Hlp_GetInstanceID(itm2)) {
		EAX = -1; return;
	};

	if (Hlp_GetInstanceID(itm1) < Hlp_GetInstanceID(itm2)) {
		EAX = 1; return;
	};

	//Equipped first
	if (itm1.flags & ITEM_ACTIVE_LEGO) {
		EAX = -1; return;
	};

	if (itm2.flags & ITEM_ACTIVE_LEGO) {
		EAX = 1; return;
	};

	EAX = 1;
};

//I. perma
//		1. ItFo_Potion_Master*
//		2. ItFo_Potion_Health_Perma*
//		3. ItFo_Potion_Mana_Perma*
//		4. ItFo_Potion_Str*
//		5. ItFo_Potion_Dex*
//II. hp
//		6. ItFo_Potion_Heal*
//III. mana
//		7. ItFo_Potion_Mana*
//IV. speed
//		8. ItFo_Potion_Haste*
//V. others
//		9. value
func int Sort_PotionGetWeight(var string s) {
	//Remove ITFO_POTION_ prefix
	s = mySTR_SubStr(s, 12, 12); //Take 12 characters - we don't need more
	if (STR_StartsWith(s, "MASTER")) {
		return 1;
	};

	if (STR_StartsWith(s, "HEAL")) {
		if (STR_StartsWith(s, "HEALTH_PERMA")) {
			return 2;
		};

		return 6;
	};
	if (STR_StartsWith(s, "MANA")) {
		if (STR_StartsWith(s, "HEALTH_PERMA")) {
			return 3;
		};

		return 7;
	};
	if (STR_StartsWith(s, "STR")) {
		return 4;
	};
	if (STR_StartsWith(s, "DEX")) {
		return 5;
	};
	if (STR_StartsWith(s, "HASTE")) {
		return 8;
	};

	return 9;
};

/*
 *	Sort_None: INV_RUNE, INV_MAGIC, INV_POTION
 *		Amulets > Rings > Belts
 *		Runes > Scrolls
 */
func void inventory2_inventory4_Compare_SortingLogic () {
	var int itmPtr1; itmPtr1 = MEM_ReadInt(ESP + 4);
	var int itmPtr2; itmPtr2 = MEM_ReadInt(ESP + 8);

	if (!itmPtr1) || (!itmPtr2) { return; };

	var oCItem itm1; itm1 = _^(itmPtr1);
	var oCItem itm2; itm2 = _^(itmPtr2);

	const int ITM_FLAG_BELT = 1 << 24; //G2A only - available for G1 tho :)

	//Amulets > Rings > Belts
	if (itm1.mainflag & ITEM_KAT_MAGIC) {
		if (itm1.flags & ITEM_AMULET) {
			if (itm2.flags & ITM_FLAG_BELT) {
				EAX = -1; return;
			};

			if (itm2.flags & ITEM_RING) {
				EAX = -1; return;
			};
		};

		if (itm1.flags & ITEM_RING) {
			if (itm2.flags & ITM_FLAG_BELT) {
				EAX = -1; return;
			};

			if (itm2.flags & ITEM_AMULET) {
				EAX = 1; return;
			};
		};

		if (itm1.flags & ITM_FLAG_BELT) {
			if (itm2.flags & ITEM_AMULET) {
				EAX = 1; return;
			};

			if (itm2.flags & ITEM_RING) {
				EAX = 1; return;
			};
		};
	};

	//Runes > Scrolls
	if (itm1.mainflag & ITEM_KAT_RUNE){
		// Circle
		if (itm1.mag_circle > itm2.mag_circle) {
			EAX = -1; return;
		};

		if (itm1.mag_circle < itm2.mag_circle) {
			EAX = 1; return;
		};
	};

	//Potions
	if (itm1.mainflag & ITEM_KAT_POTIONS){
		var string symbName1; symbName1 = GetSymbolName(itm1.instanz);
		var string symbName2; symbName2 = GetSymbolName(itm2.instanz);

		var int type1; type1 = Sort_PotionGetWeight(symbName1);
		var int type2; type2 = Sort_PotionGetWeight(symbName2);

		if (type1 < type2) {
			EAX = -1; return;
		};

		if (type1 > type2) {
			EAX = 1; return;
		};
	};

	// Value
	if (itm1.value > itm2.value) {
		EAX = -1; return;
	};

	if (itm1.value < itm2.value) {
		EAX = 1; return;
	};

	//Instance ID
	if (Hlp_GetInstanceID(itm1) > Hlp_GetInstanceID(itm2)) {
		EAX = -1; return;
	};

	if (Hlp_GetInstanceID(itm1) < Hlp_GetInstanceID(itm2)) {
		EAX = 1; return;
	};

	//Equipped first
	if (itm1.flags & ITEM_ACTIVE_LEGO) {
		EAX = -1; return;
	};

	if (itm2.flags & ITEM_ACTIVE_LEGO) {
		EAX = 1; return;
	};

	EAX = 1;
};

/*
 *	Sort_Other: INV_MISC
 *	New sorting logic
 *		itMiNugget > ItKeLockpick > ItLsTorch* > ITEM_MISSION > $$$
 */
func void inventory2_inventory8_Compare_SortingLogic () {
	var int itmPtr1; itmPtr1 = MEM_ReadInt(ESP + 4);
	var int itmPtr2; itmPtr2 = MEM_ReadInt(ESP + 8);

	if (!itmPtr1) || (!itmPtr2) { return; };

	var oCItem itm1; itm1 = _^(itmPtr1);
	var oCItem itm2; itm2 = _^(itmPtr2);

	var int itemInstanceID1; itemInstanceID1 = Hlp_GetInstanceID(itm1);
	var int itemInstanceID2; itemInstanceID2 = Hlp_GetInstanceID(itm2);

	if (itemInstanceID1 == itMiNugget) {
		EAX = -1; return;
	};
	if (itemInstanceID2 == itMiNugget) {
		EAX = 1; return;
	};
	if (itemInstanceID1 == itKeLockPick) {
		EAX = -1; return;
	};
	if (itemInstanceID2 == itKeLockPick) {
		EAX = 1; return;
	};
	if (itemInstanceID1 == ItLsTorch) {
		EAX = -1; return;
	};
	if (itemInstanceID2 == ItLsTorch) {
		EAX = 1; return;
	};
	if (itemInstanceID1 == ItLsTorchBurning) {
		EAX = -1; return;
	};
	if (itemInstanceID2 == ItLsTorchBurning) {
		EAX = 1; return;
	};
	if (itemInstanceID1 == ItLsTorchBurned) {
		EAX = -1; return;
	};
	if (itemInstanceID2 == ItLsTorchBurned) {
		EAX = 1; return;
	};
	if (itemInstanceID1 == ItLsTorchFirespit) {
		EAX = -1; return;
	};
	if (itemInstanceID2 == ItLsTorchFirespit) {
		EAX = 1; return;
	};
	if (itm1.mainflag & ITEM_MISSION) {
		EAX = -1; return;
	};
	if (itm2.mainflag & ITEM_MISSION) {
		EAX = 1; return;
	};
	if (itm1.value > itm2.value) {
		EAX = -1; return;
	};
	EAX = 1;
};

//Custom sorting functions
func void G1_EnhancedInventorySorting_Init (){
	const int once = 0;

	if (!once) {

		/*
		INV_NONE		Sort_None (oCItem *item1, oCItem *item2)
		INV_COMBAT		Sort_Weapons (oCItem *item1, oCItem *item2)
		INV_ARMOR		Sort_Armor (oCItem *item1, oCItem *item2)
		INV_RUNE		Sort_None (oCItem *item1, oCItem *item2)
		INV_MAGIC		Sort_None (oCItem *item1, oCItem *item2)
		INV_FOOD		Sort_Food (oCItem *item1, oCItem *item2)
		INV_POTION		Sort_None (oCItem *item1, oCItem *item2)
		INV_DOCS		Sort_Docs (oCItem *item1, oCItem *item2)
		INV_OTHER		Sort_Other (oCItem *item1, oCItem *item2)
		*/

		//Sort_Weapons: INV_WEAPON
		//Makes sure that weapons inventory is sorted consistently.
		ReplaceEngineFunc (inventory2_inventory1_Compare, 0, "inventory2_inventory1_Compare_SortingLogic");

		//Sort_None: INV_RUNE, INV_MAGIC, INV_POTION
		ReplaceEngineFunc (inventory2_inventory4_Compare, 0, "inventory2_inventory4_Compare_SortingLogic");

		//Sort_Other: INV_MISC
		ReplaceEngineFunc (inventory2_inventory8_Compare, 0, "inventory2_inventory8_Compare_SortingLogic");

		once = 1;
	};
};


