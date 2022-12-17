//int __thiscall oCNpc::IsMunitionAvailable(class oCItem *)
func void _hook_oCNpc_IsMunitionAvailable () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var int weaponPtr; weaponPtr = MEM_ReadInt (ESP + 4);

	if (!Hlp_Is_oCItem (weaponPtr)) { return; };

	var oCNpc slf; slf = _^ (ECX);

	if (!Hlp_IsValidNPC (slf)) { return; };

	if (NPC_IsPlayer (slf)) {
		var oCItem weapon; weapon = _^ (weaponPtr);

		//Get qty from inventory
		var int count; count = NPC_HasItems (slf, weapon.munition);

		//Get qty in hand
		if (!count) {
			var int vobPtr; vobPtr = oCNpc_GetSlotItem (slf, "ZS_RIGHTHAND");
			if (Hlp_Is_oCItem (vobPtr)) {
				var oCItem ammo; ammo = _^ (vobPtr);
				if (Hlp_GetInstanceID (ammo) == weapon.munition) {
					count += ammo.amount;
				};
			};
		};

		//No ammo
		if (!count) {
			var string instName; instName = GetSymbolName (weapon.munition);

			const int symbID = 0;

			if (!symbID) {
				symbID = MEM_FindParserSymbol ("NOAMMOPRINT_AMMOMISSING");
			};

			if (symbID != -1) {
				MEM_PushStringParam (instName);
				MEM_CallByID (symbID);
			};
		};
	};
};

func void G12_NoAmmoPrint_Init () {
	const int once = 0;
	if (!once) {
		HookEngine (oCNpc__IsMunitionAvailable , 6, "_hook_oCNpc_IsMunitionAvailable");
		once = 1;
	};
};
