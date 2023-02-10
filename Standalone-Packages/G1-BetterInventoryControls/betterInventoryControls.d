/*
 *	Better Inventory Controls
 *	 - requires functions from enhancedTrading.d !
 *
 *	This feature enables better navigation in inventories:
 *	 - Home key moves cursor to first item
 *	 - End key  moves cursor to last item
 *	 - Page Up/Page Down keys to scroll faster through inventory
 *
 *	 - if player is in heros inventory:
 *	    - put item in hand by pressing key_E
 *	    - drop a single piece of item by pressing key_Q
 *	    - drop all items by pressing left alt KEY_LMENU
 *
 *	 - if player is in chest, NPCs inventory, trading
 *	    - move 1 piece from slot back and fort by pressing left ctrl KEY_LCONTROL
 *	    - move 10 pieces from slot back and fort by pressing space bar KEY_SPACE
 *	    - move all items from single slot back and fort by pressing left alt KEY_LMENU
 *
 *	 - allows moving items to dead NPCs inventories
 */

const int invCategory_VobTaken = -1;

/*
 *	Wrapper function for all inventory 'types' (oCItemContainer, oCStealContainer, oCNpcContainer, oCNpcInventory)
 */
func int oCItemContainer_HandleKey (var int ptr, var int key) {
	var int retVal;

	var int itmPtr;
	var oCItem itm;
	var int amount;

	var int openInvType;
	var int openInvContainerPtr;

	var oCItemContainer container;

	var int npcInventoryPtr;
	var int containerPtr;

	var int npcContainerPtr;
	var oCNpcContainer npcContainer;

	var oCNpc npc;

	if (!ptr) { return 0; };

	//Quick loot
	if (key == KEY_Q) {
		openInvType = Hlp_GetOpenInventoryType ();

		if (openInvType == OpenInvType_Chest) {
			openInvContainerPtr = Hlp_GetActiveOpenInvContainer ();

			//Inventory does not have to be closed.
			//We will close it anyway - when player calls quickloot he probably wants to pick items from chest and leave
			oCItemContainer_Close (openInvContainerPtr);

			//Close players inventory
			oCNPC_CloseInventory (hero);

			//Enable custom prints for transferred items
			_MobTransferItemPrint_Event_Enabled = TRUE;

			//Transfer all items
			npc = Hlp_GetNPC (hero);
			Mob_TransferItemsToNPC (npc.interactMob, hero);

			//Disable custom prints for transferred items
			_MobTransferItemPrint_Event_Enabled = FALSE;

			//Send mob state change (from state S1 to S0) - hero will stop interaction with mob
			oCMobInter_SendStateChange (npc.interactMob, 1, 0);

			return TRUE;
		} else
		if (openInvType == OpenInvType_NPC) {
			openInvContainerPtr = Hlp_GetActiveOpenInvContainer ();

			//If player is in pickpocketing mode - then transfer a **single item** and exit (pickpocketing hook will take care of the rest)
			if (NPC_IsInStateName (hero, "ZS_PICKPOCKETING")) {
				//oCItemContainer_TransferItem (var int ptr, var int dir, var int amount)
				//dir: -1 - left, 1 - right
				retVal = oCItemContainer_TransferItem (openInvContainerPtr, 1, 1);
				return TRUE;
			};

			npcContainer = _^ (openInvContainerPtr);
			npc = _^ (npcContainer.inventory2_owner);

			//Inventory has to be closed !! otherwise items would duplicate when NPC_TransferInventory is called

			//... that's okay, if player calls quickloot he probably wants to pick up items and leave

			//Close inventory (oCNpcContainer)
			oCNpcInventory_Close (openInvContainerPtr);

			//Close players inventory
			oCNPC_CloseInventory (hero);

			//We have to reset focus_vob
			oCNPC_SetFocusVob (hero, 0);

			//Enable custom prints for transferred items
			_NpcTransferItemPrint_Event_Enabled = TRUE;

			//Transfer all items
			NPC_TransferInventory (npc, hero, FALSE, TRUE, TRUE);

			//Disable custom prints for transferred items
			_NpcTransferItemPrint_Event_Enabled = FALSE;

			return TRUE;
		};
	} else
	if ((key == KEY_PRIOR) || (key == KEY_NEXT) || (key == KEY_HOME) || (key == KEY_END)) {
		container = _^ (ptr);

		var int numItemsInCategory; numItemsInCategory = List_LengthS (container.inventory2_oCItemContainer_contents) - 1;

		if (numItemsInCategory > -1) {

			//Page Up
			if (key == KEY_PRIOR) {
				if (container.inventory2_oCItemContainer_selectedItem > container.inventory2_oCItemContainer_offset) {
					container.inventory2_oCItemContainer_selectedItem = container.inventory2_oCItemContainer_offset;
				} else {
					if (container.inventory2_oCItemContainer_selectedItem > container.inventory2_oCItemContainer_drawItemMax) {
						container.inventory2_oCItemContainer_offset -= container.inventory2_oCItemContainer_drawItemMax;
						container.inventory2_oCItemContainer_selectedItem -= container.inventory2_oCItemContainer_drawItemMax;
					} else {
						container.inventory2_oCItemContainer_selectedItem = 0;
						container.inventory2_oCItemContainer_offset = 0;
					};
				};
			};

			//Page Down
			if (key == KEY_NEXT) {
				var int pageSize; pageSize = container.inventory2_oCItemContainer_drawItemMax - 1;

				if (container.inventory2_oCItemContainer_selectedItem < container.inventory2_oCItemContainer_offset + pageSize) {
					container.inventory2_oCItemContainer_selectedItem = container.inventory2_oCItemContainer_offset + pageSize;
				} else {
					container.inventory2_oCItemContainer_offset += pageSize;
					container.inventory2_oCItemContainer_selectedItem += pageSize;
				};
			};

			//Jump to first item
			if (key == KEY_HOME) {
				container.inventory2_oCItemContainer_selectedItem = 0;
				container.inventory2_oCItemContainer_offset = 0;
			};

			//Jump to last item
			if (key == KEY_END) {
				container.inventory2_oCItemContainer_selectedItem = numItemsInCategory;
			};

			if (container.inventory2_oCItemContainer_offset > numItemsInCategory) {
				container.inventory2_oCItemContainer_offset = numItemsInCategory;
			};

			if (container.inventory2_oCItemContainer_selectedItem > numItemsInCategory) {
				container.inventory2_oCItemContainer_selectedItem = numItemsInCategory;
			};

			//Adjust offset
			if (container.inventory2_oCItemContainer_selectedItem > container.inventory2_oCItemContainer_offset + container.inventory2_oCItemContainer_drawItemMax) {
				container.inventory2_oCItemContainer_offset = container.inventory2_oCItemContainer_selectedItem - container.inventory2_oCItemContainer_drawItemMax;
			};

			return TRUE;
		};
	} else

	//Transfer items
	if ((key == KEY_LMENU) || (key == KEY_LCONTROL) || (key == KEY_SPACE)) {

		openInvType = Hlp_GetOpenInventoryType ();

		if ((openInvType == OpenInvType_Chest) || (openInvType == OpenInvType_NPC) || (openInvType == OpenInvType_Trading)) {
			openInvContainerPtr = Hlp_GetActiveOpenInvContainer ();

			if (openInvContainerPtr) {
				container = _^ (openInvContainerPtr);
				itmPtr = List_GetS (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem + 2);

				if (itmPtr) {
					//Left Alt move complete slot
					itm = _^ (itmPtr);
					amount = itm.amount;

					//Don't transfer active/equipped items! bruh
					if ((itm.flags & ITEM_ACTIVE_LEGO) == ITEM_ACTIVE_LEGO) {
						return TRUE;
					};

					//Left ctrl moves a single piece
					if (key == KEY_LCONTROL) { amount = 1; };

					//Spacebar moves 10 pieces
					if (key == KEY_SPACE) { amount = 10; };

					if (amount > itm.amount) { amount = itm.amount; };

					if (openInvType == OpenInvType_Chest) {

						//Engine function oCItemContainer::TransferItem is sloooow (is it looping through all items?) ... can we create better version?
						//Cannot be used with NPC - items moved to NPC would not be prperly stored in NPCs inventory ... closing inventory would remove all items

						//oCItemContainer_TransferItem (var int ptr, var int dir, var int amount)
						//dir: -1 - left, 1 - right
						//if (container.inventory2_oCItemContainer_right) {
						//	retVal = oCItemContainer_TransferItem (ECX, -1, amount);
						//} else {
						//	retVal = oCItemContainer_TransferItem (ECX, 1, amount);
						//};

						//From players inventory to the chest
						if (container.inventory2_oCItemContainer_right) {
							npc = Hlp_GetNPC (hero);
							npcInventoryPtr = _@ (npc.inventory2_vtbl);
							itmPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itmPtr, amount);

							containerPtr = Hlp_GetOpenContainer_oCItemContainer ();
							oCItemContainer_Insert (containerPtr, itmPtr);
						} else {
							containerPtr = Hlp_GetOpenContainer_oCItemContainer ();
							itmPtr = oCItemContainer_RemoveByPtr (containerPtr, itmPtr, amount);

							npc = Hlp_GetNPC (hero);
							npcInventoryPtr = _@ (npc.inventory2_vtbl);
							oCNpcInventory_Insert (npcInventoryPtr, itmPtr);
						};
					} else

					if (openInvType == OpenInvType_NPC) {
						//From players inventory to the NPC (yes! we will allow it :) )
						if (container.inventory2_oCItemContainer_right) {
							//Remove item from NPCs inventory
							npc = Hlp_GetNPC (hero);
							npcInventoryPtr = _@ (npc.inventory2_vtbl);
							itmPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itmPtr, amount);

							npcContainerPtr = Hlp_GetOpenContainer_oCNpcContainer ();
							npcContainer = _^ (npcContainerPtr);
							npc = _^ (npcContainer.inventory2_owner);
							npcInventoryPtr = _@ (npc.inventory2_vtbl);

							//Insert item to NPCs inventory
							itmPtr = oCNpcInventory_Insert (npcInventoryPtr, itmPtr);

							//Re-create list - this will add to the item container all items from NPCs inventory
							//We have to use oCStealContainer_CreateList, because oCNpcContainer_CreateList will not delete list in oCItemContainer (and would cause item duplication)
							oCStealContainer_CreateList (npcContainerPtr);
							//oCNpcContainer_CreateList (npcContainerPtr);

						} else {
							//If player is in pickpocketing mode - then transfer a **single item** and exit (pickpocketing hook will take care of the rest)
							if (NPC_IsInStateName (hero, "ZS_PICKPOCKETING")) {
								//oCItemContainer_TransferItem (var int ptr, var int dir, var int amount)
								//dir: -1 - left, 1 - right
								retVal = oCItemContainer_TransferItem (openInvContainerPtr, 1, 1);
								return TRUE;
							};

							//Get NPC container
							npcContainerPtr = Hlp_GetOpenContainer_oCNpcContainer ();
							npcContainer = _^ (npcContainerPtr);
							npc = _^ (npcContainer.inventory2_owner);
							npcInventoryPtr = _@ (npc.inventory2_vtbl);

							//Remove item from inventory
							itmPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itmPtr, amount);

							//Insert item to players inventory
							npc = Hlp_GetNPC (hero);
							npcInventoryPtr = _@ (npc.inventory2_vtbl);
							oCNpcInventory_Insert (npcInventoryPtr, itmPtr);

							//Re-create list - this will add to the item container all items from NPCs inventory
							//We have to use oCStealContainer_CreateList, because oCNpcContainer_CreateList will not delete list in oCItemContainer (and would cause item duplication)
							oCStealContainer_CreateList (npcContainerPtr);
							//oCNpcContainer_CreateList (npcContainerPtr);
						};
					} else

					if (openInvType == OpenInvType_Trading) {
						var oCViewDialogTrade dialogTrade;
						if (MEM_InformationMan.DlgTrade) {
							dialogTrade = _^ (MEM_InformationMan.DlgTrade);
							/*
							We had several issues with engine functions ...
							Engine automatically changes amount of transfered items oCViewDialogTrade::OnTransferRight to zCOption::trade_amount - min 10 pieces !?
								Trade_SetTradeAmount (1);
								oCViewDialogTrade_OnTransferRight (MEM_InformationMan.DlgTrade, 1);
							*/

							//Trade_SetTradeAmount (amount);

							if (dialogTrade.sectionTrade == TRADE_SECTION_LEFT_INVENTORY_G1) {
								/*
								if (amount == 1) {
									//itemValue = itm.value;
									//itemValueF = mulf (mkf (itemValue), Trade_GetSellMultiplier ());

									//if ((itemValue > 0) && (RoundF (itemValueF) == 0)) {
									//	itemValue = 1;
									//} else {
									//	itemValue = RoundF (itemValueF);
									//};

									//itmPtr = oCViewDialogStealContainer_RemoveSelectedItem (dialogTrade.dlgInventoryNpc);
									//itmPtr = oCItemContainer_Insert (_@ (container_Trader_Offer), itmPtr);
									//Trade_SetNpcContainerValue (Trade_GetNpcContainerValue () + itemValue);

									//Moves 1 piece
									itmPtr = oCViewDialogStealContainer_RemoveSelectedItem (dialogTrade.dlgInventoryNpc);
									oCViewDialogItemContainer_InsertItem (dialogTrade.dlgContainerNpc, itmPtr);
								} else {
									//This does not remove item from traders inventory!?
									//itmPtr = oCItemContainer_RemoveByPtr (_@ (container), itmPtr, amount);
									//itmPtr = oCItemContainer_Insert (_@ (container_Trader_Offer), itmPtr);

									//This does not remove item from traders inventory!?
									//itmPtr = oCNpcInventory_RemoveByPtr (_@ (control), itmPtr, amount);
									//itmPtr = oCItemContainer_Insert (_@ (container_Trader_Offer), itmPtr);

									//itmPtr = oCItemContainer_Insert (_@ (container_Trader_Offer), itmPtr);
									//oCViewDialogItemContainer_Insert (dialogTrade.dlgContainerNpc, itmPtr);

									//Engine automatically changes amount of transfered items to zCOption::trade_amount (?) (min 10 pieces)
									//oCViewDialogTrade_OnTransferRight (MEM_InformationMan.DlgTrade, amount);

									Trade_MoveToContainerNpc (itmPtr, amount);
								};
								*/
								Trade_MoveToContainerNpc (itmPtr, amount);
							} else
							if (dialogTrade.sectionTrade == TRADE_SECTION_LEFT_CONTAINER_G1) {
								Trade_MoveToInventoryNpc (itmPtr, amount);
							} else
							if (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_CONTAINER_G1) {
								Trade_MoveToInventoryPlayer (itmPtr, amount);
							} else
							if (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_INVENTORY_G1) {
								Trade_MoveToContainerPlayer (itmPtr, amount);
							};

							//Trade_SetTradeAmount (trade_amount_backup);
						};
					};
				} else {
					//If there are no more items - next Alt key will close inventory
					if (key == KEY_LMENU) {
						//Chest
						if (openInvType == OpenInvType_Chest) {
							//Players inventory
							if (container.inventory2_oCItemContainer_right) {

							} else {
								//Chest is active

								//Close container
								oCItemContainer_Close (openInvContainerPtr);

								//Close players inventory
								oCNpc_CloseInventory (hero);

								//Send mob state change (from state S1 to S0) - hero will stop interaction with mob
								npc = Hlp_GetNPC (hero);
								oCMobInter_SendStateChange (npc.interactMob, 1, 0);
							};
						} else
						//Npc
						if (openInvType == OpenInvType_NPC) {
							//Players inventory
							if (container.inventory2_oCItemContainer_right) {

							} else {
								//NPCs inventory is active

								//Setting focus vob to 0 before closing players inventory will cause also NPCs inventory to close
								oCNpc_SetFocusVob (hero, 0);

								//Close players inventory
								oCNpc_CloseInventory (hero);
							};
						};
					};
				};
			};

			return TRUE;
		};
	};

	return FALSE;
};

