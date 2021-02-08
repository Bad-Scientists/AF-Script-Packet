/*
 *	Credits: functions Trade_ChangeBuyMultiplier & Trade_ChangeSellMultiplier originally created by OrcWarriorPL
 *	https://forum.worldofplayers.de/forum/threads/879891-Skriptpaket-Ikarus-2/page12?p=14836995&viewfull=1#post14836995
 *
 *	They were modified to change multipliers for both inventory containers in case of both buying / selling containers.
 *
 *	TODO: still dirty - becuase of oCNpcInventory
 */

/*
 *	Internal variables
 */
var int TradeForceTransferAccept; //Variable indicating that player forced trading

func void Trade_ChangeBuyMultiplier (var int mul) {
	var int ptrTrader;
	ptrTrader = MEMINT_oCInformationManager_Address;
	ptrTrader = MEM_ReadInt (ptrTrader + 24);		//oCInformationManager.ocViewDialogTrade
	ptrTrader = MEM_ReadInt (ptrTrader + 248);		//oCInformationManager.ocViewDialogTrade.oCViewDialogStealContainer
	MEM_WriteInt (ptrTrader + 268, mul);			//oCInformationManager.ocViewDialogTrade.oCViewDialogStealContainer.multiplier

	var int ptrTraderOffer;
	ptrTraderOffer = MEMINT_oCInformationManager_Address;
	ptrTraderOffer = MEM_ReadInt (ptrTraderOffer + 24);	//oCInformationManager.ocViewDialogTrade
	ptrTraderOffer = MEM_ReadInt (ptrTraderOffer + 252);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer
	MEM_WriteInt (ptrTraderOffer + 268, mul);		//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer.multiplier
};

func void Trade_ChangeSellMultiplier (var int mul) {
	var int ptrBuyerOffer;
	ptrBuyerOffer = MEMINT_oCInformationManager_Address;
	ptrBuyerOffer = MEM_ReadInt (ptrBuyerOffer + 24);	//oCInformationManager.ocViewDialogTrade
	ptrBuyerOffer = MEM_ReadInt (ptrBuyerOffer + 260);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer
	MEM_WriteInt (ptrBuyerOffer + 268, mul);		//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer.multiplier

	var int ptrBuyer;
	ptrBuyer = MEMINT_oCInformationManager_Address;
	ptrBuyer = MEM_ReadInt (ptrBuyer + 24);			//oCInformationManager.ocViewDialogTrade
	ptrBuyer = MEM_ReadInt (ptrBuyer + 264);		//oCInformationManager.ocViewDialogTrade.oCViewDialogInventory
	MEM_WriteInt (ptrBuyer + 268, mul);			//oCInformationManager.ocViewDialogTrade.oCViewDialogInventory.multiplier
};

/*
 *	Function forces item transfer in trading
 */
func void oCViewDialogTrade_TransferAccept () {
	//00729390  .text     Debug data           ?TransferAccept@oCViewDialogTrade@@IAIXXZ
	const int oCViewDialogTrade__TransferAccept	= 7508880;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (MEM_InformationMan.DlgTrade), oCViewDialogTrade__TransferAccept);
		call = CALL_End();
	};
};

/*
 *	Sets containers value for both traders and buyers 'offers' to 0
 *	We have to reset value at the end of each trade ... not sure why
 */
func void Trade_ResetBuySellValue () {
	var int ptr;

	//Traders 'offer'
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 252);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer
		if (ptr) {
			//Overwrite container value - write 0
			MEM_WriteInt (ptr + 264, 0);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer.value
		};
	};

	//Buyers 'offer'
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 260);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer
		if (ptr) {
			//Overwrite container value - write 0
			MEM_WriteInt (ptr + 264, 0);	//oCInformationManager.ocViewDialogTrade.oCViewDialogItemContainer.value
		};
	};
};

