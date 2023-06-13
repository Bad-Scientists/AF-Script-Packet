/*
 *	Enhanced Pickpocketing
 *
 *	 - improves vanilla pickpocketing in G1:
 *		- enables additional body states (vanilla BS_STAND, BS_ITEMINTERACT, patched also while Npc is sitting / using mobs: BS_SIT, BS_LIE, BS_MOBINTERACT, BS_MOBINTERACT_INTERRUPT)
 *		- adds extra functions for failed pickpocketing attempts (from which we can let player know why attempt failed)
 *			- EnhancedPickPocketing_EmptyInventory is called when inventory of victim is empty
 *			- EnhancedPickPocketing_TooFar is called when victim is too far
 *		- fixes behaviour for failed theft attempts (if Npc is too far / if it's inventory is empty) of which victim is **aware of**:
 *			- in vanilla nothing would happen, only T_DONTKNOW animation would play. Here we are calling oCNpc_StopTheft - this will send perception PERC_CATCHTHIEF to victim.
 *
 *	 - additionaly we allow player to insert items into victims inventory (vanilla allows only stealing)
 *
 *	 - this feature is using 2 'API' functions to determine whether item can be stoled from / inserted into victim's inventory:
 *		- C_PP_CanBeStolenFromInventory (var C_NPC npc, var int itemPtr) determines whether item can be stoled from victim
 *		- C_PP_CanBePutToInventory (var C_NPC npc, var int itemPtr) determines whether item can be inserted into victim's inventory
 *		- if any of these determines that item **cannot** be stoled/inserted then feature calls oCNpc_StopTheft and will send perception PERC_CATCHTHIEF to victim
 */

var int _enhancedPickPocketing_StealItemAnyway;

