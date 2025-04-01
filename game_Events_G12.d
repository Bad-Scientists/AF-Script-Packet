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
var int _DropFromSlot_Event;
var int _DoThrowVob_Event;
var int _OpenDeadNpc_Event;
var int _MobStartStateChange_Event;
var int _GameHandleEvent_Event;
var int _PlayerPortalRoomChange_Event;
var int _MobStartInteraction_Event;
var int _FocusChange_Event;
var int _OpenLockable_Event;

var int _MenuEnter_Event;
var int _MenuLeave_Event;
var int _MenuHandleEvent_Event;

func void OpenInventoryEvent_AddListener (var func f) {
	if (_OpenInventory_Event) {
		Event_AddOnce(_OpenInventory_Event, f);
	};
};

func void OpenInventoryEvent_RemoveListener (var func f) {
	if (_OpenInventory_Event) {
		Event_Remove(_OpenInventory_Event, f);
	};
};

func void CloseInventoryEvent_AddListener (var func f) {
	if (_CloseInventory_Event) {
		Event_AddOnce(_CloseInventory_Event, f);
	};
};

func void CloseInventoryEvent_RemoveListener (var func f) {
	if (_CloseInventory_Event) {
		Event_Remove(_CloseInventory_Event, f);
	};
};

func void TransferItemEvent_AddListener (var func f) {
	if (_TransferItem_Event) {
		Event_AddOnce(_TransferItem_Event, f);
	};
};

func void TransferItemEvent_RemoveListener (var func f) {
	if (_TransferItem_Event) {
		Event_Remove(_TransferItem_Event, f);
	};
};

func void EquipItemEvent_AddListener (var func f) {
	if (_EquipItem_Event) {
		Event_AddOnce(_EquipItem_Event, f);
	};
};

func void EquipItemEvent_RemoveListener (var func f) {
	if (_EquipItem_Event) {
		Event_Remove(_EquipItem_Event, f);
	};
};

func void UnEquipItemEvent_AddListener (var func f) {
	if (_UnEquipItem_Event) {
		Event_AddOnce(_UnEquipItem_Event, f);
	};
};

func void UnEquipItemEvent_RemoveListener (var func f) {
	if (_UnEquipItem_Event) {
		Event_Remove(_UnEquipItem_Event, f);
	};
};

func void DoTakeVobEvent_AddListener (var func f) {
	if (_DoTakeVob_Event) {
		Event_AddOnce(_DoTakeVob_Event, f);
	};
};

func void DoTakeVobEvent_RemoveListener (var func f) {
	if (_DoTakeVob_Event) {
		Event_Remove(_DoTakeVob_Event, f);
	};
};

func void DoDropVobEvent_AddListener (var func f) {
	if (_DoDropVob_Event) {
		Event_AddOnce(_DoDropVob_Event, f);
	};
};

func void DoDropVobEvent_RemoveListener (var func f) {
	if (_DoDropVob_Event) {
		Event_Remove(_DoDropVob_Event, f);
	};
};

func void DropFromSlotEvent_AddListener (var func f) {
	if (_DropFromSlot_Event) {
		Event_AddOnce(_DropFromSlot_Event, f);
	};
};

func void DropFromSlotEvent_RemoveListener (var func f) {
	if (_DropFromSlot_Event) {
		Event_Remove(_DropFromSlot_Event, f);
	};
};

func void DoThrowVobEvent_AddListener (var func f) {
	if (_DoThrowVob_Event) {
		Event_AddOnce(_DoThrowVob_Event, f);
	};
};

func void DoThrowVobEvent_RemoveListener (var func f) {
	if (_DoThrowVob_Event) {
		Event_Remove(_DoThrowVob_Event, f);
	};
};

func void OpenDeadNPCEvent_AddListener (var func f) {
	if (_OpenDeadNpc_Event) {
		Event_AddOnce(_OpenDeadNpc_Event, f);
	};
};

func void OpenDeadNPCEvent_RemoveListener (var func f) {
	if (_OpenDeadNpc_Event) {
		Event_Remove(_OpenDeadNpc_Event, f);
	};
};

