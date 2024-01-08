/*
 *	Patch fire damage multiplication exploit
 *
 *	 - there is messed up damage multiplication logic:
 *		- function oCNpc::OnDamage_Hit checks for weapon mode
 *		- if attackers **current** weapon mode is 3, 4, 5, 6 (NPC_WEAPON_1HS, NPC_WEAPON_2HS, NPC_WEAPON_BOW, NPC_WEAPON_CBOW)
 *		- if attackers talent skill for specified weapon > 0, then damage multiplier is multiplied by DAM_CRITICAL_MULTIPLIER
 *		- problem occurs when damage was caused by fire spells - which will create event EV_DAMAGE_PER_FRAME with reference to attacker
 *		- as soon as attacker draws melee weapon for example, this burning event will multiply damage by multiplier DAM_CRITICAL_MULTIPLIER - causing exponentially growing damage
 */

func void _hook_oCNpc_OnDamage_Hit_GetWeaponMode () {
	//In EAX we return weapon mode - by default return 0
	//this basically disables damage multiplication by DAM_CRITICAL_MULTIPLIER)
	EAX = 0;

	//Attacker
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNpc slf; slf = _^ (ECX);

	//Damage descriptor
	var int ddPtr; ddPtr = MEM_ReadInt (ESP + 4);
	if (ddPtr) {
		var oSDamageDescriptor dd; dd = _^ (ddPtr);

		//**only** if damage was inflicted by weapon we will return weapon mode
		if (Hlp_Is_oCItem (dd.itemWeapon)) {
			var oCItem weapon; weapon = _^ (dd.itemWeapon);

			const int ITM_FLAG_DAG = 1<<13;
			const int ITM_FLAG_SWD = 1<<14;
			const int ITM_FLAG_AXE = 1<<15;

			const int ITM_FLAG_2HD_SWD = 1<<16;
			const int ITM_FLAG_2HD_AXE = 1<<17;

			const int ITM_FLAG_BOW = 1<<19;
			const int ITM_FLAG_CROSSBOW = 1<<20;

			const int NPC_WEAPON_1HS = 3;
			const int NPC_WEAPON_2HS = 4;
			const int NPC_WEAPON_BOW = 5;
			const int NPC_WEAPON_CBOW = 6;

			if ((weapon.flags & ITM_FLAG_DAG) || (weapon.flags & ITM_FLAG_SWD) || (weapon.flags & ITM_FLAG_AXE)) {
				EAX = NPC_WEAPON_1HS;
			};

			if ((weapon.flags & ITM_FLAG_2HD_SWD) || (weapon.flags & ITM_FLAG_2HD_AXE)) {
				EAX = NPC_WEAPON_2HS;
			};

			if (weapon.flags & ITM_FLAG_BOW) {
				EAX = NPC_WEAPON_BOW;
			};

			if (weapon.flags & ITM_FLAG_CROSSBOW) {
				EAX = NPC_WEAPON_CBOW;
			};
		};
	};
};

func void G1_PatchFireDamageMultiplication () {
	const int once = 0;

	if (!once) {
		//0x00731410 public: void __thiscall oCNpc::OnDamage_Hit(struct oCNpc::oSDamageDescriptor &)

		//00732449
		const int oCNpc__OnDamage_Hit_CheckWeaponMode_3_G1 = 7545929;
		MEM_WriteNOP (oCNpc__OnDamage_Hit_CheckWeaponMode_3_G1, 8);
		HookEngine (oCNpc__OnDamage_Hit_CheckWeaponMode_3_G1, 5, "_hook_oCNpc_OnDamage_Hit_GetWeaponMode");

		//0073245d
		const int oCNpc__OnDamage_Hit_CheckWeaponMode_4_G1 = 7545949;
		MEM_WriteNOP (oCNpc__OnDamage_Hit_CheckWeaponMode_4_G1, 8);
		HookEngine (oCNpc__OnDamage_Hit_CheckWeaponMode_4_G1, 5, "_hook_oCNpc_OnDamage_Hit_GetWeaponMode");

		//00732471
		const int oCNpc__OnDamage_Hit_CheckWeaponMode_5_G1 = 7545969;
		MEM_WriteNOP (oCNpc__OnDamage_Hit_CheckWeaponMode_5_G1, 8);
		HookEngine (oCNpc__OnDamage_Hit_CheckWeaponMode_5_G1, 5, "_hook_oCNpc_OnDamage_Hit_GetWeaponMode");

		//00732485
		const int oCNpc__OnDamage_Hit_CheckWeaponMode_6_G1 = 7545989;
		MEM_WriteNOP (oCNpc__OnDamage_Hit_CheckWeaponMode_6_G1, 8);
		HookEngine (oCNpc__OnDamage_Hit_CheckWeaponMode_6_G1, 5, "_hook_oCNpc_OnDamage_Hit_GetWeaponMode");

		once = 1;
	};
};
