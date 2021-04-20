func void _hook_oCNPC_OpenDeadNPC () {
	if (!Hlp_Is_oCNPC (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);

	if (NPC_IsPlayer (slf)) {
		if (!Hlp_Is_oCNPC (slf.focus_vob)) { return; };
		
		var oCNPC oth; oth = _^ (slf.focus_vob);
		
		if (NPC_PreventLooting (oth)) {
			oCNpc_SetFocusVob (slf, 0);
		};
	};
};

func void G12_PreventLooting_Init () {
	const int once = 0;

	if (!once) {
		HookEngine (oCNPC__OpenDeadNPC, MEMINT_SwitchG1G2 (7, 6), "_hook_oCNPC_OpenDeadNPC");
		once = 1;
	};
};
