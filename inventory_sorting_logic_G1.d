/*
 *	INV_WEAPON
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

		EAX = 1; return;
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

		EAX = 1; return;
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

	EAX = 1;
};

/*
 *	INV_MISC
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

	if (!once){
		//INV_WEAPON
		//Makes sure that weapons inventory is sorted consistently.
		ReplaceEngineFunc (inventory2_inventory1_Compare, 0, "inventory2_inventory1_Compare_SortingLogic");

		//INV_MISC
		ReplaceEngineFunc (inventory2_inventory8_Compare, 0, "inventory2_inventory8_Compare_SortingLogic");

		once = 1;
	};
};
