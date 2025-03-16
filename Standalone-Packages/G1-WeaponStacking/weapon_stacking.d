/*
 *	2021-01-07 Weapon Stacking v0.01 for Gothic 1
 *
 *	Authors: Auronen & Fawkes
 *	This little package allows you to use ITEM_MULTI flag with melee weapons in Gothic 1.
 *	Hooked functions oCNpc::EquipWeapon & oCNPC::UnequipItem will emulate same behaviour as you can see in G2A. If you have 10 weapons in 1 item slot, when equipped 1 weapon will move to it's own slot.
 *	You can then sell 9 unequipped items without additional hassle of well ... unequipping :)
 */

//Backwards compatibility (bruh)
func void G1_WeaponStacking_Init() {
	//Item-splitting is doing same thing - but it works for weapons, amulets, rings & potentially belts
	G1_ItemSplitting_Init();
};
