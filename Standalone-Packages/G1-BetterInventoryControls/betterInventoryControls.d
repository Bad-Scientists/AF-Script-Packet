/*
 *	This feature enables better navigation in inventories:
 *	 - Home key moves cursor to first item
 *	 - End key  moves cursor to last item
 *	 - Page Up/Page Down keys to scroll faster through inventory
 *
 *	 - it also adds possibility to:
 *	    - put item in hand by pressing Alt + key Up
 *	    - drop a single piece of item by pressing Alt + key Down
 */

/*
 *	Wrapper function for all inventory 'types' (oCItemContainer, oCStealContainer, oCNpcContainer, oCNpcInventory)
 */
func int oCItemContainer_HandleKey (var int ptr, var int key) {
	if ((key == KEY_PRIOR) || (key == KEY_NEXT) || (key == KEY_HOME) || (key == KEY_END)) {
		var oCItemContainer itemContainer;

		itemContainer = _^ (ptr);

		var int numItemsInCategory; numItemsInCategory = List_LengthS (itemContainer.inventory2_oCItemContainer_contents) - 1;

		if (numItemsInCategory > -1) {

			//Page Up
			if (key == KEY_PRIOR) {
				if (itemContainer.inventory2_oCItemContainer_selectedItem > itemContainer.inventory2_oCItemContainer_offset) {
					itemContainer.inventory2_oCItemContainer_selectedItem = itemContainer.inventory2_oCItemContainer_offset;
				} else {
					if (itemContainer.inventory2_oCItemContainer_selectedItem > itemContainer.inventory2_oCItemContainer_drawItemMax) {
						itemContainer.inventory2_oCItemContainer_offset -= itemContainer.inventory2_oCItemContainer_drawItemMax;
						itemContainer.inventory2_oCItemContainer_selectedItem -= itemContainer.inventory2_oCItemContainer_drawItemMax;
					} else {
						itemContainer.inventory2_oCItemContainer_selectedItem = 0;
						itemContainer.inventory2_oCItemContainer_offset = 0;
					};
				};
			};

			//Page Down
			if (key == KEY_NEXT) {
				var int pageSize; pageSize = itemContainer.inventory2_oCItemContainer_drawItemMax - 1;

				if (itemContainer.inventory2_oCItemContainer_selectedItem < itemContainer.inventory2_oCItemContainer_offset + pageSize) {
					itemContainer.inventory2_oCItemContainer_selectedItem = itemContainer.inventory2_oCItemContainer_offset + pageSize;
				} else {
					itemContainer.inventory2_oCItemContainer_offset += pageSize;
					itemContainer.inventory2_oCItemContainer_selectedItem += pageSize;
				};
			};

			//Jump to first item
			if (key == KEY_HOME) {
				itemContainer.inventory2_oCItemContainer_selectedItem = 0;
				itemContainer.inventory2_oCItemContainer_offset = 0;
			};

			//Jump to last item
			if (key == KEY_END) {
				itemContainer.inventory2_oCItemContainer_selectedItem = numItemsInCategory;
			};

			if (itemContainer.inventory2_oCItemContainer_offset > numItemsInCategory) {
				itemContainer.inventory2_oCItemContainer_offset = numItemsInCategory;
			};

			if (itemContainer.inventory2_oCItemContainer_selectedItem > numItemsInCategory) {
				itemContainer.inventory2_oCItemContainer_selectedItem = numItemsInCategory;
			};

			//Adjust offset
			if (itemContainer.inventory2_oCItemContainer_selectedItem > itemContainer.inventory2_oCItemContainer_offset + itemContainer.inventory2_oCItemContainer_drawItemMax) {
				itemContainer.inventory2_oCItemContainer_offset = itemContainer.inventory2_oCItemContainer_selectedItem - itemContainer.inventory2_oCItemContainer_drawItemMax;
			};

			return TRUE;
		};
	};

	return FALSE;
};

