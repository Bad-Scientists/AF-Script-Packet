/*
 *	Credits: functions Trade_SetBuyMultiplier & Trade_SetSellMultiplier originally created by OrcWarriorPL
 *	https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page12?p=14836995&viewfull=1#post14836995
 *
 *	They were modified to change multipliers for both inventory containers in case of both buying / selling containers.
 *
 */

//-- Internal variables
var int TradeForceTransferAccept; //Variable indicating that player forced trading

func void Trade_SetBuyMultiplier (var int mulF) {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgInventoryNpc) {
			itemCont = _^ (dialogTrade.dlgInventoryNpc);
			itemCont.valueMultiplier = mulF;
		};

		if (dialogTrade.dlgContainerNpc) {
			itemCont = _^ (dialogTrade.dlgContainerNpc);
			itemCont.valueMultiplier = mulF;
		};
	};
};

func void Trade_SetSellMultiplier (var int mulF) {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerPlayer) {
			itemCont = _^ (dialogTrade.dlgContainerPlayer);
			itemCont.valueMultiplier = mulF;
		};

		if (dialogTrade.dlgInventoryPlayer) {
			itemCont = _^ (dialogTrade.dlgInventoryPlayer);
			itemCont.valueMultiplier = mulF;
		};
	};
};

/*
 *	Function forces item transfer in trading
 */
func void oCViewDialogTrade_TransferAccept () {
	//0x00729390 protected: void __fastcall oCViewDialogTrade::TransferAccept(void)
	const int oCViewDialogTrade__TransferAccept_G1 = 7508880;

	const int null = 0;
	var int dlgTradePtr; dlgTradePtr = MEM_InformationMan.DlgTrade;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@ (dlgTradePtr), _@ (null), oCViewDialogTrade__TransferAccept_G1);
		call = CALL_End();
	};
};

/*
 *
 */
func int Trade_GetPlayerContainerValue () {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerPlayer) {
			itemCont = _^ (dialogTrade.dlgContainerPlayer);
			return itemCont.value;
		};
	};

	return 0;
};

func void Trade_SetPlayerContainerValue (var int value) {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	//Safety check
	if (value < 0) { value = 0; };

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerPlayer) {
			itemCont = _^ (dialogTrade.dlgContainerPlayer);
			itemCont.value = value;
		};

		oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerPlayer);
	};
};

func int Trade_GetNpcContainerValue () {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerNpc) {
			itemCont = _^ (dialogTrade.dlgContainerNpc);
			return itemCont.value;
		};
	};

	return 0;
};

func void Trade_SetNpcContainerValue (var int value) {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerNpc) {
			itemCont = _^ (dialogTrade.dlgContainerNpc);
			itemCont.value = value;
		};

		oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerNpc);
	};
};

func int Trade_GetBuyMultiplier () {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerNpc) {
			itemCont = _^ (dialogTrade.dlgContainerNpc);
			return itemCont.valueMultiplier;
		};
	};

	return FLOATNULL;
};

func int Trade_GetSellMultiplier () {
	var oCViewDialogTrade dialogTrade;
	var oCViewDialogItemContainer itemCont;

	if (MEM_InformationMan.DlgTrade) {
		dialogTrade = _^ (MEM_InformationMan.DlgTrade);

		if (dialogTrade.dlgContainerPlayer) {
			itemCont = _^ (dialogTrade.dlgContainerPlayer);
			return itemCont.valueMultiplier;
		};
	};

	return FLOATNULL;
};

/*
 *	Function gets value of global variable zCOption::trade_amount
 */
func int Trade_GetTradeAmount () {
	//0x00830BA8 public: static int zCOption::trade_amount
	const int zCOption__trade_amount_G1 = 8588200;
	return +MEM_ReadInt (zCOption__trade_amount_G1);
};

/*
 *	Function updates global variable zCOption::trade_amount
 *	 - this variable is used by engine to move more items at once)
 *	 - we don't need it if we are not using engine functions ... which we don't use in the end :) (e.g. oCViewDialogTrade::OnTransferRight ... this is terribly slow, as it moves items 1 by 1!)
 */
func void Trade_SetTradeAmount (var int amount) {
	//0x00830BA8 public: static int zCOption::trade_amount
	const int zCOption__trade_amount_G1 = 8588200;
	MEM_WriteInt (zCOption__trade_amount_G1, amount);
};

/*
 *	Function updates buy/sell multiplier for specific item pointer
 */
