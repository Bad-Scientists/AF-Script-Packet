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

/*
 *	Engine functions
 */

/*
 *	oCNpc_FightAttackMelee
 */
func int oCNpc_FightAttackMelee (var int slfInstance, var int fightMove) {
	//0x007499D0 private: int __thiscall oCNpc::FightAttackMelee(int)
	const int oCNpc__FightAttackMelee_G1 = 7641552;

	//0x0067EEC0 private: int __thiscall oCNpc::FightAttackMelee(int)
	const int oCNpc__FightAttackMelee_G2 = 6811328;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (fightMove));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__FightAttackMelee_G1, oCNpc__FightAttackMelee_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCNpc_ThinkNextFightAction
 */
func int oCNpc_ThinkNextFightAction (var int slfInstance) {
	//0x00749150 private: int __thiscall oCNpc::ThinkNextFightAction(void)
	const int oCNpc__ThinkNextFightAction_G1 = 7639376;

	//0x0067E350 private: int __thiscall oCNpc::ThinkNextFightAction(void)
	const int oCNpc__ThinkNextFightAction_G2 = 6808400;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__ThinkNextFightAction_G1, oCNpc__ThinkNextFightAction_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCNpc_FightAttackMagic
 */
func int oCNpc_FightAttackMagic (var int slfInstance) {
	//0x0074A800 private: int __thiscall oCNpc::FightAttackMagic(void)
	const int oCNpc__FightAttackMagic_G1 = 7645184;

	//0x0067FA60 private: int __thiscall oCNpc::FightAttackMagic(void)
	const int oCNpc__FightAttackMagic_G2 = 6814304;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__FightAttackMagic_G1, oCNpc__FightAttackMagic_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	AI functions
 */

/*
 *	AI_Attack_Ext
 *	 - function allows us to define attack type in parameter subType: EV_ATTACKFORWARD, EV_ATTACKRUN, EV_ATTACKLEFT, EV_ATTACKRIGHT
 */
func void AI_Attack_Ext (var int slfInstance, var int subType, var int combo) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!slf.AniCtrl) { return; };
	var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (slf.AniCtrl);

	//Default
	var int aniID; aniID = -1;

	if (subType == EV_ATTACKFORWARD) { aniID = aniCtrl._t_hitf; };
	if (subType == EV_ATTACKRUN) { aniID = aniCtrl._t_hitfrun; };
	if (subType == EV_ATTACKLEFT) { aniID = aniCtrl._t_hitl; };
	if (subType == EV_ATTACKRIGHT) { aniID = aniCtrl._t_hitr; };

	//Default
	if (aniID == -1) {
		subType = EV_ATTACKFORWARD;
		aniID = aniCtrl._t_hitf;
	};

	var int eMsg; eMsg = oCMsgAttack_Create	(subType, 0, FLOATNULL, aniID, combo);

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	//Add new msg to Event Manager
	zCEventManager_OnMessage (eMgr, eMsg, _@ (slf));
};

/*
func void testComboFistFight () {
	var oCNpc slf; slf = Hlp_GetNpc (PC_Thief);
	Npc_ClearAIQueue (slf);
	slf.enemy = _@ (hero);

	FM_SetToFistMode (slf);
	AI_Attack_Ext (slf, EV_ATTACKFORWARD, 2);
};

func void testComboFight () {
	var oCNpc slf; slf = Hlp_GetNpc (PC_Thief);
	Npc_ClearAIQueue (slf);
	slf.enemy = _@ (hero);

	AI_ReadyMeleeWeapon (slf);

	AI_Attack_Ext (slf, EV_ATTACKFORWARD, 4);
};
*/
