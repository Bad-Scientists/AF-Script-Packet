/***
	v 0.01
	Authors: Auronen & Fawkes
	This little package allows you to use ITEM_MULTI flag with melee weapons in Gothic 1.
	Hooked functions oCNpc::EquipWeapon & oCNPC::UnequipItem will emulate same behaviour as you can see in G2A. If you have 10 weapons in 1 item slot, when equipped 1 weapon will move to it's own slot.
	You can then sell 9 unequipped items without additional hassle of well ... unequipping :)
***/

/*
 *	#Description#
 *	
 *	@param slfInstance		NPC instance
 *	@param itmInstance		Item isntance
 *	@param qty				quantity
 *
 */
func int oCNpc__GetFromInv (var int slfInstance, var int itmInstance, var int qty) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//006A4E20  .text     Debug data           ?GetFromInv@oCNpc@@QAEPAVoCItem@@HH@Z
	const int oCNpc__GetFromInv_G1 = 6966816;
	
	//0x00749180 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	const int oCNpc__GetFromInv_G2 = 7639424;

	CALL_IntParam (qty);
	CALL_IntParam (itmInstance);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__GetFromInv_G1, oCNpc__GetFromInv_G2));

	return CALL_RetValAsPtr ();
};

/*
 *	Removes items from inventory
 *	
 *	@param slfInstance		NPC instance
 *	@param itmPtr			Item pointer
 *	@param qty				quantity
 *
 */
func int oCNpc_RemoveFromInv (var int slfInstance, var int itmPtr, var int qty) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//006A5260  .text     Debug data           ?RemoveFromInv@oCNpc@@QAEPAVoCItem@@PAV2@H@Z
	const int oCNpc__RemoveFromInv_G1 = 6967904;
	
	//0x007495A0 public: class oCItem * __thiscall oCNpc::RemoveFromInv(class oCItem *,int)
	const int oCNpc__RemoveFromInv_G2 = 7640480;

	CALL_IntParam (qty);
	CALL_PtrParam (itmPtr);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__RemoveFromInv_G1, oCNpc__RemoveFromInv_G2));

	return CALL_RetValAsPtr ();
};

/*
 *	Puts item from inventory
 *	
 *	@param slfInstance		NPC instance
 *	@param itmPtr			Item pointer
 *
 */
func int oCNpc_PutInInv (var int slfInstance, var int itmPtr) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//006A4FF0  .text     Debug data           ?PutInInv@oCNpc@@QAEPAVoCItem@@PAV2@@Z
	const int oCNpc__PutInInv_G1 = 6967280;
	
	//0x00749350 public: class oCItem * __thiscall oCNpc::PutInInv(class oCItem *)
	const int oCNpc__PutInInv_G2 = 7639888;

	CALL_PtrParam (itmPtr);
	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNpc__PutInInv_G1, oCNpc__PutInInv_G2));

	return CALL_RetValAsPtr ();
};

/*
 *	Removes item flags
 *	
 *	@param itmPtr			Item pointer
 *	@param removeFlags		flags to be removed
 *
 */
func void oCItem_RemoveFlags (var int itmPtr, var int removeFlags) {
	if (!itmPtr) { return; };
	var oCItem itm; itm = _^ (itmPtr);
	itm.flags = itm.flags & ~ (removeFlags);
};

/*
 *	Adds item flags
 *	
 *	@param itmPtr			Item pointer
 *	@param addFlags			flags to be added
 *
 */
func void oCItem_AddFlags (var int itmPtr, var int addFlags) {
	if (!itmPtr) { return; };
	var oCItem itm; itm = _^ (itmPtr);
	itm.flags = itm.flags | (addFlags);
};



//00696C20  .text     Debug data           ?EquipWeapon@oCNpc@@QAEXPAVoCItem@@@Z
//Already defined in LeGo
//const int oCNpc__EquipWeapon = 6908960;

func void _HOOK_NPC_EQUIPWEAPON ()
{
	if ((!ECX) || (!MEM_ReadInt (ESP + 4))) {
		return;
	};
	
	var oCNPC slf; slf = _^ (ECX);
	//Don't call this for NPC
	if (!NPC_IsPlayer (slf)) { return; };

	//Get item pointer
	var int itmPtr; itmPtr = MEM_ReadInt (ESP + 4);
	var oCItem itm; itm = _^ (itmPtr);

	if (Hlp_IsValidItem (itm)) {
		//Melee weapons --> all of them should have ITEM_MULTI
		if (itm.mainflag & ITEM_KAT_NF) && (itm.flags & ITEM_MULTI)
		{
			//Removes item from inventory - item is not 'deleted' tho!
			itmPtr = oCNpc_RemoveFromInv (slf, itmPtr, 1);

			//Remove flag
			oCItem_RemoveFlags (itmPtr, ITEM_MULTI);

			//Puts item back to inventory
			itmPtr = oCNpc_PutInInv (slf, itmPtr);

			//override pointer! This will make sure that our item without ITEM_MULTI flag is equipped
			MEM_WriteInt (ESP + 4, itmPtr);
		};
	};
};

//0068FBC0  .text     Debug data           ?UnequipItem@oCNPC@@QAEXPAVoCItem@@@Z
//Already defined in LeGo
//const int oCNPC__UnequipItem = 6880192;

func void _HOOK_NPC_UNEQUIPITEM ()
{
	if ((!ECX) || (!MEM_ReadInt (ESP + 4))) {
		return;
	};
	
	var oCNPC slf; slf = _^ (ECX);
	//Don't call this for NPC
	if (!NPC_IsPlayer (slf)) { return; };

	//Get item pointer
	var int itmPtr; itmPtr = MEM_ReadInt (ESP + 4);
	var oCItem itm; itm = _^ (itmPtr);

	if (Hlp_IsValidItem (itm)) {
		//Melee weapons --> all of them should have ITEM_MULTI
		if (itm.mainflag & ITEM_KAT_NF) {
			//Removes item from inventory - item is not 'deleted' tho!
			itmPtr = oCNpc_RemoveFromInv (slf, itmPtr, 1);

			oCItem_AddFlags (itmPtr, ITEM_MULTI);

			//Puts item back to inventory
			itmPtr = oCNpc_PutInInv (slf, itmPtr);
		};
	};
};

// To be hooked in Startup.d
HookEngine (oCNpc__EquipWeapon, 5, "_HOOK_NPC_EQUIPWEAPON");
HookEngine (oCNPC__UnequipItem, 7, "_HOOK_NPC_UNEQUIPITEM");
