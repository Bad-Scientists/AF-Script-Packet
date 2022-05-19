/*
 *
 */

//[Internal variables]
var int _TradeOnAccept_Event;
var int _TradeOnAccept_Event_Break;

var int _TradeOnExit_Event;
var int _TradeOnExit_Event_Break;

var int _TradeHandleEvent_Event;
var int _TradeHandleEvent_Event_Break;

var int _ItemContainerActivate_Event;
var int _ItemContainerHandleEvent_Event;
var int _StealContainerHandleEvent_Event;
var int _NpcContainerHandleEvent_Event;
var int _NpcInventoryHandleEvent_Event;

func void TradeOnAcceptEvent_AddListener (var func f) {
	Event_AddOnce (_TradeOnAccept_Event, f);
};

func void TradeOnAcceptEvent_RemoveListener (var func f) {
	Event_Remove (_TradeOnAccept_Event, f);
};

func void TradeOnExitEvent_AddListener (var func f) {
	Event_AddOnce (_TradeOnExit_Event, f);
};

func void TradeOnExitEvent_RemoveListener (var func f) {
	Event_Remove (_TradeOnExit_Event, f);
};

func void TradeHandleEvent_AddListener (var func f) {
	Event_AddOnce (_TradeHandleEvent_Event, f);
};

func void TradeHandleEvent_RemoveListener (var func f) {
	Event_Remove (_TradeHandleEvent_Event, f);
};

func void ItemContainerActivate_AddListener (var func f) {
	Event_AddOnce (_ItemContainerActivate_Event, f);
};

func void ItemContainerActivate_RemoveListener (var func f) {
	Event_Remove (_ItemContainerActivate_Event, f);
};

func void ItemContainerHandleEvent_AddListener (var func f) {
	Event_AddOnce (_ItemContainerHandleEvent_Event, f);
};

func void ItemContainerHandleEvent_RemoveListener (var func f) {
	Event_Remove (_ItemContainerHandleEvent_Event, f);
};

func void StealContainerHandleEvent_AddListener (var func f) {
	Event_AddOnce (_StealContainerHandleEvent_Event, f);
};

func void StealContainerHandleEvent_RemoveListener (var func f) {
	Event_Remove (_StealContainerHandleEvent_Event, f);
};

func void NpcContainerHandleEvent_AddListener (var func f) {
	Event_AddOnce (_NpcContainerHandleEvent_Event, f);
};

func void NpcContainerHandleEvent_RemoveListener (var func f) {
	Event_Remove (_NpcContainerHandleEvent_Event, f);
};

func void NpcInventoryHandleEvent_AddListener (var func f) {
	Event_AddOnce (_NpcInventoryHandleEvent_Event, f);
};

func void NpcInventoryHandleEvent_RemoveListener (var func f) {
	Event_Remove (_NpcInventoryHandleEvent_Event, f);
};

//---

func void _hook_oCViewDialogTrade_OnAccept () {
	_TradeOnAccept_Event_Break = FALSE;
	Event_Execute (_TradeOnAccept_Event, 0);
};

func void _hook_oCViewDialogTrade_OnExit () {
	_TradeOnExit_Event_Break = FALSE;
	Event_Execute (_TradeOnExit_Event, 0);
};

func void _hook_oCViewDialogTrade_HandleEvent () {
	//--> Safety check
	if (!MEM_InformationMan.DlgTrade) { return; };

	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	if (!dialogTrade.IsActivated) { return; };
	//<--

	_TradeHandleEvent_Event_Break = FALSE;
	Event_Execute (_TradeHandleEvent_Event, 0);
};

//---

func void _hook_oCItemContainer_Activate () {
	Event_Execute (_ItemContainerActivate_Event, 0);
};

func void _hook_oCItemContainer_HandleEvent () {
	Event_Execute (_ItemContainerHandleEvent_Event, 0);
};

func void _hook_oCStealContainer_HandleEvent () {
	Event_Execute (_StealContainerHandleEvent_Event, 0);
};

func void _hook_oCNpcContainer_HandleEvent () {
	Event_Execute (_NpcContainerHandleEvent_Event, 0);
};

func void _hook_oCNpcInventory_HandleEvent () {
	Event_Execute (_NpcInventoryHandleEvent_Event, 0);
};

//---

func void G1_TradeEvents_Init () {
	if (!_TradeOnAccept_Event) {
		_TradeOnAccept_Event = Event_Create ();
	};

	if (!_TradeOnExit_Event) {
		_TradeOnExit_Event = Event_Create ();
	};

	if (!_TradeHandleEvent_Event) {
		_TradeHandleEvent_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[Trade events]
		HookEngine (oCViewDialogTrade__OnAccept, 6, "_hook_oCViewDialogTrade_OnAccept");

		HookEngine (oCViewDialogTrade__OnExit, 5, "_hook_oCViewDialogTrade_OnExit");

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
		HookEngine (oCItemContainer__HandleEvent, 7, "_hook_oCItemContainer_HandleEvent");

		HookEngine (oCStealContainer__HandleEvent, 6, "_hook_oCStealContainer_HandleEvent");

		//G2A HookLen 7
		HookEngine (oCNpcContainer__HandleEvent, 8, "_hook_oCNpcContainer_HandleEvent");

		HookEngine (oCNpcInventory__HandleEvent, 6, "_hook_oCNpcInventory_HandleEvent");

		once = 1;
	};
};


func void G1_GameEvents_Init () {
	G1_TradeEvents_Init ();
	G1_InventoryEvents_Init ();
};