func void MobStartStateChangeEvent_AddListener (var func f) {
	if (_MobStartStateChange_Event) {
		Event_AddOnce(_MobStartStateChange_Event, f);
	};
};

func void MobStartStateChangeEvent_RemoveListener (var func f) {
	if (_MobStartStateChange_Event) {
		Event_Remove(_MobStartStateChange_Event, f);
	};
};

func void GameHandleEvent_AddListener (var func f) {
	if (_GameHandleEvent_Event) {
		Event_AddOnce (_GameHandleEvent_Event, f);
	};
};

func void GameHandleEvent_RemoveListener (var func f) {
	if (_GameHandleEvent_Event) {
		Event_Remove(_GameHandleEvent_Event, f);
	};
};

func void PlayerPortalRoomChange_AddListener (var func f) {
	if (_PlayerPortalRoomChange_Event) {
		Event_AddOnce(_PlayerPortalRoomChange_Event, f);
	};
};

func void PlayerPortalRoomChange_RemoveListener (var func f) {
	if (_PlayerPortalRoomChange_Event) {
		Event_Remove(_PlayerPortalRoomChange_Event, f);
	};
};

func void MobStartInteractionEvent_AddListener (var func f) {
	if (_MobStartInteraction_Event) {
		Event_AddOnce(_MobStartInteraction_Event, f);
	};
};

func void MobStartInteractionEvent_RemoveListener (var func f) {
	if (_MobStartInteraction_Event) {
		Event_Remove(_MobStartInteraction_Event, f);
	};
};

func void FocusChangeEvent_AddListener (var func f) {
	if (_FocusChange_Event) {
		Event_AddOnce(_FocusChange_Event, f);
	};
};

func void FocusChangeEvent_RemoveListener (var func f) {
	if (_FocusChange_Event) {
		Event_Remove(_FocusChange_Event, f);
	};
};

func void OpenLockableEvent_AddListener (var func f) {
	if (_OpenLockable_Event) {
		Event_AddOnce(_OpenLockable_Event, f);
	};
};

func void OpenLockableEvent_RemoveListener (var func f) {
	if (_OpenLockable_Event) {
		Event_Remove(_OpenLockable_Event, f);
	};
};

func void MenuEnterEvent_AddListener (var func f) {
	if (_MenuEnter_Event) {
		Event_AddOnce(_MenuEnter_Event, f);
	};
};

func void MenuEnterEvent_RemoveListener (var func f) {
	if (_MenuEnter_Event) {
		Event_Remove(_MenuEnter_Event, f);
	};
};

func void MenuLeaveEvent_AddListener (var func f) {
	if (_MenuLeave_Event) {
		Event_AddOnce(_MenuLeave_Event, f);
	};
};

func void MenuLeaveEvent_RemoveListener (var func f) {
	if (_MenuLeave_Event) {
		Event_Remove(_MenuLeave_Event, f);
	};
};

func void MenuHandleEventEvent_AddListener (var func f) {
	if (_MenuHandleEvent_Event) {
		Event_AddOnce(_MenuHandleEvent_Event, f);
	};
};

func void MenuHandleEventEvent_RemoveListener (var func f) {
	if (_MenuHandleEvent_Event) {
		Event_Remove(_MenuHandleEvent_Event, f);
	};
};

/*
 *
 */

func void _hook_oCItemContainer_TransferItem () {
	if (!Hlp_Is_oCNpcContainer (ECX)) { return; };
	if (_TransferItem_Event) {
		Event_Execute(_TransferItem_Event, 0);
	};
};

func void _hook_oCNPC_Equip () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_EquipItem_Event) {
		Event_Execute(_EquipItem_Event, 0);
	};
};

func void _hook_oCNPC_UnEquipItem () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_UnEquipItem_Event) {
		Event_Execute(_UnEquipItem_Event, 0);
	};
};

func void _hook_oCNpc_DoTakeVob () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_DoTakeVob_Event) {
		Event_Execute(_DoTakeVob_Event, 0);
	};
};

