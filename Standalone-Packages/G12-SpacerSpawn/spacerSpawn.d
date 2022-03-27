/*
 *	Spacer spawn
 *	 - super simple feature that will insert into the world NPCs previously inserted via Spacer.
 *
 *	Principle:
 *	 - NPC inserted in Spacer does not have starting waypoint, it does not even have state_aiStatePosition, but it seems to retain its position, stored in _zCVob_trafoObjToWorld
 *	 - NPCs inserted into the world have either routine (oCNPC_States.hasRoutine) or ai state (oCNPC_States.aiStateDriven)
 *	 - whenever game tries to spawn an NPC it checks whether NPC has routine or ai state
 *	 - seems like NPC inserted via Spacer does not have any of these
 *	 - so in hooked function below we will check both properties - if NPC does not have routine and it does not have ai state - then we know this is NPC inserted via Spacer
 *	 - we can update it's spawn position state_aiStatePosition with it's 'physical' position _zCVob_trafoObjToWorld
 *	 - then we can update its aiStateDriven value to true - this will make sure NPC is inserted into the world by Gothic engine
 */
func void _hook_oCSpawnManager_SpawnNpc__SpacerSpawn () {
	var int slfPtr; slfPtr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (slfPtr)) { return; };

	var oCNpc slf; slf = _^ (slfPtr);

	var int statePtr; statePtr = NPC_GetNPCState (slf);
	if (!statePtr) { return; };
	var oCNPC_States state; state = _^ (statePtr);

	//If NPC does not have routine and it does not have ai state --> then it was inserted from Spacer
	if ((!state.hasRoutine) && (!state.aiStateDriven)) {
		//Update aiStateDriven - to kick in ai state
		state.aiStateDriven = 1;

		slf.state_aiStatePosition[0] = slf._zCVob_trafoObjToWorld[3];
		slf.state_aiStatePosition[1] = slf._zCVob_trafoObjToWorld[7];
		slf.state_aiStatePosition[2] = slf._zCVob_trafoObjToWorld[11];
	};
};

func void G12_SpacerSpawn_Init () {
	const int once = 0;
	if (!once) {
		//0x006D0710 public: void __thiscall oCSpawnManager::SpawnNpc(class oCNpc *,class zVEC3 const &,float)
		const int oCSpawnManager__SpawnNpc_G1 = 7145232;

		//0x00778E70 public: void __thiscall oCSpawnManager::SpawnNpc(class oCNpc *,class zVEC3 const &,float)
		const int oCSpawnManager__SpawnNpc_G2 = 7835248;

		HookEngine (MEMINT_SwitchG1G2 (oCSpawnManager__SpawnNpc_G1, oCSpawnManager__SpawnNpc_G2), 6, "_hook_oCSpawnManager_SpawnNpc__SpacerSpawn");

		once = 1;
	};
};
