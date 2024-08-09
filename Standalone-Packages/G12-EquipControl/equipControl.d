func void _hook_oCNpc_EquipControl () {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCItem (itemPtr)) { return; };

	var C_NPC slf; slf = _^ (ECX);

	const int symbID = 0;
	var int retVal; retVal = 0;

	if (!symbID) {
		symbID = MEM_FindParserSymbol ("C_Npc_CanEquip");
	};

	if (symbID != -1) {
		MEM_PushInstParam (slf);
		MEM_PushIntParam (itemPtr);

		MEM_CallByID (symbID);
		retVal = MEM_PopIntResult ();
	};

	if (retVal) {
		//Null item pointer - this will cancel equip action (everything handled from function C_Npc_CanEquip - no need to let engine do it)
		MEM_WriteInt (ESP + 4, 0);
	};
};

func void G12_EquipControl_Init () {
	const int once = 0;
	if (!once) {
		//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
		const int oCNpc__Equip_G1 = 6908144;

		//0x00739C90 public: void __thiscall oCNpc::Equip(class oCItem *)
		const int oCNpc__Equip_G2 = 7576720;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__Equip_G1, oCNpc__Equip_G2), 5, "_hook_oCNpc_EquipControl");

		once = 1;
	};
};