func void _eventTradeHandleEvent__BetterInvControls (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	var int ptr;
	//ptr = Hlp_Trade_GetActiveTradeContainer ();
	ptr = Hlp_GetActiveOpenInvContainer ();

	if (ptr) {
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
	if (!Hlp_Is_oCNpcInventory (ECX)) { return; };

	var int key; key = MEM_ReadInt (ESP + 4);
	//oCNpcInventory
	var int cancel; cancel = oCItemContainer_HandleKey (ECX, key);

	var oCNpcInventory npcInventory;

	//Has to be C_NPC because of LeGo oCNpc_PutInSlot function
	var C_NPC slf;
	var int vobPtr;

	var oCItem itm;
	var int amount;

	var int openInvType; openInvType = Hlp_GetOpenInventoryType ();

//-- Player's inventory - additional controls

	if (openInvType == OpenInvType_Player) {
		const int action_Nothing	= 0;
		const int action_PutInHand	= 1;
		const int action_DropItem	= 2;
		const int action_DropAllItems	= 3;

		var int action; action = action_Nothing;

		//Put in hand / back to inventory
		if (key == key_E) { action = action_PutInHand; };

		//Drop from hand - single piece
		if (key == key_Q) { action = action_DropItem; };

		//Drop from hand - all items
		if (key == key_LMENU) { action = action_DropAllItems; };

		if (action != action_Nothing) {

			npcInventory = _^ (ECX);

			if (Hlp_Is_oCNpc (npcInventory.inventory2_owner)) {
				if (npcInventory.inventory2_oCItemContainer_contents) {
					slf = _^ (npcInventory.inventory2_owner);
					if (NPC_IsPlayer (slf)) {
						vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");
						//Put item to hand only if hand is empty!
						if (!vobPtr) {
							if (npcInventory.inventory2_oCItemContainer_selectedItem > -1) {
								//if (List_LengthS (npcInventory.inventory2_oCItemContainer_contents) > 1) {
								//Here we don't need to get length - all we need to know is whether list is empty :)
								var zCListSort l; l = _^ (npcInventory.inventory2_oCItemContainer_contents);
								if (l.next) {
									vobPtr = List_GetS (npcInventory.inventory2_oCItemContainer_contents, npcInventory.inventory2_oCItemContainer_selectedItem + 2);

									if (vobPtr) {
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
										} else
										//Drop item - 1 piece / all pieces
										if ((action == action_DropItem) || (action == action_DropAllItems)) {
											amount = 0;

											if (action == action_DropItem) {
												amount = 1;
											} else
											if (action == action_DropAllItems) {
												itm = _^ (vobPtr);
												amount = itm.amount;
											};

											if (amount > 0) {
												//Take 1 piece from inventory, put in hand, remove from hand
												vobPtr = oCNpc_RemoveFromInvByPtr (slf, vobPtr, amount);
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
											};
										};

										cancel = TRUE;
									};
								};
							};
						} else {
							//If an item is already in hand - we can drop it directly
							if ((action == action_DropItem) || (action == action_DropAllItems)) {
								vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");
								AI_DropVobPtr (slf, vobPtr);
							} else
							//If an item is already in hand - and we try to put an item to hand - do the opposite - put it back to inventory
							if (action == action_PutInHand) {
								//Remove from hand - do not drop
								vobPtr = oCNpc_RemoveFromSlot_Fixed (hero, "ZS_RIGHTHAND", FALSE, 0);
								//Put in inventory
								vobPtr = oCNpc_PutInInvPtr (slf, vobPtr);
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

func void _eventDoTakeVob_SwitchCategory () {
	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);
	if ((!Hlp_Is_oCNpc (ECX)) || (!Hlp_Is_oCItem (itemPtr))) { return; };

	var oCNPC slf; slf = _^ (ECX);
	var oCItem itm; itm = _^ (itemPtr);

	if (Hlp_IsValidItem (itm)) {
		if (NPC_IsPlayer (slf)) {
			invCategory_VobTaken = Npc_ItemGetCategory (slf, itemPtr);
		};
	};
};

func void _eventOpenInventory_SwitchToCategory () {
	if (invCategory_VobTaken != -1) {
		oCNpcInventory_SwitchToCategory (ECX, invCategory_VobTaken);
		invCategory_VobTaken = -1;
	};
};

func void G1_BetterInventoryControls_Init(){
	G1_TradeEvents_Init ();

	G1_InventoryEvents_Init ();

	TradeHandleEvent_AddListener (_eventTradeHandleEvent__BetterInvControls);

	ItemContainerHandleEvent_AddListener (_eventItemContainerHandleEvent__BetterInvControls);

	StealContainerHandleEvent_AddListener (_eventStealContainerHandleEvent__BetterInvControls);

	NpcContainerHandleEvent_AddListener (_eventNpcContainerHandleEvent__BetterInvControls);

	NpcInventoryHandleEvent_AddListener (_eventNpcInventoryHandleEvent__BetterInvControls);

	G12_DoDropVobEvent_Init ();
	DoDropVobEvent_AddListener (_eventDoDropVob__BetterInvControls);

	G12_DoTakeVobEvent_Init ();
	DoTakeVobEvent_AddListener (_eventDoTakeVob_SwitchCategory);

	G12_OpenInventoryEvent_Init ();
	OpenInventoryEvent_AddListener (_eventOpenInventory_SwitchToCategory);
};
