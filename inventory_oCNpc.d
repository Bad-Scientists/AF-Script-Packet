/*
 *	Hlp_GetOpenInventoryType
 *
 *	 - identifies type of opened inventory:
 *	 - 0 none
 *	 - 1 players inventory
 *	 - 2 looting NPC
 *	 - 3 looting chest
 *	 - 4 trading inventory
 *	 - 5 stealing
 */

/*
enum {
NPC_GAME_NORMAL,
NPC_GAME_PLUNDER,
NPC_GAME_STEAL
};
*/

/*
 *	Function returns game_mode
 */
func int oCNpc_Get_Game_Mode () {
	//0x008DBC24 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G1 = 9288740;

	//0x00AB27D0 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G2 = 11216848;

	return + MEM_ReadInt (MEMINT_SwitchG1G2 (oCNpc__game_mode_G1, oCNpc__game_mode_G2));
};

/*
 *	Function updates game_mode
 */
func void oCNpc_Set_Game_Mode (var int newMode) {
	//0x008DBC24 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G1 = 9288740;

	//0x00AB27D0 public: static int oCNpc::game_mode
	const int oCNpc__game_mode_G2 = 11216848;

	MEM_WriteInt (MEMINT_SwitchG1G2 (oCNpc__game_mode_G1, oCNpc__game_mode_G2), newMode);
};

//0x008DBC24 public: static int oCNpc::game_mode
//0x008DBC28 class oCNpc * stealnpc
//0x008DBC2C float stealcheck_timer

const int OpenInvType_None = 0;
const int OpenInvType_Player = 1;
const int OpenInvType_NPC = 2;
const int OpenInvType_Chest = 3;
const int OpenInvType_Trading = 4;
const int OpenInvType_Stealing = 5;

func int Hlp_GetOpenInventoryType () {
	//0x008DA998 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G1 = 9283992;

	//0x00AB0FD4 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G2 = 11210708;

	//0x007DCDFC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G1 = 8244732;

	//0x0083C4AC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G2 = 8635564;

	//0x007DCEA4 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G1 = 8244900;

	//0x0083C574 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G2 = 8635764;

	//0x007DCF54 const oCNpcContainer::`vftable'
	const int oCNpcContainer_vtbl_G1 = 8245076;

	//0x0083C644 const oCNpcContainer::`vftable'
	const int oCNpcContainer_vtbl_G2 = 8635972;

	//0x007DD004 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G1 = 8245252;

	//0x0083C714 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G2 = 8636180;

//-- 1. check - game mode

	const int NPC_GAME_NORMAL = 0; //When player is taking item
	const int NPC_GAME_PLUNDER = 1; //When player is looting and Npc
	const int NPC_GAME_STEAL = 2; //When player is stealing from Npc

	var int game_mode; game_mode = oCNpc_Get_Game_Mode();

	if (game_mode == NPC_GAME_PLUNDER) {
		return OpenInvType_NPC;
	};
	if (game_mode == NPC_GAME_STEAL) {
		return OpenInvType_Stealing;
	};

//-- 2. check - dialog trade

	if (MEM_InformationMan.DlgTrade) {
		var oCViewDialogTrade dlgTrade; dlgTrade = _^(MEM_InformationMan.DlgTrade);
		if (dlgTrade.isActivated) {
			return OpenInvType_Trading;
		};
	};

//-- 3. check - determine based on open inventory types

	var oCItemContainer container;

	var int itemContainer; itemContainer = 0;
	var int stealContainer; stealContainer = 0;
	var int npcContainer; npcContainer = 0;
	var int playerInventory; playerInventory = 0;

	var zCList list;
	var int ptr; ptr = MEMINT_SwitchG1G2(s_openContainers_G1, s_openContainers_G2);

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			container = _^ (ptr);

			if (container.inventory2_vtbl == MEMINT_SwitchG1G2(oCItemContainer_vtbl_G1, oCItemContainer_vtbl_G2)) { itemContainer = 1; };
			if (container.inventory2_vtbl == MEMINT_SwitchG1G2(oCStealContainer_vtbl_G1, oCStealContainer_vtbl_G2)) { stealContainer = 1; };
			if (container.inventory2_vtbl == MEMINT_SwitchG1G2(oCNpcContainer_vtbl_G1, oCStealContainer_vtbl_G2)) { npcContainer = 1; };
			if (container.inventory2_vtbl == MEMINT_SwitchG1G2(oCNpcInventory_vtbl_G1, oCNpcInventory_vtbl_G2)) { playerInventory = 1; };
		};

		ptr = list.next;
	end;

//-- TODO: check if this works with G2A
	//With G2A we can probably use inventory2_oCItemContainer_invMode? For now this logic seems to be good enough :)

	//Players inventory
	if ((playerInventory) && (!itemContainer) && (!stealContainer) && (!npcContainer)) { return OpenInvType_Player; };

	//Looting NPC
	if ((playerInventory) && (!itemContainer) && (!stealContainer) && (npcContainer)) { return OpenInvType_NPC; };

	//Looting chest
	if ((playerInventory) && (itemContainer) && (!stealContainer) && (!npcContainer)) { return OpenInvType_Chest; };

	//Trading inventory
	if ((playerInventory) && (itemContainer) && (stealContainer) && (!npcContainer)) { return OpenInvType_Trading; };

	//Stealing
	if ((playerInventory) && (!itemContainer) && (stealContainer) && (!npcContainer)) { return OpenInvType_Stealing; };

	return OpenInvType_None;
};

func int Hlp_Trade_GetInventoryNpcContainer () {
	if (!MEM_InformationMan.DlgTrade) { return 0; };

	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	if (dialogTrade.dlgInventoryNpc) {
		var oCViewDialogStealContainer dialogStealContainer;
		dialogStealContainer = _^ (dialogTrade.dlgInventoryNpc);

		//oCStealContainer
		if (dialogStealContainer.stealContainer) {
			return dialogStealContainer.stealContainer;
		};
	};

	return 0;
};

func int Hlp_Trade_GetContainerNpcContainer () {
	//G2A does not have containers!
	if (MEMINT_SwitchG1G2 (0, 1)) { return 0; };

	if (!MEM_InformationMan.DlgTrade) { return 0; };

	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	//G2A class oCViewDialogTrade does not have property dlgContainerNpc
	//Therefore we cannot use it directly, but we have to use offset instead
	//var int dlgContainerNpc; //oCViewDialogItemContainer* // sizeof 04h offset FCh

	var int itemContainerPtr; itemContainerPtr = MEM_ReadInt (_@ (dialogTrade) + 252);

//	if (dialogTrade.dlgContainerNpc) {
	if (itemContainerPtr) {
		var oCViewDialogItemContainer dialogItemContainer;
		//dialogItemContainer = _^ (dialogTrade.dlgContainerNpc);
		dialogItemContainer = _^ (itemContainerPtr);

		//oCItemContainer
		if (dialogItemContainer.itemContainer) {
			return dialogItemContainer.itemContainer;
		};
	};

	return 0;
};

func int Hlp_Trade_GetContainerPlayerContainer () {
	//G2A does not have containers!
	if (MEMINT_SwitchG1G2 (0, 1)) { return 0; };

	if (!MEM_InformationMan.DlgTrade) { return 0; };

	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	//G2A class oCViewDialogTrade does not have property dlgContainerPlayer
	//Therefore we cannot use it directly, but we have to use offset instead
	//var int dlgContainerPlayer; //oCViewDialogItemContainer* // sizeof 04h offset 104h

	var int itemContainerPtr; itemContainerPtr = MEM_ReadInt (_@ (dialogTrade) + 260);

	//if (dialogTrade.dlgContainerPlayer) {
	if (itemContainerPtr) {
		var oCViewDialogItemContainer dialogItemContainer;
		//dialogItemContainer = _^ (dialogTrade.dlgContainerPlayer);
		dialogItemContainer = _^ (itemContainerPtr);

		//oCItemContainer
		if (dialogItemContainer.itemContainer) {
			return dialogItemContainer.itemContainer;
		};
	};

	return 0;
};

func int Hlp_Trade_GetInventoryPlayerContainer () {
	if (!MEM_InformationMan.DlgTrade) { return 0; };

	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	if (dialogTrade.dlgInventoryPlayer) {
		var oCViewDialogInventory dialogInventory;
		dialogInventory = _^ (dialogTrade.dlgInventoryPlayer);

		//oCNpcInventory
		if (dialogInventory.inventory) {
			return dialogInventory.inventory;
		};
	};

	return 0;
};

/*
 *	Returns pointer to active oCItemContainer
 */
