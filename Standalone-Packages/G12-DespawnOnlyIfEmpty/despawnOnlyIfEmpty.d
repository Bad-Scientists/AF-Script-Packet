/*
 *	Simple feature preventing despawn of dead NPCs, if they have anything in their inventory
 */
func void _hook_oCSpawnManager_CheckInsertNpc_HasMissionItem () {
	//ECX 0x007DDF34 const oCNpc::`vftable'

	//0x0066D550 public: virtual int __thiscall oCNpcInventory::IsEmpty(void)

	//ignoreArmor, ignoreActive
	//0x0070D1A0 public: virtual int __thiscall oCNpcInventory::IsEmpty(int,int)

	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNpc slf; slf = _^ (ECX);

	//If inventory is not empty - prevent despawn
	if (!NPC_InventoryIsEmpty (slf, 0, 0, TRUE)) {
		//Return TRUE
		EAX = 1;
		return;
	};

	//Return FALSE;
	EAX = 0;
};

func void G12_DespawnOnlyIfEmpty_Init () {
	const int once = 0;
	if (!once) {
		//0x006CFDE0 private: void __thiscall oCSpawnManager::CheckInsertNpc(void)

		//006cfe3b
		const int oCSpawnManager__CheckInsertNpc_HasMissionItem_G1 = 7142971;

		//00778227
		const int oCSpawnManager__CheckInsertNpc_HasMissionItem_G2 = 7832103;

		var int addr; addr = MEMINT_SwitchG1G2 (oCSpawnManager__CheckInsertNpc_HasMissionItem_G1, oCSpawnManager__CheckInsertNpc_HasMissionItem_G2);

		MEM_WriteNOP (addr, 5);
		HookEngine (addr, 5, "_hook_oCSpawnManager_CheckInsertNpc_HasMissionItem");

		//const int spawnRemoveNpcOnlyIfEmpty_addr_G2 = 9153756;
		//MemoryProtectionOverride(spawnRemoveNpcOnlyIfEmpty_addr_G2, 1);
		//MEM_WriteByte (spawnRemoveNpcOnlyIfEmpty_addr_G2, 1);

		once = 1;
	};
};