/*
 *	Drop from slot is basically drop vob event ... same as Do Throw vob
 *	Should I combine these 3? Or is it okay to keep them separate??
 *	I think it makes sense to keep them separate ... modder will have to keep in mind to control all events
 *	It is also easier for me to keep them separate as they have different parameters ...
 *	In theory we can use event-type constant to recognize which event is calling event functions ...
 */
//const int evDoDropVob = 1;			//'Standard' Gothic function oCNpc::DoDropVob(class zCVob *)
						//Pointer to dropped item is in function parameter (ESP + 4)
//const int evDoDropFromSlot = 2;			//Item dropped using oCNpc::DropFromSlot(class zSTRING const &)
						//Pointer to dropped item has to be obtained by checking vobs in slot ! Items are still in slots when this event is called!

//0x006A10F0 public: virtual int __thiscall oCNpc::DoDropVob(class zCVob *)
func void _hook_oCNpc_DoDropVob () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_DoDropVob_Event) {
		Event_Execute(_DoDropVob_Event, 0);
	};
};

//0x006A6270 public: class oCVob * __thiscall oCNpc::DropFromSlot(struct TNpcSlot *)
func void _hook_oCNpc_DropFromSlot () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	if (!MEM_ReadInt (ESP + 4)) { return; };

	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_DropFromSlot_Event) {
		Event_Execute(_DropFromSlot_Event, 0);
	};
};

//0x006A13C0 public: virtual int __thiscall oCNpc::DoThrowVob(class zCVob *,float)
func void _hook_oCNpc_DoThrowVob () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_DoThrowVob_Event) {
		Event_Execute(_DoThrowVob_Event, 0);
	};
};

//0x006BB890 public: void __thiscall oCNpc::OpenDeadNpc(void)
func void _hook_oCNPC_OpenDeadNPC () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (_OpenDeadNpc_Event) {
		Event_Execute(_OpenDeadNpc_Event, 0);
	};
};

//protected: virtual void __thiscall oCMobInter::StartStateChange(class oCNpc *,int,int)
func void _hook_oCMobInter_StartStateChange () {
	if (!Hlp_Is_oCMobInter (ECX)) { return; };
	if (_MobStartStateChange_Event) {
		Event_Execute(_MobStartStateChange_Event, 0);
	};
};

//--- LeGo is 'detecting' following game states

//const int Gamestate_NewGame     = 0;
//const int Gamestate_Loaded      = 1;
//const int Gamestate_WorldChange = 2;
//const int Gamestate_Saving      = 3;

//--- We have added custom game states (255+ value should be enough in case of future LeGo updates)

const int Gamestate_PreSaveGameProcessing = 256;	//right before game saving
const int Gamestate_PostSaveGameProcessing = 257;	//right after game saving
const int Gamestate_ChangeLevel = 258;				//on level change

func void _hook_oCNpc_PreSaveGameProcessing () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNpc slf; slf = _^ (ECX);
	if (NPC_IsPlayer (slf)) {
		if (_LeGo_Flags & LeGo_Gamestate) {
			if (_Gamestate_Event) {
				Event_Execute(_Gamestate_Event, Gamestate_PreSaveGameProcessing);
			};
		};
	};
};

func void _hook_oCNpc_PostSaveGameProcessing () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNpc slf; slf = _^ (ECX);
	if (NPC_IsPlayer (slf)) {
		if (_LeGo_Flags & LeGo_Gamestate) {
			if (_Gamestate_Event) {
				Event_Execute(_Gamestate_Event, Gamestate_PostSaveGameProcessing);
			};
		};
	};
};

func void _hook_oCGame_ChangeLevel () {
	if (_LeGo_Flags & LeGo_Gamestate) {
		if (_Gamestate_Event) {
			Event_Execute(_Gamestate_Event, Gamestate_ChangeLevel);
		};
	};
};

func void _hook_oCGame_HandleEvent () {
	var int key; key = MEM_ReadInt (ESP + 4);
	if (_GameHandleEvent_Event) {
		Event_Execute(_GameHandleEvent_Event, key);
	};
};

//var int PC_PortalManager_OldPlayerRoom;
var int PC_PortalManager_CurPlayerPortal;

