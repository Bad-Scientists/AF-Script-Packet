/*
 *	Game events for Gothic 1
 */

//[Internal variables]
var int _TradeOnAccept_Event;
var int _TradeOnExit_Event;
var int _TradeTransferReset_Event;
var int _TradeHandleEvent_Event;

var int _ItemContainerActivate_Event;
var int _ItemContainerHandleEvent_Event;
var int _StealContainerHandleEvent_Event;
var int _NpcContainerHandleEvent_Event;
var int _NpcInventoryHandleEvent_Event;

func void TradeOnAcceptEvent_AddListener (var func f) {
	if (_TradeOnAccept_Event) {
		Event_AddOnce(_TradeOnAccept_Event, f);
	};
};

func void TradeOnAcceptEvent_RemoveListener (var func f) {
	if (_TradeOnAccept_Event) {
		Event_Remove(_TradeOnAccept_Event, f);
	};
};

func void TradeOnExitEvent_AddListener (var func f) {
	if (_TradeOnExit_Event) {
		Event_AddOnce(_TradeOnExit_Event, f);
	};
};

func void TradeOnExitEvent_RemoveListener (var func f) {
	if (_TradeOnExit_Event) {
		Event_Remove(_TradeOnExit_Event, f);
	};
};

func void TradeTransferResetEvent_AddListener (var func f) {
	if (_TradeTransferReset_Event) {
		Event_AddOnce(_TradeTransferReset_Event, f);
	};
};

func void TradeTransferResetEvent_RemoveListener (var func f) {
	if (_TradeTransferReset_Event) {
		Event_Remove(_TradeTransferReset_Event, f);
	};
};

func void TradeHandleEvent_AddListener (var func f) {
	if (_TradeHandleEvent_Event) {
		Event_AddOnce(_TradeHandleEvent_Event, f);
	};
};

func void TradeHandleEvent_RemoveListener (var func f) {
	if (_TradeHandleEvent_Event) {
		Event_Remove(_TradeHandleEvent_Event, f);
	};
};

func void ItemContainerActivate_AddListener (var func f) {
	if (_ItemContainerActivate_Event) {
		Event_AddOnce(_ItemContainerActivate_Event, f);
	};
};

func void ItemContainerActivate_RemoveListener (var func f) {
	if (_ItemContainerActivate_Event) {
		Event_Remove(_ItemContainerActivate_Event, f);
	};
};

func void ItemContainerHandleEvent_AddListener (var func f) {
	if (_ItemContainerHandleEvent_Event) {
		Event_AddOnce(_ItemContainerHandleEvent_Event, f);
	};
};

func void ItemContainerHandleEvent_RemoveListener (var func f) {
	if (_ItemContainerHandleEvent_Event) {
		Event_Remove(_ItemContainerHandleEvent_Event, f);
	};
};

func void StealContainerHandleEvent_AddListener (var func f) {
	if (_StealContainerHandleEvent_Event) {
		Event_AddOnce(_StealContainerHandleEvent_Event, f);
	};
};

func void StealContainerHandleEvent_RemoveListener (var func f) {
	if (_StealContainerHandleEvent_Event) {
		Event_Remove(_StealContainerHandleEvent_Event, f);
	};
};

func void NpcContainerHandleEvent_AddListener (var func f) {
	if (_NpcContainerHandleEvent_Event) {
		Event_AddOnce(_NpcContainerHandleEvent_Event, f);
	};
};

func void NpcContainerHandleEvent_RemoveListener (var func f) {
	if (_NpcContainerHandleEvent_Event) {
		Event_Remove(_NpcContainerHandleEvent_Event, f);
	};
};

func void NpcInventoryHandleEvent_AddListener (var func f) {
	if (_NpcInventoryHandleEvent_Event) {
		Event_AddOnce(_NpcInventoryHandleEvent_Event, f);
	};
};