func void _hook_oCViewDialogTrade_OnTransfer__EnhancedTrading () {
	var int ptr;
	var int activeContainerNo; activeContainerNo = -1;

	var oCItemContainer container;

	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		//Get activeContainerNo: 0 = trader, 1 = traders offer, 2 = buyers offer, 3 = buyer
		activeContainerNo = MEM_ReadInt (ptr + 268);
	};
	
	//No need to adjust anything
	if (activeContainerNo == -1) { return; };

	//Trader
	if (activeContainerNo == 0) {
		ptr = MEMINT_oCInformationManager_Address;
		ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade

		if (ptr) {
			ptr = MEM_ReadInt (ptr + 248);	//oCInformationManager.ocViewDialogTrade.oCViewDialogStealContainer

			if (ptr) {
				ptr = MEM_ReadInt (ptr + 256);
				container = _^ (ptr);
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
				container = _^ (ptr);
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
				container = _^ (ptr);
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
				container = _^ (ptr);
			};
		};
	};

	var oCNPC npc; npc = _^ (MEM_InformationMan.npc);

	var int itemPtr; itemPtr = List_GetS (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem + 2);

	if (itemPtr) {
		var oCItem itm;
		itm = _^ (itemPtr);

		//--- Figure out if trader wants to buy an item

		if (activeContainerNo == 3) //Player selling items
		{
			if (!NPC_WantsToBuyItems (npc, itemPtr)) {
				//Trick von mud-freak! :)
				const int contents = 0;
				ECX = _@ (contents) - 4;
				return;
			};
		};

		//--- Adjust selling/buying multiplier value

		var int multiplier;
	
		//if item.value == 1 - set multiplier to 100 % (otherwise value of the item would be 0!)
		if (itm.Value == 1) {
			multiplier = FLOATONE;
		} else {
			if (activeContainerNo == 3)	//Player selling items
			|| (activeContainerNo == 2)	//Player moving items back to his inventory
			{
				multiplier = NPC_GetSellMultiplierF (npc, itemPtr);
			} else {			//Player buying items / moving items back to traders inventory
				multiplier = NPC_GetBuyMultiplierF (npc, itemPtr);
			};
		};

		Trade_ChangeBuyMultiplier (multiplier);
		Trade_ChangeSellMultiplier (multiplier);
	};

};

func void _hook_oCViewDialogTrade_OnExit__EnhancedTrading () {
	//Reset values
	Trade_ResetBuySellValue ();
	TradeForceTransferAccept = 0;
};

func void _hook_oCViewDialogTrade_HandleEvent__EnhancedTrading ()
{
	var int key; key = MEM_ReadInt (ESP + 4);

	//Check if trader / buyer have enough ore to sell / buy stuff
	if (key != KEY_RETURN) {
		return;
	};

	var int ptr;
	
	var oCNpcInventory container_Trader;
	var oCItemContainer container_Trader_Offer;
	var oCItemContainer container_Buyer_Offer;
	var oCNpcInventory container_Buyer;
	
//--- Get Item containers (oCItemContainer)

	//Traders Inventory
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 248);	//oCViewDialogStealContainer
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Trader = _^ (ptr);
		};
	};

	//Traders 'offer'
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 252);	//oCViewDialogStealContainer
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Trader_Offer = _^ (ptr);
		};
	};

	//Buyers 'offer'
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 260);	//oCViewDialogItemContainer
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Buyer_Offer = _^ (ptr);
		};
	};

	//Buyers inventory
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 264);	//oCViewDialogItemInventory
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Buyer = _^ (ptr);
		};
	};
	
//--- Get Offer Value + Ore amount for both Trader and Buyer

	var string msg;

	var int valueBuying;
	var int valueSelling;

	var int oreTrader;
	var int oreBuyer;

	var int delta;

	var int cancel; cancel = FALSE;

	//inventory2_oCItemContainer_textCategoryStatic contains Total Value of offers - we can exploit that
	valueBuying = STR_ToInt (container_Trader_Offer.inventory2_oCItemContainer_textCategoryStatic);
	valueSelling = STR_ToInt (container_Buyer_Offer.inventory2_oCItemContainer_textCategoryStatic);
	
	var C_NPC Trader; Trader = _^ (container_Trader.inventory2_owner);
	oreTrader = NPC_HasItems (Trader, ItMiNugget);
	
	var C_NPC Buyer; Buyer = _^ (container_Buyer.inventory2_owner);
	oreBuyer = NPC_HasItems (Buyer, ItMiNugget);
	
	delta = valueBuying - valueSelling;
	
	if (delta == 0) {
		//Trade went smoothly :)
	} else
	//Buyer does not have enough ore!
	if (delta > 0) {
		if (delta > oreBuyer) {
			PrintScreen (TEXT_TRADE_BUYER_NOTENOUGHORE, -1, POSY_TRADE_BUYER_NOTENOUGHORE, "font_old_20_white.tga", _TIME_MESSAGE_LOGENTRY);
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
				PrintScreen (TEXT_TRADE_TRADER_NOTENOUGHORE, -1, POSY_TRADE_TRADER_NOTENOUGHORE, "font_old_20_white.tga", _TIME_MESSAGE_LOGENTRY);
				cancel = FALSE;
			} else
			//Second warning --> ignore enter
			if (TradeForceTransferAccept == 2) {
				PrintScreen (TEXT_TRADE_TRADER_NOTENOUGHORE_CONFIRM, -1, POSY_TRADE_TRADER_NOTENOUGHORE_CONFIRM, "font_old_20_white.tga", _TIME_MESSAGE_LOGENTRY);
				cancel = TRUE;
			} else
			//If player confirmed trade anyway ... then don't ignore it
			if (TradeForceTransferAccept == 3) {
				cancel = FALSE;
				TradeForceTransferAccept = 0;
			};
		};
	};

	if (cancel) {
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void _hook_oCViewDialogTrade_OnAccept__EnhancedTrading ()
{
	var int ptr;
	
	var oCNpcInventory container_Trader;
	var oCItemContainer container_Trader_Offer;
	var oCItemContainer container_Buyer_Offer;
	var oCNpcInventory container_Buyer;
	
//--- Get Item containers (oCItemContainer)

	//Traders Inventory
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 248);	//oCViewDialogItemInventory
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Trader = _^ (ptr);
		};
	};

	//Traders 'offer'
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 252);	//oCViewDialogStealContainer
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Trader_Offer = _^ (ptr);
		};
	};

	//Buyers 'offer'
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 260);	//oCViewDialogItemContainer
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Buyer_Offer = _^ (ptr);
		};
	};

	//Buyers inventory
	ptr = MEMINT_oCInformationManager_Address;
	ptr = MEM_ReadInt (ptr + 24);	//oCInformationManager.ocViewDialogTrade
	if (ptr) {
		ptr = MEM_ReadInt (ptr + 264);	//oCViewDialogItemInventory
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 256);	//oCItemContainer
			container_Buyer = _^ (ptr);
		};
	};
	