func void Trade_UpdateBuySellMultiplier (var int itmPtr) {
	var oCNPC npc;
	var oCItem itm;
	var oCNpcInventory npcInventory;
	var oCViewDialogTrade dialogTrade;

	var int npcInventoryPtr;

	if (!MEM_InformationMan.DlgTrade) { return; };

	dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	itm = _^ (itmPtr);

	npcInventoryPtr = Hlp_Trade_GetInventoryNpcContainer ();
	npcInventory = _^ (npcInventoryPtr);

	npc = _^ (npcInventory.inventory2_owner);

	//--- Figure out if trader wants to buy an item

	if (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_INVENTORY_G1) //Player selling items
	{
		const int symbID = 0;
		var int retVal; retVal = 0;

		if (!symbID) {
			symbID = MEM_FindParserSymbol ("C_NPC_WANTSTOBUYITEMS");
		};

		if (symbID != -1) {
			MEM_PushInstParam (npc);
			MEM_PushIntParam (itmPtr);

			MEM_CallByID (symbID);
			retVal = MEM_PopIntResult ();

			if (!retVal) {
				//Trick von mud-freak! :)
				const int contents = 0;
				ECX = _@ (contents) - 4;
				return;
			};
		};
	};

	//--- Adjust selling/buying multiplier value

	var int multiplier;

	if (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_CONTAINER_G1)	//Player moving items back to his inventory
	|| (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_INVENTORY_G1)	//Player selling items
	{
		multiplier = Trade_GetSellMultiplier ();

		const int symbID1 = 0;

		if (!symbID1) {
			symbID1 = MEM_FindParserSymbol ("C_Npc_GetSellMultiplierF");
		};

		if (symbID1 != -1) {
			MEM_PushInstParam (npc);
			MEM_PushIntParam (itmPtr);

			MEM_CallByID (symbID1);
			multiplier = MEM_PopIntResult ();
		};

		Trade_SetSellMultiplier (multiplier);
	} else {
		//Player buying items / moving items back to traders inventory
		multiplier = Trade_GetBuyMultiplier ();

		const int symbID2 = 0;

		if (!symbID2) {
			symbID2 = MEM_FindParserSymbol ("C_Npc_GetBuyMultiplierF");
		};

		if (symbID2 != -1) {
			MEM_PushInstParam (npc);
			MEM_PushIntParam (itmPtr);

			MEM_CallByID (symbID2);
			multiplier = MEM_PopIntResult ();
		};

		Trade_SetBuyMultiplier (multiplier);
	};
};

/*
 *	Function calculates total value of an item
 */
func int Trade_CalculateTotalValue (var int itemValue, var int amount, var int multiplier) {
	var int itemValueF;

	if (itemValue > 1) {
		var int totalValue; totalValue = 0;

		while (amount > 0);
			itemValueF = mulf (multiplier, mkf (itemValue));

			var int newValue;

			if ((itemValue > 0) && (RoundF (itemValueF) == 0)) {
				newValue = 1;
			} else {
				newValue = RoundF (itemValueF);
			};

			totalValue += newValue;
			amount -= 1;
		end;

		itemValue = totalValue;
	} else {
		itemValue *= amount;
	};

	return +itemValue;
};

/*
 *	Function moves amount of items (by item pointer) from players container back to players inventory
 */
func void Trade_MoveToInventoryPlayer (var int itmPtr, var int amount) {
	var oCNpc npc;
	var oCNpcInventory npcInventory;

	var int npcInventoryPtr;
	var int playersContainer;

	//Update buy/sell multipliers
	Trade_UpdateBuySellMultiplier (itmPtr);

	npcInventoryPtr = Hlp_Trade_GetInventoryPlayerContainer ();
	npcInventory = _^ (npcInventoryPtr);

	playersContainer = Hlp_Trade_GetContainerPlayerContainer (); //oCItemContainer*
	itmPtr = oCItemContainer_RemoveByPtr (playersContainer, itmPtr, amount);

	npc = _^ (npcInventory.inventory2_owner);
	npcInventoryPtr = _@ (npc.inventory2_vtbl);
	itmPtr = oCNpcInventory_Insert (npcInventoryPtr, itmPtr);

	//--> We don't have to update inventory ...
	//Updating the owner of npcInventory will also update it's contents
	//npcInventoryPtr = Hlp_Trade_GetInventoryPlayerContainer (); //oCNpcInventory*
	//oCNpcInventory_SetOwner (npcInventoryPtr, _@ (npc));
	//<--

	//Update value

	//This didn't help with value ...
	//oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerPlayer);

	//... we have to calculate value ourselves!
	var int multiplier; multiplier = Trade_GetSellMultiplier ();

	var oCItem itm; itm = _^ (itmPtr);
	var int itemValue; itemValue = itm.value;

	itemValue = Trade_CalculateTotalValue (itemValue, amount, multiplier);
	Trade_SetPlayerContainerValue (Trade_GetPlayerContainerValue () - itemValue);
};