func int oCNpcFocus_GetRange2 () {
	//0x00635180 public: float __thiscall oCNpcFocus::GetRange2(void)
	const int oCNpcFocus__GetRange2_G1 = 6508928;

	//0x006BEF80 public: float __thiscall oCNpcFocus::GetRange2(void)
	const int oCNpcFocus__GetRange2_G2 = 7073664;

	//0x008DA648 public: static class oCNpcFocus * oCNpcFocus::focus
	const int oCNpcFocus__focus_G1 = 9283144;

	//0x00AB0738 public: static class oCNpcFocus * oCNpcFocus::focus
	const int oCNpcFocus__focus_G2 = 11208504;

	var int focusPtr; focusPtr = MEM_ReadInt (MEMINT_SwitchG1G2 (oCNpcFocus__focus_G1, oCNpcFocus__focus_G2));

	var int retVal;

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall(_@ (focusPtr), MEMINT_SwitchG1G2 (oCNpcFocus__GetRange2_G1, oCNpcFocus__GetRange2_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Wrapper function checking body states
 */
func int Npc_BodyState_AwareOfTheft (var int npcInstance) {
	var oCNpc npc; npc = Hlp_GetNpc (npcInstance);

	const int BS_ONLY_STATE = 127;

	var int bodyState; bodyState = npc.bitfield[4] & oCNpc_bitfield4_bodyState;
	bodyState = (bodyState & BS_ONLY_STATE);

	//Define locally (global G1 have different values for a valid reason I assume :) )
	const int BS_STAND = 0;
	const int BS_WALK = 1;
	const int BS_SNEAK = 2;
	const int BS_RUN = 3;
	const int BS_SPRINT = 4;
	const int BS_SWIM = 5;
	const int BS_CRAWL = 6;
	const int BS_DIVE = 7;
	const int BS_JUMP = 8;
	const int BS_CLIMB = 9;
	const int BS_FALL = 10;
	const int BS_SIT = 11;
	const int BS_LIE = 12;
	const int BS_INVENTORY = 13;
	const int BS_ITEMINTERACT = 14;
	const int BS_MOBINTERACT = 15;
	const int BS_MOBINTERACT_INTERRUPT = 16;

	//Vanilla
	//BS_STAND, BS_ITEMINTERACT

	//'Patched'
	//BS_SIT, BS_LIE, BS_MOBINTERACT, BS_MOBINTERACT_INTERRUPT

	if ((bodyState == BS_STAND) || (bodyState == BS_ITEMINTERACT)
	|| (bodyState == BS_SIT) || (bodyState == BS_LIE) || (bodyState == BS_MOBINTERACT) || (bodyState == BS_MOBINTERACT_INTERRUPT))
	{
		return FALSE;
	};

	return TRUE;
};

func int oCNpc_IsVictimAwareOfTheft (var int npcInstance) {
/*
	As I was unable to 'patch' engine function we have to create our own version

	//0x006BAD80 public: int __thiscall oCNpc::IsVictimAwareOfTheft(void)
	const int oCNpc__IsVictimAwareOfTheft_G1 = 7056768;

	//0x00761EF0 public: int __thiscall oCNpc::IsVictimAwareOfTheft(void)
	const int oCNpc__IsVictimAwareOfTheft_G2 = 7741168;

	var oCNpc npc; npc = Hlp_GetNpc (npcInstance);
	if (!Hlp_IsValidNpc (npc)) { return FALSE; };

	var int npcPtr; npcPtr = _@ (npc);

	var int retVal;

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall(_@(npcPtr), MEMINT_SwitchG1G2 (oCNpc__IsVictimAwareOfTheft_G1, oCNpc__IsVictimAwareOfTheft_G2));
		call = CALL_End();
	};

	return + retVal;
*/
	//Re-creating oCNpc::IsVictimAwareOfTheft logic -->

	//thief
	var oCNpc npc; npc = Hlp_GetNpc (npcInstance);
	if (!Hlp_IsValidNpc (npc)) { return FALSE; };

	//Return FALSE if we don't have victim
	//0x008DBC28 class oCNpc * stealnpc
	const int stealnpc_addr_G1 = 9288744;
	var int stealnpcPtr; stealnpcPtr = MEM_ReadInt (stealnpc_addr_G1);
	if (!stealnpcPtr) { return FALSE; };

	var int retVal;

//-- Dead - not aware of theft

	//0x00693480 public: int __thiscall oCNpc::IsDead(void)
	const int oCNpc__IsDead_G1 = 6894720;

	//0x00736740 public: int __thiscall oCNpc::IsDead(void)
	const int oCNpc__IsDead_G2 = 7563072;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall(_@(stealnpcPtr), MEMINT_SwitchG1G2 (oCNpc__IsDead_G1, oCNpc__IsDead_G2));
		call = CALL_End();
	};

	if (retVal) { return FALSE; };

//-- Unconscious - not aware of theft

	//0x00693490 public: int __thiscall oCNpc::IsUnconscious(void)
	const int oCNpc__IsUnconscious_G1 = 6894736;

	//0x00736750 public: int __thiscall oCNpc::IsUnconscious(void)
	const int oCNpc__IsUnconscious_G2 = 7563088;

	const int call2 = 0;
	if (CALL_Begin(call2)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall(_@(stealnpcPtr), MEMINT_SwitchG1G2 (oCNpc__IsUnconscious_G1, oCNpc__IsUnconscious_G2));
		call2 = CALL_End();
	};

	if (retVal) { return FALSE; };

//-- Check if Npc detected thief (through perceptions, SENSE_SMELL will always detect thief if Npc is within npc.senses_range distance!)

	//0x0069CE90 public: int __thiscall oCNpc::HasVobDetected(class zCVob *)
	const int oCNpc__HasVobDetected_G1 = 6934160;

	//0x007405B0 public: int __thiscall oCNpc::HasVobDetected(class zCVob *)
	const int oCNpc__HasVobDetected_G2 = 7603632;

	var int npcPtr; npcPtr = _@ (npc);

	const int call3 = 0;
	if (CALL_Begin(call3)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall(_@(stealnpcPtr), MEMINT_SwitchG1G2 (oCNpc__HasVobDetected_G1, oCNpc__HasVobDetected_G2));
		call3 = CALL_End();
	};

	if (retVal) { return TRUE; };

//-- Check game mode - if we are in steal mode - check body state

	//victim
	var oCNpc slf; slf = _^ (stealnpcPtr);

	var int gameMode; gameMode = oCNpc_Get_Game_Mode ();
	if (gameMode == NPC_GAME_STEAL) {
		if (Npc_BodyState_AwareOfTheft (slf)) {
			return TRUE;
		};
	};

	return FALSE;
};

/*
 *	oCNpc_StopTheft
 *	 - engine function closes steal inventory
 *	 - if parameter victimIsAware is true then it also sends perception PERC_CATCHTHIEF to victim
 */
func void oCNpc_StopTheft (var int slfInstance, var int thiefPtr, var int victimIsAware) {
	//0x006BAFD0 public: void __thiscall oCNpc::StopTheft(class oCNpc *,int)
	const int oCNpc__StopTheft_G1 = 7057360;

	//0x00762160 public: void __thiscall oCNpc::StopTheft(class oCNpc *,int)
	const int oCNpc__StopTheft_G2 = 7741792;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (victimIsAware));
		CALL_PtrParam (_@ (thiefPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__StopTheft_G1, oCNpc__StopTheft_G2));
		call = CALL_End();
	};
};

