/***
	2021-01-04 Weapon Stacking v0.01
	Authors: Auronen & Fawkes
	This little package allows you to use ITEM_MULTI flag with melee weapons in Gothic 1.
	Hooked functions oCNpc::EquipWeapon & oCNPC::UnequipItem will emulate same behaviour as you can see in G2A. If you have 10 weapons in 1 item slot, when equipped 1 weapon will move to it's own slot.
	You can then sell 9 unequipped items without additional hassle of well ... unequipping :)
***/

//0062A050  .text     Debug data           ?RemoveWeapon2@oCAniCtrl_Human@@QAEHXZ
const int oCAniCtrl_Human__RemoveWeapon2 = 6463568;

//oCAniCtrl_Human__RemoveWeapon1 is called when removing melee weapon
//HookEngine (oCAniCtrl_Human__RemoveWeapon1, 6, "_hook_oCAniCtrl_Human_RemoveWeapon1__weaponStacking");
//oCAniCtrl_Human__RemoveWeapon2 is called when removing both melee weapon and also ranged weapons
func void _hook_oCAniCtrl_Human_RemoveWeapon2__weaponStacking (){
	var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (ECX);
	
	var oCNPC slf; slf = _^ (aniCtrl.npc);

	if (NPC_IsPlayer (slf)) {
		NPC_SplitMultipleEquippedWeapons (slf);
	};
};

//006BB0A0  .text     Debug data           ?OpenInventory@oCNPC@@QAEXXZ
//Already defined in LeGo
//const int oCNPC__OpenInventory = 7057568;
func void _hook_oCNPC_OpenInventory__weaponStacking () {
	if (!ECX) { return; };
	var oCNPC slf; slf = _^ (ECX);

	if (NPC_IsPlayer (slf)) {
		NPC_SplitMultipleEquippedWeapons (slf);
	};
};

//NEW INV_WEAPON sorting

/*
	Sorting logic -->	ITEM_KAT_NF > damageTotal > value > Hlp_GetInstanceID (in case of items with same instance ID item without ITEM_MULTI flag is sorted on top)
				ITEM_KAT_FF > damageTotal > value > Hlp_GetInstanceID (in case of items with same instance ID item without ITEM_MULTI flag is sorted on top)
				ITEM_KAT_MUN > value > Hlp_GetInstanceID
*/

//0066B3D0  .text     Debug data           ??0oCNpcInventory@@QAE@XZ
//inventory2_inventory1_Compare int(_cdecl*)(oCItem*, OCItem*)	66B510	6731024
const int inventory2_inventory1_Compare = 6731024;

//itm1 > itm2 returns -1
//itm1 < itm2 returns 1
func void inventory2_inventory1_Compare__weaponStacking () {
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

//006968F0  .text     Debug data           ?Equip@oCNPC@@QAEXPAVoCItem@@@Z
//Already defined in LeGo
//const int oCNPC__Equip = 6908144;
func void _hook_oCNPC_Equip__weaponStacking (){
	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);
	if ((!ECX) || (!itemPtr)) { return; };

	var oCNPC slf; slf = _^ (ECX);
	var oCItem itm; itm = _^ (itemPtr);

	if (Hlp_IsValidItem (itm)) {
		if (NPC_IsPlayer (slf)) {
			//Call this only for melee and ranged, which were not equipped yet
			if ((itm.mainflag & ITEM_KAT_NF) || (itm.mainflag & ITEM_KAT_FF))
			&& ((itm.flags & ITEM_ACTIVE_LEGO) != ITEM_ACTIVE_LEGO)
			{
				//One item instance might be in multiple slots --> it might have flag ITEM_ACTIVE_LEGO, it might not

				//Function 'NPC_WeaponInstanceRemoveAddFlags' will loop through all inventory slots and will remove flag ITEM_ACTIVE_LEGO also it will add flag ITEM_MULTI
				//Unfortunately it will scramble all pointers, because function reinserts items to inventory !
				//That is why we cannot use pointers and we have to use item instance instead afterwards to get 'new' pointer
				var int itemInstance; itemInstance = Hlp_GetInstanceID (itm);
				NPC_WeaponInstanceRemoveAddFlags (slf, itemInstance, ITEM_ACTIVE_LEGO, ITEM_MULTI);
				
				//We have to get new pointer using itemInstance
				itemPtr = NPC_GetWeaponPtrByInstance (slf, itemInstance);

				//Remove from inventory 1 item, remove flag ITEM_MULTI and put it back to inventory (this will put it to its own slot)
				itemPtr = oCNpc_RemoveFromInvByPtr (slf, itemPtr, 1);
				oCItem_RemoveFlags (itemPtr, ITEM_MULTI);
				itemPtr = oCNpc_PutInInv (slf, itemPtr);

				//override pointer! This will make sure that our item without ITEM_MULTI flag will be equipped
				MEM_WriteInt (ESP + 4, itemPtr);
			};
		};

	};
};

