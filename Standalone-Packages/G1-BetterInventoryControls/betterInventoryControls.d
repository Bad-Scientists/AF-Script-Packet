/*
 *	This feature enables better navigation in inventories:
 *		- Home key moves cursor to first item
 *		- End key  moves cursor to last item
 *		- Page Up/Page Down keys to scroll faster
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

func void _eventNpcInventoryHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	//oCNpcInventory
	var int cancel; cancel = oCItemContainer_HandleKey (ECX, key);

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void G1_BetterInventoryControls_Init(){
	const int once = 0;
	
	G1_TradeEvents_Init ();
	
	G1_InventoryEvents_Init ();
	
	if (!once) {
		TradeHandleEvent_AddListener (_eventTradeHandleEvent__BetterInvControls);

		ItemContainerHandleEvent_AddListener (_eventItemContainerHandleEvent__BetterInvControls);

		StealContainerHandleEvent_AddListener (_eventStealContainerHandleEvent__BetterInvControls);

		NpcContainerHandleEvent_AddListener (_eventNpcContainerHandleEvent__BetterInvControls);

		NpcInventoryHandleEvent_AddListener (_eventNpcInventoryHandleEvent__BetterInvControls);

		once = 1;
	};
};