/*
 *	Hook called when steal container is empty
 */
func void _hook_oCNpc_OpenSteal_StealContainerIsEmpty () {
	//self & other are updated by engine at this point
	//self is player
	//other is victim

	//Check if Npc is aware of theft - and react if it is!
	var int awareOfTheft; awareOfTheft = oCNpc_IsVictimAwareOfTheft (self);
	if (awareOfTheft) {
		//Call API function
		//API_CallByString ("ENHANCEDPICKPOCETING_AWAREOFTHEFT");

		oCNpc_StopTheft (other, _@ (self), awareOfTheft);
		return;
	};

	//Call API function
	API_CallByString ("ENHANCEDPICKPOCETING_EMPTYINVENTORY");
};

/*
 *	Hook called when steal attempt fails - let's see why!
 */
func void _hook_oCNpc_OpenSteal_ConditionsFailed () {
	//self & other are updated by engine at this point
	//self is player
	//other is victim

	//Run checks again - to get correct error message (and to fix behaviour)

	//Check if Npc is aware of theft - and react if it is!
	var int awareOfTheft; awareOfTheft = oCNpc_IsVictimAwareOfTheft (self);
	if (awareOfTheft) {
		//Call API function
		//API_CallByString ("ENHANCEDPICKPOCETING_AWAREOFTHEFT");

		oCNpc_StopTheft (other, _@ (self), awareOfTheft);
		return;
	};

	//0x008DBC28 class oCNpc * stealnpc
	const int stealnpc_addr_G1 = 9288744;
	var int stealnpcPtr; stealnpcPtr = MEM_ReadInt (stealnpc_addr_G1);
	if (!stealnpcPtr) { return; };

	//Check if stealnpc is too far
	var int fDistToStealNpc; fDistToStealNpc = zCVob_GetDistanceToVob2 (_@ (self), stealnpcPtr);
	var int fFocusRange; fFocusRange = oCNpcFocus_GetRange2 ();

	if (gf (fDistToStealNpc, fFocusRange)) {
		//Call API function
		API_CallByString ("ENHANCEDPICKPOCETING_TOOFAR");

		return;
	};

	//... otherwise it's because of G_CANSTEAL

	//Call API function
	//API_CallByString ("ENHANCEDPICKPOCETING_CANTSTEALFROM");
};

func void _hook_oCNpc_IsVictimAwareOfTheft_PatchBodyStates () {
	EAX = 0;

	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNpc npc; npc = _^ (ECX);

	//Return TRUE - body state is **invalid** for stealing
	if (Npc_BodyState_AwareOfTheft (npc)) {
		EAX = 1;
	};
};

/*
 *	Wrapper function for inventory 'types' (oCStealContainer & oCNpcInventory)
 */
