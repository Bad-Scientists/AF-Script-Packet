/*
 *	Fight mode functions
 */

/*
 *	Switch to fist mode
 */
func void FM_SetToFistMode (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (Npc_IsInFightMode (slf, FMODE_FIST)) { return; };

	var int itemPtr; itemPtr = oCNpc_GetWeapon (slf);
	if (itemPtr) {
		AI_RemoveWeapon (slf);
	};

	AI_DrawWeapon_Ext (slf, FMODE_FIST, 1); //Melee - fists
};

/*
 *	Switch to fight mode (specific melee weapon)
 */
func void FM_SetToMelee (var int slfInstance, var int itemInstanceID) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Npc_HasItems (slf, itemInstanceID)) { return; };

	var int itemPtr; itemPtr = oCNpc_GetWeapon (slf);
	if (itemPtr) {
		var oCItem itm; itm = _^ (itemPtr);
		//Is this weapon that we want to draw?
		if (Hlp_GetInstanceID (itm) == itemInstanceID) {
			return;
		};
	};

	if ((itemPtr) || (Npc_IsInFightMode (slf, FMODE_FIST))) {
		AI_RemoveWeapon (slf);
	};

	if (Npc_GetInvItem (slf, itemInstanceID)) {
		if ((item.Flags & ITEM_ACTIVE_LEGO) == FALSE) {
			AI_UnequipMeleeWeapon (slf);
			AI_EquipItemPtr (slf, _@ (item));
		};
	};

	AI_DrawWeapon_Ext (slf, FMODE_FIST, 0); //Melee
};

/*
 *	Switch to fight mode (specific ranged weapon)
 */
func void FM_SetToRanged (var int slfInstance, var int itemInstanceID) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Npc_HasItems (slf, itemInstanceID)) { return; };

	var int itemPtr; itemPtr = oCNpc_GetWeapon (slf);
	if (itemPtr) {
		var oCItem itm; itm = _^ (itemPtr);
		//Is this weapon that we want to draw?
		if (Hlp_GetInstanceID (itm) == itemInstanceID) {
			return;
		};
	};

	//Remove weapon
	if ((itemPtr) || (Npc_IsInFightMode (slf, FMODE_FIST))) {
		AI_RemoveWeapon (slf);
	};

	//Equip weapon if not equipped
	if (Npc_GetInvItem (slf, itemInstanceID)) {
		if ((item.Flags & ITEM_ACTIVE_LEGO) == FALSE) {
			AI_UnequipRangedWeapon (slf);
			AI_EquipItemPtr (slf, _@ (item));
		};
	};

	AI_DrawWeapon_Ext (slf, FMODE_FAR, 0); //Ranged
};

