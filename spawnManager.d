/*
 *	Function removes NPC from world
 */
func void oCSpawnManager_DeleteNpc (var int slfPtr) {
	//0x006D0DE0 public: void __thiscall oCSpawnManager::DeleteNpc(class oCNpc *)
	const int oCSpawnManager__DeleteNpc_G1 = 7146976;

	//0x00779690 public: void __thiscall oCSpawnManager::DeleteNpc(class oCNpc *)
	const int oCSpawnManager__DeleteNpc_G2 = 7837328;

	if (!slfPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (MEM_Game.spawnman), MEMINT_SwitchG1G2 (oCSpawnManager__DeleteNpc_G1, oCSpawnManager__DeleteNpc_G2));
		call = CALL_End ();
	};
};

func void oCSpawnManager_SpawnNpc_AtPos (var int slfPtr, var int posPtr, var int timeDelayF) {
	//0x006D0710 public: void __thiscall oCSpawnManager::SpawnNpc(class oCNpc *,class zVEC3 const &,float)
	const int oCSpawnManager__SpawnNpc_G1 = 7145232;

	//0x00778E70 public: void __thiscall oCSpawnManager::SpawnNpc(class oCNpc *,class zVEC3 const &,float)
	const int oCSpawnManager__SpawnNpc_G2 = 7835248;

	if (!slfPtr) { return; };
	if (!posPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_FloatParam (_@ (timeDelayF));
		CALL_PtrParam (_@ (posPtr));
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (MEM_Game.spawnman), MEMINT_SwitchG1G2 (oCSpawnManager__SpawnNpc_G1, oCSpawnManager__SpawnNpc_G2));
		call = CALL_End ();
	};
};

func void oCSpawnManager_SpawnNpc_AtVob (var int slfPtr, var string targetVob, var int timeDelayF) {
	//0x006D04C0 public: void __thiscall oCSpawnManager::SpawnNpc(class oCNpc *,class zSTRING const &,float)
	const int oCSpawnManager__SpawnNpc_G1 = 7144640;

	//0x00778BA0 public: void __thiscall oCSpawnManager::SpawnNpc(class oCNpc *,class zSTRING const &,float)
	const int oCSpawnManager__SpawnNpc_G2 = 7834528;

	if (!slfPtr) { return; };

	CALL_FloatParam (timeDelayF);
	CALL_zStringPtrParam (targetVob);
	CALL_PtrParam (slfPtr);
	CALL__thiscall (MEM_Game.spawnman, MEMINT_SwitchG1G2 (oCSpawnManager__SpawnNpc_G1, oCSpawnManager__SpawnNpc_G2));
};

func int oCSpawnManager_InsertNpc (var int slfPtr, var int posPtr) {
	//0x006D0250 private: int __thiscall oCSpawnManager::InsertNpc(class oCNpc *,class zVEC3 const &)
	const int oCSpawnManager__InsertNpc_G1 = 7144016;

	//0x00778920 private: int __thiscall oCSpawnManager::InsertNpc(class oCNpc *,class zVEC3 const &)
	const int oCSpawnManager__InsertNpc_G2 = 7833888;

	if (!slfPtr) { return 0; };
	if (!posPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (posPtr));
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (MEM_Game.spawnman), MEMINT_SwitchG1G2 (oCSpawnManager__InsertNpc_G1, oCSpawnManager__InsertNpc_G2));
		call = CALL_End ();
	};

	return CALL_RetValAsInt ();
};
