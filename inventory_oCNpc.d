/*
 *	Hlp_GetOpenInventoryType
 *
 *	 - identifies type of opened inventory:
 *	 - 0 none
 *	 - 1 players inventory
 *	 - 2 looting NPC
 *	 - 3 looting chest
 *	 - 4 trading inventory
 */

/*
enum {
NPC_GAME_NORMAL,
NPC_GAME_PLUNDER,
NPC_GAME_STEAL
};
*/

//0x008DBC24 public: static int oCNpc::game_mode
//0x008DBC28 class oCNpc * stealnpc
//0x008DBC2C float stealcheck_timer

const int OpenInvType_None = 0;
const int OpenInvType_Player = 1;
const int OpenInvType_NPC = 2;
const int OpenInvType_Chest = 3;
const int OpenInvType_Trading = 4;

func int Hlp_GetOpenInventoryType () {
	//0x008DA998 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G1 = 9283992;

	//0x00AB0FD4 class zCList<class oCItemContainer> s_openContainers
	const int s_openContainers_G2 = 11210708;

//-- TODO: add logic for G2A

	//0x007DCDFC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G1 = 8244732;

	//0x007DCEA4 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G1 = 8244900;

	//0x007DCF54 const oCNpcContainer::`vftable'
	const int oCNpcContainer_vtbl_G1 = 8245076;

	//0x007DD004 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G1 = 8245252;

//--
	var oCItemContainer container;

	var int itemContainer; itemContainer = 0;
	var int stealContainer; stealContainer = 0;
	var int npcContainer; npcContainer = 0;
	var int playerInventory; playerInventory = 0;

	var int ptr; ptr = MEMINT_SwitchG1G2(s_openContainers_G1, s_openContainers_G2);

	var zCList list;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			container = _^ (ptr);

			if (container.inventory2_vtbl == oCItemContainer_vtbl_G1) { itemContainer = 1; };
			if (container.inventory2_vtbl == oCStealContainer_vtbl_G1) { stealContainer = 1; };
			if (container.inventory2_vtbl == oCNpcContainer_vtbl_G1) { npcContainer = 1; };
			if (container.inventory2_vtbl == oCNpcInventory_vtbl_G1) { playerInventory = 1; };
		};

		ptr = list.next;
	end;

	//Players inventory
	if ((playerInventory) && (!itemContainer) && (!stealContainer) && (!npcContainer)) { return OpenInvType_Player; };

	//Looting NPC
	if ((playerInventory) && (!itemContainer) && (!stealContainer) && (npcContainer)) { return OpenInvType_NPC; };

	//Looting chest
	if ((playerInventory) && (itemContainer) && (!stealContainer) && (!npcContainer)) { return OpenInvType_Chest; };

	//Trading inventory
	if ((playerInventory) && (itemContainer) && (stealContainer) && (!npcContainer)) { return OpenInvType_Trading; };

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

//-- TODO: add logic for G2A

func int Hlp_GetOpenContainer_oCItemContainer () {
	//0x007DCDFC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G1 = 8244732;

	return +Hlp_GetOpenContainer (oCItemContainer_vtbl_G1);
};

func int Hlp_GetOpenContainer_oCStealContainer () {
	//0x007DCEA4 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G1 = 8244900;

	return +Hlp_GetOpenContainer (oCStealContainer_vtbl_G1);
};

func int Hlp_GetOpenContainer_oCNpcContainer () {
	//0x007DCF54 const oCNpcContainer::`vftable'
	const int oCNpcContainer_vtbl_G1 = 8245076;

	return +Hlp_GetOpenContainer (oCNpcContainer_vtbl_G1);
};

func int Hlp_GetOpenContainer_oCNpcInventory () {
	//0x007DD004 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G1 = 8245252;

	return +Hlp_GetOpenContainer (oCNpcInventory_vtbl_G1);
};

//-- oCItemContainer functions

func int oCItemContainer_Draw (var int ptr) {
	//0x00667660 protected: virtual void __thiscall oCItemContainer::Draw(void)
	const int oCItemContainer__Draw_G1 = 6714976;

	//0x007076B0 protected: virtual void __thiscall oCItemContainer::Draw(void)
	const int oCItemContainer__Draw_G2 = 7370416;

	if (!ptr) { return 0; };

	var int retVal;

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

//G1 only
func int oCNpcInventory_SwitchToCategory (var int npcInventoryPtr, var int invCategory) {
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
		CALL_IntParam (_@ (invCategory));
		CALL__thiscall (_@ (npcInventoryPtr), oCNpcInventory__SwitchToCategory_G1);
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	oCNpcInventory_UnpackCategory
 *	 - in case of G2A inventory category is redundant
 */
func void oCNpcInventory_UnpackCategory (var int npcInventoryPtr, var int invCategory) {
	//0x0066FAD0 public: void __thiscall oCNpcInventory::UnpackCategory(int)
	const int oCNpcInventory__UnpackCategory_G1 = 6748880;

	//0x0070F620 public: void __thiscall oCNpcInventory::UnpackCategory(void)
	const int oCNpcInventory__UnpackCategory_G2 = 7403040;

	if (!npcInventoryPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		if (MEMINT_SwitchG1G2 (1, 0)) {
			CALL_IntParam (_@ (invCategory));
		};
		CALL__thiscall (_@ (npcInventoryPtr), MEMINT_SwitchG1G2 (oCNpcInventory__UnpackCategory_G1, oCNpcInventory__UnpackCategory_G2));
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

//--

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

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

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
			return (NPC_HasItems (slf, Hlp_GetinstanceID (item)));
		};
	};

	return 0;
};

func void NPC_RemoveInventoryCategory (var int slfInstance, var int invCategory, var int flagsKeepItems, var int mainFlagsKeepItems) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int amount;
	var int itmInstance;

	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);

	while (amount > 0);
		itmInstance = Hlp_GetinstanceID (item);

		//Chceme tieto itemy odstranit ?
		//Zbroj - neodstranujeme taku, co je equipnuta
		if ((item.Flags & flagsKeepItems) || (item.MainFlag & mainFlagsKeepItems) || ((invCategory == INV_ARMOR) && (NPC_GetArmor (slf) == itmInstance)))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		var int ptr; ptr = _@ (item);

		var oCItem itm; itm = _^ (ptr);

		if (itm.amount == 1) {
			oCNPC_UnequipItemPtr (slf, ptr);
			NPC_RemoveInvItem (slf, itmInstance);
		} else {
			NPC_RemoveInvItems (slf, itmInstance, itm.amount);
		};

		amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
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