func void NpcInventoryHandleEvent_RemoveListener (var func f) {
	if (_NpcInventoryHandleEvent_Event) {
		Event_Remove(_NpcInventoryHandleEvent_Event, f);
	};
};

//---

func void _hook_oCViewDialogTrade_OnAccept () {
	if (_TradeOnAccept_Event) {
		Event_Execute(_TradeOnAccept_Event, 0);
	};
};

func void _hook_oCViewDialogTrade_OnExit () {
	if (_TradeOnExit_Event) {
		Event_Execute(_TradeOnExit_Event, 0);
	};
};

func void _hook_oCViewDialogTrade_TransferReset () {
	if (_TradeTransferReset_Event) {
		Event_Execute(_TradeTransferReset_Event, 0);
	};
};

func void _hook_oCViewDialogTrade_HandleEvent () {
	//Is active?
	var int ptr; ptr = MEMINT_oCInformationManager_Address;
	if (ptr) {
		//Exit if not in trade mode
		//zTInfoMgrMode Mode; // sizeof 04h offset 54h
		var int mode; mode = MEM_ReadInt(ptr + 84);
		if (mode != INFO_MGR_MODE_TRADE) { return; };

		//oCInformationManager.DlgTrade; // sizeof 04h offset 18h
		var int dlgTradePtr; dlgTradePtr = MEM_ReadInt(ptr + 28);
		if (dlgTradePtr) {
			//IsActivated; // sizeof 04h offset F4h
			var int isActivated; isActivated = MEM_ReadInt(dlgTradePtr + 244);
			if (isActivated) {
				if (_TradeHandleEvent_Event) {
					Event_Execute(_TradeHandleEvent_Event, 0);
				};
			};
		};
	};
};

//---

func void _hook_oCItemContainer_Activate () {
	if (_ItemContainerActivate_Event) {
		Event_Execute(_ItemContainerActivate_Event, 0);
	};
};

func void _hook_oCItemContainer_HandleEvent () {
	//Is active?
	if (ECX) {
		//oCItemContainer.frame; // sizeof 04h offset 1Ch
		var int isActive; isActive = MEM_ReadInt(ECX + 28);
		if (isActive) {
			if (_ItemContainerHandleEvent_Event) {
				Event_Execute(_ItemContainerHandleEvent_Event, 0);
			};
		};
	};
};

func void _hook_oCStealContainer_HandleEvent () {
	//Is active?
	if (ECX) {
		//Exit if not in steal mode
		if (oCNpc_Get_Game_Mode() != NPC_GAME_STEAL) { return; };

		//class oCStealContainer : public oCItemContainer {
		//Same offset as oCItemContainer
		//oCStealContainer.frame; // sizeof 04h offset 1Ch
		var int isActive; isActive = MEM_ReadInt(ECX + 28);
		if (isActive) {
			if (_StealContainerHandleEvent_Event) {
				Event_Execute(_StealContainerHandleEvent_Event, 0);
			};
		};
	};
};

func void _hook_oCNpcContainer_HandleEvent () {
	//Is active?
	var int ptr; ptr = ECX;
	if (ECX) {
		//Exit if not in plunder mode
		if (oCNpc_Get_Game_Mode() != NPC_GAME_PLUNDER) { return; };

		//class oCNpcContainer : public oCStealContainer {
		//class oCStealContainer : public oCItemContainer {
		//Same offset as oCItemContainer
		//oCNpcContainer.frame; // sizeof 04h offset 1Ch
		var int isActive; isActive = MEM_ReadInt(ECX + 28);
		if (isActive) {
			if (_NpcContainerHandleEvent_Event) {
				Event_Execute(_NpcContainerHandleEvent_Event, 0);
			};
		};
	};
};