/*
Not required ... we can get same result using Hlp_GetActiveOpenInvContainer
func int Hlp_Trade_GetActiveTradeContainer () {
	if (!MEM_InformationMan.DlgTrade) { return 0; };

	var oCViewDialogTrade dialogTrade;
	dialogTrade = _^ (MEM_InformationMan.DlgTrade);

	if (dialogTrade.sectionTrade == TRADE_SECTION_LEFT_INVENTORY_G1) {
		return +Hlp_Trade_GetInventoryNpcContainer ();
	} else
	if (dialogTrade.sectionTrade == TRADE_SECTION_LEFT_CONTAINER_G1) {
		return +Hlp_Trade_GetContainerNpcContainer ();
	} else
	if (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_CONTAINER_G1) {
		return +Hlp_Trade_GetContainerPlayerContainer ();
	} else
	if (dialogTrade.sectionTrade == TRADE_SECTION_RIGHT_INVENTORY_G1) {
		return +Hlp_Trade_GetInventoryPlayerContainer ();
	};

	return 0;
};
*/

/*
 *	Returns pointer to active oCItemContainer
 */
func int Hlp_GetActiveOpenInvContainer () {
	//0x008DA998 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G1 = 9283992;

	//0x00AB0FD4 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G2 = 11210708;

	var oCItemContainer container;

	var int ptr; ptr = MEMINT_SwitchG1G2(s_openContainers_G1, s_openContainers_G2);

	var zCList list;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			container = _^ (ptr);

			if (container.inventory2_oCItemContainer_frame) {
				return ptr;
			};
		};

		ptr = list.next;
	end;

	return 0;
};

/*
 *	Returns pointer to open containers
 */
func int Hlp_GetOpenContainer (var int vtbl) {
	//0x008DA998 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G1 = 9283992;

	//0x00AB0FD4 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G2 = 11210708;

	var oCItemContainer container;

	var int ptr; ptr = MEMINT_SwitchG1G2(s_openContainers_G1, s_openContainers_G2);

	var zCList list;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			container = _^ (ptr);
			if (container.inventory2_vtbl == vtbl) {
				return ptr;
			};
		};

		ptr = list.next;
	end;

	return 0;
};

func int Hlp_GetOpenContainer_oCItemContainer () {
	//0x007DCDFC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G1 = 8244732;

	//0x0083C4AC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G2 = 8635564;

	return +Hlp_GetOpenContainer(MEMINT_SwitchG1G2(oCItemContainer_vtbl_G1, oCItemContainer_vtbl_G2));
};

func int Hlp_GetOpenContainer_oCStealContainer () {
	//0x007DCEA4 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G1 = 8244900;

	//0x0083C574 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G2 = 8635764;

	return +Hlp_GetOpenContainer(MEMINT_SwitchG1G2(oCStealContainer_vtbl_G1, oCStealContainer_vtbl_G2));
};

func int Hlp_GetOpenContainer_oCNpcContainer () {
	//0x007DCF54 const oCNpcContainer::`vftable'
	const int oCNpcContainer_vtbl_G1 = 8245076;

	//0x0083C644 const oCNpcContainer::`vftable'
	const int oCNpcContainer_vtbl_G2 = 8635972;

	return +Hlp_GetOpenContainer(MEMINT_SwitchG1G2(oCNpcContainer_vtbl_G1, oCNpcContainer_vtbl_G2));
};

func int Hlp_GetOpenContainer_oCNpcInventory () {
	//0x007DD004 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G1 = 8245252;

	//0x0083C714 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G2 = 8636180;

	return +Hlp_GetOpenContainer(MEMINT_SwitchG1G2(oCNpcInventory_vtbl_G1, oCNpcInventory_vtbl_G2));
};

//-- oCItemContainer functions

func int oCItemContainer_ActivateNextContainer (var int ptr, var int direction) {
	//0x00669980 protected: int __thiscall oCItemContainer::ActivateNextContainer(int)
	const int oCItemContainer__ActivateNextContainer_G1 = 6723968;

	//0x0070A150 protected: int __thiscall oCItemContainer::ActivateNextContainer(int)
	const int oCItemContainer__ActivateNextContainer_G2 = 7381328;

	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (direction));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__ActivateNextContainer_G1, oCItemContainer__ActivateNextContainer_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void oCItemContainer_Draw (var int ptr) {
	//0x00667660 protected: virtual void __thiscall oCItemContainer::Draw(void)
	const int oCItemContainer__Draw_G1 = 6714976;

	//0x007076B0 protected: virtual void __thiscall oCItemContainer::Draw(void)
	const int oCItemContainer__Draw_G2 = 7370416;

	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__Draw_G1, oCItemContainer__Draw_G2));
		call = CALL_End();
	};
};

func int oCItemContainer_Insert (var int ptr, var int itemPtr) {
	//0x00669250 public: virtual class oCItem * __thiscall oCItemContainer::Insert(class oCItem *)
	const int oCItemContainer__Insert_G1 = 6722128;

	//0x00709360 public: virtual class oCItem * __thiscall oCItemContainer::Insert(class oCItem *)
	const int oCItemContainer__Insert_G2 = 7377760;

	if (!itemPtr) { return 0; };
	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__Insert_G1, oCItemContainer__Insert_G2));
		call = CALL_End();
	};

	return +retVal;
};

func int oCItemContainer_IsEmpty (var int ptr) {
	//0x00669750 public: virtual int __thiscall oCItemContainer::IsEmpty(void)
	const int oCItemContainer__IsEmpty_G1 = 6723408;

	//0x00709E10 public: virtual int __thiscall oCItemContainer::IsEmpty(void)
	const int oCItemContainer__IsEmpty_G2 = 7380496;

	//Hmmm, which one makes more sense in case pointer is invalid, is empty true or false? :)
	if (!ptr) { return TRUE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__IsEmpty_G1, oCItemContainer__IsEmpty_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCItemContainer_Remove (var int ptr, var int itemPtr) {
	//0x00669320 public: virtual void __thiscall oCItemContainer::Remove(class oCItem *)
	const int oCItemContainer__Remove_G1 = 6722336;

	//0x00709430 public: virtual void __thiscall oCItemContainer::Remove(class oCItem *)
	const int oCItemContainer__Remove_G2 = 7377968;

	if (!itemPtr) { return; };
	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__Remove_G1, oCItemContainer__Remove_G2));
		call = CALL_End();
	};
};

func int oCItemContainer_RemoveByPtr (var int ptr, var int itemPtr, var int amount) {
	//0x006693C0 public: virtual class oCItem * __thiscall oCItemContainer::RemoveByPtr(class oCItem *,int)
	const int oCItemContainer__RemoveByPtr_G1 = 6722496;

	//0x007094D0 public: virtual class oCItem * __thiscall oCItemContainer::RemoveByPtr(class oCItem *,int)
	const int oCItemContainer__RemoveByPtr_G2 = 7378128;

	if (!itemPtr) { return 0; };
	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (amount));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__RemoveByPtr_G1, oCItemContainer__RemoveByPtr_G2));
		call = CALL_End();
	};

	return +retVal;
};

//Same as oCItemContainer::RemoveByPtr ?
//0x006693D0 public: virtual class oCItem * __thiscall oCItemContainer::Remove(class oCItem *,int)

func void oCItemContainer_DeleteContents (var int ptr, var int force) {
	//0x00669490 protected: virtual void __thiscall oCItemContainer::DeleteContents(void)
	const int oCItemContainer__DeleteContents_G1 = 6722704;

	//0x00709590 protected: virtual void __thiscall oCItemContainer::DeleteContents(void)
	const int oCItemContainer__DeleteContents_G2 = 7378320;

	if (!ptr) { return; };

	//only inventory2_oCItemContainer_ownList can be deleted, adding force option
	if (force) {
		var oCItemContainer itemContainer;
		itemContainer = _^ (ptr);
		itemContainer.inventory2_oCItemContainer_ownList = 1;
	};

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__DeleteContents_G1, oCItemContainer__DeleteContents_G2));
		call = CALL_End();
	};
};

