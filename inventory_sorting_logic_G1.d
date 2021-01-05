/*
 *	INV_WEAPON sorting
 *
 *	New sorting logic -->	ITEM_KAT_NF > damageTotal > value > Hlp_GetInstanceID (in case of items with same instance ID item without ITEM_MULTI flag > item with ITEM_MULTI flag)
 *				ITEM_KAT_FF > damageTotal > value > Hlp_GetInstanceID (in case of items with same instance ID item without ITEM_MULTI flag > item with ITEM_MULTI flag)
 *				ITEM_KAT_MUN > value > Hlp_GetInstanceID
 */

//itm1 > itm2 returns -1
//itm1 < itm2 returns 1
func void inventory2_inventory1_Compare_SortingLogic () {
	var int itmPtr1; itmPtr1 = MEM_ReadInt (ESP + 4);
	var int itmPtr2; itmPtr2 = MEM_ReadInt (ESP + 8);

	var oCItem itm1; itm1 = _^ (itmPtr1);
	var oCItem itm2; itm2 = _^ (itmPtr2);

	//Melee > Ranged > Ammo
	if (itm1.mainflag & ITEM_KAT_NF){
		//Melee
		if (itm2.mainflag & ITEM_KAT_NF){
			if (itm1.damageTotal > itm2.damageTotal) {
				EAX = -1; return;
			};

			if (itm1.damageTotal < itm2.damageTotal) {
				EAX = 1; return;
			};

			if (itm1.damageTotal == itm2.damageTotal) {
				if (itm1.value > itm2.value) {
					EAX = -1; return;
				};

				if (itm1.value < itm2.value) {
					EAX = 1; return;
				};

				if (itm1.value == itm2.value) {
					if (Hlp_GetInstanceID (itm1) > Hlp_GetInstanceID (itm2)) {
						EAX = -1; return;
					};

					//Same instance ID - put equipped item first (equipped will not have ITEM_MULTI flag)
					if (Hlp_GetInstanceID (itm1) == Hlp_GetInstanceID (itm2)) {
						if (itm1.flags & ITEM_MULTI) {
							EAX = 1; return;
						};

						if (itm2.flags & ITEM_MULTI) {
							EAX = -1; return;
						};
					};

					EAX = 1; return;
				};
			};
		};

		//Ranged
		if (itm2.mainflag & ITEM_KAT_FF){
			EAX = -1; return;
		};

		//Ammo
		if (itm2.mainflag & ITEM_KAT_MUN){
			EAX = -1; return;
		};
	};

	//Ranged < Melee
	//Ranged > Ammo
	if (itm1.mainflag & ITEM_KAT_FF){
		//Ranged
		if (itm2.mainflag & ITEM_KAT_FF){
			if (itm1.damageTotal > itm2.damageTotal) {
				EAX = -1; return;
			};

			if (itm1.damageTotal < itm2.damageTotal) {
				EAX = 1; return;
			};

			if (itm1.damageTotal == itm2.damageTotal) {
				if (itm1.value > itm2.value) {
					EAX = -1; return;
				};

				if (itm1.value < itm2.value) {
					EAX = 1; return;
				};

				if (itm1.value == itm2.value) {
					if (Hlp_GetInstanceID (itm1) > Hlp_GetInstanceID (itm2)) {
						EAX = -1; return;
					};

					//Same instance ID - put equipped item first (equipped will not have ITEM_MULTI flag)
					if (Hlp_GetInstanceID (itm1) == Hlp_GetInstanceID (itm2)) {
						if (itm1.flags & ITEM_MULTI) {
							EAX = 1; return;
						};

						if (itm2.flags & ITEM_MULTI) {
							EAX = -1; return;
						};
					};

					EAX = 1; return;
				};
			};
		};

		//Melee
		if (itm2.mainflag & ITEM_KAT_NF){
			EAX = 1; return;
		};

		//Ammo
		if (itm2.mainflag & ITEM_KAT_MUN){
			EAX = -1; return;
		};
	};

	//Ammo
	EAX = 1;
};