func void _hook_oCPortalRoomManager_HasPlayerChangedPortalRoom () {
	if (!MEM_Game.portalman) { return; };

	var oCPortalRoomManager portalManager; portalManager = _^ (MEM_Game.portalman);

	//if (portalManager.curPlayerRoom != PC_PortalManager_OldPlayerRoom) {
	//	PC_PortalManager_OldPlayerRoom = portalManager.curPlayerRoom;

	if (portalManager.curPlayerPortal != PC_PortalManager_CurPlayerPortal) {
		PC_PortalManager_CurPlayerPortal = portalManager.curPlayerPortal;
		if (_PlayerPortalRoomChange_Event) {
			Event_Execute(_PlayerPortalRoomChange_Event, 0);
		};
	};
};

//---

func void _hook_oCItemContainer_OpenPassive () {
	if (!Hlp_Is_oCNpcInventory (ECX)) { return; };

	var oCNpcInventory npcInventory; npcInventory = _^ (ECX);

	if (!Hlp_Is_oCNpc (npcInventory.inventory2_owner)) { return; };

	var oCNpc slf; slf = _^ (npcInventory.inventory2_owner);

	if (!NPC_IsPlayer (slf)) { return; };

	//Flush keys to prevent accidental inventory movements (while stealing)
	zCInput_Win32_ClearKeyBuffer();
	zCInput_Win32_ResetRepeatKey(true);

	if (_OpenInventory_Event) {
		Event_Execute(_OpenInventory_Event, 0);
	};
};

func void _hook_oCMobInter_StartInteraction () {
	if (!Hlp_Is_oCMobInter (ECX))  { return; };

	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	if (_MobStartInteraction_Event) {
		Event_Execute(_MobStartInteraction_Event, 0);
	};
};

func void G12_OpenInventoryEvent_Init () {
	if (!_OpenInventory_Event) {
		_OpenInventory_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x00668050 public: virtual void __thiscall oCItemContainer::OpenPassive(int,int,enum oCItemContainer::oTItemListMode)
		const int oCItemContainer__OpenPassive_G1 = 6717520;

		//0x007086D0 public: virtual void __thiscall oCItemContainer::OpenPassive(int,int,int)
		const int oCItemContainer__OpenPassive_G2 = 7374544;

		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__OpenPassive_G1, oCItemContainer__OpenPassive_G2), 7, "_hook_oCItemContainer_OpenPassive");

		once = 1;
	};
};

func void _hook_oCItemContainer_Close () {
	if (!Hlp_Is_oCNpcInventory (ECX)) { return; };

	var oCNpcInventory npcInventory; npcInventory = _^ (ECX);

	if (!Hlp_Is_oCNpc (npcInventory.inventory2_owner)) { return; };

	var oCNpc slf; slf = _^ (npcInventory.inventory2_owner);

	if (!NPC_IsPlayer (slf)) { return; };

	if (_CloseInventory_Event) {
		Event_Execute(_CloseInventory_Event, 0);
	};
};

func void G12_CloseInventoryEvent_Init () {
	if (!_CloseInventory_Event) {
		_CloseInventory_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x00668C10 public: virtual void __thiscall oCItemContainer::Close(void)
		const int oCItemContainer__Close_G1 = 6720528;

		//0x00708F30 public: virtual void __thiscall oCItemContainer::Close(void)
		const int oCItemContainer__Close_G2 = 7376688;

		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__Close_G1, oCItemContainer__Close_G2), 7, "_hook_oCItemContainer_Close");

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
		//HookLen G2A 6
		HookEngine (oCNPC__UnEquipItem, MEMINT_SwitchG1G2 (7, 6), "_hook_oCNPC_UnEquipItem");
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

	if (!_DropFromSlot_Event) {
		_DropFromSlot_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[DoDropVob events]
		HookEngine (oCNPC__DoDropVob, 6, "_hook_oCNpc_DoDropVob");

		//--> Engine calls oCNpc::DropFromSlot(struct TNpcSlot *)
		//0x006A61A0 public: class oCVob * __thiscall oCNpc::DropFromSlot(class zSTRING const &)
		//0x0074A590 public: class oCVob * __thiscall oCNpc::DropFromSlot(class zSTRING const &)

		//Only in G1
		//0x00694060 public: void __thiscall oCNpc::RemoveFromHand(void)
		//<--

		//0x006A6270 public: class oCVob * __thiscall oCNpc::DropFromSlot(struct TNpcSlot *)
		const int oCNpc__DropFromSlot_G1 = 6972016;

		//0x0074A660 public: class oCVob * __thiscall oCNpc::DropFromSlot(struct TNpcSlot *)
		const int oCNpc__DropFromSlot_G2 = 7644768;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__DropFromSlot_G1, oCNpc__DropFromSlot_G2), 6, "_hook_oCNpc_DropFromSlot");

		once = 1;
	};
};