func void oCItemContainer_SetContents (var int ptr, var int contents) {
	//0x00667E60 public: virtual void __thiscall oCItemContainer::SetContents(class zCListSort<class oCItem> *)
	const int oCItemContainer__SetContents_G1 = 6717024;

	//0x007084F0 public: virtual void __thiscall oCItemContainer::SetContents(class zCListSort<class oCItem> *)
	const int oCItemContainer__SetContents_G2 = 7374064;

	if (!contents) { return; };
	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (contents));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__SetContents_G1, oCItemContainer__SetContents_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func int oCItemContainer_TransferItem (var int ptr, var int dir, var int amount) {
	//0x00669780 protected: virtual int __thiscall oCItemContainer::TransferItem(int,int)
	const int oCItemContainer__TransferItem_G1 = 6723456;

	//0x00709F40 protected: virtual int __thiscall oCItemContainer::TransferItem(int,int)
	const int oCItemContainer__TransferItem_G2 = 7380800;

	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (amount));
		CALL_IntParam (_@ (dir)); //dir -1 == left, 1 == right
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__TransferItem_G1, oCItemContainer__TransferItem_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCItemContainer_Activate (var int ptr) {
	//0x00668F60 public: virtual void __thiscall oCItemContainer::Activate(void)
	const int oCItemContainer__Activate_G1 = 6721376;

	//0x00709230 public: virtual void __thiscall oCItemContainer::Activate(void)
	const int oCItemContainer__Activate_G2 = 7377456;

	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__Activate_G1, oCItemContainer__Activate_G2));
		call = CALL_End();
	};
};

func int oCItemContainer_IsActive (var int ptr) {
	//0x006665A0 public: virtual int __thiscall oCItemContainer::IsActive(void)
	const int oCItemContainer__IsActive_G1 = 6710688;

	//0x007050D0 public: virtual int __thiscall oCItemContainer::IsActive(void)
	const int oCItemContainer__IsActive_G2 = 7360720;

	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__IsActive_G1, oCItemContainer__IsActive_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCItemContainer_Close (var int ptr) {
	//0x00668C10 public: virtual void __thiscall oCItemContainer::Close(void)
	const int oCItemContainer__Close_G1 = 6720528;

	//0x00708F30 public: virtual void __thiscall oCItemContainer::Close(void)
	const int oCItemContainer__Close_G2 = 7376688;

	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__Close_G1, oCItemContainer__Close_G2));
		call = CALL_End();
	};
};

/*
 *	oCItemContainer_OpenPassive
 *	 - G1 mode - item list mode
 *	 - G2A inventory mode - INV_MODE_DEFAULT, INV_MODE_CONTAINER, INV_MODE_PLUNDER, INV_MODE_STEAL, INV_MODE_BUY, INV_MODE_SELL
 */

/*

//enum oTItemListMode { FULLSCREEN, HALFSCREEN, ONE };

enum {
	INV_MODE_DEFAULT,
	INV_MODE_CONTAINER,
	INV_MODE_PLUNDER,
	INV_MODE_STEAL,
	INV_MODE_BUY,
	INV_MODE_SELL,
	INV_MODE_MAX
};
*/
func void oCItemContainer_OpenPassive (var int ptr, var int x, var int y, var int mode) {
	//0x00668050 public: virtual void __thiscall oCItemContainer::OpenPassive(int,int,enum oCItemContainer::oTItemListMode)
	const int oCItemContainer__OpenPassive_G1 = 6717520;

	//0x007086D0 public: virtual void __thiscall oCItemContainer::OpenPassive(int,int,int)
	const int oCItemContainer__OpenPassive_G2 = 7374544;

	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (mode));
		CALL_PtrParam (_@ (y));
		CALL_PtrParam (_@ (x));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCItemContainer__OpenPassive_G1, oCItemContainer__OpenPassive_G2));
		call = CALL_End();
	};
};

//-- oCNpcContainer functions

func int oCNpcContainer_Insert (var int ptr, var int itemPtr) {
	//0x0066B2D0 public: virtual class oCItem * __thiscall oCNpcContainer::Insert(class oCItem *)
	const int oCNpcContainer__Insert_G1 = 6730448;

	//0x0070B9F0 public: virtual class oCItem * __thiscall oCNpcContainer::Insert(class oCItem *)
	const int oCNpcContainer__Insert_G2 = 7387632;

	if (!itemPtr) { return 0; };
	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCNpcContainer__Insert_G1, oCNpcContainer__Insert_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCNpcContainer_CreateList (var int ptr) {
	//0x0066AB10 public: virtual void __thiscall oCNpcContainer::CreateList(void)
	const int oCNpcContainer__CreateList_G1 = 6728464;

	//0x0070B570 public: virtual void __thiscall oCNpcContainer::CreateList(void)
	const int oCNpcContainer__CreateList_G2 = 7386480;

	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCNpcContainer__CreateList_G1, oCNpcContainer__CreateList_G2));
		call = CALL_End();
	};
};

//-- oCNpcInventory functions

func int oCNpcInventory_GetNumItemsInCategory (var int ptr, var int invCat) {
	//0x0066C4C0 public: int __thiscall oCNpcInventory::GetNumItemsInCategory(int)
	const int oCNpcInventory__GetNumItemsInCategory_G1 = 6735040;

	//0x0070C340 public: int __thiscall oCNpcInventory::GetNumItemsInCategory(void)
	const int oCNpcInventory__GetNumItemsInCategory_G2 = 7390016;

	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		if (MEMINT_SwitchG1G2 (1, 0)) {
			CALL_IntParam (_@ (invCat));
		};
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCNpcInventory__GetNumItemsInCategory_G1, oCNpcInventory__GetNumItemsInCategory_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int oCNpcInventory_GetCategory (var int ptr, var int itemPtr) {
	//0x0066C430 public: int __thiscall oCNpcInventory::GetCategory(class oCItem *)
	const int oCNpcInventory__GetCategory_G1 = 6734896;

	//0x0070C690 public: int __thiscall oCNpcInventory::GetCategory(class oCItem *)
	const int oCNpcInventory__GetCategory_G2 = 7390864;

	if (!itemPtr) { return 0; };
	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCNpcInventory__GetCategory_G1, oCNpcInventory__GetCategory_G2));
		call = CALL_End();
	};

	return +retVal;
};

func int oCNpcInventory_RemoveByPtr (var int ptr, var int itemPtr, var int amount) {
	//0x0066CF10 public: virtual class oCItem * __thiscall oCNpcInventory::RemoveByPtr(class oCItem *,int)
	const int oCNpcInventory__RemoveByPtr_G1 = 6737680;

	//0x0070CC70 public: virtual class oCItem * __thiscall oCNpcInventory::RemoveByPtr(class oCItem *,int)
	const int oCNpcInventory__RemoveByPtr_G2 = 7392368;

	if (!itemPtr) { return 0; };
	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (amount));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCNpcInventory__RemoveByPtr_G1, oCNpcInventory__RemoveByPtr_G2));
		call = CALL_End();
	};

	return +retVal;
};

func int oCNpcInventory_Insert (var int ptr, var int itemPtr) {
	//0x0066C7D0 public: virtual class oCItem * __thiscall oCNpcInventory::Insert(class oCItem *)
	const int oCNpcInventory__Insert_G1 = 6735824;

	//0x0070C730 public: virtual class oCItem * __thiscall oCNpcInventory::Insert(class oCItem *)
	const int oCNpcInventory__Insert_G2 = 7391024;

	if (!itemPtr) { return 0; };
	if (!ptr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCNpcInventory__Insert_G1, oCNpcInventory__Insert_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCNpcInventory_Close (var int npcInventoryPtr) {
	//0x0066C1E0 public: virtual void __thiscall oCNpcInventory::Close(void)
	const int oCNpcInventory__Close_G1 = 6734304;

	//0x0070C2F0 public: virtual void __thiscall oCNpcInventory::Close(void)
	const int oCNpcInventory__Close_G2 = 7389936;

	if (!npcInventoryPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (npcInventoryPtr), MEMINT_SwitchG1G2 (oCNpcInventory__Close_G1, oCNpcInventory__Close_G2));
		call = CALL_End();
	};
};

func int Npc_GetNpcInventoryPtr (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);
	return + npcInventoryPtr;
};

//G1 only
func int oCNpcInventory_SwitchToCategory (var int npcInventoryPtr, var int invCat) {
	//0x0066DE60 public: int __thiscall oCNpcInventory::SwitchToCategory(int)
	const int oCNpcInventory__SwitchToCategory_G1 = 6741600;

	//There is no G2A function
	const int oCNpcInventory__SwitchToCategory_G2 = 0;

	if (!npcInventoryPtr) { return 0; };

	//return 0 in G2A
	if (MEMINT_SwitchG1G2 (0, 1)) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (invCat));
		CALL__thiscall (_@ (npcInventoryPtr), oCNpcInventory__SwitchToCategory_G1);
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	oCNpcInventory_UnpackCategory
 *	 - in case of G2A inventory category is redundant
 */