/*
 *	Function moves amount of items (by item pointer) from players inventory to players container
 */
func void Trade_MoveToContainerPlayer (var int itmPtr, var int amount) {
	var oCNpc npc;
	var oCNpcInventory npcInventory;

	var int npcInventoryPtr;
	var int playersContainer;

	//Update buy/sell multipliers
	Trade_UpdateBuySellMultiplier (itmPtr);

	//If item value == 1 then we **have** to calculate this value ourselves!
	//... oCViewDialogItemContainer_InsertItem updates total value of all items ...
	var int containerValue;
	containerValue = Trade_GetPlayerContainerValue ();

	npcInventoryPtr = Hlp_Trade_GetInventoryPlayerContainer ();
	npcInventory = _^ (npcInventoryPtr);

	npc = _^ (npcInventory.inventory2_owner);

	npcInventoryPtr = _@ (npc.inventory2_vtbl);
	itmPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itmPtr, amount);

	//Insert item to container
	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	oCViewDialogItemContainer_InsertItem (dialogTrade.dlgContainerPlayer, itmPtr);

	//Redraw immediately
	var int npcContainer; npcContainer = Hlp_Trade_GetContainerPlayerContainer ();
	oCItemContainer_Draw (npcContainer);

	//--> We don't have to update inventory ...
	//Updating the owner of npcInventory will also update it's contents
	//npcInventoryPtr = Hlp_Trade_GetInventoryPlayerContainer (); //oCNpcInventory*
	//oCNpcInventory_SetOwner (npcInventoryPtr, _@ (npc));
	//<--

	//Update value

	//This didn't help with value ...
	//oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerPlayer);

	//... we have to calculate value ourselves!
	var int multiplier; multiplier = Trade_GetSellMultiplier ();

	var oCItem itm; itm = _^ (itmPtr);
	var int itemValue; itemValue = itm.value;

	itemValue = Trade_CalculateTotalValue (itemValue, amount, multiplier);
	Trade_SetPlayerContainerValue (containerValue + itemValue);
};

/*
 *	Function moves amount of items (by item pointer) from npcs inventory to npcs container
 */
func void Trade_MoveToContainerNpc (var int itmPtr, var int amount) {
	var oCNpc npc;
	var oCNpcInventory npcInventory;

	var int npcInventoryPtr;

	//Update buy/sell multipliers
	Trade_UpdateBuySellMultiplier (itmPtr);

	//If item value == 1 then we **have** to calculate this value ourselves!
	//... oCViewDialogItemContainer_InsertItem updates total value of all items ...
	var int containerValue;
	containerValue = Trade_GetNpcContainerValue ();

	npcInventoryPtr = Hlp_Trade_GetInventoryNpcContainer ();
	npcInventory = _^ (npcInventoryPtr);

	npc = _^ (npcInventory.inventory2_owner);

	npcInventoryPtr = _@ (npc.inventory2_vtbl);
	itmPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itmPtr, amount);

	//Insert item to container
	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	oCViewDialogItemContainer_InsertItem (dialogTrade.dlgContainerNpc, itmPtr);

	//Redraw immediately
	var int npcContainer; npcContainer = Hlp_Trade_GetContainerNpcContainer ();
	oCItemContainer_Draw (npcContainer);

	//--> We **have to** update inventory ...
	//Updating the owner of stealContainer will also update it's contents
	var int stealContainerPtr;
	stealContainerPtr = Hlp_Trade_GetInventoryNpcContainer (); //oCStealContainer*
	oCStealContainer_SetOwner (stealContainerPtr, _@ (npc));
	//<--

	//Update value

	//This didn't help with value ...
	//oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerPlayer);

	//... we have to calculate value ourselves!
	var int multiplier; multiplier = Trade_GetBuyMultiplier ();

	var oCItem itm; itm = _^ (itmPtr);
	var int itemValue; itemValue = itm.value;

	itemValue = Trade_CalculateTotalValue (itemValue, amount, multiplier);
	Trade_SetNpcContainerValue (containerValue + itemValue);
};

/*
 *	Function moves amount of items (by item pointer) from npcs container back to npcs inventory
 */
