

/*
 * Gets pointer of equipped melee weapon
 *
 *    @param npcInstance        npc 
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */
func int oCNpc__GetEquippedMeleeWeapon (var int npcInstance)
{
	//00694580  .text     Debug data           ?GetEquippedMeleeWeapon@oCNpc@@QAEPAVoCItem@@XZ
	const int oCNpc__GetEquippedMeleeWeapon_G1 = 6899072;
	
	//0x00737930 public: class oCItem * __thiscall oCNpc::GetEquippedMeleeWeapon(void) 
	const int oCNpc__GetEquippedMeleeWeapon_G2 = 7567664;
	
	var oCNPC slf;
	slf = Hlp_GetNPC (npcInstance);
	
	if (!slf) { return -1; };
	
	CALL__thiscall (MEM_InstToPtr (slf), MEMINT_SwitchG1G2(oCNpc__GetEquippedMeleeWeapon_G1, oCNpc__GetEquippedMeleeWeapon_G2));
	return CALL_RetValAsPtr();
};

func int oCNpc_PutInInv (var int npcInstance, var int itemPtr)
{
	//006A4FF0  .text     Debug data           ?PutInInv@oCNpc@@QAEPAVoCItem@@PAV2@@Z
	const int oCNpc__PutInInv_G1 = 6967280;
	//0x00749350 public: class oCItem * __thiscall oCNpc::PutInInv(class oCItem *)
	
	var oCNPC slf;
	slf = Hlp_GetNPC (npcInstance);
	
	if (!slf) { return -1; };
	
	CALL_IntParam (itemPtr);
	CALL__thiscall (MEM_InstToPtr(slf), oCNpc__PutInInv_G1);
	return CALL_RetValAsPtr();
};

func int oCNpc_PutInInvAmount (var int npcInstance, var int itemPtr, var int amount)
{
	//006A5180  .text     Debug data           ?PutInInv@oCNpc@@QAEPAVoCItem@@HH@Z
	const int oCNpc__PutInInAm_G1 = 6967680;
	//0x007494C0 public: class oCItem * __thiscall oCNpc::PutInInv(int,int)
	
	var oCNPC slf;
	slf = Hlp_GetNPC (npcInstance);
	
	if (!slf) { return -1; };
	
	
	CALL_IntParam (amount);
	CALL_IntParam (itemPtr);
	CALL__thiscall (MEM_InstToPtr(slf), oCNpc__PutInInAm_G1);
	return CALL_RetValAsPtr();
};

func void oCItem_RemoveFlags (var int itmPtr, var int removeFlags) {
	if (!itmPtr) { return; };
	var oCItem itm; itm = _^ (itmPtr);
	itm.flags = itm.flags & ~ (removeFlags);
};

func void oCItem_AddFlags (var int itmPtr, var int addFlags) {
	if (!itmPtr) { return; };
	var oCItem itm; itm = _^ (itmPtr);
	itm.flags = itm.flags | (addFlags);
};

func int oCNpc_RemoveFromInv (var int npcInstance, var int itemPtr, var int amount)
{
	//006A5260  .text     Debug data           ?RemoveFromInv@oCNpc@@QAEPAVoCItem@@PAV2@H@Z
	const int oCNpc__RemoveFromInv_G1 = 6967904;
	//0x007495A0 public: class oCItem * __thiscall oCNpc::RemoveFromInv(class oCItem *,int)
	
	var oCNPC slf;
	slf = Hlp_GetNPC (npcInstance);
	
	if (!slf) { return -1; };
	
	CALL_IntParam (amount);
	CALL_IntParam (itemPtr);
	CALL__thiscall (MEM_InstToPtr(slf), oCNpc__RemoveFromInv_G1);
	return CALL_RetValAsPtr();
};

func int oCNpc__GetFromInv (var int npcInstance, var int itemPtr, var int amount)
{
	//006A4E20  .text     Debug data           ?GetFromInv@oCNpc@@QAEPAVoCItem@@HH@Z
	const int oCNpc__GetFromInv_G1 = 6966816;
	//0x00749180 public: class oCItem * __thiscall oCNpc::GetFromInv(int,int)
	
	var oCNPC slf;
	slf = Hlp_GetNPC (npcInstance);
	
	if (!slf) { return -1; };
	
	CALL_IntParam (amount);
	CALL_IntParam (itemPtr);
	CALL__thiscall (MEM_InstToPtr(slf), oCNpc__GetFromInv_G1);
	return CALL_RetValAsPtr();
};





func int oCItem__HasFlag (var int itemPtr, var int itemFlag)
{
	//00671FC0  .text     Debug data           ?HasFlag@oCItem@@QAEHH@Z
	const int oCItem__HasFlag_G1 = 6758336;
	
	//0x007126D0 public: int __thiscall oCItem::HasFlag(int)
	const int oCItem__HasFlag_G2 = 7415504;
	
	
	CALL_IntParam (itemFlag);
	CALL__thiscall (itemPtr, MEMINT_SwitchG1G2(oCItem__HasFlag_G1, oCItem__HasFlag_G2));
	return CALL_RetValAsInt();
};

func void oCItem__SetFlag (var int itemPtr, var int itemFlag)
{
	//00672000  .text     Debug data           ?SetFlag@oCItem@@QAEXH@Z
	const int oCItem__SetFlag_G1 = 6758400;
	
	//0x00712710 public: void __thiscall oCItem::SetFlag(int)
	const int oCItem__SetFlag_G2 = 7415568;
	
	CALL_IntParam (itemFlag);
	CALL__thiscall (itemPtr, MEMINT_SwitchG1G2(oCItem__SetFlag_G1, oCItem__SetFlag_G2));
};

func void oCItem__ClearFlag (var int itemPtr, var int itemFlag)
{
	//00671FE0  .text     Debug data           ?ClearFlag@oCItem@@QAEXH@Z
	const int oCItem__ClearFlag_G1 = 6758368;
	
	//0x007126F0 public: void __thiscall oCItem::ClearFlag(int)
	const int oCItem__ClearFlag_G2 = 7415536;
	
	CALL_IntParam (itemFlag);
	CALL__thiscall (itemPtr, MEMINT_SwitchG1G2(oCItem__ClearFlag_G1, oCItem__ClearFlag_G2));
};

func int oCItem__SplitItem (var int itemPtr, var int param1)
{
	//00672440  .text     Debug data           ?SplitItem@oCItem@@QAEPAV1@H@Z
	const int oCItem__SplitItem_G1 = 6759488;
	
	//0x00712BA0 public: class oCItem * __thiscall oCItem::SplitItem(int)
	const int oCItem__SplitItem_G2 = 7416736;
	
	CALL_IntParam (param1);
	CALL__thiscall (itemPtr, MEMINT_SwitchG1G2(oCItem__SplitItem_G1, oCItem__SplitItem_G2));
	return CALL_RetValAsPtr();
};