func void G12_DoThrowVobEvent_Init () {
	if (!_DoThrowVob_Event) {
		_DoThrowVob_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x006A13C0 public: virtual int __thiscall oCNpc::DoThrowVob(class zCVob *,float)
		const int oCNpc__DoThrowVob_G1 = 6951872;

		//0x007450B0 public: virtual int __thiscall oCNpc::DoThrowVob(class zCVob *,float)
		const int oCNpc__DoThrowVob_G2 = 7622832;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__DoThrowVob_G1, oCNpc__DoThrowVob_G2), 5, "_hook_oCNpc_DoThrowVob");
		once = 1;
	};
};

func void G12_OpenDeadNPCEvent_Init () {
	if (!_OpenDeadNpc_Event) {
		_OpenDeadNpc_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//[OpenDeadNPC events]
		//HookLen G2A 6
		HookEngine (oCNPC__OpenDeadNpc, MEMINT_SwitchG1G2 (7, 6), "_hook_oCNPC_OpenDeadNPC");
		once = 1;
	};
};

func void G12_GameState_Extended_Init () {
	if (_LeGo_Flags & LeGo_Gamestate) {
		//Everything ok...
	} else {
		zSpy_Info("G12_GameState_Extended_Init: warning this feature required LeGo_Gamestate flag to be enabled!");
	};

	const int once = 0;
	if (!once) {
		//Called before game save
		HookEngine (oCNpc__PreSaveGameProcessing, 7, "_hook_oCNpc_PreSaveGameProcessing");

		//Called after game save
		HookEngine (oCNpc__PostSaveGameProcessing, 7, "_hook_oCNpc_PostSaveGameProcessing");

		/*
		--> oCGame::PreSaveGameProcessing is not called ?!

		//0x0063AC50 private: void __thiscall oCGame::PreSaveGameProcessing(int)
		const int oCGame__PreSaveGameProcessing_G1 = 6532176;

		//0x006C5120 private: void __thiscall oCGame::PreSaveGameProcessing(int)
		const int oCGame__PreSaveGameProcessing_G2 = 7098656;

		//HookEngine (MEMINT_SwitchG1G2 (oCGame__PreSaveGameProcessing_G1, oCGame__PreSaveGameProcessing_G2), 6, "_hook_oCGame_PreSaveGameProcessing");

		//0x0063ACF0 private: void __thiscall oCGame::PostSaveGameProcessing(void)
		const int oCGame__PostSaveGameProcessing_G1 = 6532336;

		//0x006C51C0 private: void __thiscall oCGame::PostSaveGameProcessing(void)
		const int oCGame__PostSaveGameProcessing_G2 = 7098816;

		//HookEngine (MEMINT_SwitchG1G2 (oCGame__PostSaveGameProcessing_G1, oCGame__PostSaveGameProcessing_G2), 6, "_hook_oCGame_PostSaveGameProcessing");
		*/

		//Called before change level
		//This one is already hooked by LeGo (LeGo_Saves), but it seems like LeGo 2.7.1 does not mind (let's hope for the best!)
		HookEngine (oCGame__ChangeLevel, 7, "_hook_oCGame_ChangeLevel");

		once = 1;
	};
};

