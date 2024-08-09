/*
 *	Enhanced Pickpocketing
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (translate to your own language, define rules for pickpocketing)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

//If this constant is set to true - then even if theft attempt has failed, hero will steal item (and will be caught)
const int ENHANCEDPICKPOCKETING_STEALITEMANYWAY = 1;

//API function
//Called when victim is out of pickpocketing range
func void EnhancedPickPocketing_TooFar () {
	PrintScreen("You're too far away!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

//API function
//Called when player steals item and is caught when stealing
func void EnhancedPickPocketing_DoStealItemAnyway(var C_NPC npc, var int itemPtr) {
	//Additional action when player steals item and is caught
};

/*
 *	Example
 *	Here we will not allow player to steal from/put into inventory ItMiNugget
 */
//API function
//This is where you can define Npc&Item-specific rules for pickpocketing - putting items to victim's inventory
func int C_PP_CanBePutToInventory(var C_NPC npc, var int itemPtr) {
	var oCItem itm; itm = _^(itemPtr);

	//Do not allow to insert ItMiNuggets
	if (Hlp_GetInstanceID(itm) == ItMiNugget) {
		return FALSE;
	};

	return TRUE;
};

//API function
//This is where you can define Npc&Item-specific rules for pickpocketing - taking items from victim's inventory
func int C_PP_CanBeStolenFromInventory(var C_NPC npc, var int itemPtr) {
	var oCItem itm; itm = _^(itemPtr);

	//Do not allow to steal ItMiNuggets
	if (Hlp_GetInstanceID(itm) == ItMiNugget) {
		return FALSE;
	};

	return TRUE;
};