func int oCItemContainer_HandleKey__EnhancedPickPocketing (var int ptr, var int key) {
	var int stealContainerPtr;
	var oCStealContainer stealContainer;

	var int openInvType;
	var int openInvContainerPtr;

	var int containerPtr;
	var oCItemContainer container;

	var oCNpc npc;
	var oCNpc owner;
	var int npcInventoryPtr;

	var int itemPtr;
	var oCItem itm;

	var int amount;
	var int retVal;

	//Transfer items
	if ((key == KEY_LMENU) || (key == KEY_LCONTROL) || (key == KEY_SPACE)) {

		openInvType = Hlp_GetOpenInventoryType ();

		if (openInvType == OpenInvType_Stealing) {
			openInvContainerPtr = Hlp_GetActiveOpenInvContainer ();

			if (openInvContainerPtr) {
				container = _^ (openInvContainerPtr);
				//itemPtr = List_GetS (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem + 2);
				itemPtr = zCListSort_GetData (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem);

				if (itemPtr) {
					//1 item at a time?
					amount = 1;

					stealContainerPtr = Hlp_GetOpenContainer_oCStealContainer ();
					stealContainer = _^ (stealContainerPtr);
					owner = _^ (stealContainer.inventory2_owner);

					const int symbID = 0;

					if (!symbID) {
						symbID = MEM_FindParserSymbol ("C_PP_CanBePutToInventory");
					};

					const int symbID2 = 0;

					if (!symbID2) {
						symbID2 = MEM_FindParserSymbol ("C_PP_CanBeStolenFromInventory");
					};

					const int symbID3 = 0;

					if (!symbID3) {
						symbID3 = MEM_FindParserSymbol ("ENHANCEDPICKPOCKETING_STEALITEMANYWAY");
					};

					//By default ... allow stealing 1 item at a time (TODO: do we want to allow stealing more at once?)
					amount = 1;

					//Success by default
					retVal = TRUE;

					//From players inventory to the steal victim (yes! we will allow that too :) )
					if (container.inventory2_oCItemContainer_right) {
						//Can be put to inventory?
						if (symbID != -1) {
							MEM_PushInstParam (owner);
							MEM_PushIntParam (itemPtr);
							MEM_CallByID (symbID);
							retVal = MEM_PopIntResult ();
						};

						//Success - move item
						if (retVal) {
							if (amount) {
								//Remove item from players inventory
								npc = Hlp_GetNPC (hero);
								npcInventoryPtr = _@ (npc.inventory2_vtbl);
								itemPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itemPtr, amount);

								npcInventoryPtr = _@ (owner.inventory2_vtbl);

								//Insert item to NPCs inventory
								itemPtr = oCNpcInventory_Insert (npcInventoryPtr, itemPtr);

								//Re-create list
								oCStealContainer_CreateList (stealContainerPtr);
							};
						};
					} else {
						//Can be stolen from inventory?
						if (symbID2 != -1) {
							MEM_PushInstParam (owner);
							MEM_PushIntParam (itemPtr);
							MEM_CallByID (symbID2);
							retVal = MEM_PopIntResult ();
						};

						//Success - move item
						//Additionaly we allow to move item to player's inventory even on failed attempt (if modder wishes to do so)
						if ((retVal) || (_enhancedPickPocketing_StealItemAnyway)) {
							if (amount) {
								//Remove item from NPCs inventory
								npcInventoryPtr = _@ (owner.inventory2_vtbl);
								itemPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itemPtr, amount);

								//Insert item to players inventory
								npc = Hlp_GetNPC (hero);
								npcInventoryPtr = _@ (npc.inventory2_vtbl);

								itemPtr = oCNpcInventory_Insert (npcInventoryPtr, itemPtr);

								//Re-create list
								oCStealContainer_CreateList (stealContainerPtr);
							};

							//Call EnhancedPickPocketing_StealItemAnyway (in case modder wants to update aivar or do some further actions)
							if (!retVal) {
								if (symbID3 != -1) {
									MEM_PushInstParam (owner);
									MEM_PushIntParam (itemPtr);
									MEM_CallByID (symbID3);
								};
							};
						};
					};

					//Pickpocketing failed - stop theft!
					if (!retVal) {
						oCNpc_StopTheft (owner, _@ (hero), 1);
					};

					return TRUE;
				};
			};
		};
	};

	//Allow switching to player's inventory (not allowed in vanilla) ... we allow it in order to move items from player's inventory to steal victim
	if ((key == MEM_GetKey ("keyRight"))
	|| (key == MEM_GetSecondaryKey ("keyRight"))
	|| (key == MEM_GetKey ("keyStrafeRight"))
	|| (key == MEM_GetSecondaryKey ("keyRight")))
	{
		openInvType = Hlp_GetOpenInventoryType ();

		if (openInvType == OpenInvType_Stealing) {
			openInvContainerPtr = Hlp_GetActiveOpenInvContainer ();

			//0x007DCEA4 const oCStealContainer::`vftable'
			const int oCStealContainer_vtbl_G1 = 8244900;

			if (MEM_ReadInt (openInvContainerPtr) == oCStealContainer_vtbl_G1) {
				//Get action key state
				var int actionKey; actionKey = MEM_GetKey ("keyAction"); actionKey = MEM_KeyState (actionKey);
				var int secondaryActionKey; secondaryActionKey = MEM_GetSecondaryKey ("keyAction"); secondaryActionKey = MEM_KeyState (secondaryActionKey);

				//Cancel default Ctrl + right arrow (in vanilla it would transfer an item)
				if (((actionKey == KEY_PRESSED) || (actionKey == KEY_HOLD)) || ((secondaryActionKey == KEY_PRESSED) || (secondaryActionKey == KEY_HOLD))) {
					return TRUE;
				};

				//Switch to next category
				//-1 to left, 1 to right
				return + oCItemContainer_ActivateNextContainer (ptr, 1);
			};
		};
	};

	return FALSE;
};