func void G12_MobStartStateChangeEvent_Init () {
	if (!_MobStartStateChange_Event) {
		_MobStartStateChange_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x0067E6E0 protected: virtual void __thiscall oCMobInter::StartStateChange(class oCNpc *,int,int)
		const int oCMobInter__StartStateChange_G1 = 6809312;

		//0x0071FEA0 public: virtual void __thiscall oCMobInter::StartStateChange(class oCNpc *,int,int)
		const int oCMobInter__StartStateChange_G2 = 7470752;

		//[Mob Start state change events]
		HookEngine (MEMINT_SwitchG1G2 (oCMobInter__StartStateChange_G1, oCMobInter__StartStateChange_G2), 7, "_hook_oCMobInter_StartStateChange");
		once = 1;
	};
};

func void G12_GameHandleEvent_Init () {
	if (!_GameHandleEvent_Event) {
		_GameHandleEvent_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x0065EEE0 private: virtual int __thiscall oCGame::HandleEvent(int)
		const int oCGame__HandleEvent_G1 = 6680288;	//0x65EEE0
		//const int oCGame__HandleEvent_G1 = 6685092;	oCGame__HandleEvent_dfltCase

		//0x006FC170 private: virtual int __thiscall oCGame::HandleEvent(int)
		const int oCGame__HandleEvent_G2 = 7324016;	//0x6FC170
						//7325123	oCGame__HandleEvent_openInvCheck
						//7327661	oCGame__HandleEvent_spellKeys
						//7328820	oCGame__HandleEvent_dfltCase

		HookEngine (MEMINT_SwitchG1G2(oCGame__HandleEvent_G1, oCGame__HandleEvent_G2), MEMINT_SwitchG1G2(6, 7), "_hook_oCGame_HandleEvent");
		once = 1;
	};
};

func void G12_PlayerPortalRoomChangeEvent_Init () {
	if (!_PlayerPortalRoomChange_Event) {
		_PlayerPortalRoomChange_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//TODO: we can call this from return portion of the engine function
		//Is there a better method? this function seems to be called constantly (so far I didn't notice any performance impact)

		//0x006CB630 public: int __thiscall oCPortalRoomManager::HasPlayerChangedPortalRoom(void)
		const int oCPortalRoomManager__HasPlayerChangedPortalRoom_G1 = 7124528;

		//0x00773070 public: int __thiscall oCPortalRoomManager::HasPlayerChangedPortalRoom(void)
		const int oCPortalRoomManager__HasPlayerChangedPortalRoom_G2 = 7811184;

		HookEngine (MEMINT_SwitchG1G2 (oCPortalRoomManager__HasPlayerChangedPortalRoom_G1, oCPortalRoomManager__HasPlayerChangedPortalRoom_G2), 9, "_hook_oCPortalRoomManager_HasPlayerChangedPortalRoom");
		once = 1;
	};
};

func void G12_MobStartInterationEvent_Init () {
	if (!_MobStartInteraction_Event) {
		_MobStartInteraction_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x0067FCA0 protected: virtual void __thiscall oCMobInter::StartInteraction(class oCNpc *)
		const int oCMobInter__StartInteraction_G1 = 6814880;
		//0x00721580 protected: virtual void __thiscall oCMobInter::StartInteraction(class oCNpc *)
		const int oCMobInter__StartInteraction_G2 = 7476608;

		HookEngine (MEMINT_SwitchG1G2 (oCMobInter__StartInteraction_G1, oCMobInter__StartInteraction_G2), 6, "_hook_oCMobInter_StartInteraction");
		once = 1;
	};
};

/*
 *	Focus change event
 */

var int PC_FocusVob;

func void _hook_oCGame_GetFocusVob () {
	if (!Hlp_IsValidNPC (hero)) { return; };
	var oCNpc her; her = Hlp_GetNPC (hero);

	//Focus changed
	if (PC_FocusVob != her.focus_vob) {
		PC_FocusVob = her.focus_vob;

		if (_FocusChange_Event) {
			Event_Execute(_FocusChange_Event, PC_FocusVob);
		};
	};
};