func void _hook_oCNpcInventory_HandleEvent () {
	//Is active?
	if (ECX) {
		//class oCNpcInventory : public oCItemContainer {
		//Same offset as oCItemContainer
		//oCNpcContainer.frame; // sizeof 04h offset 1Ch
		var int isActive; isActive = MEM_ReadInt(ECX + 28);
		if (isActive) {
			if (_NpcInventoryHandleEvent_Event) {
				Event_Execute(_NpcInventoryHandleEvent_Event, 0);
			};
		};
	};
};

//---

func void G1_TradeEvents_Init () {
	if (!_TradeOnAccept_Event) {
		_TradeOnAccept_Event = Event_Create ();
	};

	if (!_TradeOnExit_Event) {
		_TradeOnExit_Event = Event_Create ();
	};

	if (!_TradeTransferReset_Event) {
		_TradeTransferReset_Event = Event_Create ();
	};

	if (!_TradeHandleEvent_Event) {
		_TradeHandleEvent_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[Trade events]
		//0x0072A870 protected: void __fastcall oCViewDialogTrade::OnAccept(void)
		HookEngine (oCViewDialogTrade__OnAccept, 6, "_hook_oCViewDialogTrade_OnAccept");

		//0x0072AAB0 protected: void __fastcall oCViewDialogTrade::OnExit(void)
		HookEngine (oCViewDialogTrade__OnExit, 5, "_hook_oCViewDialogTrade_OnExit");

		//0x007293F0 protected: void __fastcall oCViewDialogTrade::TransferReset(void)
		HookEngine (oCViewDialogTrade__TransferReset, 9, "_hook_oCViewDialogTrade_TransferReset");

		//0x007299A0 public: virtual int __thiscall oCViewDialogTrade::HandleEvent(int)
		//G2A len 10
		HookEngine (oCViewDialogTrade__HandleEvent, 7, "_hook_oCViewDialogTrade_HandleEvent");

		once = 1;
	};
};

func void G1_ItemContainerActivateEvent_Init () {
	if (!_ItemContainerActivate_Event) {
		_ItemContainerActivate_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		HookEngine (oCItemContainer__Activate, 7, "_hook_oCItemContainer_Activate");
		once = 1;
	};
};

func void G1_InventoryEvents_Init () {
	G1_ItemContainerActivateEvent_Init ();

	if (!_ItemContainerHandleEvent_Event) {
		_ItemContainerHandleEvent_Event = Event_Create ();
	};

	if (!_StealContainerHandleEvent_Event) {
		_StealContainerHandleEvent_Event = Event_Create ();
	};

	if (!_NpcContainerHandleEvent_Event) {
		_NpcContainerHandleEvent_Event = Event_Create ();
	};

	if (!_NpcInventoryHandleEvent_Event) {
		_NpcInventoryHandleEvent_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//G2A HookLen 6
		//0x00669DD0 protected: virtual int __thiscall oCItemContainer::HandleEvent(int)
		HookEngine (oCItemContainer__HandleEvent, 7, "_hook_oCItemContainer_HandleEvent");

		//class oCStealContainer : public oCItemContainer {
		//class oCNpcContainer : public oCStealContainer {
		//class oCNpcInventory : public oCItemContainer {

		//0x0066A730 public: virtual int __thiscall oCStealContainer::HandleEvent(int)
		HookEngine (oCStealContainer__HandleEvent, 6, "_hook_oCStealContainer_HandleEvent");

		//G2A HookLen 7
		//0x0066ACD0 public: virtual int __thiscall oCNpcContainer::HandleEvent(int)
		HookEngine (oCNpcContainer__HandleEvent, 6, "_hook_oCNpcContainer_HandleEvent");

		//0x0066E390 public: virtual int __thiscall oCNpcInventory::HandleEvent(int)
		HookEngine (oCNpcInventory__HandleEvent, 6, "_hook_oCNpcInventory_HandleEvent");

		once = 1;
	};
};


func void G1_GameEvents_Init () {
	G1_TradeEvents_Init ();
	G1_InventoryEvents_Init ();
};
