/*
 *	Patch fixing fight combos
 *	 - with this patch Npcs can now use combos! :)
 *
 *	 - G1 FAI uses combos - defined FAI_HUMAN_MASTER.D - but they were not working ...
 *	 - G2 NOTR DOES NOT USE combos by default - you will have to update your Fight AI logic
 *
 *	MOVE_MASTERATTACK is the one that performs combo:
 *
 *	Fight AI entries:
 *
 *	MOVE_SIDEATTACK			Left --> Right
 *	MOVE_FRONTATTACK		Left --> Foward
 *	or						Foward --> Right
 *
 *	MOVE_TRIPLEATTACK		Foward --> Right -->Left
 *	or						Left --> Right --> Foward
 *
 *	MOVE_WHIRLATTACK		Left --> Right --> Left --> Right
 *	MOVE_MASTERATTACK		Left --> Right --> [Foward --> Foward --> Foward --> Foward] == combo
 *
 */


/*
Usage - call from Init_Global after Ikarus & LeGo initialization

func void Init_Global () {
	//Ikarus initialization
	MEM_InitAll();

	//LeGo intializatoin
	LeGo_Init (yourflags |
		LeGo_HookEngine
		);

	//Patch fight combos
	G12_PatchFightCombos ();
};

*/

func void _hook_oCNpc_EV_AttackForward_HitCombo_Npc () {
	if (!ECX) { return; };
	var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (ECX);

	if (!aniCtrl.npc) { return; };
	var oCNpc slf; slf = _^ (aniCtrl.npc);

	//If Npc is in combo animation
	if (oCAniCtrl_Human_IsInCombo (ECX)) {
		//Some fight styles don't have combos - if we would enable combo - Npc would freeze in their animation
		//Check if combo can be enabled
		if (aniCtrl.comboNr + 1 < aniCtrl.comboMax) {
			//Enable combo :)
			const int canEnableNextCombo = 1;
			aniCtrl.bitfield = aniCtrl.bitfield | canEnableNextCombo;
		};
	};
};

func void G12_PatchFightCombos () {
	const int once = 0;
	if (!once) {

		//In engine there is an incorrect condition check (< instead of >) ... we need to swap EAX - EDX comparison to fix it
		//3b c2 CMP EAX, EDX
		//3b d0 CMP EDX, EAX

		//006aae8f
		const int oCNpc__EV_AttackForward_ComboCheck_G1 = 6991503;

		//0074ff77
		const int oCNpc__EV_AttackForward_ComboCheck_G2 = 7667575;

		var int addr; addr = MEMINT_SwitchG1G2 (oCNpc__EV_AttackForward_ComboCheck_G1, oCNpc__EV_AttackForward_ComboCheck_G2);

		MemoryProtectionOverride (addr + 1, 1);
		MEM_WriteByte (addr + 1, 208); //D0

		//Additionally we need to add canEnableNextCombo flag to aniCtrl if aniCtrl is in combo animation ... this is handled by hook below
		//006aae99
		const int oCNpc__EV_AttackForward_HitCombo_Npc_G1 = 6991513;

		//0074ff81
		const int oCNpc__EV_AttackForward_HitCombo_Npc_G2 = 7667585;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__EV_AttackForward_HitCombo_Npc_G1, oCNpc__EV_AttackForward_HitCombo_Npc_G2), 5, "_hook_oCNpc_EV_AttackForward_HitCombo_Npc");

		once = 1;
	};
};