func void G12_FocusChangeEvent_Init () {
	if (!_FocusChange_Event) {
		_FocusChange_Event = Event_Create ();
	};

	PC_FocusVob = 0;

	const int once = 0;
	if (!once) {
		//00639268
		const int oCGame__GetFocusVob_G1 = 6525544;

		//006C35A5
		const int oCGame__GetFocusVob_G2 = 7091621;

		HookEngine(MEMINT_SwitchG1G2 (oCGame__GetFocusVob_G1, oCGame__GetFocusVob_G2), MEMINT_SwitchG1G2 (5, 8), "_hook_oCGame_GetFocusVob");
		once = 1;
	};
};

/*
 *	Open lockable event
 */

const int OpenLockableEvent_UnlockWithKey = 1;
const int OpenLockableEvent_UnlockWithPicklock = 2;
const int OpenLockableEvent_PickLockSuccess = 3;
const int OpenLockableEvent_PickLockFailure = 4;
const int OpenLockableEvent_PickLockFailureBroken = 5;

func void _hook_oCMobLockable_UnlockWithKey () {
	//EBP 0x007DDF34 const oCNpc::`vftable'
	self = _^(EBP);
	if (_OpenLockable_Event) {
		Event_Execute(_OpenLockable_Event, OpenLockableEvent_UnlockWithKey);
	};
};

func void _hook_oCMobLockable_UnlockWithPickLock () {
	//EBP 0x007DDF34 const oCNpc::`vftable'
	self = _^(EBP);
	if (_OpenLockable_Event) {
		Event_Execute(_OpenLockable_Event, OpenLockableEvent_UnlockWithPicklock);
	};
};

func void _hook_oCMobLockable_PickLockSuccess () {
	//EBP 0x007DDF34 const oCNpc::`vftable'
	self = _^(EBP);
	if (_OpenLockable_Event) {
		Event_Execute(_OpenLockable_Event, OpenLockableEvent_PickLockSuccess);
	};
};

func void _hook_oCMobLockable_PickLockFailure () {
	//EBP 0x007DDF34 const oCNpc::`vftable'
	self = _^(EBP);
	if (_OpenLockable_Event) {
		Event_Execute(_OpenLockable_Event, OpenLockableEvent_PickLockFailure);
	};
};

func void _hook_oCMobLockable_PickLockFailureBroken () {
	//EBP 0x007DDF34 const oCNpc::`vftable'
	self = _^(EBP);
	if (_OpenLockable_Event) {
		Event_Execute(_OpenLockable_Event, OpenLockableEvent_PickLockFailureBroken);
	};
};

func void G12_OpenLockableEvent_Init () {
	if (!_OpenLockable_Event) {
		_OpenLockable_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//G1
		//0x00681FF0 public: virtual void __thiscall oCMobLockable::Interact(class oCNpc *,int,int,int,int,int)

		//G2A
		//0x00723CF0 public: virtual void __thiscall oCMobLockable::Interact(class oCNpc *,int,int,int,int,int)

		//006820d2 - unlock with key - success
		const int oCMobLockable__Interact_UnlockWithKey_G1 = 6824146;

		//00723dce
		const int oCMobLockable__Interact_UnlockWithKey_G2 = 7486926;

		HookEngine (MEMINT_SwitchG1G2 (oCMobLockable__Interact_UnlockWithKey_G1, oCMobLockable__Interact_UnlockWithKey_G2), 6, "_hook_oCMobLockable_UnlockWithKey");

		//00682212 - unlock with lockpick - success
		const int oCMobLockable__Interact_UnlockWithPickLock_G1 = 6824466;

		//00723ef5
		const int oCMobLockable__Interact_UnlockWithPickLock_G2 = 7487221;

		HookEngine (MEMINT_SwitchG1G2 (oCMobLockable__Interact_UnlockWithPickLock_G1, oCMobLockable__Interact_UnlockWithPickLock_G2), 5, "_hook_oCMobLockable_UnlockWithPickLock");

		//006822ad - picklock - success
		const int oCMobLockable__Interact_PickLockSuccess_G1 = 6824621;

		//723f77
		const int oCMobLockable__Interact_PickLockSuccess_G2 = 7487351;

		HookEngine (MEMINT_SwitchG1G2 (oCMobLockable__Interact_PickLockSuccess_G1, oCMobLockable__Interact_PickLockSuccess_G2), 6, "_hook_oCMobLockable_PickLockSuccess");

		//0068234f - picklock - failure - broken
		const int oCMobLockable__Interact_PickLockFailureBroken_G1 = 6824783;

		//00724019
		const int oCMobLockable__Interact_PickLockFailureBroken_G2 = 7487513;

		HookEngine (MEMINT_SwitchG1G2 (oCMobLockable__Interact_PickLockFailureBroken_G1, oCMobLockable__Interact_PickLockFailureBroken_G2), 8, "_hook_oCMobLockable_PickLockFailureBroken");

		//006824d6 - picklock - failure
		const int oCMobLockable__Interact_PickLockFailure_G1 = 6825174;

		//00724208
		const int oCMobLockable__Interact_PickLockFailure_G2 = 7488008;

		HookEngine (MEMINT_SwitchG1G2 (oCMobLockable__Interact_PickLockFailure_G1, oCMobLockable__Interact_PickLockFailure_G2), 8, "_hook_oCMobLockable_PickLockFailure");

		once = 1;
	};
};