func void _eventTradeHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	var int activeContainerNo; activeContainerNo = -1;

	var int ptr;

	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		//Get activeContainerNo: 0 = trader, 1 = traders offer, 2 = buyers offer, 3 = buyer
		activeContainerNo = MEM_ReadInt (ptr + 268);
	};

	//Trader
	if (activeContainerNo == 0) {
		ptr = MEMINT_oCInformationManager_Address;
		ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade

		if (ptr) {
			ptr = MEM_ReadInt (ptr + 248);	//oCInformationManager.ocViewDialogTrade.oCViewDialogStealContainer

			if (ptr) {
				ptr = MEM_ReadInt (ptr + 256);
			};
		};
	} else
	//Traders offer
	if (activeContainerNo == 1) {
		ptr = MEMINT_oCInformationManager_Address;
		ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade

		if (ptr) {
			ptr = MEM_ReadInt (ptr + 252);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer

			if (ptr) {
				ptr = MEM_ReadInt (ptr + 256);
			};
		};
	} else
	//Buyers offer
	if (activeContainerNo == 2) {
		ptr = MEMINT_oCInformationManager_Address;
		ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade

		if (ptr) {
			ptr = MEM_ReadInt (ptr + 260);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer

			if (ptr) {
				ptr = MEM_ReadInt (ptr + 256);
			};
		};
	} else
	//Buyer
	if (activeContainerNo == 3) {
		ptr = MEMINT_oCInformationManager_Address;
		ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade

		if (ptr) {
			ptr = MEM_ReadInt (ptr + 264);	//oCInformationManager.ocViewDialogTrade.oCViewDialogInventory

			if (ptr) {
				ptr = MEM_ReadInt (ptr + 256);
			};
		};
	};

	if (activeContainerNo > -1) {
		//oCViewDialogTrade
		cancel = oCItemContainer_HandleKey (ptr, key);
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void _eventItemContainerHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	//oCItemContainer
	var int cancel; cancel = oCItemContainer_HandleKey (ECX, key);

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void _eventStealContainerHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	//oCStealContainer
	var int cancel; cancel = oCItemContainer_HandleKey (ECX, key);

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void _eventNpcContainerHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	//oCNpcContainer
	var int cancel; cancel = oCItemContainer_HandleKey (ECX, key);

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

/*
func void oCNpc_RemoveFromHand__BetterInvControls (var int slfInstance) {
	//0x00694060 public: void __thiscall oCNpc::RemoveFromHand(void)
	const int oCNpc__RemoveFromHand_G1 = 6897760;

	//There is no G2A function
	const int oCNpc__RemoveFromHand_G2 = 0;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//return in G2A (I would not expect this to be called at any point, since this is in only G1 function ... but just in case)
	if (MEMINT_SwitchG1G2 (0, 1)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), oCNpc__RemoveFromHand_G1);
		call = CALL_End();
	};
};
*/

func void _eventNpcInventoryHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	//oCNpcInventory
	var int cancel; cancel = oCItemContainer_HandleKey (ECX, key);

	var oCNpcInventory npcInventory;

	//Has to be C_NPC because of LeGo oCNpc_PutInSlot function
	var C_NPC slf;
	var int vobPtr;

	//Player's inventory - additional controls

	const int action_Nothing	= 0;
	const int action_PutInHand	= 1;
	const int action_DropItem	= 2;

	var int action; action = action_Nothing;

	var int altKey;
	var int altSecondaryKey;

	//Alt + key Up --> Put item in hand
	if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp"))) {
		altKey = MEM_GetKey ("keySMove");
		altSecondaryKey = MEM_GetKey ("keySMove");

		altKey = MEM_KeyState (altKey);
		altSecondaryKey = MEM_KeyState (altSecondaryKey);

		if (((altKey == KEY_PRESSED) || (altKey == KEY_HOLD)) || ((altSecondaryKey == KEY_PRESSED) || (altSecondaryKey == KEY_HOLD))) {
			action = action_PutInHand;
		};
	};

	//Alt + key Down --> Drop 1 piece
	if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown"))) {
		altKey = MEM_GetKey ("keySMove");
		altSecondaryKey = MEM_GetKey ("keySMove");

		altKey = MEM_KeyState (altKey);
		altSecondaryKey = MEM_KeyState (altSecondaryKey);

		if (((altKey == KEY_PRESSED) || (altKey == KEY_HOLD)) || ((altSecondaryKey == KEY_PRESSED) || (altSecondaryKey == KEY_HOLD))) {
			action = action_DropItem;
		};
	};

	if (action != action_Nothing) {

		if (ECX) {
			npcInventory = _^ (ECX);

			if (Hlp_Is_oCNpc (npcInventory.inventory2_owner)) {
				if (npcInventory.inventory2_oCItemContainer_contents) {
					if ((npcInventory.inventory2_oCItemContainer_selectedItem > -1) && List_LengthS (npcInventory.inventory2_oCItemContainer_contents) > 1) {
						slf = _^ (npcInventory.inventory2_owner);
						if (NPC_IsPlayer (slf)) {
							vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");
							//Put item to hand only if hand is empty!
							if (!vobPtr) {
								vobPtr = List_GetS (npcInventory.inventory2_oCItemContainer_contents, npcInventory.inventory2_oCItemContainer_selectedItem + 2);

								if (vobPtr) {
									//Drop item - 1 piece
									if (action == action_DropItem) {
										//Take 1 piece from inventory, put in hand, remove from hand
										vobPtr = oCNpc_RemoveFromInvByPtr (slf, vobPtr, 1);
										oCNpc_SetRightHand (slf, vobPtr);
										//oCNpc_RemoveFromHand__BetterInvControls (slf);

										//var int retVal; retVal = oCNpc_DropFromSlot (slf, "ZS_RIGHTHAND");
										//We can't play any animations here
										//Npc_PlayAni (slf, "T_STAND_2_IDROP");
										//
										vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");
										AI_DropVobPtr (slf, vobPtr);

										//0x0066DF50 public: int __thiscall oCNpcInventory::FindNextCategory(void)
										//const int oCNpcInventory__FindNextCategory_G1 = 6741840;
										//CALL__thiscall (ECX, oCNpcInventory__FindNextCategory_G1);
									} else
									//Put in hand
									if (action == action_PutInHand) {
										//Take 1 piece from inventory, put in hand
										vobPtr = oCNpc_RemoveFromInvByPtr (slf, vobPtr, 1);
										oCNpc_SetRightHand (slf, vobPtr);
										//oCNpc_PutInSlot (slf, "ZS_RIGHTHAND", vobPtr, 0);

										//If I close inventory - then player will jump - cancel action has no effect (key event is then handled by different function?)
										//Close inventory
										//const int oCNpcInventory__Close = 6734304;
										//CALL__thiscall (ECX, oCNpcInventory__Close);
									};

									cancel = TRUE;
								};
							};
						};
					};
				};
			};
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

/*
 *	If player had in hand item and switched to fight mode - then engine calls oCNpc_DoDropVob - this function drops not only item in hand but also 1 piece from inventory for some reason
 */
func void _eventDoDropVob__BetterInvControls (var int eventType) {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int vobPtr; vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");
	if (vobPtr) {
		//This engine function drops item from hand only
		//oCNpc_RemoveFromHand__BetterInvControls (slf);
		var int retVal; retVal = oCNpc_DropFromSlot (slf, "ZS_RIGHTHAND");

		//Crash ...
		//const int contents = 0;
		//ECX = _@ (contents) - 4;

		//... this will cancel item drop using oCNpc::DoDropVob(class zCVob *)
		MEM_WriteInt (ESP + 4, 0);
	};
};

func void G1_BetterInventoryControls_Init(){
	const int once = 0;

	G1_TradeEvents_Init ();

	G1_InventoryEvents_Init ();

	TradeHandleEvent_AddListener (_eventTradeHandleEvent__BetterInvControls);

	ItemContainerHandleEvent_AddListener (_eventItemContainerHandleEvent__BetterInvControls);

	StealContainerHandleEvent_AddListener (_eventStealContainerHandleEvent__BetterInvControls);

	NpcContainerHandleEvent_AddListener (_eventNpcContainerHandleEvent__BetterInvControls);

	NpcInventoryHandleEvent_AddListener (_eventNpcInventoryHandleEvent__BetterInvControls);

	G12_DoDropVobEvent_Init ();

	DoDropVobEvent_AddListener (_eventDoDropVob__BetterInvControls);
};
