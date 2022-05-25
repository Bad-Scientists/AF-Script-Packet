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


/*
 *	Set insert range
 */
func void oCSpawnManager_SetInsertRange (var int f) {
	//0x006CF5D0 public: static void __cdecl oCSpawnManager::SetInsertRange(float)
	const int oCSpawnManager__SetInsertRange_G1 = 7140816;

	//0x00777820 public: static void __cdecl oCSpawnManager::SetInsertRange(float)
	const int oCSpawnManager__SetInsertRange_G2 = 7829536;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (f));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCSpawnManager__SetInsertRange_G1, oCSpawnManager__SetInsertRange_G2));
		call = CALL_End ();
	};
};

/*
 *	Get insert range
 */
func int oCSpawnManager_GetInsertRange () {
	//0x006CF5E0 public: static float __cdecl oCSpawnManager::GetInsertRange(void)
	const int oCSpawnManager__GetInsertRange_G1 = 7140832;

	//0x00777830 public: static float __cdecl oCSpawnManager::GetInsertRange(void)
	const int oCSpawnManager__GetInsertRange_G2 = 7829552;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCSpawnManager__GetInsertRange_G1, oCSpawnManager__GetInsertRange_G2));
		call = CALL_End ();
	};

	return +retVal;
};

/*
 *	Set remove range
 */
func void oCSpawnManager_SetRemoveRange (var int f) {
	//0x006CF5F0 public: static void __cdecl oCSpawnManager::SetRemoveRange(float)
	const int oCSpawnManager__SetRemoveRange_G1 = 7140848;

	//0x00777840 public: static void __cdecl oCSpawnManager::SetRemoveRange(float)
	const int oCSpawnManager__SetRemoveRange_G2 = 7829568;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (f));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCSpawnManager__SetRemoveRange_G1, oCSpawnManager__SetRemoveRange_G2));
		call = CALL_End ();
	};
};

/*
 *	Get remove range
 */
func int oCSpawnManager_GetRemoveRange () {
	//0x006CF600 public: static float __cdecl oCSpawnManager::GetRemoveRange(void)
	const int oCSpawnManager__GetRemoveRange_G1 = 7140864;

	//0x00777850 public: static float __cdecl oCSpawnManager::GetRemoveRange(void)
	const int oCSpawnManager__GetRemoveRange_G2 = 7829584;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCSpawnManager__GetRemoveRange_G1, oCSpawnManager__GetRemoveRange_G2));
		call = CALL_End ();
	};

	return +retVal;
};

/*
 *	Set spawn time
 */
func void oCSpawnManager_SetSpawnTime (var int f) {
	//0x006CF610 public: static void __cdecl oCSpawnManager::SetSpawnTime(float)
	const int oCSpawnManager__SetSpawnTime_G1 = 7140880;

	//0x00777860 public: static void __cdecl oCSpawnManager::SetSpawnTime(float)
	const int oCSpawnManager__SetSpawnTime_G2 = 7829600;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (f));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCSpawnManager__SetSpawnTime_G1, oCSpawnManager__SetSpawnTime_G2));
		call = CALL_End ();
	};
};

/*
 *	Get spawn time
 */
func int oCSpawnManager_GetSpawnTime () {
	//0x006CF620 public: static float __cdecl oCSpawnManager::GetSpawnTime(void)
	const int oCSpawnManager__GetSpawnTime_G1 = 7140896;

	//0x00777870 public: static float __cdecl oCSpawnManager::GetSpawnTime(void)
	const int oCSpawnManager__GetSpawnTime_G2 = 7829616;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCSpawnManager__GetSpawnTime_G1, oCSpawnManager__GetSpawnTime_G2));
		call = CALL_End ();
	};

	return +retVal;
};

/*
 *	Get spawn node for specific NPC
 */
func int oCSpawnManager_GetNodePtr (var int npcPtr) {
	if (!MEM_SpawnManager.spawnList_array) { return 0; };
	if (!MEM_SpawnManager.spawnList_numInArray) { return 0; };

	repeat (i, MEM_SpawnManager.spawnList_numInArray); var int i;
		var int spawnNodePtr; spawnNodePtr = MEM_ReadIntArray (MEM_SpawnManager.spawnList_array, i);
		if (spawnNodePtr) {
			//NPC pointer is @ offset 0, we don't really need to converr pointer to oSSpawnNode object

			//var oSSpawnNode spawnNode; spawnNode = _^ (spawnNodePtr);
			//if (npcPtr == spawnNode.npc) {
			//	return spawnNodePtr;
			//};
			if (MEM_ReadInt (spawnNodePtr) == npcPtr) {
				return spawnNodePtr;
			};
		};
	end;

	return 0;
};
