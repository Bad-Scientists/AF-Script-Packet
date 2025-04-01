//-- Internal variables
var int _TradeForceTransferAccept; //Variable indicating that player forced trading

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
 *	 - this variable is used by engine to move more items at once
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
func void Trade_UpdateBuySellMultiplier() {
	var C_NPC npc;

	//Safety checks
	if (!MEM_InformationMan.DlgTrade) { return; };
	var oCViewDialogTrade dialogTrade; dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	if (!dialogTrade.isActivated) { return; };

	//Get trader
	var int npcInventoryPtr; npcInventoryPtr = Hlp_Trade_GetInventoryNpcContainer ();
	if (!npcInventoryPtr) { return; };
	var oCNpcInventory npcInventory; npcInventory = _^ (npcInventoryPtr);

	if (!npcInventory.inventory2_owner) { return; };
	npc = _^ (npcInventory.inventory2_owner);

	//Get item from active container
	var int ptr; ptr = Hlp_GetActiveOpenInvContainer();
	var oCItemContainer container; container = _^(ptr);
	var int itmPtr; itmPtr = zCListSort_GetData (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem);

	//Update selling and buying multipliers

	var int multiplier;

	//Sell multiplier
	multiplier = Trade_GetSellMultiplier ();

	const int symbID1 = 0;

	if (!symbID1) {
		symbID1 = MEM_FindParserSymbol ("C_NPC_GETSELLMULTIPLIERF");
	};

	if (symbID1 != -1) {
		MEM_PushInstParam (npc);
		MEM_PushIntParam (itmPtr);

		MEM_CallByID (symbID1);
		multiplier = MEM_PopIntResult ();
	};

	Trade_SetSellMultiplier (multiplier);

	//Player buying items / moving items back to traders inventory
	multiplier = Trade_GetBuyMultiplier ();

	const int symbID2 = 0;

	if (!symbID2) {
		symbID2 = MEM_FindParserSymbol ("C_NPC_GETBUYMULTIPLIERF");
	};

	if (symbID2 != -1) {
		MEM_PushInstParam (npc);
		MEM_PushIntParam (itmPtr);

		MEM_CallByID (symbID2);
		multiplier = MEM_PopIntResult ();
	};

	Trade_SetBuyMultiplier (multiplier);
};

/*
 *	Trade_ValidateTransfer
 *	 - function validates whether item can be moved to desired section
 */
func int Trade_ValidateTransfer(var int itmPtr, var int sectionTrade) {
	var C_NPC npc;
	var oCItem itm;
	var oCNpcInventory npcInventory;
	var oCViewDialogTrade dialogTrade;

	var int npcInventoryPtr;

	if (!itmPtr) { return FALSE; };
	if (!MEM_InformationMan.DlgTrade) { return FALSE; };

	dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	itm = _^ (itmPtr);

	npcInventoryPtr = Hlp_Trade_GetInventoryNpcContainer ();
	npcInventory = _^ (npcInventoryPtr);

	npc = _^ (npcInventory.inventory2_owner);

	//--- Figure out if trader wants to buy an item

	if (sectionTrade == TRADE_SECTION_RIGHT_INVENTORY_G1) //Player selling items
	{
		const int symbID = 0;
		var int retVal; retVal = 0;

		if (!symbID) {
			symbID = MEM_FindParserSymbol ("C_NPC_WANTSTOBUYITEMS");
		};

		if (symbID != -1) {
			MEM_PushInstParam(npc);
			MEM_PushIntParam(itmPtr);

			MEM_CallByID (symbID);
			retVal = MEM_PopIntResult ();

			//Result is coming from API function
			return +retVal;
		};
	};

	//Valid by default
	return TRUE;
};

/*
 *	Function calculates total value of an item
 */
func int Trade_CalculateTotalValue (var int itemValue, var int amount, var int multiplierF) {
	//Allow free item transfer when multiplier is 0
	if (multiplierF == FLOATNULL) { return 0; };

	var int itemValueF; itemValueF = mulf (mkf (itemValue), multiplierF);
	var int newValue; newValue = RoundF (itemValueF);

	if ((itemValue > 0) && (newValue == 0)) {
		newValue = 1;
	};

	return + (newValue * amount);
};

/*
 *	Function moves amount of items (by item pointer) from players container back to players inventory
 */
