/*
 *	In G1 there are several events that are closing inventory, this package allows me to add listeners which will be called every time inventory is closed.
 *
 *	Seems like we can still use registers (ECX, ESP + 4) from listeners - yuppiii !!
 *
 *	Requires LeGo_EventHandler
 */

//[Internal variables]
var int _OpenInventory_Event;
var int _CloseInventory_Event;
var int _TransferItem_Event;
var int _EquipItem_Event;
var int _UnEquipItem_Event;
var int _DoTakeVob_Event;
var int _DoDropVob_Event;
var int _OpenDeadNPC_Event;

func void OpenInventoryEvent_AddListener (var func f) {
	Event_AddOnce (_OpenInventory_Event, f);
};

func void OpenInventoryEvent_RemoveListener (var func f) {
	Event_Remove (_OpenInventory_Event, f);
};

func void CloseInventoryEvent_AddListener (var func f) {
	Event_AddOnce (_CloseInventory_Event, f);
};

func void CloseInventoryEvent_RemoveListener (var func f) {
	Event_Remove (_CloseInventory_Event, f);
};

func void TransferItemEvent_AddListener (var func f) {
	Event_AddOnce (_TransferItem_Event, f);
};

func void TransferItemEvent_RemoveListener (var func f) {
	Event_Remove (_TransferItem_Event, f);
};

func void EquipItemEvent_AddListener (var func f) {
	Event_AddOnce (_EquipItem_Event, f);
};

func void EquipItemEvent_RemoveListener (var func f) {
	Event_Remove (_EquipItem_Event, f);
};

func void UnEquipItemEvent_AddListener (var func f) {
	Event_AddOnce (_UnEquipItem_Event, f);
};

func void UnEquipItemEvent_RemoveListener (var func f) {
	Event_Remove (_UnEquipItem_Event, f);
};

func void DoTakeVobEvent_AddListener (var func f) {
	Event_AddOnce (_DoTakeVob_Event, f);
};

func void DoTakeVobEvent_RemoveListener (var func f) {
	Event_Remove (_DoTakeVob_Event, f);
};

func void DoDropVobEvent_AddListener (var func f) {
	Event_AddOnce (_DoDropVob_Event, f);
};

func void DoDropVobEvent_RemoveListener (var func f) {
	Event_Remove (_DoDropVob_Event, f);
};

func void OpenDeadNPCEvent_AddListener (var func f) {
	Event_AddOnce (_OpenDeadNPC_Event, f);
};

func void OpenDeadNPCEvent_RemoveListener (var func f) {
	Event_Remove (_OpenDeadNPC_Event, f);
};

/*
 *	Some made-up 'internal' constants
 */

const int evOpenInventory = 1;		//Inventory open using 'standard' method (oCNPC__OpenInventory)

const int evDrawWeapon = 1;		//Weapon drawing (oCNPC__EV_DrawWeapon, oCNPC__EV_DrawWeapon1, oCNPC__EV_DrawWeapon2)
const int evCloseInventory = 2;		//Inventory closed using 'standard' method (oCNPC__CloseInventory)
const int evOpenScreenMap = 3;		//Opening map (oCNPC__OpenScreen_Map replaced by _hook_oCNPC_OpenScreen_Map)
const int evStatusScreenShow = 4;	//Opening status screen (oCStatusScreen__Show)
const int evLogScreenShow = 5;		//Opening log screen (oCLogScreen__Show)
const int evMapScreenShow = 6;		//Opening map (oCMapScreen__Show)

/*
 *	'Standard' inventory opening method
 */
func void _hook_oCNPC_OpenInventory () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_OpenInventory_Event, evOpenInventory);
};

/*
 *	'Standard' inventory closing method
 */
func void _hook_oCNpc_CloseInventory () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_CloseInventory_Event, evCloseInventory);
};

/*
 *	Weapon drawing closes inventory
 */
func void _hook_oCNPC_EV_DrawWeapon () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_CloseInventory_Event, evDrawWeapon);
};

/*
 *	Function is called when player presses 'B' for status screen
 */
func void _hook_oCStatusScreen_Show () {
	Event_Execute (_CloseInventory_Event, evStatusScreenShow);
};

/*
 *	Function is called when player presses 'L' for Log screen
 */
func void _hook_oCLogScreen_Show () {
	Event_Execute (_CloseInventory_Event, evLogScreenShow);
};

/*
 *	Function is called when player presses 'M' to show Map
 */
func void _hook_oCMapScreen_Show () {
	Event_Execute (_CloseInventory_Event, evMapScreenShow);
};