func void Trade_MoveToInventoryNpc (var int itmPtr, var int amount) {
	var oCNpcInventory npcInventory;

	var int npcsContainer;

	//Update buy/sell multipliers
	Trade_UpdateBuySellMultiplier (itmPtr);

	npcsContainer = Hlp_Trade_GetContainerNpcContainer (); //oCItemContainer*
	itmPtr = oCItemContainer_RemoveByPtr (npcsContainer, itmPtr, amount);

	//Insert item to inventory
	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	oCViewDialogStealContainer_InsertItem (dialogTrade.dlgInventoryNpc, itmPtr);

	//--> We don't have to update inventory ... oCViewDialogStealContainer_InsertItem will do it automatically
	//var int stealContainerPtr;
	//stealContainerPtr = Hlp_Trade_GetInventoryNpcContainer (); //oCStealContainer*
	//oCStealContainer_SetOwner (stealContainerPtr, _@ (Trader));
	//<--

	//Update value

	//This didn't help with value ...
	//oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerPlayer);

	//... we have to calculate value ourselves!
	var int multiplier; multiplier = Trade_GetBuyMultiplier ();

	var oCItem itm; itm = _^ (itmPtr);
	var int itemValue; itemValue = itm.value;

	itemValue = Trade_CalculateTotalValue (itemValue, amount, multiplier);
	Trade_SetNpcContainerValue (Trade_GetNpcContainerValue () - itemValue);
};

/*
 *	Hook updates buy/sell multipliers for moved items
 */
func void _hook_OnTransfer__EnhancedTrading () {
	var oCItemContainer container;

	var int ptr;
	//ptr = Hlp_Trade_GetActiveTradeContainer ();
	ptr = Hlp_GetActiveOpenInvContainer ();
	if (!ptr) { return; };
	container = _^ (ptr);

	var int itemPtr; itemPtr = List_GetS (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem + 2);

	if (itemPtr) {
		//Update buy/sell multipliers
		Trade_UpdateBuySellMultiplier (itemPtr);
	};
};

func void _eventTradeOnExit__EnhancedTrading (var int dummyVariable) {
	if (_TradeOnExit_Event_Break) { return; };

	//Reset values
	Trade_SetNpcContainerValue (0);
	Trade_SetPlayerContainerValue (0);

	TradeForceTransferAccept = 0;
};

/*
 *	Hook handles trade confirmation
 *	 - Enter confirms trade
 */
