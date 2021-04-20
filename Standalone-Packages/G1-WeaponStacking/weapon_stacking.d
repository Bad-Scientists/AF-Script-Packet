/*
 *	2021-01-07 Weapon Stacking v0.01 for Gothic 1
 *
 *	Authors: Auronen & Fawkes
 *	This little package allows you to use ITEM_MULTI flag with melee weapons in Gothic 1.
 *	Hooked functions oCNpc::EquipWeapon & oCNPC::UnequipItem will emulate same behaviour as you can see in G2A. If you have 10 weapons in 1 item slot, when equipped 1 weapon will move to it's own slot.
 *	You can then sell 9 unequipped items without additional hassle of well ... unequipping :)
 */

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

func void _hook_oCItemContainer__Activate__weaponStacking () {
	//We cannot get oCItemContainer owner this address oCItemContainer.inventory2_oCItemContainer_npc == 0
	//So let's call it on hero
	NPC_SplitMultipleEquippedWeapons (hero);
};

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
				itemPtr = NPC_GetItemPtrByInstance (slf, INV_WEAPON, itemInstance);

				//Remove from inventory 1 item, remove flag ITEM_MULTI and put it back to inventory (this will put it to its own slot)
				itemPtr = oCNpc_RemoveFromInvByPtr (slf, itemPtr, 1);
				oCItem_RemoveFlags (itemPtr, ITEM_MULTI);
				itemPtr = oCNpc_PutInInvPtr (slf, itemPtr);

				//override pointer! This will make sure that our item without ITEM_MULTI flag will be equipped
				MEM_WriteInt (ESP + 4, itemPtr);
			};
		};

	};
};

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
					itemPtr = oCNpc_PutInInvPtr (slf, itemPtr);
				} else {
					var int itemInstance; itemInstance = Hlp_GetInstanceID (itm);
					NPC_WeaponInstanceRemoveAddFlags (slf, itemInstance, ITEM_ACTIVE_LEGO, ITEM_MULTI);
				};
			};
		};
	};
};

func void _hook_oCNpc_DoTakeVob__weaponStacking (){
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

func void _hook_weaponSorting__weaponStacking (){
	//Do we want to change anything? probably not
	inventory2_inventory1_Compare_SortingLogic ();
};

func void G1_WeaponStacking_Init (){
	const int once = 0;

	if (!once){
		//Splits equipped weapons on weapon removal.
		//I didn't find better hook but this one - function is being called all the time during weapon removal - even when weapon is unequipped - which is ideal for calling 'NPC_SplitMultipleEquippedWeapons'.
		HookEngine (oCAniCtrl_Human__RemoveWeapon2, 6, "_hook_oCAniCtrl_Human_RemoveWeapon2__weaponStacking");

		//Splits equipped weapons when opening inventory
		HookEngine (oCItemContainer__Activate, 7, "_hook_oCItemContainer__Activate__weaponStacking");

		//Not good enough - splits weapons on second run only
		//0066BDE0  .text     Debug data           ?Open@oCNpcInventory@@QAEXHH@Z
		//const int oCNpcInventory__Open = 6733280;
		//HookEngine (oCNpcInventory__Open, 7, "_hook_oCNpcInventory_Open__weaponStacking");

		//Not good enough - splits weapons on second run only
		//006BB0A0  .text     Debug data           ?OpenInventory@oCNPC@@QAEXXZ
		//const int oCNPC__OpenInventory_G1 = 7057568;
		//HookEngine (oCNPC__OpenInventory, 6, "_hook_oCNPC_OpenInventory__weaponStacking");

		//Splits weapons on equipping. Removes ITEM_MULTI flag and re-inserts to inventory
		HookEngine (oCNPC__Equip, 5, "_hook_oCNPC_Equip__weaponStacking");

		//'Merges' weapons on unequipping. Applies ITEM_MULTI flag and re-inserts to inventory
		HookEngine (oCNPC__UnequipItem, 7, "_hook_oCNPC_UnequipItem__weaponStacking");

		//Applies ITEM_MULTI flag when picking items
		HookEngine (oCNPC__DoTakeVob, 6, "_hook_oCNpc_DoTakeVob__weaponStacking");
		
		//Hook on oCNpc__DoDropVob applying back on weapons ITEM_MULTI when dropping is not supported. (When weapon was equipped it messed up oCNPC__UnequipItem hook)
		//It is probably not required. We can rethink this later if needed.

		//Custom sorting function. Makes sure that weapons inventory is sorted consistently.
		ReplaceEngineFunc (inventory2_inventory1_Compare, 0, "_hook_weaponSorting__weaponStacking");
		
		once = 1;
	};
};