func void oCNpcInventory_UnpackCategory (var int npcInventoryPtr, var int invCat) {
	//0x00670740 public: void __thiscall oCNpcInventory::UnpackItemsInCategory(int)
	//0x00710A20 public: void __thiscall oCNpcInventory::UnpackItemsInCategory(void)

	//0x0066FAD0 public: void __thiscall oCNpcInventory::UnpackCategory(int)
	const int oCNpcInventory__UnpackCategory_G1 = 6748880;

	//0x0070F620 public: void __thiscall oCNpcInventory::UnpackCategory(void)
	const int oCNpcInventory__UnpackCategory_G2 = 7403040;

	if (!npcInventoryPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		if (MEMINT_SwitchG1G2 (1, 0)) {
			CALL_IntParam (_@ (invCat));
		};
		CALL__thiscall (_@ (npcInventoryPtr), MEMINT_SwitchG1G2 (oCNpcInventory__UnpackCategory_G1, oCNpcInventory__UnpackCategory_G2));
		call = CALL_End();
	};
};

func void oCNpc_UnpackInventory (var int slfInstance) {
	//0x00670400 public: void __thiscall oCNpcInventory::UnpackAllItems(void)
	const int oCNpcInventory__UnpackAllItems_G1 = 6751232;

	//0x00710030 public: void __thiscall oCNpcInventory::UnpackAllItems(void)
	const int oCNpcInventory__UnpackAllItems_G2 = 7405616;

	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slfInstance);
	if (!npcInventoryPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (npcInventoryPtr), MEMINT_SwitchG1G2 (oCNpcInventory__UnpackAllItems_G1, oCNpcInventory__UnpackAllItems_G2));
		call = CALL_End();
	};
};

func void oCNpcInventory_SetOwner (var int npcInventoryPtr, var int npcPtr) {
	//0x0066C290 public: void __thiscall oCNpcInventory::SetOwner(class oCNpc *)
	const int oCNpcInventory__SetOwner_G1 = 6734480;

	//0x0070C320 public: void __thiscall oCNpcInventory::SetOwner(class oCNpc *)
	const int oCNpcInventory__SetOwner_G2 = 7389984;

	if (!npcInventoryPtr) { return; };
	if (!npcPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall (_@ (npcInventoryPtr), MEMINT_SwitchG1G2 (oCNpcInventory__SetOwner_G1, oCNpcInventory__SetOwner_G2));
		call = CALL_End();
	};
};

//0x0066C610 public: class oCItem * __thiscall oCNpcInventory::GetItem(int,int)
//0x0070C450 public: class oCItem * __thiscall oCNpcInventory::GetItem(int)

//-- oCStealContainer functions

func void oCStealContainer_CreateList (var int ptr) {
	//0x0066A5C0 public: virtual void __thiscall oCStealContainer::CreateList(void)
	const int oCStealContainer__CreateList_G1 = 6727104;

	//0x0070ADE0 public: virtual void __thiscall oCStealContainer::CreateList(void)
	const int oCStealContainer__CreateList_G2 = 7384544;

	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCStealContainer__CreateList_G1, oCStealContainer__CreateList_G2));
		call = CALL_End();
	};
};

func void oCStealContainer_SetOwner (var int stealContainerPtr, var int npcPtr) {
	//0x0066A590 public: virtual void __thiscall oCStealContainer::SetOwner(class oCNpc *)
	const int oCStealContainer__SetOwner_G1 = 6727056;

	//0x0070ADB0 public: virtual void __thiscall oCStealContainer::SetOwner(class oCNpc *)
	const int oCStealContainer__SetOwner_G2 = 7384496;

	if (!stealContainerPtr) { return; };
	if (!npcPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall (_@ (stealContainerPtr), MEMINT_SwitchG1G2 (oCStealContainer__SetOwner_G1, oCStealContainer__SetOwner_G2));
		call = CALL_End();
	};
};

//-- oCViewDialogItemContainer functions

func void oCViewDialogItemContainer_InsertItem (var int ptr, var int itemPtr) {
	//0x007276C0 public: void __fastcall oCViewDialogItemContainer::InsertItem(class oCItem *)
	const int oCViewDialogItemContainer__InsertItem_G1 = 7501504;

	//0x00689C00 public: void __fastcall oCViewDialogItemContainer::InsertItem(class oCItem *)
	const int oCViewDialogItemContainer__InsertItem_G2 = 6855680;

	if (!itemPtr) { return; };
	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(ptr), _@(itemPtr), MEMINT_SwitchG1G2 (oCViewDialogItemContainer__InsertItem_G1, oCViewDialogItemContainer__InsertItem_G2));
		call = CALL_End();
	};
};

func int oCViewDialogItemContainer_RemoveSelectedItem (var int ptr) {
	//0x007275E0 public: class oCItem * __fastcall oCViewDialogItemContainer::RemoveSelectedItem(void)
	const int oCViewDialogItemContainer__RemoveSelectedItem_G1 = 7501280;

	//0x00689B90 public: class oCItem * __fastcall oCViewDialogItemContainer::RemoveSelectedItem(void)
	const int oCViewDialogItemContainer__RemoveSelectedItem_G2 = 6855568;

	if (!ptr) { return 0; };

	const int null = 0;
	const int call = 0;

	var int retVal;

	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__fastcall(_@(ptr), _@(null), MEMINT_SwitchG1G2 (oCViewDialogItemContainer__RemoveSelectedItem_G1, oCViewDialogItemContainer__RemoveSelectedItem_G2));
		call = CALL_End();
	};

	return +retVal;
};


func void oCViewDialogItemContainer_UpdateValue (var int ptr) {
	//0x00727900 protected: void __fastcall oCViewDialogItemContainer::UpdateValue(void)
	const int oCViewDialogItemContainer__UpdateValue_G1 = 7502080;

	//0x00689D10 protected: void __fastcall oCViewDialogItemContainer::UpdateValue(void)
	const int oCViewDialogItemContainer__UpdateValue_G2 = 6855952;

	if (!ptr) { return; };

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(ptr), _@(null), MEMINT_SwitchG1G2 (oCViewDialogItemContainer__UpdateValue_G1, oCViewDialogItemContainer__UpdateValue_G2));
		call = CALL_End();
	};
};

//-- oCViewDialogInventory functions

func int oCViewDialogInventory_RemoveSelectedItem (var int ptr) {
	//0x00726B50 public: class oCItem * __fastcall oCViewDialogInventory::RemoveSelectedItem(void)
	const int oCViewDialogInventory__RemoveSelectedItem_G1 = 7498576;

	//0x00689150 public: class oCItem * __fastcall oCViewDialogInventory::RemoveSelectedItem(void)
	const int oCViewDialogInventory__RemoveSelectedItem_G2 = 6852944;

	if (!ptr) { return 0; };

	var int retVal;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__fastcall(_@(ptr), _@(null), MEMINT_SwitchG1G2 (oCViewDialogInventory__RemoveSelectedItem_G1, oCViewDialogInventory__RemoveSelectedItem_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCViewDialogInventory_InsertItem (var int ptr, var int itemPtr) {
	//0x00726BE0 public: void __fastcall oCViewDialogInventory::InsertItem(class oCItem *)
	const int oCViewDialogInventory__InsertItem_G1 = 7498720;

	//0x006891E0 public: void __fastcall oCViewDialogInventory::InsertItem(class oCItem *)
	const int oCViewDialogInventory__InsertItem_G2 = 6853088;

	if (!itemPtr) { return; };
	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(ptr), _@(itemPtr), MEMINT_SwitchG1G2 (oCViewDialogInventory__InsertItem_G1, oCViewDialogInventory__InsertItem_G2));
		call = CALL_End();
	};
};

//-- oCViewDialogStealContainer functions

func void oCViewDialogStealContainer_InsertItem (var int ptr, var int itemPtr) {
	//0x00728130 public: void __fastcall oCViewDialogStealContainer::InsertItem(class oCItem *)
	const int oCViewDialogStealContainer__InsertItem_G1 = 7504176;

	//0x0068A500 public: void __fastcall oCViewDialogStealContainer::InsertItem(class oCItem *)
	const int oCViewDialogStealContainer__InsertItem_G2 = 6857984;

	if (!itemPtr) { return; };
	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(ptr), _@(itemPtr), MEMINT_SwitchG1G2 (oCViewDialogStealContainer__InsertItem_G1, oCViewDialogStealContainer__InsertItem_G2));
		call = CALL_End();
	};
};

func void oCViewDialogStealContainer_RemoveItem (var int ptr, var int itemPtr) {
	//0x007281F0 protected: void __fastcall oCViewDialogStealContainer::RemoveItem(class oCItem *)
	const int oCViewDialogStealContainer__RemoveItem_G1 = 7504368;

	//0x0068A550 protected: void __fastcall oCViewDialogStealContainer::RemoveItem(class oCItem *)
	const int oCViewDialogStealContainer__RemoveItem_G2 = 6858064;

	if (!itemPtr) { return; };
	if (!ptr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(ptr), _@(itemPtr), MEMINT_SwitchG1G2 (oCViewDialogStealContainer__RemoveItem_G1, oCViewDialogStealContainer__RemoveItem_G2));
		call = CALL_End();
	};
};

