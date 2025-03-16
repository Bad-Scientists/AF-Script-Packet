/*
 *	zCCamera_Get_activeCam
 *	 - gets active camera
 */
func int zCCamera_Get_activeCam () {
	//0x00873240 public: static class zCCamera * zCCamera::activeCam
	const int activeCam_addr_G1 = 8860224;

	//0x008D7F94 public: static class zCCamera * zCCamera::activeCam
	const int activeCam_addr_G2 = 9273236;

	return + MEM_ReadInt(MEMINT_SwitchG1G2 (activeCam_addr_G1, activeCam_addr_G2));
};

/*
 *	zCCamera_Activate
 *	 - activates camera - updates camMatrix
 */
func void zCCamera_Activate (var int camera) {
	//0x005364C0 public: void __thiscall zCCamera::Activate(void)
	const int zCCamera__Activate_G1 = 5465280;

	//0x0054A700 public: void __thiscall zCCamera::Activate(void)
	const int zCCamera__Activate_G2 = 5547776;

	if (!camera) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@(camera), MEMINT_SwitchG1G2 (zCCamera__Activate_G1, zCCamera__Activate_G2));
		call = CALL_End();
	};
};

/*
 *	zCCamera_ProjectF
 *	 - projects 3D points in the world to screen coordinates X & Y (floats)
 */
func void zCCamera_ProjectF (var int camera, var int posPtr, var int xscrPtrF, var int yscrPtrF) {
	//0x0051D7F0 public: void __thiscall zCCamera::Project(class zVEC3 const * const,float &,float &)const
	const int zCCamera__Project_G1 = 5363696;

	//0x00530030 public: void __thiscall zCCamera::Project(class zVEC3 const * const,float &,float &)const
	const int zCCamera__Project_G2 = 5439536;

	if (!camera) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam ( _@ (yscrPtrF));
		CALL_PtrParam ( _@ (xscrPtrF));
		CALL_PtrParam ( _@ (posPtr));
		CALL__thiscall (_@(camera), MEMINT_SwitchG1G2 (zCCamera__Project_G1, zCCamera__Project_G2));
		call = CALL_End();
	};
};

/*
 *	zCCamera_Project
 *	 - projects 3D points in the world to screen coordinates X & Y (ints)
 */
func void zCCamera_Project (var int camera, var int posPtr, var int xscrPtr, var int yscrPtr) {
	//0x005606D0 public: void __thiscall zCCamera::Project(class zVEC3 const * const,int &,int &)
	const int zCCamera__Project_G1 = 5637840;

	//0x0057A440 public: void __thiscall zCCamera::Project(class zVEC3 const * const,int &,int &)
	const int zCCamera__Project_G2 = 5743680;

	if (!camera) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam ( _@ (yscrPtr));
		CALL_PtrParam ( _@ (xscrPtr));
		CALL_PtrParam ( _@ (posPtr));
		CALL__thiscall (_@(camera), MEMINT_SwitchG1G2 (zCCamera__Project_G1, zCCamera__Project_G2));
		call = CALL_End();
	};
};

/*
 *	zCAIBase_Release
 *	 - ai camera destructor
 */
func void zCAIBase_Release (var int ai) {
	//0x004841F0 protected: virtual __thiscall zCAIBase::~zCAIBase(void)
	const int zCAIBase__zCAIBase_G1 = 4735472;

	//0x0048BE50 protected: virtual __thiscall zCAIBase::~zCAIBase(void)
	const int zCAIBase__zCAIBase_G2 = 4767312;

	if (!ai) { return; };

	zCObject_Release (ai);
};

/*
 *	oCNpc_ActivateDialogCam
 *	 - activates dialogue camera between Npcs (overrides oCNpc.talkOther pointer)
 */
func int oCNpc_ActivateDialogCam (var int slfInstance, var int othInstance, var int durationF) {
	//0x006B2430 public: int __thiscall oCNpc::ActivateDialogCam(float)
	const int oCNpc__ActivateDialogCam_G1 = 7021616;

	//0x00758130 public: int __thiscall oCNpc::ActivateDialogCam(float)
	const int oCNpc__ActivateDialogCam_G2 = 7700784;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	var oCNpc oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNpc (oth)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);
	slf.talkOther = _@ (oth);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_FloatParam (_@ (durationF));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__ActivateDialogCam_G1, oCNpc__ActivateDialogCam_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCNpc_DeactivateDialogCam
 *	 - deactivates dialogue camera
 */
