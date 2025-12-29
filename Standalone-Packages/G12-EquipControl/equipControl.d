func void _eventEquipItem__EquipControl (var int dummyVariable) {
	//Same for G1 & G2A
	const int ITM_FLAG_ACTIVE = 1 << 30;

	var int itemPtr; itemPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCItem (itemPtr)) { return; };

	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var C_NPC slf; slf = _^ (ECX);

	var int retVal; retVal = 0;

	const int symbID = 0;
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
	G12_EquipItemEvent_Init();
	EquipItemEvent_AddListener(_eventEquipItem__EquipControl);
};