func int oCViewDialogStealContainer_RemoveSelectedItem (var int ptr) {
	//0x00728010 public: class oCItem * __fastcall oCViewDialogStealContainer::RemoveSelectedItem(void)
	const int oCViewDialogStealContainer__RemoveSelectedItem_G1 = 7503888;

	//0x0068A440 public: class oCItem * __fastcall oCViewDialogStealContainer::RemoveSelectedItem(void)
	const int oCViewDialogStealContainer__RemoveSelectedItem_G2 = 6857792;

	if (!ptr) { return 0; };

	const int null = 0;
	const int call = 0;

	var int retVal;

	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__fastcall(_@(ptr), _@(null), MEMINT_SwitchG1G2 (oCViewDialogStealContainer__RemoveSelectedItem_G1, oCViewDialogStealContainer__RemoveSelectedItem_G2));
		call = CALL_End();
	};

	return +retVal;
};

//-- oCViewDialogTrade functions

func int oCViewDialogTrade_OnTransferLeft (var int ptr, var int amount) {
	//0x0072A2B0 protected: int __fastcall oCViewDialogTrade::OnTransferLeft(int)
	const int oCViewDialogTrade__OnTransferLeft_G1 = 7512752;

	//0x0068B840 protected: int __fastcall oCViewDialogTrade::OnTransferLeft(short)
	const int oCViewDialogTrade__OnTransferLeft_G2 = 6862912;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__fastcall(_@(ptr), _@(amount), MEMINT_SwitchG1G2 (oCViewDialogTrade__OnTransferLeft_G1, oCViewDialogTrade__OnTransferLeft_G2));
		call = CALL_End();
	};

	return +retVal;
};

func int oCViewDialogTrade_OnTransferRight (var int ptr, var int amount) {
	//0x0072A530 protected: int __fastcall oCViewDialogTrade::OnTransferRight(int)
	const int oCViewDialogTrade__OnTransferRight_G1 = 7513392;

	//0x0068BB10 protected: int __fastcall oCViewDialogTrade::OnTransferRight(short)
	const int oCViewDialogTrade__OnTransferRight_G2 = 6863632;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__fastcall(_@(ptr), _@(amount), MEMINT_SwitchG1G2 (oCViewDialogTrade__OnTransferRight_G1, oCViewDialogTrade__OnTransferRight_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	Removes from NPC inventory item with specified qty and returns pointer to removed item
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 *		qty			quantity
 */
func int oCNpc_RemoveFromInvByPtr (var int slfInstance, var int itemPtr, var int qty) {
	//0x006A5260 public: class oCItem * __thiscall oCNpc::RemoveFromInv(class oCItem *,int)
	const int oCNpc__RemoveFromInv_G1 = 6967904;

	//0x007495A0 public: class oCItem * __thiscall oCNpc::RemoveFromInv(class oCItem *,int)
	const int oCNpc__RemoveFromInv_G2 = 7640480;

	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (qty));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__RemoveFromInv_G1, oCNpc__RemoveFromInv_G2));

		call = CALL_End();
	};

	return +retVal;
};

/*
 *	Puts item to NPC's inventory
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 */
func int oCNpc_PutInInvPtr (var int slfInstance, var int itemPtr) {
	//0x006A4FF0 public: class oCItem * __thiscall oCNpc::PutInInv(class oCItem *)
	const int oCNpc__PutInInv_G1 = 6967280;

	//0x00749350 public: class oCItem * __thiscall oCNpc::PutInInv(class oCItem *)
	const int oCNpc__PutInInv_G2 = 7639888;

	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__PutInInv_G1, oCNpc__PutInInv_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	Equips item by item pointer
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 */
func void oCNPC_EquipPtr (var int slfInstance, var int itemPtr) {
	//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
	const int oCNPC__Equip_G1 = 6908144;

	//0x00739C90 public: void __thiscall oCNpc::Equip(class oCItem *)
	const int oCNPC__Equip_G2 = 7576720;

	if (!itemPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__Equip_G1, oCNPC__Equip_G2));
		call = CALL_End();
	};
};

/*
 *	Unequips item by item pointer
 *		slfInstance		NPC instance
 *		itemPtr			item pointer
 */
func void oCNPC_UnequipItemPtr (var int slfInstance, var int itemPtr){
	//0x0068FBC0 public: void __thiscall oCNpc::UnequipItem(class oCItem *)
	const int oCNPC__UnequipItem_G1 = 6880192;

	//0x007326C0 public: void __thiscall oCNPC::UnequipItem(class oCItem *)
	const int oCNPC__UnequipItem_G2 = 7546560;

	if (!itemPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__UnequipItem_G1, oCNPC__UnequipItem_G2));
		call = CALL_End();
	};
};

/*
 *	Returns pointer to currently drawn weapon (weapon in hand)
 *		slfInstance		NPC instance
 */
func int oCNpc_GetWeapon (var int slfInstance) {
	//0x006943F0 public: class oCItem * __thiscall oCNpc::GetWeapon(void)
	const int oCNpc__GetWeapon_G1 = 6898672;

	//0x007377A0 public: class oCItem * __thiscall oCNpc::GetWeapon(void)
	const int oCNpc__GetWeapon_G2 = 7567264;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetWeapon_G1, oCNpc__GetWeapon_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Gets pointer of equipped melee weapon
 *    		npcInstance		NPC instance
 */
func int oCNpc_GetEquippedMeleeWeapon (var int slfInstance) {
	//0x00694580 public: class oCItem * __thiscall oCNpc::GetEquippedMeleeWeapon(void)
	const int oCNpc__GetEquippedMeleeWeapon_G1 = 6899072;

	//0x00737930 public: class oCItem * __thiscall oCNpc::GetEquippedMeleeWeapon(void)
	const int oCNpc__GetEquippedMeleeWeapon_G2 = 7567664;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetEquippedMeleeWeapon_G1, oCNpc__GetEquippedMeleeWeapon_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int oCNpc_GetEquippedRangedWeapon (var int slfInstance) {
	//0x00694690 public: class oCItem * __thiscall oCNpc::GetEquippedRangedWeapon(void)
	const int oCNpc__GetEquippedRangedWeapon_G1 = 6899344;

	//0x00737A40 public: class oCItem * __thiscall oCNpc::GetEquippedRangedWeapon(void)
	const int oCNpc__GetEquippedRangedWeapon_G2 = 7567936;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetEquippedRangedWeapon_G1, oCNpc__GetEquippedRangedWeapon_G2));
		call = CALL_End();
	};

	return + retVal;
};

//Same as oCNpc_GetSlotItem (slfInstance, NPC_NODE_TORSO);
func int oCNpc_GetEquippedArmor (var int slfInstance) {
	//0x006947A0 public: class oCItem * __thiscall oCNpc::GetEquippedArmor(void)
	const int oCNpc__GetEquippedArmor_G1 = 6899616;

	//0x00737B50 public: class oCItem * __thiscall oCNpc::GetEquippedArmor(void)
	const int oCNpc__GetEquippedArmor_G2 = 7568208;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetEquippedArmor_G1, oCNpc__GetEquippedArmor_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int Npc_HasItemInAnySlot (var int slfInstance, var int itemInstanceID) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (!Npc_GetInvItem (slf, itemInstanceID)) { return FALSE; };

	repeat (i, slf.invSlot_numInArray); var int i;
		var int slotPtr; slotPtr = MEM_ReadIntArray (slf.invSlot_array, i);

		if (slotPtr) {
			var TNpcSlot slot; slot = _^ (slotPtr);
			if (slot.vob == _@ (item)) {
				return TRUE;
			};
		};
	end;

	return FALSE;
};

/*
 *	TODO: test this one
 *    		npcInstance		NPC instance
 *    		itemPtr			item pointer?
 *    		qty			qty?
 */