func void _eventStealContainerHandleEvent__EnhancedPickPocketing (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	//oCStealContainer
	var int cancel; cancel = oCItemContainer_HandleKey__EnhancedPickPocketing (ECX, key);

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void _eventNpcInventoryHandleEvent__EnhancedPickPocketing (var int dummyVariable) {
	if (!Hlp_Is_oCNpcInventory (ECX)) { return; };

	var int key; key = MEM_ReadInt (ESP + 4);
	//oCNpcInventory
	var int cancel; cancel = oCItemContainer_HandleKey__EnhancedPickPocketing (ECX, key);

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void G1_EnhancedPickPocketing_Init () {
	G1_InventoryEvents_Init ();

	StealContainerHandleEvent_AddListener (_eventStealContainerHandleEvent__EnhancedPickPocketing);

	NpcInventoryHandleEvent_AddListener (_eventNpcInventoryHandleEvent__EnhancedPickPocketing);

	//-- Load API values / init default values

	_enhancedPickPocketing_StealItemAnyway = API_GetSymbolIntValue ("ENHANCEDPICKPOCKETING_STEALITEMANYWAY", 1);

	//--

	const int once = 0;
	if (!once) {
		var int i;
		var int ptr;

//-- Patch body states

/*
		//Don't really understand why - but I was unable to 'patch' engine function oCNpc::IsVictimAwareOfTheft
		//006BADDD
		const int oCNpc__IsVictimAwareOfTheft__CheckBodyStates_G1 = 7056861;
		MemoryProtectionOverride (oCNpc__IsVictimAwareOfTheft__CheckBodyStates_G1, 7);
		ptr = oCNpc__IsVictimAwareOfTheft__CheckBodyStates_G1;
		repeat (i, 5);
			MEM_WriteByte (ptr, 144); //nop
			ptr += 1;
		end;

		MEM_WriteByte (ptr, 133); ptr += 1; //85 C0 test eax, eax
		MEM_WriteByte (ptr, 192); ptr += 1;

		HookEngine (oCNpc__IsVictimAwareOfTheft__CheckBodyStates_G1, 5, "_hook_oCNpc_IsVictimAwareOfTheft_PatchBodyStates");
*/
		//0x006BB350 public: int __thiscall oCNpc::OpenSteal(void)
		//006BB4FA
		const int oCNpc__OpenSteal_IsVictimAwareOfTheft_CheckBodyStates_G1 = 7058682;
		MemoryProtectionOverride (oCNpc__OpenSteal_IsVictimAwareOfTheft_CheckBodyStates_G1, 7);
		ptr = oCNpc__OpenSteal_IsVictimAwareOfTheft_CheckBodyStates_G1;
		repeat (i, 5);
			MEM_WriteByte (ptr, 144); //nop
			ptr += 1;
		end;

		MEM_WriteByte (ptr, 133); ptr += 1; //85 C0 test eax, eax
		MEM_WriteByte (ptr, 192); ptr += 1;

		HookEngine (oCNpc__OpenSteal_IsVictimAwareOfTheft_CheckBodyStates_G1, 5, "_hook_oCNpc_IsVictimAwareOfTheft_PatchBodyStates");

		//0x006BAE10 public: void __thiscall oCNpc::CheckSpecialSituations(void)
		//006BAEA3
		const int oCNpc__CheckSpecialSituations_IsVictimAwareOfTheft_CheckBodyStates_G1 = 7057059;
		MemoryProtectionOverride (oCNpc__CheckSpecialSituations_IsVictimAwareOfTheft_CheckBodyStates_G1, 7);
		ptr = oCNpc__CheckSpecialSituations_IsVictimAwareOfTheft_CheckBodyStates_G1;
		repeat (i, 5);
			MEM_WriteByte (ptr, 144); //nop
			ptr += 1;
		end;

		MEM_WriteByte (ptr, 133); ptr += 1; //85 C0 test eax, eax
		MEM_WriteByte (ptr, 192); ptr += 1;

		HookEngine (oCNpc__CheckSpecialSituations_IsVictimAwareOfTheft_CheckBodyStates_G1, 5, "_hook_oCNpc_IsVictimAwareOfTheft_PatchBodyStates");

//-- Additional hooks explaining why pickpocketing was not successfull + making sure Npc reacts to stealing

		//006BB654
		const int oCNpc__OpenSteal_StealContainerIsEmpty_G1 = 7059028;
		HookEngine (oCNpc__OpenSteal_StealContainerIsEmpty_G1, 5, "_hook_oCNpc_OpenSteal_StealContainerIsEmpty");

		//006bb767
		const int oCNpc__OpenSteal_Conditions_G1 = 7059303;
		HookEngine (oCNpc__OpenSteal_Conditions_G1, 5, "_hook_oCNpc_OpenSteal_ConditionsFailed");

		once = 1;
	};
};