//--- Get Offer Value + Ore amount for both Trader and Buyer

	var int valueBuying;
	var int valueSelling;

	var int oreTrader;
	var int oreBuyer;

	var int delta;

	//inventory2_oCItemContainer_textCategoryStatic contains Total Value of offers - we can exploit that
	valueBuying = STR_ToInt (container_Trader_Offer.inventory2_oCItemContainer_textCategoryStatic);
	valueSelling = STR_ToInt (container_Buyer_Offer.inventory2_oCItemContainer_textCategoryStatic);
	
	var C_NPC Trader; Trader = _^ (container_Trader.inventory2_owner);
	oreTrader = NPC_HasItems (Trader, ItMiNugget);
	
	var C_NPC Buyer; Buyer = _^ (container_Buyer.inventory2_owner);
	oreBuyer = NPC_HasItems (Buyer, ItMiNugget);
	
	delta = valueBuying - valueSelling;
	
	var string msg;
	
	if (delta == 0) {
		//Trade went smoothly :)
	} else
	//Buyer has to supply ore !
	if (delta > 0) {
		if (delta > oreBuyer) {
	
		} else {
			//Accept Transfer anyway!			
			oCViewDialogTrade_TransferAccept ();

			//'Move' ore from Buyer to Trader
			NPC_RemoveInvItems (Buyer, ItMiNugget, delta);
			CreateInvItems (Trader, ItMiNugget, delta);
			
			PrintScreen (GetText_TradeGiveOre (delta), -1, _YPOS_MESSAGE_GIVEN, "font_old_10_white.tga", _TIME_MESSAGE_TAKEN);
		};
	} else
	//Trader has to supply ore !
	{
		//Abs (delta)
		delta = 0 - delta;

		if (delta > oreTrader) {
			if (oreTrader > 0) {
				delta = oreTrader;

				//'Move' ore from Trader to Buyer
				NPC_RemoveInvItems (Trader, ItMiNugget, delta);
				CreateInvItems (Buyer, ItMiNugget, delta);
				
				PrintScreen (GetText_ReceiveGiveOre (delta), -1, _YPOS_MESSAGE_TAKEN, "font_old_10_white.tga", _TIME_MESSAGE_TAKEN);
			};
		} else {
			//Accept Transfer anyway!
			oCViewDialogTrade_TransferAccept ();

			//'Move' ore from Trader to Buyer
			NPC_RemoveInvItems (Trader, ItMiNugget, delta);
			CreateInvItems (Buyer, ItMiNugget, delta);
			
			PrintScreen (GetText_ReceiveGiveOre (delta), -1, _YPOS_MESSAGE_TAKEN, "font_old_10_white.tga", _TIME_MESSAGE_TAKEN);
		};
	};
};

func void G1_EnhancedTrading_Init(){
	const int once = 0;
	
	if (!once) {
		//Hooked functions checks whether NPC wants to buy an item or not. Also it cahnges selling/buying multiplier values
		HookEngine (oCViewDialogTrade__OnTransferLeft, 10, "_hook_oCViewDialogTrade_OnTransfer__EnhancedTrading");
		HookEngine (oCViewDialogTrade__OnTransferRight, 10, "_hook_oCViewDialogTrade_OnTransfer__EnhancedTrading");

		//Called when exiting trading
		HookEngine (oCViewDialogTrade__OnExit, 5, "_hook_oCViewDialogTrade_OnExit__EnhancedTrading");

		//Obsluha obchodovania - automaticke dorovnavanie rudy
		HookEngine (oCViewDialogTrade__OnAccept, 6, "_hook_oCViewDialogTrade_OnAccept__EnhancedTrading");

		//10
		HookEngine (oCViewDialogTrade__HandleEvent, 7, "_hook_oCViewDialogTrade_HandleEvent__EnhancedTrading");

		once = 1;
	};
};