func void Trade_MoveToInventoryPlayer (var int itmPtr, var int amount) {
	//Update buy/sell multipliers
	if (!Trade_ValidateTransfer(itmPtr, TRADE_SECTION_RIGHT_CONTAINER_G1)) {
		return;
	};

	var int playersContainer; playersContainer = Hlp_Trade_GetContainerPlayerContainer (); //oCItemContainer*
	var int npcInventoryPtr; npcInventoryPtr = Hlp_Trade_GetInventoryPlayerContainer (); //oCNpcInventory*
	if (!playersContainer || !npcInventoryPtr) { return; };

	//Save value
	var int containerValue; containerValue = Trade_GetPlayerContainerValue ();

	itmPtr = oCItemContainer_RemoveByPtr (playersContainer, itmPtr, amount);

	var oCNpcInventory npcInventory; npcInventory = _^(npcInventoryPtr);
	var oCNpc npc; npc = _^(npcInventory.inventory2_owner);
	npcInventoryPtr = _@(npc.inventory2_vtbl);

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
	Trade_SetPlayerContainerValue (containerValue - itemValue);
};

/*
 *	Function moves amount of items (by item pointer) from players inventory to players container
 */
func void Trade_MoveToContainerPlayer (var int itmPtr, var int amount) {
	//Update buy/sell multipliers
	if (!Trade_ValidateTransfer(itmPtr, TRADE_SECTION_RIGHT_INVENTORY_G1)) {
		return;
	};

	var int npcInventoryPtr; npcInventoryPtr = Hlp_Trade_GetInventoryPlayerContainer (); //oCNpcInventory*
	var int playersContainer; playersContainer = Hlp_Trade_GetContainerPlayerContainer (); //oCItemContainer*
	if (!npcInventoryPtr || !playersContainer) { return; };
	if (!MEM_InformationMan.DlgTrade) { return; };

	//Save value
	//If item value == 1 then we **have** to calculate this value ourselves!
	//... oCViewDialogItemContainer_InsertItem updates total value of all items ...
	var int containerValue; containerValue = Trade_GetPlayerContainerValue ();

	var oCNpcInventory npcInventory; npcInventory = _^(npcInventoryPtr);
	var oCNpc npc; npc = _^(npcInventory.inventory2_owner);
	npcInventoryPtr = _@(npc.inventory2_vtbl);

	itmPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, itmPtr, amount);

	var oCViewDialogTrade dialogTrade; dialogTrade = _^(MEM_InformationMan.DlgTrade);
	oCViewDialogItemContainer_InsertItem(dialogTrade.dlgContainerPlayer, itmPtr);

	//Redraw immediately
	oCItemContainer_Draw (playersContainer);

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
	//Update buy/sell multipliers
	if (!Trade_ValidateTransfer(itmPtr, TRADE_SECTION_LEFT_INVENTORY_G1)) {
		return;
	};

	var int stealContainerPtr; stealContainerPtr = Hlp_Trade_GetInventoryNpcContainer(); //oCStealContainer*
	var int npcContainer; npcContainer = Hlp_Trade_GetContainerNpcContainer (); //oCItemContainer*
	if (!stealContainerPtr || !npcContainer) { return; };
	if (!MEM_InformationMan.DlgTrade) { return; };

	//Save value
	//If item value == 1 then we **have** to calculate this value ourselves!
	//... oCViewDialogItemContainer_InsertItem updates total value of all items ...
	var int containerValue; containerValue = Trade_GetNpcContainerValue ();

	//We need to get inventory oCStealContainer->inventory2_owner->inventory2_vtbl
	var oCStealContainer stealContainer; stealContainer = _^(stealContainerPtr);
	var oCNpc npc; npc = _^(stealContainer.inventory2_owner);
	var int npcInventoryPtr; npcInventoryPtr = _@(npc.inventory2_vtbl); //oCNpcInventory

	itmPtr = oCNpcInventory_RemoveByPtr(npcInventoryPtr, itmPtr, amount);

	var oCViewDialogTrade dialogTrade; dialogTrade = _^(MEM_InformationMan.DlgTrade);
	oCViewDialogItemContainer_InsertItem(dialogTrade.dlgContainerNpc, itmPtr);

	//Redraw immediately
	oCItemContainer_Draw (npcContainer);

	//--> We **have to** update inventory ...
	//Updating the owner of stealContainer will also update it's contents
	oCStealContainer_SetOwner(stealContainerPtr, stealContainer.inventory2_owner);
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
	//Update buy/sell multipliers
	if (!Trade_ValidateTransfer(itmPtr, TRADE_SECTION_LEFT_CONTAINER_G1)) {
		return;
	};

	var int npcContainer; npcContainer = Hlp_Trade_GetContainerNpcContainer (); //oCItemContainer*
	var int stealContainerPtr; stealContainerPtr = Hlp_Trade_GetInventoryNpcContainer(); //oCStealContainer*
	if (!npcContainer || !stealContainerPtr) { return; };
	if (!MEM_InformationMan.DlgTrade) { return; };

	//Save value
	var int containerValue; containerValue = Trade_GetNpcContainerValue ();

	itmPtr = oCItemContainer_RemoveByPtr (npcContainer, itmPtr, amount);

	var oCViewDialogTrade dialogTrade; dialogTrade = _^ (MEM_InformationMan.DlgTrade);
	oCViewDialogStealContainer_InsertItem(dialogTrade.dlgInventoryNpc, itmPtr);

	//--> We don't have to update inventory ... oCViewDialogStealContainer_InsertItem will do it automatically
	//oCStealContainer_SetOwner(stealContainerPtr, stealContainer.inventory2_owner);
	//<--

	//Update value

	//This didn't help with value ...
	//oCViewDialogItemContainer_UpdateValue (dialogTrade.dlgContainerPlayer);

	//... we have to calculate value ourselves!
	var int multiplier; multiplier = Trade_GetBuyMultiplier ();

	var oCItem itm; itm = _^ (itmPtr);
	var int itemValue; itemValue = itm.value;
	itemValue = Trade_CalculateTotalValue (itemValue, amount, multiplier);
	Trade_SetNpcContainerValue (containerValue - itemValue);
};

