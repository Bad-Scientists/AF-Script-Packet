/*
 *	func void oCMobContainer_Remove (var int mobPtr, var int itmPtr){
 */

/*
 *	Removes Item from oCMobContainer
 *		mobPtr			pointer to oCMobContainer
 *		itmPtr			pointer to oCItem in oCMobContainer
 *	Usage:
 *		oCMobContainer_Remove(mobPtr, itmPtr);
 */
func void oCMobContainer_Remove (var int mobPtr, var int itmPtr){
	//0x00683EB0 public: virtual void __thiscall oCMobContainer::Remove(class oCItem *)
	const int oCMobContainer__Remove_G1 = 6831792;

	//0x00725FF0 public: virtual void __thiscall oCMobContainer::Remove(class oCItem *)
	const int oCMobContainer__Remove_G2 = 7495664;

	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };
	if (!Hlp_Is_oCItem (itmPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Remove_G1, oCMobContainer__Remove_G2));
		call = CALL_End();
	};
};

/*
 *	I was hoping this one removes item from oCMobContainer without dicarding it - but returned pointer is 0
 *

func int oCMobContainer_GetRemoved (var int mobPtr, var int itmPtr, var int amount){
	//0x00683F40 public: virtual class oCItem * __thiscall oCMobContainer::Remove(class oCItem *,int)
	const int oCMobContainer__Remove_G1 = 6831936;

	//0x00726080 public: virtual class oCItem * __thiscall oCMobContainer::Remove(class oCItem *,int)
	const int oCMobContainer__Remove_G2 = 7495808;

	if (!Hlp_Is_oCMobContainer (mobPtr)) { return 0; };
	if (!Hlp_Is_oCItem (itmPtr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (amount));
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Remove_G1, oCMobContainer__Remove_G2));
		call = CALL_End();
	};

	var int retVal; retVal = CALL_RetValAsPtr ();

	B_Msg_Add (IntToString (retVal));

	return retVal;
};
*/

func void oCMobContainer_Insert (var int mobPtr, var int itmPtr){
	//0x00683E80 public: virtual void __thiscall oCMobContainer::Insert(class oCItem *)
	const int oCMobContainer__Insert_G1 = 6831744;

	//0x00725FC0 public: virtual void __thiscall oCMobContainer::Insert(class oCItem *)
	const int oCMobContainer__Insert_G2 = 7495616;

	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };
	if (!Hlp_Is_oCItem (itmPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Insert_G1, oCMobContainer__Insert_G2));
		call = CALL_End();
	};
};

//0x00726190 public: virtual void __thiscall oCMobContainer::CreateContents(class zSTRING const &)

/*
 *
 *	This package 'sparkled' from Neconspictor's post about 'Mob_RemoveAllItems' function.
 *	Original post here: https://forum.worldofplayers.de/forum/threads/1449528-Mob_RemoveItems?p=24599541&viewfull=1#post24599541
 *
 *	func int oCMobContainer_GetItemPtrBySlot (var int mobPtr, var int itemSlot)
 *	func void Mob_RemoveAllItems (var int mobPtr)
 *	func void Mob_RemoveItems (var int mobPtr, var int itemInstance, var int qty)
 *	func void Mob_TransferItemsToNPC (var int mobPtr, var int slfInstance)
 */

/*
 *	Returns pointer to oCItem in a specific inventory slot in a chest
 *		mobPtr			pointer to oCMobContainer
 *		itemSlot		slot number (starts with 0)
 *	Usage:
 *		itemPtr = oCMobContainer_GetItemPtrBySlot (her.focus_vob, 0);
 */
func int oCMobContainer_GetItemPtrBySlot (var int mobPtr, var int itemSlot){
	if (!Hlp_Is_oCMobContainer (mobPtr)) { return 0 ; };

	var int ptr;
	var int itmPtr;
	var zCListSort list;
	var oCMobContainer container; container = _^ (mobPtr);
	var int i; i = 0;

	ptr = container.containList_next;

	while (ptr);
		list = _^ (ptr);
		itmPtr = list.data;

		if (itmPtr) {
			if (itemSlot == i) {
				return itmPtr;
			};

			i += 1;
		};

		ptr = list.next;
	end;

	return 0;
};

/*
 *	Removes from oCMobContainer all items
 *		mobPtr			pointer to oCMobContainer
 *		itemSlot		slot number (starts with 0)
 *	Usage:
 *		Mob_RemoveAllItems (her.focus_vob);
 */
func void Mob_RemoveAllItems (var int mobPtr){
	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };

	var int ptr;
	var oCMobContainer container; container = _^(mobPtr);
	var zCListSort list;

	ptr = container.containList_next;

	while (ptr != 0);
		list = _^(ptr);
		var int itmPtr; itmPtr = list.data;

		if (itmPtr == 0) {
			ptr= list.next;
		} else {
			oCMobContainer_Remove(mobPtr, itmPtr);
			ptr = container.containList_next;
		};
	end;
};

/*
 *	Removes from oCMobContainer 1 item
 *		mobPtr			pointer to oCMobContainer
 *		itemInstance		item instance
 *		qty			qty to be removed
 *	Usage:
 *		Mob_RemoveItems (her.focus_vob, ItarScrollFireBolt, 1);
 */