func void _eventTradeHandleEvent__EnhancedTrading (var int dummyVariable) {
	if (_TradeHandleEvent_Event_Break) { return; };

	var int key; key = MEM_ReadInt (ESP + 4);

	if (key != KEY_RETURN) { return; };

	var oCStealContainer containerNpc;
	var oCNpcInventory containerPlayer;

	var oCViewDialogTrade dialogTrade;
	var oCItemContainer container;

	//Get item containers (oCItemContainer)

	var int ptr;

	//Get NPCs inventory
	ptr = Hlp_Trade_GetInventoryNpcContainer ();
	if (!ptr) { return; };
	containerNpc = _^ (ptr);

	//Get Players inventory
	ptr = Hlp_Trade_GetInventoryPlayerContainer ();
	if (!ptr) { return; };
	containerPlayer = _^ (ptr);

	if (!MEM_InformationMan.DlgTrade) { return; };
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	//Get active container
	//ptr = Hlp_Trade_GetActiveTradeContainer ();
	ptr = Hlp_GetActiveOpenInvContainer ();
	if (!ptr) { return; };
	container = _^ (ptr);

	var int cancel; cancel = FALSE;

	//Check if trader / buyer have enough ore to sell / buy stuff

	//Get Offer Value + Ore amount for both Trader and Buyer

	if (key == KEY_RETURN) {
		var int amount;
		var string msg;

		var int valueBuying; valueBuying = Trade_GetNpcContainerValue ();
		var int valueSelling; valueSelling = Trade_GetPlayerContainerValue ();

		var oCNPC Trader; Trader = _^ (containerNpc.inventory2_owner);
		var int oreTrader; oreTrader = NPC_HasItems (Trader, ItMiNugget);

		var oCNPC Buyer; Buyer = _^ (containerPlayer.inventory2_owner);
		var int oreBuyer; oreBuyer = NPC_HasItems (Buyer, ItMiNugget);

		var int delta; delta = valueBuying - valueSelling;

		if (delta == 0) {
			//Trade went smoothly :)
		} else
		//Buyer does not have enough ore!
		if (delta > 0) {
			if (delta > oreBuyer) {
				API_CallByString ("ENHANCEDTRADING_NOTENOUGHORE");
			} else {
				//Move ore to players container
				if (NPC_GetInvItem (Buyer, ItMiNugget)) {
					amount = delta;
					Trade_MoveToContainerPlayer (_@ (item), amount);
				};
			};
		} else
		//Trader does not have enough ore!
		{
			//Abs (delta)
			delta = 0 - delta;

			if (delta > oreTrader) {
				TradeForceTransferAccept += 1;

				//First warning
				if (TradeForceTransferAccept == 1) {
					API_CallByString ("ENHANCEDTRADING_TRADER_NOTENOUGHORE");
					cancel = FALSE;
				} else
				//Second warning --> ignore enter
				if (TradeForceTransferAccept == 2) {
					API_CallByString ("ENHANCEDTRADING_TRADER_NOTENOUGHORE_CONFIRM");
					cancel = TRUE;
				} else
				//If player confirmed trade anyway ... then don't ignore it
				if (TradeForceTransferAccept == 3) {
					cancel = FALSE;
					TradeForceTransferAccept = 0;
				};
			};

			if (delta > 0) {
				if (oreTrader > 0) {
					amount = delta;
					if (amount > oreTrader) { amount = oreTrader; };

					//Move ore to traders container
					if (NPC_GetInvItem (Trader, ItMiNugget)) {
						Trade_MoveToContainerNpc (_@ (item), amount);
					};
				};
			};
		};
	};

	if (cancel) {
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void _eventTradeOnAccept__EnhancedTrading (var int dummyVariable) {
	if (_TradeOnAccept_Event_Break) { return; };

	var oCViewDialogTrade dialogTrade;

	var oCStealContainer containerNpc;
	var oCNpcInventory containerPlayer;

//--- Get Item containers (oCItemContainer)

	//Get item containers (oCItemContainer)

	var int ptr;

	//Get NPCs inventory
	ptr = Hlp_Trade_GetInventoryNpcContainer (); //oCStealContainer*
	if (!ptr) { return; };
	containerNpc = _^ (ptr);

	//Get Players inventory
	ptr = Hlp_Trade_GetInventoryPlayerContainer ();
	if (!ptr) { return; };
	containerPlayer = _^ (ptr);

//--- Get Offer Value + Ore amount for both Trader and Buyer

	var string msg;

	var int valueBuying; valueBuying = Trade_GetNpcContainerValue ();
	var int valueSelling; valueSelling = Trade_GetPlayerContainerValue ();

	var C_NPC Trader; Trader = _^ (containerNpc.inventory2_owner);
	var int oreTrader; oreTrader = NPC_HasItems (Trader, ItMiNugget);

	var C_NPC Buyer; Buyer = _^ (containerPlayer.inventory2_owner);
	var int oreBuyer; oreBuyer = NPC_HasItems (Buyer, ItMiNugget);

	var int delta; delta = valueBuying - valueSelling;

	if (delta == 0) {
		//Trade went smoothly :)
	} else
	//Buyer has to supply ore !
	if (delta > 0) {
		if (delta > oreBuyer) {

		} else {
			//Accept Transfer anyway!
			oCViewDialogTrade_TransferAccept ();
		};
	};
};

func void G1_EnhancedTrading_Init(){
	const int once = 0;

	G1_TradeEvents_Init ();

	TradeOnExitEvent_AddListener (_eventTradeOnExit__EnhancedTrading);
	TradeOnAcceptEvent_AddListener (_eventTradeOnAccept__EnhancedTrading);
	TradeHandleEvent_AddListener (_eventTradeHandleEvent__EnhancedTrading);

	if (!once) {
		//Hooked functions checks whether NPC wants to buy an item or not. Also it cahnges selling/buying multiplier values
		HookEngine (oCViewDialogTrade__OnTransferLeft, 10, "_hook_OnTransfer__EnhancedTrading");
		HookEngine (oCViewDialogTrade__OnTransferRight, 10, "_hook_OnTransfer__EnhancedTrading");

		//Called when exiting trading
		//HookEngine (oCViewDialogTrade__OnExit, 5, "_hook_oCViewDialogTrade_OnExit__EnhancedTrading");

		//Obsluha obchodovania - automaticke dorovnavanie rudy
		//HookEngine (oCViewDialogTrade__OnAccept, 6, "_hook_oCViewDialogTrade_OnAccept__EnhancedTrading");

		//10
		//HookEngine (oCViewDialogTrade__HandleEvent, 7, "_hook_oCViewDialogTrade_HandleEvent__EnhancedTrading");

		once = 1;
	};
};
