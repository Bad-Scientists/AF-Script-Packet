/*
 *	Output units
 */

/*
 *	oCSVMManager_GetOU
 *	 - returns SVM output unit instance ID
 */
func int oCSVMManager_GetOU (var string svm, var int voice) {
	//0x006D1520 public: int __thiscall oCSVMManager::GetOU(class zSTRING const &,int)
	const int oCSVMManager__GetOU_G1 = 7148832;

	//0x00779E50 public: int __thiscall oCSVMManager::GetOU(class zSTRING const &,int)
	const int oCSVMManager__GetOU_G2 = 7839312;

	if (!MEM_Game.svmman) { return -1; };

	CALL_IntParam (voice);
	CALL_zStringPtrParam (svm);
	CALL__thiscall (MEM_Game.svmman, MEMINT_SwitchG1G2 (oCSVMManager__GetOU_G1, oCSVMManager__GetOU_G2));

	return CALL_RetValAsInt ();
};

func int zCCSManager_LibGet (var int ou) {
	//0x0041BA30 public: virtual class zCCSBlock * __thiscall zCCSManager::LibGet(int)
	const int zCCSManager__LibGet_G1 = 4307504;

	//0x0041BF20 public: virtual class zCCSBlock * __thiscall zCCSManager::LibGet(int)
	const int zCCSManager__LibGet_G2 = 4308768;

	if (!MEM_Game._zCSession_csMan) { return 0; };
	var int csManPtr; csManPtr = MEM_Game._zCSession_csMan; //zCCSManager*

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (ou));
		CALL__thiscall (_@ (csManPtr), MEMINT_SwitchG1G2 (zCCSManager__LibGet_G1, zCCSManager__LibGet_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCCSManager_LibGetSvmModuleName
 *	 - returns name of SVM instance ID
 */
func string zCCSManager_LibGetSvmModuleName (var int ou) {
	//0x004196C0 public: virtual class zSTRING __thiscall zCCSManager::LibGetSvmModuleName(int)
	const int zCCSManager__LibGetSvmModuleName_G1 = 4298432;

	//0x00419BC0 public: virtual class zSTRING __thiscall zCCSManager::LibGetSvmModuleName(int)
	const int zCCSManager__LibGetSvmModuleName_G2 = 4299712;

	if (!MEM_Game._zCSession_csMan) { return STR_EMPTY; };

	CALL_RetValIszString ();
	CALL_IntParam (ou);
	CALL__thiscall (MEM_Game._zCSession_csMan, MEMINT_SwitchG1G2 (zCCSManager__LibGetSvmModuleName_G1, zCCSManager__LibGetSvmModuleName_G2));

	return CALL_RetValAszstring ();
};

/*
 *	zCCSManager_LibIsSvmModuleRunning
 *	 - checks if SVM is runinng
 */
func int zCCSManager_LibIsSvmModuleRunning (var int ou) {
	//0x00419980 public: virtual int __thiscall zCCSManager::LibIsSvmModuleRunning(int)
	const int zCCSManager__LibIsSvmModuleRunning_G1 = 4299136;

	//0x00419E80 public: virtual int __thiscall zCCSManager::LibIsSvmModuleRunning(int)
	const int zCCSManager__LibIsSvmModuleRunning_G2 = 4300416;

	if (!MEM_Game._zCSession_csMan) { return FALSE; };
	var int csManPtr; csManPtr = MEM_Game._zCSession_csMan;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (ou));
		CALL__thiscall (_@ (csManPtr), MEMINT_SwitchG1G2 (zCCSManager__LibIsSvmModuleRunning_G1, zCCSManager__LibIsSvmModuleRunning_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCCSManager_LibSvmModuleStop
 *	 - stops SVM ou
 */
func int zCCSManager_LibSvmModuleStop (var int ou) {
	//0x00419C60 public: virtual int __thiscall zCCSManager::LibSvmModuleStop(int)
	const int zCCSManager__LibSvmModuleStop_G1 = 4299872;

	//0x0041A160 public: virtual int __thiscall zCCSManager::LibSvmModuleStop(int)
	const int zCCSManager__LibSvmModuleStop_G2 = 4301152;

	if (!MEM_Game._zCSession_csMan) { return FALSE; };
	var int csManPtr; csManPtr = MEM_Game._zCSession_csMan;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (ou));
		CALL__thiscall (_@ (csManPtr), MEMINT_SwitchG1G2 (zCCSManager__LibSvmModuleStop_G1, zCCSManager__LibSvmModuleStop_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int zCCSManager_LibValidateOU (var int ou) {
	//0x0041BE20 public: virtual int __thiscall zCCSManager::LibValidateOU(int)
	const int zCCSManager__LibValidateOU_G1 = 4308512;

	//0x0041C3B0 public: virtual int __thiscall zCCSManager::LibValidateOU(int)
	const int zCCSManager__LibValidateOU_G2 = 4309936;

	if (!MEM_Game._zCSession_csMan) { return -1; };
	var int csManPtr; csManPtr = MEM_Game._zCSession_csMan;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (ou));
		CALL__thiscall (_@ (csManPtr), MEMINT_SwitchG1G2 (zCCSManager__LibValidateOU_G1, zCCSManager__LibValidateOU_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int zCCSManager_LibValidateOU_ByName (var string ou) {
	//0x0041BE50 public: virtual int __thiscall zCCSManager::LibValidateOU(class zSTRING &)
	const int zCCSManager__LibValidateOU_G1 = 4308560;

	//0x0041C3E0 public: virtual int __thiscall zCCSManager::LibValidateOU(class zSTRING &)
	const int zCCSManager__LibValidateOU_G2 = 4309984;

	if (!MEM_Game._zCSession_csMan) { return -1; };

	CALL_zStringPtrParam (ou);
	CALL__thiscall (MEM_Game._zCSession_csMan, MEMINT_SwitchG1G2 (zCCSManager__LibValidateOU_G1, zCCSManager__LibValidateOU_G2));

	return CALL_RetValAsInt ();
};

func void Npc_StartOutputUnit (var int slfInstance, var int diaInstance) {
	//0x006C63B0 public: void __thiscall oCNpc_States::StartOutputUnit(int)
	const int oCNpc_States__StartOutputUnit_G1 = 7103408;

	//0x0076D8F0 public: void __thiscall oCNpc_States::StartOutputUnit(int)
	const int oCNpc_States__StartOutputUnit_G2 = 7788784;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//NPC_GetNPCState replacing with 'raw' implementation because of compilation order
	//var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	var int statePtr; statePtr = _@ (slf) + MEMINT_SwitchG1G2 (1136, 1416);
	if (!statePtr) { return; };

	if (diaInstance == -1) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (diaInstance));
		CALL__thiscall (_@ (statePtr), MEMINT_SwitchG1G2 (oCNpc_States__StartOutputUnit_G1, oCNpc_States__StartOutputUnit_G2));
		call = CALL_End();
	};
};

func void Npc_OutputSVM (var int slfInstance, var string svm) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int ou; ou = oCSVMManager_GetOU (svm, slf.voice);
	Npc_StartOutputUnit (slf, ou);
};

func void Npc_Output (var int slfInstance, var string ouName) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int ou; ou = zCCSManager_LibValidateOU_ByName (ouName);
	Npc_StartOutputUnit (slf, ou);
};

func void Npc_StopSVM (var int slfInstance, var string svm) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int ou; ou = oCSVMManager_GetOU (svm, slf.voice);
	var int retVal; retVal = zCCSManager_LibSvmModuleStop (ou);
};