func void Mob_RemoveItems (var int mobPtr, var int itemInstance, var int qty){
	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };

	var oCItem itm;

	var int itmPtr; itmPtr = 1;
	var int i; i = 0;

	//Loop through all inventory slots to find itemInstance
	while (itmPtr);
		itmPtr = oCMobContainer_GetItemPtrBySlot (mobPtr, i);

		if (itmPtr) {
			itm = _^ (itmPtr);

			if (Hlp_GetInstanceID (itm) == itemInstance) {
				if (itm.amount > qty) {
					//Adjust qty - is this okay?
					itm.amount = (itm.amount - qty);
				} else {
					//Remove everything
					oCMobContainer_Remove (mobPtr, itmPtr);
				};

				return;
			};
		};

		i += 1;
	end;
};

/*
 *	Transfers all items from oCMobContainer to NPC
 *		mobPtr			pointer to oCMobContainer
 *		slfInstance		NPC instance
 *	Usage:
 *		Mob_TransferItemsToNPC (her.focus_vob, hero);
 */
var int _MobTransferItemPrint_Event;
var int _MobTransferItemPrint_Event_Enabled;

func void MobTransferItemPrintEvent_Init () {
	if (!_MobTransferItemPrint_Event) {
		_MobTransferItemPrint_Event = Event_Create ();
	};
};

func void MobTransferItemPrintEvent_AddListener (var func f) {
	Event_AddOnce (_MobTransferItemPrint_Event, f);
};

func void MobTransferItemPrintEvent_RemoveListener (var func f) {
	Event_Remove (_MobTransferItemPrint_Event, f);
};

func void Mob_TransferItemsToNPC (var int mobPtr, var int slfInstance){
	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };

	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var oCItem itm;
	var int i;

	var int ptr;
	var oCMobContainer container; container = _^ (mobPtr);
	var zCListSort list;

	ptr = container.containList_next;

	while (ptr != 0);
		list = _^(ptr);
		var int itmPtr; itmPtr = list.data;

		if (itmPtr == 0) {
			ptr = list.next;
		} else {
			itm = _^ (itmPtr);

			//Custom prints for transferred items
			if ((_MobTransferItemPrint_Event) && (_MobTransferItemPrint_Event_Enabled)) {
				Event_Execute (_MobTransferItemPrint_Event, itmPtr);
			};

			i = 0;
			while (i < itm.amount);
				//We have to create items in a loop using CreateInvItem function (because of items without ITEM_MULTI flag)
				CreateInvItem (slf, Hlp_GetInstanceID (itm));
				i += 1;
			end;

			oCMobContainer_Remove(mobPtr, itmPtr);
			ptr = container.containList_next;
		};
	end;
};

func void Mob_TransferItemsToMob (var int mobPtr1, var int mobPtr2){
	if (!Hlp_Is_oCMobContainer (mobPtr1)) { return; };
	if (!Hlp_Is_oCMobContainer (mobPtr2)) { return; };

	var int i;

	var int transferredItem;

	var int ptr;
	var oCMobContainer container; container = _^ (mobPtr1);
	var zCListSort list;

	ptr = container.containList_next;

	while (ptr != 0);
		list = _^ (ptr);
		var int itmPtr; itmPtr = list.data;

		if (itmPtr == 0) {
			ptr = list.next;
		} else {
			//Custom prints for transferred items
			if ((_MobTransferItemPrint_Event) && (_MobTransferItemPrint_Event_Enabled)) {
				Event_Execute (_MobTransferItemPrint_Event, itmPtr);
			};

			oCMobContainer_Insert (mobPtr2, itmPtr);
			oCMobContainer_Remove (mobPtr1, itmPtr);

			ptr = container.containList_next;
		};
	end;
};

func void Mob_CopyItemsToMob (var int mobPtr1, var int mobPtr2){
	if (!Hlp_Is_oCMobContainer (mobPtr1)) { return; };
	if (!Hlp_Is_oCMobContainer (mobPtr2)) { return; };

	var int i;

	var int transferredItem;

	var int ptr;
	var oCMobContainer container; container = _^ (mobPtr1);
	var zCListSort list;

	ptr = container.containList_next;

	while (ptr != 0);
		list = _^ (ptr);
		var int itmPtr; itmPtr = list.data;

		if (itmPtr) {
			//Custom prints for transferred items
			if ((_MobTransferItemPrint_Event) && (_MobTransferItemPrint_Event_Enabled)) {
				Event_Execute (_MobTransferItemPrint_Event, itmPtr);
			};

			oCMobContainer_Insert (mobPtr2, itmPtr);
		};

		ptr = list.next;
	end;
};

/*
 *	Returns -1 mobPtr is either invalid or not oCMobContainer
 *		 0 mobPtr is not empty
 *		 1 mobPtr is empty
 */
func int Mob_IsEmpty (var int mobPtr) {
	if (!Hlp_Is_oCMobContainer (mobPtr)) { return -1; };

	var oCMobContainer container; container = _^ (mobPtr);

	if (!container.containList_next) {
		return TRUE;
	};

	return FALSE;
};