var int _NpcTransferItemPrint_Event;
var int _NpcTransferItemPrint_Event_Enabled;

func void NpcTransferItemPrintEvent_Init () {
	if (!_NpcTransferItemPrint_Event) {
		_NpcTransferItemPrint_Event = Event_Create ();
	};
};

func void NpcTransferItemPrintEvent_AddListener (var func f) {
	Event_AddOnce (_NpcTransferItemPrint_Event, f);
};

func void NpcTransferItemPrintEvent_RemoveListener (var func f) {
	Event_Remove (_NpcTransferItemPrint_Event, f);
};

func void NPC_TransferInventoryCategory (var int slfInstance, var int othInstance, var int invCategory, var int transferEquippedArmor, var int transferEquippedItems, var int transferMissionItems) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var C_NPC oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return; };

	var int amount;
	var int itmInstance;

	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);

	while (amount > 0);
		itmInstance = Hlp_GetinstanceID (item);

		//Ignore equipped armor
		if (!transferEquippedArmor)
		&& (NPC_GetArmor (slf) == itmInstance) //&& (item.Flags & ITEM_ACTIVE_LEGO))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		//Ignore equipped items
		if (!transferEquippedItems)
		&& (((NPC_GetMeleeWeapon (slf) == itmInstance) || (NPC_GetRangedWeapon (slf) == itmInstance)) && (item.Flags & ITEM_ACTIVE_LEGO))
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		//Ignore mission items
		if (!transferMissionItems)
		&& (item.Flags & ITEM_MISSION)
		{
			itmSlot += 1;
			amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
			continue;
		};

		//Convert to oCItem to get amount property
		var int itmPtr; itmPtr = _@ (item);
		var oCItem itm; itm = _^ (itmPtr);

		//Custom prints for transferred items
		if ((_NpcTransferItemPrint_Event) && (_NpcTransferItemPrint_Event_Enabled)) {
			Event_Execute (_NpcTransferItemPrint_Event, itmPtr);
		};

		if (itm.amount == 1) {
			CreateInvItem (oth, itmInstance);
			NPC_RemoveInvItem (slf, itmInstance);
		} else {
			CreateInvItems (oth, itmInstance, itm.amount);
			NPC_RemoveInvItems (slf, itmInstance, itm.amount);
		};

		amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
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

func void NPC_UnEquipInventoryCategory (var int slfinstance, var int invCategory) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int amount;
	var int itmSlot; itmSlot = 0;

	amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);

	//Loop
	while (amount > 0);
		oCNPC_UnequipItemPtr (slf, _@ (item));

		itmSlot = itmSlot + 1;
		amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
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
func int NPC_InventoryIsEmpty (var int slfInstance, var int ignoreFlags, var int ignoreMainFlags, var int ignoreArmor) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

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

	//NPC_GetArmor requires C_NPC ... ;-/
	var C_NPC _slf; _slf = Hlp_GetNpc (slf);
	var int armorID; armorID = NPC_GetArmor (_slf);

	repeat (invCat, noOfCategories); var int invCat;
		oCNpcInventory_UnpackCategory (npcInventoryPtr, invCat);
		ptr = MEM_ReadInt (_@ (slf) + offset + (12 * invCat));

		while (ptr);
			list = _^ (ptr);

			if (list.data) {
				itm = _^ (list.data);
				if ((itm.Flags & ignoreFlags) || (itm.MainFlag & ignoreMainFlags) || ((invCat == INV_ARMOR) && (armorID == Hlp_GetInstanceID (itm)) && (ignoreArmor))) {
					ptr = list.next;
					continue;
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

	//NPC_GetArmor requires C_NPC ... ;-/
	var C_NPC _slf; _slf = Hlp_GetNpc (slf);
	var int armorID; armorID = NPC_GetArmor (_slf);

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

func void oCNpc_UnpackInventory (var int slfInstance)
{
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	if (MEMINT_SwitchG1G2 (1, 0)) {
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_WEAPON);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_ARMOR);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_RUNE);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_MAGIC);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_FOOD);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_POTION);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_DOC);
		oCNpcInventory_UnpackCategory (npcInventoryPtr, INV_MISC);
	} else {
		oCNpcInventory_UnpackCategory (npcInventoryPtr, 0);
	};
};

func int Npc_ItemGetCategory (var int slfInstance, var int itemPtr) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return -1; };

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);
    return + oCNpcInventory_GetCategory (npcInventoryPtr, itemPtr);
};