func int oCNpc_PutInInvPtrAmount (var int npcInstance, var int itemPtr, var int qty){
	//0x006A5180 public: class oCItem * __thiscall oCNpc::PutInInv(int,int)
	const int oCNpc__PutInInv_G1 = 6967680;

	//0x007494C0 public: class oCItem * __thiscall oCNpc::PutInInv(int,int)
	const int oCNpc__PutInInv_G2 = 7640256;

	if (!itemPtr) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (qty));
		CALL_IntParam (_@ (itemPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__PutInInv_G1, oCNpc__PutInInv_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	Function returns pointer to item in inventory
 *    		npcInstance		NPC instance
 *    		itemInstance		item instance
 *    		qty			qty?
 */
func int oCNpc_GetFromInv (var int slfInstance, var int itemInstance, var int qty) {
	//0x006A4E20 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	const int oCNpc__GetFromInv_G1 = 6966816;

	//0x00749180 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	const int oCNpc__GetFromInv_G2 = 7639424;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (qty));
		CALL_IntParam (_@ (itemInstance));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetFromInv_G1, oCNpc__GetFromInv_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	LeGo version does not return pointer in G2A :-/
 */
func int oCNpc_RemoveFromSlot_Fixed (var int slfInstance, var string slotName, var int dropIt, var int killEffect) {
	//0x006A5E80 public: class oCVob * __thiscall oCNpc::RemoveFromSlot(class zSTRING const &,int)
	const int oCNpc__RemoveFromSlot_G1 = 6971008;

	//0x0074A270 public: class oCVob * __thiscall oCNpc::RemoveFromSlot(class zSTRING const &,int,int)
	const int oCNpc__RemoveFromSlot_G2 = 7643760;

	//0x006A5F50 public: class oCVob * __thiscall oCNpc::RemoveFromSlot(struct TNpcSlot *,int)
	//0x0074A340 public: class oCVob * __thiscall oCNpc::RemoveFromSlot(struct TNpcSlot *,int,int)

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//killEffect parameter is valid only for G2A
	if (MEMINT_SwitchG1G2 (0, 1)) {
		CALL_IntParam (killEffect);
	};

	CALL_IntParam (dropIt);
	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__RemoveFromSlot_G1, oCNpc__RemoveFromSlot_G2));

	return CALL_RetValAsPtr ();
};

func int oCNpc_GetInvSlot (var int slfInstance, var string slotName) {
	//0x006A5770 public: struct TNpcSlot * __thiscall oCNpc::GetInvSlot(class zSTRING const &)
	const int oCNpc__GetInvSlot_G1 = 6969200;

	//0x00749AE0 public: struct TNpcSlot * __thiscall oCNpc::GetInvSlot(class zSTRING const &)
	const int oCNpc__GetInvSlot_G2 = 7641824;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__GetInvSlot_G1, oCNpc__GetInvSlot_G2));

	return CALL_RetValAsPtr ();
};

func void oCNpc_CreateInvSlot (var int slfInstance, var string slotName) {
	//0x006A5480 public: void __thiscall oCNpc::CreateInvSlot(class zSTRING const &)
	const int oCNpc__CreateInvSlot_G1 = 6968448;

	//0x00749800 public: void __thiscall oCNpc::CreateInvSlot(class zSTRING const &)
	const int oCNpc__CreateInvSlot_G2 = 7641088;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__CreateInvSlot_G1, oCNpc__CreateInvSlot_G2));
};

func void oCNpc_DeleteInvSlot (var int slfInstance, var string slotName) {
	//0x007499E0 public: void __thiscall oCNpc::DeleteInvSlot(class zSTRING const &)
	const int oCNpc__DeleteInvSlot_G1 = 7641568;

	//0x006A5670 public: void __thiscall oCNpc::DeleteInvSlot(class zSTRING const &)
	const int oCNpc__DeleteInvSlot_G2 = 6968944;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	CALL_zStringPtrParam (slotName);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__DeleteInvSlot_G1, oCNpc__DeleteInvSlot_G2));
};

/*
 *	NPC_CreateInvSlot
 *	 - wrapper function that will create inventory slot (if it does not exist already, oCNpc_CreateInvSlot would not check if it exitst)
 */
func void NPC_CreateInvSlot (var int slfInstance, var string slotName) {
	if (!oCNpc_GetInvSlot (slfInstance, slotName)) {
		oCNpc_CreateInvSlot (slfInstance, slotName);
	};
};

/*
 *	Returns pointer to specific item instance in NPC's inventory
 *		slfInstance		NPC instance
 *		invCat			inventory category
 *		itemInstance		item instance
 */
func int NPC_GetItemPtrByInstance (var int slfInstance, var int invCat, var int itemInstance){
	if (invCat < 0) || (invCat >= INV_CAT_MAX) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slf);

	var oCItem itm;
	var zCListSort list;

	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		/*
		if (invCat == INV_WEAPON)	{ ptr = slf.inventory2_inventory1_next; } else
		if (invCat == INV_ARMOR)	{ ptr = slf.inventory2_inventory2_next; } else
		if (invCat == INV_RUNE)		{ ptr = slf.inventory2_inventory3_next; } else
		if (invCat == INV_MAGIC)	{ ptr = slf.inventory2_inventory4_next; } else
		if (invCat == INV_FOOD)		{ ptr = slf.inventory2_inventory5_next; } else
		if (invCat == INV_POTION)	{ ptr = slf.inventory2_inventory6_next; } else
		if (invCat == INV_DOC)		{ ptr = slf.inventory2_inventory7_next; } else
		if (invCat == INV_MISC)		{ ptr = slf.inventory2_inventory8_next; };
		*/

		/*
		G1 oCNPC - inventory offset
			var int    inventory2_inventory0_next;		// 0x05F8 zCListSort<oCItem>*
			var int    inventory2_inventory1_next;		// 0x0604 zCListSort<oCItem>*
			var int    inventory2_inventory2_next;		// 0x0610 zCListSort<oCItem>*
			var int    inventory2_inventory3_next;		// 0x061C zCListSort<oCItem>*
			var int    inventory2_inventory4_next;		// 0x0628 zCListSort<oCItem>*
			var int    inventory2_inventory5_next;		// 0x0634 zCListSort<oCItem>*
			var int    inventory2_inventory6_next;		// 0x0640 zCListSort<oCItem>*
			var int    inventory2_inventory7_next;		// 0x064C zCListSort<oCItem>*
			var int    inventory2_inventory8_next;		// 0x0658 zCListSort<oCItem>*
		*/
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
	} else {
		/*
		G2A oCNPC - inventory offset
			var int    inventory2_inventory_next;		// 0x0718 zCListSort<oCItem>*
		*/
		//G2A has single inventory
		offset = 1816;
	};

	oCNpcInventory_UnpackCategory (npcInventoryPtr, invCat);

	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

	while (ptr);
		list = _^ (ptr);

		if (list.data) {
			itm = _^ (list.data);
			if (Hlp_GetInstanceID (itm) == itemInstance) {
				return list.data;
			};
		};

		ptr = list.next;
	end;

	return 0;
};

/*
 *	Returns number of items in inventory by item instance name
 *		slfInstance		NPC instance
 *		instanceName		item instance name
 */
func int NPC_HasItemInstanceName (var int slfInstance, var string instanceName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int symbID; symbID = MEM_GetSymbolIndex (instanceName);
	if (symbID > 0) && (symbID < currSymbolTableLength) {
		//if (NPC_GetInventoryItem (slf, symbID))
		if (NPC_GetInvItem (slf, symbID)) {
			return (NPC_HasItems (slf, Hlp_GetInstanceID (item)));
		};
	};

	return 0;
};

func int Npc_ItemGetCategory (var int slfInstance, var int itemPtr) {
	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slfInstance);
	return + oCNpcInventory_GetCategory (npcInventoryPtr, itemPtr);
};

func void NPC_RemoveInventoryCategory (var int slfInstance, var int invCat, var int flagsKeepItems, var int mainFlagsKeepItems) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int armorItemID; armorItemID = Npc_GetArmor (slf);

	var int itmSlot; itmSlot = 0;
	var int amount; amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);

	var int itemInstanceID;

	while (amount > 0);

		//Fix logic for G2 NoTR (credits: Neocromicon & Damianut)
		//G2 does not have separate inventories for items - NPC_GetInvItemBySlot goes through whole inventory
		//we have to check invCat one more time here!
		if (invCat > 0) {
			if (Npc_ItemGetCategory(slfInstance, _@(item)) != invCat) {
				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};
		};

		itemInstanceID = Hlp_GetInstanceID (item);

		//Do we want to remove this item?
		//(do not remove equipped armor)
		if (item.flags & flagsKeepItems) {
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
			continue;
		};

		if (item.MainFlag & mainFlagsKeepItems) {
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
			continue;
		};

		if (invCat == INV_ARMOR) {
			if ((armorItemID == itemInstanceID) && (item.Flags & ITEM_ACTIVE_LEGO)) {
				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};
		};

		oCNPC_UnequipItemPtr (slf, _@ (item));

		if (amount == 1) {
			NPC_RemoveInvItem (slf, itemInstanceID);
		} else {
			NPC_RemoveInvItems (slf, itemInstanceID, amount);
		};

		amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
	end;
};