func int oCNpc_DeactivateDialogCam (var int slfInstance) {
	//0x006B2670 public: int __thiscall oCNpc::DeactivateDialogCam(void)
	const int oCNpc__DeactivateDialogCam_G1 = 7022192;

	//0x00758360 public: int __thiscall oCNpc::DeactivateDialogCam(void)
	const int oCNpc__DeactivateDialogCam_G2 = 7701344;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DeactivateDialogCam_G1, oCNpc__DeactivateDialogCam_G2));
		call = CALL_End();
	};

	return + retVal;
};


/*
 *	zCSession_GetCameraVob
 *	 - returns camera vob zCVob *
 */
 func int zCSession_GetCameraVob () {
	//0x005B7290 public: virtual class zCVob * __thiscall zCSession::GetCameraVob(void)const
	const int zCSession__GetCameraVob_G1 = 5993104;

	//0x005DE7B0 public: virtual class zCVob * __thiscall zCSession::GetCameraVob(void)const
	const int zCSession__GetCameraVob_G2 = 6154160;

	//TODO: Can we use oCGame here: class oCGame : public zCSession { ?
	//Or do we need to get session via:
	//0x005F9C40 public: class zCSession * __thiscall zCWorld::GetOwnerSession(void)
	//0x00628480 public: class zCSession * __thiscall zCWorld::GetOwnerSession(void)

	var int retVal;
	var int gamePtr; gamePtr = _@ (MEM_Game);
	if (!gamePtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (gamePtr), MEMINT_SwitchG1G2 (zCSession__GetCameraVob_G1, zCSession__GetCameraVob_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCAICamera_SetVob
 *	 - sets up camera zCVob *
 */
func void zCAICamera_SetVob (var int aiPtr, var int vobPtr) {
	//0x00499910 public: void __thiscall zCAICamera::SetVob(class zCVob *)
	const int zCAICamera__SetVob_G1 = 4823312;

	//0x004A0E60 public: void __thiscall zCAICamera::SetVob(class zCVob *)
	const int zCAICamera__SetVob_G2 = 4853344;

	if (!aiPtr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (aiPtr), MEMINT_SwitchG1G2 (zCAICamera__SetVob_G1, zCAICamera__SetVob_G2));
		call = CALL_End();
	};
};

/*
 *	zCSession_GetCamera
 *	 - returns camera zCCamera *
 */
func int zCSession_GetCamera () {
	//0x005B7270 public: virtual class zCCamera * __thiscall zCSession::GetCamera(void)const
	const int zCSession__GetCamera_G1 = 5993072;

	//0x005DE790 public: virtual class zCCamera * __thiscall zCSession::GetCamera(void)const
	const int zCSession__GetCamera_G2 = 6154128;

	var int retVal;
	var int gamePtr; gamePtr = _@ (MEM_Game);

	if (!gamePtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (gamePtr), MEMINT_SwitchG1G2 (zCSession__GetCamera_G1, zCSession__GetCamera_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCSession_GetCameraAI
 *	 - returns camera zCAICamera *
 * (same as zCSession_GetCameraAI)
 */
func int zCSession_GetCameraAI () {
	//0x005B7280 public: virtual class zCAICamera * __thiscall zCSession::GetCameraAI(void)const
	const int zCSession__GetCameraAI_G1 = 5993088;

	//0x005DE7A0 public: virtual class zCAICamera * __thiscall zCSession::GetCameraAI(void)const
	const int zCSession__GetCameraAI_G2 = 6154144;

	var int retVal;
	var int gamePtr; gamePtr = _@ (MEM_Game);

	if (!gamePtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (gamePtr), MEMINT_SwitchG1G2 (zCSession__GetCameraAI_G1, zCSession__GetCameraAI_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCAICamera_GetCurrent
 *	 - returns camera zCAICamera *
 */
 func int zCAICamera_GetCurrent () {
	//0x004988E0 public: static class zCAICamera * __cdecl zCAICamera::GetCurrent(void)
	const int zCSession__GetCurrent_G1 = 4819168;

	//0x0049FD20 public: static class zCAICamera * __cdecl zCAICamera::GetCurrent(void)
	const int zCSession__GetCurrent_G2 = 4848928;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__cdecl (MEMINT_SwitchG1G2 (zCSession__GetCurrent_G1, zCSession__GetCurrent_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCAICamera_SetTarget
 *	 - sets target for camera ai
 */
func void zCAICamera_SetTarget (var int aiPtr, var int vobPtr) {
	//0x00499BC0 public: void __thiscall zCAICamera::SetTarget(class zCVob *)
	const int zCAICamera__SetTarget_G1 = 4824000;

	//0x004A1120 public: void __thiscall zCAICamera::SetTarget(class zCVob *)
	const int zCAICamera__SetTarget_G2 = 4854048;

	if (!aiPtr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL__thiscall (_@ (aiPtr), MEMINT_SwitchG1G2 (zCAICamera__SetTarget_G1, zCAICamera__SetTarget_G2));
		call = CALL_End();
	};
};

/*
 *	zCAICamera_ReceiveMsg
 *	 - msgPtr has to be pointer to message type!
 */
func void zCAICamera_ReceiveMsg (var int aiPtr, var int msgPtr) {
	//0x004998E0 public: void __thiscall zCAICamera::ReceiveMsg(enum zTAICamMsg const &)
	const int zCAICamera__ReceiveMsg_G1 = 4823264;

	//0x004A0E30 public: void __thiscall zCAICamera::ReceiveMsg(enum zTAICamMsg const &)
	const int zCAICamera__ReceiveMsg_G2 = 4853296;

	if (!aiPtr) { return; };
	if (!msgPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (msgPtr));
		CALL__thiscall (_@ (aiPtr), MEMINT_SwitchG1G2 (zCAICamera__ReceiveMsg_G1, zCAICamera__ReceiveMsg_G2));
		call = CALL_End();
	};
};

/*
 *	Camera_GetTarget
 *	 - returns target of camera ai
 */
func int Camera_GetTarget () {
	var int aiPtr; aiPtr = zCSession_GetCameraAI ();
	if (!aiPtr) { return 0; };

	var zCAICamera ai; ai = _^ (aiPtr);
	return ai.target;
};

/*
 *	Camera_SetTarget
 *	 - sets target for camera ai (zPLAYER_BEAMED message will switch to target immediately)
 */
func void Camera_SetTarget (var int vobPtr) {
	var int aiPtr; aiPtr = zCSession_GetCameraAI ();
	zCAICamera_SetTarget (aiPtr, vobPtr);
	zCAICamera_ReceiveMsg (aiPtr, _@ (zPLAYER_BEAMED));
};

/*
 *	Dangerous - can despawn player if you are not careful :)
 *	Engine function is unstable if called multiple times - accesses pointer to an Npc which might be meanwhile invalid?
 *
 *	!!! use 'safe' version of the function below !!!
 */

//func void oCGame_SwitchCamToNextNpc () {
//	//0x0065EDD0 public: void __thiscall oCGame::SwitchCamToNextNpc(void)
//	const int oCGame_SwitchCamToNextNpc_G1 = 6680016;
//
//	//0x006FBF40 public: void __thiscall oCGame::SwitchCamToNextNpc(void)
//	const int oCGame_SwitchCamToNextNpc_G2 = 7323456;
//
//	var int gamePtr; gamePtr = _@ (MEM_Game);
//	if (!gamePtr) { return; };
//
//	//const int call = 0;
//	//if (CALL_Begin(call)) {
//		CALL__thiscall (gamePtr, MEMINT_SwitchG1G2 (oCGame_SwitchCamToNextNpc_G1, oCGame_SwitchCamToNextNpc_G2));
//	//	call = CALL_End();
//	//};
//};

var int watchNpcNr;

func void oCGame_SwitchCamToNextNpc_Reset () {
	watchNpcNr = 0;
};

/*
 *	oCGame_SwitchCamToNextNpc
 *	 - switches camera to next Npc npc voblist
 *	 - returns pointer of target Npc
 */
func int oCGame_SwitchCamToNextNpc () {
	var int listPtr;
	listPtr = MEM_World_Get_voblist_npcs ();

	var int npcNr; npcNr = -1;
	var int npcPtr; npcPtr = 0;

	var zCListSort list;

	while (listPtr);
		list = _^ (listPtr);
		if (zCVob_GetHomeWorld (list.data)) {
			npcNr += 1;

			if (npcNr == watchNpcNr) {
				npcPtr = list.data;
				watchNpcNr += 1;
				break;
			};
		};

		listPtr = list.next;
	end;

	if (npcPtr) {
		Camera_SetTarget (npcPtr);
	} else {
		watchNpcNr = 0;
	};

	return + npcPtr;
};