func void _eventTradeOnExit__EnhancedTrading (var int dummyVariable) {
	//Reset values
	Trade_SetNpcContainerValue (0);
	Trade_SetPlayerContainerValue (0);

	_TradeForceTransferAccept = 0;
};

func void _eventTradeTransferReset__EnhancedTrading (var int dummyVariable) {
	//Reset values
	Trade_SetNpcContainerValue (0);
	Trade_SetPlayerContainerValue (0);
};

/*
 *	Hook handles trade confirmation
 *	 - Enter confirms trade
 */
func void _eventTradeHandleEvent__EnhancedTrading (var int dummyVariable) {
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
				_TradeForceTransferAccept += 1;

				//First warning
				if (_TradeForceTransferAccept == 1) {
					API_CallByString ("ENHANCEDTRADING_TRADER_NOTENOUGHORE");
					cancel = FALSE;
				} else
				//Second warning --> ignore enter
				if (_TradeForceTransferAccept == 2) {
					API_CallByString ("ENHANCEDTRADING_TRADER_NOTENOUGHORE_CONFIRM");
					cancel = TRUE;
				} else
				//If player confirmed trade anyway ... then don't ignore it
				if (_TradeForceTransferAccept == 3) {
					cancel = FALSE;
					_TradeForceTransferAccept = 0;
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
		zCInputCallback_SetKey(0);
	};
};

func void _eventTradeOnAccept__EnhancedTrading (var int dummyVariable) {
	var oCViewDialogTrade dialogTrade;

	var oCStealContainer containerNpc;
	var oCNpcInventory containerPlayer;

//--- Get Item containers (oCItemContainer)

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

func void _hook_oCItemContainer_Draw__EnhancedTrading() {
	if (oCItemContainer_IsActive (ECX)) {
		//Update trade buy/sell multiplier
		Trade_UpdateBuySellMultiplier();
	};
};

func void G1_EnhancedTrading_Init(){
	const int once = 0;

	G1_TradeEvents_Init ();

	TradeOnExitEvent_AddListener (_eventTradeOnExit__EnhancedTrading);
	TradeTransferResetEvent_AddListener (_eventTradeTransferReset__EnhancedTrading);
	TradeOnAcceptEvent_AddListener (_eventTradeOnAccept__EnhancedTrading);
	TradeHandleEvent_AddListener (_eventTradeHandleEvent__EnhancedTrading);

	if (!once) {
		//0x007076B0 protected: virtual void __thiscall oCItemContainer::Draw(void)
		//const int oCItemContainer__Draw_G2 = 7370416;

		//I decided to change trading multiplier value every time container is drawn (because I want to have it updated immediately) not only on transfer

		//0066768b
		const int oCItemContainer__Draw_IsOpen_G1 = 6715019;

		//007076df
		const int oCItemContainer__Draw_IsOpen_G2 = 7370463;

		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__Draw_IsOpen_G1, oCItemContainer__Draw_IsOpen_G2), MEMINT_SwitchG1G2(10, 6), "_hook_oCItemContainer_Draw__EnhancedTrading");

		once = 1;
	};
};