/*
 *	Menu-related events
 */

func void _hook_zCMenu_Enter__GameEvent () {
	if (_MenuEnter_Event) {
		Event_Execute(_MenuEnter_Event, 0);
	};
};

func void _hook_zCMenu_Leave__GameEvent () {
	if (_MenuLeave_Event) {
		Event_Execute(_MenuLeave_Event, 0);
	};
};

func void _hook_zCMenu_HandleEvent__GameEvent () {
	//TODO: we should not pass key as variable
	var int key; key = MEM_ReadInt (ESP + 4);
	if (_MenuHandleEvent_Event) {
		Event_Execute(_MenuHandleEvent_Event, key);
	};
};

func void G12_MenuEvent_Init () {
	if (!_MenuEnter_Event) {
		_MenuEnter_Event = Event_Create ();
	};

	if (!_MenuLeave_Event) {
		_MenuLeave_Event = Event_Create ();
	};

	if (!_MenuHandleEvent_Event) {
		_MenuHandleEvent_Event = Event_Create ();
	};

	const int once = 0;
	if (!once) {
		//0x004CEB90 public: virtual void __thiscall zCMenu::Enter(void)
		const int zCMenu__Enter_G1 = 5041040;

		//0x004DB780 public: virtual void __thiscall zCMenu::Enter(void)
		const int zCMenu__Enter_G2 = 5093248;

		//G1 5 G2 NoTR 6
		HookEngine (MEMINT_SwitchG1G2 (zCMenu__Enter_G1, zCMenu__Enter_G2), MEMINT_SwitchG1G2 (5, 6), "_hook_zCMenu_Enter__GameEvent");

		//0x004CEBF0 public: virtual void __thiscall zCMenu::Leave(void)
		const int zCMenu__Leave_G1 = 5041136;

		//0x004DB910 public: virtual void __thiscall zCMenu::Leave(void)
		const int zCMenu__Leave_G2 = 5093648;

		HookEngine (MEMINT_SwitchG1G2 (zCMenu__Leave_G1, zCMenu__Leave_G2), 9, "_hook_zCMenu_Leave__GameEvent");

		//0x004CEE10 public: virtual int __thiscall zCMenu::HandleEvent(int)
		const int zCMenu__HandleEvent_G1 = 5041680;

		//0x004DBB70 public: virtual int __thiscall zCMenu::HandleEvent(int)
		const int zCMenu__HandleEvent_G2 = 5094256;

		HookEngine (MEMINT_SwitchG1G2 (zCMenu__HandleEvent_G1, zCMenu__HandleEvent_G2), 5, "_hook_zCMenu_HandleEvent__GameEvent");

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
	G12_DoThrowVobEvent_Init ();
	G12_OpenDeadNPCEvent_Init ();
	G12_GameState_Extended_Init ();
	G12_MobStartStateChangeEvent_Init ();
	G12_PlayerPortalRoomChangeEvent_Init ();
	G12_MobStartInterationEvent_Init ();
	G12_FocusChangeEvent_Init ();
	G12_OpenLockableEvent_Init ();
	G12_MenuEvent_Init ();
};