//0068FBC0  .text     Debug data           ?UnequipItem@oCNPC@@QAEXPAVoCItem@@@Z
//Already defined in LeGo
//const int oCNPC__UnequipItem = 6880192;
func void _hook_oCNPC_UnequipItem__weaponStacking (){
	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);

	if (!ECX) || (!itemPtr) { return; };

	var oCNPC slf; slf = _^ (ECX);
	var oCItem itm; itm = _^ (itemPtr);

	if (Hlp_IsValidItem (itm)) {
		if (NPC_IsPlayer (slf)){
			if ((itm.mainflag & ITEM_KAT_NF) || (itm.mainflag & ITEM_KAT_FF)){
				if ((itm.flags & ITEM_ACTIVE_LEGO) == ITEM_ACTIVE_LEGO){
					itemPtr = oCNpc_RemoveFromInvByPtr (slf, itemPtr, itm.amount);
					oCItem_AddFlags (itemPtr, ITEM_MULTI);
					itemPtr = oCNpc_PutInInv (slf, itemPtr);
				} else {
					var int itemInstance; itemInstance = Hlp_GetInstanceID (itm);
					NPC_WeaponInstanceRemoveAddFlags (slf, itemInstance, ITEM_ACTIVE_LEGO, ITEM_MULTI);
				};
			};
		};
	};
};

//006A0D10  .text     Debug data           ?DoTakeVob@oCNPC@@UAEHPAVzCVob@@@Z
const int oCNPC__DoTakeVob = 6950160;
func void _hook_oCNPC_DoTakeVob__weaponStacking (){
	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);
	if ((!ECX) || (!itemPtr)) { return; };

	var oCNPC slf; slf = _^ (ECX);
	var oCItem itm; itm = _^ (itemPtr);

	if (Hlp_IsValidItem (itm)) {
		if (NPC_IsPlayer (slf)) {
			//Add ITEM_MULTI flag to taken items
			if (itm.mainflag & ITEM_KAT_NF) || (itm.mainflag & ITEM_KAT_FF) {
				itm.flags = itm.flags | ITEM_MULTI;
			};
		};
	};
};

func void G1_WeaponStacking_Init (){
	const int once = 0;

	if (!once){
		//Splits equipped weapons when opening inventory
		HookEngine (oCNPC__OpenInventory, 6, "_hook_oCNPC_OpenInventory__weaponStacking");
		
		//Splits equipped weapons on weapon removal.
		//I didn't find better hook but this one - function is being called all the time during weapon removal - even when weapon is unequipped - which is ideal for calling 'NPC_SplitMultipleEquippedWeapons'.
		HookEngine (oCAniCtrl_Human__RemoveWeapon2, 6, "_hook_oCAniCtrl_Human_RemoveWeapon2__weaponStacking");

		//Splits weapons on equipping. Removes ITEM_MULTI flag and re-inserts to inventory
		HookEngine (oCNPC__Equip, 5, "_hook_oCNPC_Equip__weaponStacking");
		//'Merges' weapons on unequipping. Applies ITEM_MULTI flag and re-inserts to inventory
		HookEngine (oCNPC__UnequipItem, 7, "_hook_oCNPC_UnequipItem__weaponStacking");

		//Applies ITEM_MULTI flag when taking weapons from world.
		HookEngine (oCNPC__DoTakeVob, 6, "_hook_oCNPC_DoTakeVob__weaponStacking");
		
		//Hook on oCNpc__DoDropVob applying back on weapons ITEM_MULTI when dropping is not supported. (When weapon was equipped it messed up oCNPC__UnequipItem hook)
		//It is probably not required. We can rethink this later if needed.

		//Custom sorting function. Makes sure that weapons inventory is sorted consistently.
		ReplaceEngineFunc (inventory2_inventory1_Compare, 0, "inventory2_inventory1_Compare__weaponStacking");
		
		once = 1;
	};
};