//Even though this function is supposedly method of oCItemContainer class, reading out vtbl in ECX gives me 8245076 (oCNPCContainer_vtbl)
//After some trial-error testing, we can safely use oCNpcInventory here
func void _hook_oCItemContainer_TransferItem () {
	if (!Hlp_Is_oCNpcContainer (ECX)) { return; };
	Event_Execute (_TransferItem_Event, 0);
};

func void _hook_oCNPC_Equip () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_EquipItem_Event, 0);
};

func void _hook_oCNPC_UnEquipItem () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_UnEquipItem_Event, 0);
};

func void _hook_oCNpc_DoTakeVob () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_DoTakeVob_Event, 0);
};

func void _hook_oCNpc_DoDropVob () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_DoDropVob_Event, 0);
};

func void _hook_oCNPC_OpenDeadNPC () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	Event_Execute (_OpenDeadNPC_Event, 0);
};

//---

func void G12_OpenInventoryEvent_Init () {
	if (!_OpenInventory_Event) {
		_OpenInventory_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[Open inventory events]
		HookEngine (oCNPC__OpenInventory, 6, "_hook_oCNPC_OpenInventory");
		once = 1;
	};
};
	
func void G12_CloseInventoryEvent_Init () {
	if (!_CloseInventory_Event) {
		_CloseInventory_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[Close inventory events]
		//Function is called when inventory is closed
		HookEngine (oCNPC__CloseInventory, 6, "_hook_oCNpc_CloseInventory");
		
		//Weapon drawing closes inventory
		HookEngine (oCNPC__EV_DrawWeapon, 6, "_hook_oCNPC_EV_DrawWeapon");
		HookEngine (oCNPC__EV_DrawWeapon1, 5, "_hook_oCNPC_EV_DrawWeapon");
		HookEngine (oCNPC__EV_DrawWeapon2, 6, "_hook_oCNPC_EV_DrawWeapon");

		HookEngine (oCStatusScreen__Show, 7, "_hook_oCStatusScreen_Show");
		HookEngine (oCLogScreen__Show, 7, "_hook_oCLogScreen_Show");

		HookEngine (oCMapScreen__Show, 7, "_hook_oCMapScreen_Show");
		once = 1;
	};
};

func void G12_TransferItemEvent_Init () {
	if (!_TransferItem_Event) {
		_TransferItem_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[Transfer item events]
		//Function is called on transfer from npc to npc, from npc to chest
		HookEngine (oCItemContainer__TransferItem, 5, "_hook_oCItemContainer_TransferItem");
		once = 1;
	};
};

func void G12_EquipItemEvent_Init () {
	if (!_EquipItem_Event) {
		_EquipItem_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[Equip item events]
		HookEngine (oCNPC__Equip, 5, "_hook_oCNPC_Equip");
		once = 1;
	};
};

func void G12_UnEquipItemEvent_Init () {
	if (!_UnEquipItem_Event) {
		_UnEquipItem_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[UnEquip item events]
		HookEngine (oCNPC__UnEquipItem, 7, "_hook_oCNPC_UnEquipItem");
		once = 1;
	};
};

func void G12_DoTakeVobEvent_Init () {
	if (!_DoTakeVob_Event) {
		_DoTakeVob_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[DoTakeVob events]
		HookEngine (oCNPC__DoTakeVob, 6, "_hook_oCNpc_DoTakeVob");
		once = 1;
	};
};

func void G12_DoDropVobEvent_Init () {
	if (!_DoDropVob_Event) {
		_DoDropVob_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[DoDropVob events]
		HookEngine (oCNPC__DoDropVob, 6, "_hook_oCNpc_DoDropVob");
		once = 1;
	};
};

func void G12_OpenDeadNPCEvent_Init () {
	if (!_OpenDeadNPC_Event) {
		_OpenDeadNPC_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[OpenDeadNPC events]
		HookEngine (oCNPC__OpenDeadNPC, MEMINT_SwitchG1G2 (7, 6), "_hook_oCNPC_OpenDeadNPC");
		once = 1;
	};
};

func void G12_GameEvents_Init () {
	G12_OpenInventoryEvent_Init ();
	G12_CloseInventoryEvent_Init ();
	G12_TransferItemEvent_Init ();
	G12_EquipItemEvent_Init ();
	G12_UnEquipItemEvent_Init ();
	G12_DoTakeVobEvent_Init ();
	G12_DoDropVobEvent_Init ();
	G12_OpenDeadNPCEvent_Init ();
};