func void NPC_RemoveInventory (var int slfInstance, var int flagsKeepItems, var int mainFlagsKeepItems) {
	//G1
	if (MEMINT_SwitchG1G2 (1, 0)) {
		NPC_RemoveInventoryCategory (slfInstance, INV_WEAPON, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_ARMOR, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_RUNE, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_MAGIC, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_FOOD, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_POTION, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_DOC, flagsKeepItems, mainFlagsKeepItems);
		NPC_RemoveInventoryCategory (slfInstance, INV_MISC, flagsKeepItems, mainFlagsKeepItems);
	} else {
	//G2A
		NPC_RemoveInventoryCategory (slfInstance, 0, flagsKeepItems, mainFlagsKeepItems);
	};
};

var int _NpcTransferItem_Event;
var int _NpcTransferItem_Event_Enabled;

var int _NpcTransferItem_FromNpcPtr;
var int _NpcTransferItem_ToNpcPtr;

func void NpcTransferItemEvent_Init () {
	if (!_NpcTransferItem_Event) {
		_NpcTransferItem_Event = Event_Create ();
	};
};

func void NpcTransferItemEvent_AddListener (var func f) {
	Event_AddOnce (_NpcTransferItem_Event, f);
};

func void NpcTransferItemEvent_RemoveListener (var func f) {
	Event_Remove (_NpcTransferItem_Event, f);
};

func void NPC_TransferInventoryCategory (var int slfInstance, var int othInstance, var int invCat, var int transferEquippedArmor, var int transferEquippedItems, var int transferMissionItems) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var C_NPC oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return; };

	_NpcTransferItem_FromNpcPtr = _@ (slf);
	_NpcTransferItem_ToNpcPtr = _@ (oth);

	var int armorItemID; armorItemID = Npc_GetArmor (slf);

	var int itmSlot; itmSlot = 0;
	var int amount; amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);

	var int itemInstanceID;

	while (amount > 0);
		//Fix logic for G2 NoTR (credits: Neocromicon & Damianut)
		//G2 does not have separate inventories for items - NPC_GetInvItemBySlot goes through whole inventory
		//we have to check invCat one more time here!
		if (invCat > 0) {
			if (Npc_ItemGetCategory(slfInstance, _@(item)) != invCat) {
				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};
		};

		itemInstanceID = Hlp_GetInstanceID (item);

		//Ignore equipped armor
		if (invCat == INV_ARMOR) {
			if ((!transferEquippedArmor) && (armorItemID == itemInstanceID) && (item.Flags & ITEM_ACTIVE_LEGO))
			{
				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};
		};

		//Ignore equipped items
		if ((!transferEquippedItems) && (item.Flags & ITEM_ACTIVE_LEGO))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
			continue;
		};

		//Ignore mission items
		if ((!transferMissionItems) && (item.Flags & ITEM_MISSION))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
			continue;
		};

		//Custom prints for transferred items
		if ((_NpcTransferItem_Event) && (_NpcTransferItem_Event_Enabled)) {
			Event_Execute (_NpcTransferItem_Event, _@ (item));
		};

		if (amount == 1) {
			CreateInvItem (oth, itemInstanceID);
			NPC_RemoveInvItem (slf, itemInstanceID);
		} else {
			CreateInvItems (oth, itemInstanceID, amount);
			NPC_RemoveInvItems (slf, itemInstanceID, amount);
		};

		amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
	end;
};

func void NPC_TransferInventory (var int slfInstance, var int othInstance, var int transferEquippedArmor, var int transferEquippedItems, var int transferMissionItems) {
	//G1
	if (MEMINT_SwitchG1G2 (1, 0)) {
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_WEAPON, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_ARMOR, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_RUNE, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_MAGIC, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_FOOD, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_POTION, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_DOC, transferEquippedArmor, transferEquippedItems, transferMissionItems);
		NPC_TransferInventoryCategory (slfInstance, othInstance, INV_MISC, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	} else {
	//G2A
		NPC_TransferInventoryCategory (slfInstance, othInstance, 0, transferEquippedArmor, transferEquippedItems, transferMissionItems);
	};
};

func void NPC_UnEquipInventoryCategory (var int slfinstance, var int invCat) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int amount;
	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);

	//Loop
	while (amount > 0);
		//Fix logic for G2 NoTR (credits: Neocromicon & Damianut)
		//G2 does not have separate inventories for items - NPC_GetInvItemBySlot goes through whole inventory
		//we have to check invCat one more time here!
		if (invCat > 0) {
			if (Npc_ItemGetCategory(slfInstance, _@(item)) != invCat) {
				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};
		};

		oCNPC_UnequipItemPtr (slf, _@ (item));

		itmSlot = itmSlot + 1;
		amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
	end;
};

func void NPC_UnEquipInventory (var int slfinstance) {
	//G1
	if (MEMINT_SwitchG1G2 (1, 0)) {
		NPC_UnEquipInventoryCategory (slfinstance, INV_WEAPON);
		NPC_UnEquipInventoryCategory (slfinstance, INV_ARMOR);
		NPC_UnEquipInventoryCategory (slfinstance, INV_RUNE);
		NPC_UnEquipInventoryCategory (slfinstance, INV_MAGIC);
		NPC_UnEquipInventoryCategory (slfinstance, INV_FOOD);
		NPC_UnEquipInventoryCategory (slfinstance, INV_POTION);
		NPC_UnEquipInventoryCategory (slfinstance, INV_DOC);
		NPC_UnEquipInventoryCategory (slfinstance, INV_MISC);
	} else {
	//G2A
		NPC_UnEquipInventoryCategory (slfinstance, 0);
	};
};

/*
 *	NPC_InventoryIsEmpty
 *	 - function checks whether inventory is empty
 */
func int NPC_InventoryIsEmpty (var int slfInstance, var int ignoreFlags, var int ignoreMainFlags, var int ignoreEquippedArmor) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slf);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	/*
	var int armorItemID; armorItemID = -1;
    if (Npc_HasEquippedArmor(slf)) {
		var C_ITEM armorItem; armorItem = Npc_GetEquippedArmor(slf);
		armorItemID = Hlp_GetInstanceID(armorItem);
	};
	*/
	var int armorItemID; armorItemID = Npc_GetArmor(slf);

	oCNpc_UnpackInventory(slf);

	repeat (invCat, noOfCategories); var int invCat;
		ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

		while (ptr);
			list = _^ (ptr);

			if (list.data) {
				itm = _^ (list.data);
				if (itm.flags & ignoreFlags) {
					ptr = list.next;
					continue;
				};

				if (itm.mainFlag & ignoreMainFlags) {
					ptr = list.next;
					continue;
				};

				if (invCat == INV_ARMOR) {
					if ((armorItemID == Hlp_GetInstanceID (itm)) && (ignoreEquippedArmor) && (itm.Flags & ITEM_ACTIVE_LEGO)) {
						ptr = list.next;
						continue;
					};
				};

				return FALSE;
			};

			ptr = list.next;
		end;
	end;

	return TRUE;
};

/*
 *	NPC_HasMissionItem
 *	 - checks whether NPC has any mission items
 *	 - adding here as an alternative, because we are replacing engine version of function oCNpc::HasMissionItem!
 */
func int NPC_HasMissionItem (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slf);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	repeat (invCat, noOfCategories); var int invCat;
		oCNpcInventory_UnpackCategory (npcInventoryPtr, invCat);
		ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

		while (ptr);
			list = _^ (ptr);

			if (list.data) {
				itm = _^ (list.data);
				if (itm.mainflag & ITEM_MISSION) {
					return TRUE;
				};
			};

			ptr = list.next;
		end;
	end;

	return FALSE;
};

/*
 *	Function unequips melee weapon
 */
func void Npc_UnequipMeleeWeapon (var int slfInstance) {
	var int itemPtr; itemPtr = oCNpc_GetEquippedMeleeWeapon (slfInstance);
	if (itemPtr) {
		oCNpc_UnequipItemPtr (slfInstance, itemPtr);
	};
};

/*
 *	Function unequips ranged weapon
 */
func void Npc_UnequipRangedWeapon (var int slfInstance) {
	var int itemPtr; itemPtr = oCNpc_GetEquippedRangedWeapon (slfInstance);
	if (itemPtr) {
		oCNpc_UnequipItemPtr (slfInstance, itemPtr);
	};
};

/*
 *	Function unequips all weapons
 */
func void Npc_UnequipWeapons (var int slfInstance) {
	Npc_UnequipMeleeWeapon (slfInstance);
	Npc_UnequipRangedWeapon (slfInstance);
};

/*
 *	Npc_GetItemSlot
 *	 - function loops through inventory and returns index of inventory slot in which item is stored
 */
func int Npc_GetItemSlot (var int slfInstance, var int invCat, var int searchItemInstanceID) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };

	//By default -1
	var int retSlot; retSlot = -1;

	var int itmSlot; itmSlot = 0;
	var int amount; amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);

	var int itemInstanceID;

	while (amount > 0);
		itemInstanceID = Hlp_GetInstanceID (item);

		if (itemInstanceID == searchItemInstanceID) {
			//Same for G1 & G2A
			const int ITM_FLAG_ACTIVE = 1 << 30;

			//Prio - unequipped items
			if (oCItem_HasFlag(_@(item), ITM_FLAG_ACTIVE)) {
				//Keep track of the equipped one tho
				retSlot = itmSlot;

				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};

			return + itmSlot;
		} else {
			//Exit if instance does not match
			if (retSlot > -1) {
				return retSlot;
			};
		};

		itmSlot += 1;
		amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
	end;

	return retSlot;
};

/*
 *	Npc_InvSelectItem
 *	 - function selects item in inventory
 */
func void Npc_InvSelectItem (var int slfInstance, var int itemInstanceID) {
	var oCNPC slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (Npc_GetInvItem (slf, itemInstanceID)) {
		var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slfInstance);
		var int invCat; invCat = oCNpcInventory_GetCategory (npcInventoryPtr, _@ (item));
		oCNpcInventory_SwitchToCategory (npcInventoryPtr, invCat);

		var int itmSlot; itmSlot = Npc_GetItemSlot (slf, invCat, itemInstanceID);

		slf.inventory2_oCItemContainer_offset = itmSlot;
		slf.inventory2_oCItemContainer_selectedItem = itmSlot;
	};
};

/*
 *	Npc_InvOpenPassive
 *	 - function opens inventory passively
 */
func void Npc_InvOpenPassive (var int slfInstance, var int itemInstanceID, var int hasInvFocus) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Unpack inventory
	oCNpc_UnpackInventory (slfInstance);

	//Select inventory item
	Npc_InvSelectItem (slfInstance, itemInstanceID);

	//Get Npc inventory ptr
	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slfInstance);
	if (!npcInventoryPtr) { return; };

	//In G1 invMode 2 means only a single item will be rendered on screen
	//enum oTItemListMode { FULLSCREEN, HALFSCREEN, ONE };

	//In G2A inv mode represents something else
	//INV_MODE_DEFAULT, INV_MODE_CONTAINER, INV_MODE_PLUNDER, INV_MODE_STEAL, INV_MODE_BUY, INV_MODE_SELL
	var int invMode; invMode = 0;
	if (MEMINT_SwitchG1G2 (1, 0)) {
		invMode = 2;
	};

	if (Npc_IsPlayer (slf)) {
		oCItemContainer_OpenPassive (npcInventoryPtr, 8192, 0, invMode);
		slf.inventory2_oCItemContainer_right = TRUE;
	} else {
		oCItemContainer_OpenPassive (npcInventoryPtr, 0, 0, invMode);
		slf.inventory2_oCItemContainer_right = FALSE;
	};

	slf.inventory2_oCItemContainer_frame = hasInvFocus;
};

/*
 *	Npc_CloseInventory
 *	 - function closes inventory
 */
func void Npc_CloseInventory (var int slfInstance) {
	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slfInstance);
	oCNpcInventory_Close (npcInventoryPtr);
};

/*
 *	Npc_InvSwitchToCategory
 *	 - function switches inventory to specified inv category
 */
func void Npc_InvSwitchToCategory (var int slfInstance, var int invCat) {
	var int npcInventoryPtr; npcInventoryPtr = Npc_GetNpcInventoryPtr (slfInstance);
	oCNpcInventory_SwitchToCategory (npcInventoryPtr, invCat);
};

func void oCNpc_AddItemEffects (var int slfInstance, var int itemPtr) {
	//0x0068F640 public: void __thiscall oCNpc::AddItemEffects(class oCItem *)
	const int oCNpc__AddItemEffects_G1 = 6878784;

	//0x007320F0 public: void __thiscall oCNpc::AddItemEffects(class oCItem *)
	const int oCNpc__AddItemEffects_G2 = 7545072;

	if (!itemPtr) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(itemPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__AddItemEffects_G1, oCNpc__AddItemEffects_G2));
		call = CALL_End();
	};
};

func void oCNpc_RemoveItemEffects (var int slfInstance, var int itemPtr) {
	//0x0068F7D0 public: void __thiscall oCNpc::RemoveItemEffects(class oCItem *)
	const int oCNpc__RemoveItemEffects_G1 = 6879184;

	//0x00732270 public: void __thiscall oCNpc::RemoveItemEffects(class oCItem *)
	const int oCNpc__RemoveItemEffects_G2 = 7545456;

	if (!itemPtr) { return; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;

	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(itemPtr));
		CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__RemoveItemEffects_G1, oCNpc__RemoveItemEffects_G2));
		call = CALL_End();
	};
};

/*
 *	Npc_SimpleEquip
 *	 - function adds all effect & calls on_equip function
 */
func void Npc_SimpleEquip (var int slfInstance, var int itemPtr) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	oCNpc_AddItemEffects (slfInstance, itemPtr);
	oCItem_SetFlag (itemPtr, ITM_FLAG_ACTIVE);
};

/*
 *	Npc_SimpleUnequip
 *	 - function adds all effect & calls on_unequip function
 */
func void Npc_SimpleUnequip (var int slfInstance, var int itemPtr) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	oCNpc_RemoveItemEffects (slfInstance, itemPtr);
	oCItem_ClearFlag (itemPtr, ITM_FLAG_ACTIVE);
};

/*
 *	Npc_GetCountEquippedItemsByFlag
 *	 - function returns number of equipped items with specific flags
 */
func int Npc_GetCountEquippedItemsByFlag (var int slfInstance, var int category, var int searchFlag) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	if (category == -1) { return 0; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	var int count; count = 0;

	//Unpack inventory
	oCNpcInventory_UnpackCategory (npcInventoryPtr, category);

	//Loop through all items - count how many equipped items we already have
	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * category));

	while (ptr);
		list = _^ (ptr);

		if (Hlp_Is_oCItem (list.data)) {
			if (oCItem_HasFlag (list.data, searchFlag)) {
				if (oCItem_HasFlag (list.data, ITM_FLAG_ACTIVE)) {
					count += 1;
				};
			};
		};

		ptr = list.next;
	end;

	return + count;
};

/*
 *	Npc_GetCountEquippedItemsByInstance
 *	 - function returns number of equipped items for specified instance
 */
func int Npc_GetCountEquippedItemsByInstance (var int slfInstance, var int category, var int itemInstanceID) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	if (category == -1) { return 0; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	var int count; count = 0;

	//Unpack inventory
	oCNpcInventory_UnpackCategory (npcInventoryPtr, category);

	//Loop through all items - count how many equipped items we already have
	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * category));

	while (ptr);
		list = _^ (ptr);

		if (Hlp_Is_oCItem (list.data)) {
			itm = _^ (list.data);
			if (Hlp_GetInstanceID (itm) == itemInstanceID) {
				if (oCItem_HasFlag (list.data, ITM_FLAG_ACTIVE)) {
					count += 1;
				};
			};
		};

		ptr = list.next;
	end;

	return + count;
};

/*
 *	Npc_GetEquippedItemPtrByFlag
 *	 - function returns pointer to equipped item specified by flag
 */
func int Npc_GetEquippedItemPtrByFlag (var int slfInstance, var int category, var int searchFlag) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	if (category == -1) { return 0; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	var oCItem itm;
	var zCListSort list;

	var int noOfCategories;
	var int offset;
	var int ptr;

	//G1/G2A compatibility --> we cannot use inventory2_inventory1_next / inventory2_inventory_next properties, but instead we have to read from inventory offsets
	if (GOTHIC_BASE_VERSION == 1) {
		offset = 1528;						// 0x05F8 zCListSort<oCItem>*
		noOfCategories = INV_CAT_MAX;
	} else {
		offset = 1816;						// 0x0718 zCListSort<oCItem>*
		noOfCategories = 1;
	};

	var int count; count = 0;

	//Unpack inventory
	oCNpcInventory_UnpackCategory (npcInventoryPtr, category);

	//Loop through all items - and find equipped item
	ptr = MEM_ReadInt (_@ (slf) + offset + (12 * category));

	while (ptr);
		list = _^ (ptr);

		if (Hlp_Is_oCItem (list.data)) {
			if (oCItem_HasFlag (list.data, searchFlag)) {
				if (oCItem_HasFlag (list.data, ITM_FLAG_ACTIVE)) {
					return list.data;
				};
			};
		};

		ptr = list.next;
	end;

	return 0;
};

