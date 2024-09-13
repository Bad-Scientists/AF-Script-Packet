/*
 *	These are some useful engine ANIMATION functions
 *	by Milgos, Fawkes and Auronen
 */

func int oCNPC_GetModel (var int slfInstance) {
	//0x00695300 public: class zCModel * __thiscall oCNpc::GetModel(void)
	const int oCNPC__GetModel_G1 = 6902528;

	//0x00738720 public: class zCModel * __thiscall oCNpc::GetModel(void)
	const int oCNPC__GetModel_G2 = 7571232;

	//check if npc is valid
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__GetModel_G1, oCNPC__GetModel_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 * 	  Returns aniID based on animation name
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */
func int zCModel_GetAniIdFromAniName (var int modelPtr, var string aniName) {
	//0x0047EC50 public: int __thiscall zCModel::GetAniIDFromAniName(class zSTRING const &)const
	const int zCModel__GetAniIdFromAniName_G1 = 4713552;

	//0x00612070 public: int __thiscall zCModel::GetAniIDFromAniName(class zSTRING const &)const
	const int zCModel__GetAniIdFromAniName_G2 = 6365296;

	// check
	if (!modelPtr) { return -1; };
	aniName = Str_Upper (aniName);

	//CALL_zstringPtrParam cannot be used in recyclable call
	CALL_zstringPtrParam (aniName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetAniIdFromAniName_G1, zCModel__GetAniIdFromAniName_G2));

	return CALL_RetValAsInt();
};

/*
 *    Returns aniPtr based on animation ID
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniID         		animation ID
 */
func int zCModel_GetAniFromAniID (var int modelPtr, var int aniID) { //zCModelAni *
	//0x0046D1E0 public: class zCModelAni * __thiscall zCModel::GetAniFromAniID(int)const
	const int zCModel__GetAniFromAniID_G1 = 4641248;

	//0x00472F50 public: class zCModelAni * __thiscall zCModel::GetAniFromAniID(int)const
	const int zCModel__GetAniFromAniID_G2 = 4665168;

	// checks
	if (!modelPtr) { return 0; };
	if (aniID == -1) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (aniID));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__GetAniFromAniID_G1, zCModel__GetAniFromAniID_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *    Plays animation using animation name
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniName         	animation name
 *	  @param param2				I have no idea, what it does
 */

//Name changed from zCModel_StartAni to zCModel_StartAnimation --> to match engine function name
func void zCModel_StartAnimation (var int modelPtr, var string aniName) {
	//0x0055CE40 public: virtual void __thiscall zCModel::StartAnimation(class zSTRING const &)
	const int zCModel__StartAnimation_G1 = 5623360;

	//0x005765E0 public: virtual void __thiscall zCModel::StartAnimation(class zSTRING const &)
	const int zCModel__StartAnimation_G2 = 5727712;

	if (!modelPtr) { return; };
	aniName = Str_Upper (aniName);

	//CALL_zstringPtrParam cannot be used in recyclable call
	CALL_zStringPtrParam (aniName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__StartAnimation_G1, zCModel__StartAnimation_G2));
};

/*
enum {
	zMDL_STARTANI_DEFAULT,
	zMDL_STARTANI_ISNEXTANI,
	zMDL_STARTANI_FORCE
};
*/

func void zCModel_StartAni (var int modelPtr, var string aniName, var int startMode) {
	//0x005611A0 public: void __thiscall zCModel::StartAni(class zSTRING const &,int)
	const int zCModel__StartAni_G1 = 5640608;

	//0x0057AF70 public: void __thiscall zCModel::StartAni(class zSTRING const &,int)
	const int zCModel__StartAni_G2 = 5746544;

	if (!modelPtr) { return; };
	aniName = Str_Upper (aniName);

	CALL_IntParam (startMode);
	CALL_zStringPtrParam (aniName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__StartAni_G1, zCModel__StartAni_G2));
};

//void zCModel::StartAni (zTModelAniID aniID, const int startMode)
//0x005612A0 public: void __thiscall zCModel::StartAni(int,int)

//void zCModel::StartAni (zCModelAni* protoAni, const int startMode)
//0x005612F0 public: void __thiscall zCModel::StartAni(class zCModelAni *,int)

/*
 *	Plays animation using animation pointer
 *
 *	modelPtr
 *	int aniID
 *	int startMode
 */

//Function zCModel_StartAniByAniID changed to zCModel_StartAni_ByAniID
func void zCModel_StartAni_ByAniID (var int modelPtr, var int aniID, var int startMode) {
	//0x005612A0 public: void __thiscall zCModel::StartAni(int,int)
	const int zCModel__StartAni_ByAniID_G1 = 5640864;

	//0x0057B070 public: void __thiscall zCModel::StartAni(int,int)
	const int zCModel__StartAni_ByAniID_G2 = 5746800;

	//checks
	if (!modelPtr) { return; };
	if (aniID == -1) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (startMode));
		CALL_IntParam (_@ (aniID));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__StartAni_ByAniID_G1, zCModel__StartAni_ByAniID_G2));
		call = CALL_End();
	};
};

/*
 *    Returns AniActivePtr using animation pointer
 *
 *    @param zCModel		    zCModelPtr
 *    @param zCModelAniPtr      animation pointer
 */
func int zCModel_GetActiveAni (var int modelPtr, var int modelAniPtr) { //zCModelAniActive *
	//0x00560DD0 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(class zCModelAni *)const
	const int zCModel__GetActiveAni_G1 = 5639632;

	//0x0057ABA0 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(class zCModelAni *)const
	const int zCModel__GetActiveAni_G2 = 5745568;

	// checks
	if (!modelPtr) { return 0; };
	if (!modelAniPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (modelAniPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__GetActiveAni_G1, zCModel__GetActiveAni_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *    Returns AniActivePtr using animation id
 *
 *    @param zCModel		    zCModelPtr
 *    @param aniID      		animation id
 */
func int zCModel_GetActiveAni_ByAniID (var int modelPtr, var int aniID) { //zCModelAniActive *
	//0x00560D90 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(int)const
	const int zCModel__GetActiveAni_ByAniID_G1 = 5639568;

	//0x0057AB60 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(int)const
	const int zCModel__GetActiveAni_ByAniID_G2 = 5745504;

	// checks
	if (!modelPtr) { return 0; };
	if (aniID == -1) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (aniID));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__GetActiveAni_ByAniID_G1, zCModel__GetActiveAni_ByAniID_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *    Sets progress percentage for active animation
 *
 *    @param zCModelAniActivePtr        active animation pointer
 *    @param progress      				progress (0.0 to 1.0)
 */
func void zCModelAniActive_SetProgressPercent (var int modelAniActivePtr, var int progressF) {
	//0x0055D510 public: void __thiscall zCModelAniActive::SetProgressPercent(float)
	const int zCModelAniActive__SetProgressPercent_G1 = 5625104;

	//0x00576CA0 public: void __thiscall zCModelAniActive::SetProgressPercent(float)
	const int zCModelAniActive__SetProgressPercent_G2 = 5729440;

	//checks
	if (!modelAniActivePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (progressF));
		CALL__thiscall (_@ (modelAniActivePtr), MEMINT_SwitchG1G2 (zCModelAniActive__SetProgressPercent_G1, zCModelAniActive__SetProgressPercent_G2));
		call = CALL_End();
	};
};

/*
 *    Sets active animation to a specified frame
 *
 *    @param zCModelAniActivePtr        active animation pointer
 *    @param frame      				frame number (float)
 */
func void zCModelAniActive_SetActFrame (var int modelAniActivePtr, var int frameF) {
	//0x0055D560 public: void __thiscall zCModelAniActive::SetActFrame(float)
	const int zCModelAniActive__SetActFrame_G1 = 5625184;

	//0x00576CF0 public: void __thiscall zCModelAniActive::SetActFrame(float)
	const int zCModelAniActive__SetActFrame_G2 = 5729520;

	//checks
	if (!modelAniActivePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (frameF));
		CALL__thiscall (_@ (modelAniActivePtr), MEMINT_SwitchG1G2 (zCModelAniActive__SetActFrame_G1, zCModelAniActive__SetActFrame_G2));
		call = CALL_End();
	};
};

/*
 *	  Sets direction for active animation
 *
 *    @param zCModelAniActivePtr        active animation pointer
 *    @param direction      			direction - "AniDir_Forward" or "AniDir_Reverse"
 */
func void zCModelAniActive_SetDirection (var int modelAniActivePtr, var int direction) {
	//0x0055D480 public: void __thiscall zCModelAniActive::SetDirection(enum zTMdl_AniDir)
	const int zCModelAniActive__SetDirection_G1 = 5624960;

	//0x00576C10 public: void __thiscall zCModelAniActive::SetDirection(enum zTMdl_AniDir)
	const int zCModelAniActive__SetDirection_G2 = 5729296;

	//checks
	if (!modelAniActivePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (direction));
		CALL__thiscall (_@ (modelAniActivePtr), MEMINT_SwitchG1G2 (zCModelAniActive__SetDirection_G1, zCModelAniActive__SetDirection_G2));
		call = CALL_End();
	};
};

/*
 *    Get the progress of active animation (zCModelAniActive)
 *
 *    @param zCModel     zCModelptr
 *	  @param aniName	 animation name
 */
func int zCModelAniActive_GetProgressPercent (var int modelAniActivePtr) { // float
	//0x0055D4D0 public: float __thiscall zCModelAniActive::GetProgressPercent(void)const
	const int zCModelAniActive__GetProgressPercent_G1 = 5625040;

	//0x00576C60 public: float __thiscall zCModelAniActive::GetProgressPercent(void)const
	const int zCModelAniActive__GetProgressPercent_G2 = 5729376;

	if (!modelAniActivePtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (modelAniActivePtr), MEMINT_SwitchG1G2 (zCModelAniActive__GetProgressPercent_G1, zCModelAniActive__GetProgressPercent_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *    Get the progress of active animation (zCModel)
 *
 *    @param zCModel     zCModelptr
 *	  @param aniID	 	animation ID
 */
func int zCModel_GetProgressPercent_ByAniID (var int modelPtr, var int aniID) {
	// ! Seems like engine function zCModel::GetProgressPercent is unstable and might crash !
	//So instead using here zCModelAniActive::GetProgressPercent which so far was working properly

	/*
	//0x005652C0 public: float __thiscall zCModel::GetProgressPercent(int)const
	const int zCModel__GetProgressPercent_ByAniID_G1 = 5657280;

	//0x0057F340 public: float __thiscall zCModel::GetProgressPercent(int)const
	const int zCModel__GetProgressPercent_ByAniID_G2 = 5763904;

	//check
	if (!modelPtr) { return FLOATNULL; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam (_@ (aniID));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__GetProgressPercent_ByAniID_G1, zCModel__GetProgressPercent_ByAniID_G2));
		call = CALL_End();
	};

	return + retVal;
	*/

	var int aniActivePtr; aniActivePtr = zCModel_GetActiveAni_ByAniID(modelPtr, aniID);
	return + zCModelAniActive_GetProgressPercent (aniActivePtr);
};

/*
 *    Get the progress of active animation (zCModel)
 *
 *    @param zCModel     zCModelptr
 *	  @param aniName	 animation name
 */
func int zCModel_GetProgressPercent_ByAniName (var int modelPtr, var string aniName) {
	// ! Seems like engine function zCModel::GetProgressPercent is unstable and might crash !
	//So instead using here zCModelAniActive::GetProgressPercent which so far was working properly

	/*
	//0x00565210 public: float __thiscall zCModel::GetProgressPercent(class zSTRING const &)const
	const int zCModel__GetProgressPercent_ByAniName_G1 = 5657104;

	//0x0057F290 public: float __thiscall zCModel::GetProgressPercent(class zSTRING const &)const
	const int zCModel__GetProgressPercent_ByAniName_G2 = 5763728;

	if (!modelPtr) { return FLOATNULL; };
	aniName = STR_Upper (aniName);

	CALL_RetValIsFloat (); // method returns float
	//CALL_zstringPtrParam cannot be used in recyclable call
	CALL_zStringPtrParam (aniName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetProgressPercent_ByAniName_G1, zCModel__GetProgressPercent_ByAniName_G2));
	return CALL_RetValAsFloat ();
	*/

	if (!modelPtr) { return FLOATNULL; };
	var int aniID; aniID = zCModel_GetAniIdFromAniName (modelPtr, aniName);
	return + zCModel_GetProgressPercent_ByAniID (modelPtr, aniID);
};

/*
 *    Is animation running
 *
 *    @param modelPtr	     modelPtr
 *    @param zCModelAniPtr   animation pointer
 */
func int zCModel_IsAniActive (var int modelPtr, var int modelAniPtr) { //BOOL
	//0x0046D220 public: int __thiscall zCModel::IsAniActive(class zCModelAni *)
	const int zCModel__IsAniActive_G1 = 4641312;

	//0x00472F90 public: int __thiscall zCModel::IsAniActive(class zCModelAni *)
	const int zCModel__IsAniActive_G2 = 4665232;

	//check
	if (!modelPtr) { return 0; };
	if (!modelAniPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (modelAniPtr));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__IsAniActive_G1, zCModel__IsAniActive_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int zCModel_IsAniActive_ByAniID (var int modelPtr, var int aniID) {
	var int modelAniPtr; modelAniPtr = zCModel_GetAniFromAniID (modelPtr, aniID);
	return +zCModel_IsAniActive (modelPtr, modelAniPtr);
};

func int zCModel_IsAniActive_ByAniName (var int modelPtr, var string aniName) {
	var int aniID; aniID = zCModel_GetAniIdFromAniName (modelPtr, aniName);
	return +zCModel_IsAniActive_ByAniID (modelPtr, aniID);
};


/*
 *    Stop running animation
 *
 *    @param zCModel     			zCModelPtr
 *    @param aniName    			animation name
 */
func void zCModel_StopAnimation (var int modelPtr, var string aniName) {
	//0x0055CE50 public: virtual void __thiscall zCModel::StopAnimation(class zSTRING const &)
	const int zCModel__StopAnimation_G1 = 5623376;

	//0x005765F0 public: virtual void __thiscall zCModel::StopAnimation(class zSTRING const &)
	const int zCModel__StopAnimation_G2 = 5727728;

	// check
	if (!modelPtr) { return; };
	aniName = Str_Upper (aniName);

	//CALL_zstringPtrParam cannot be used in recyclable call
	CALL_zStringPtrParam (aniName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__StopAnimation_G1, zCModel__StopAnimation_G2));
};

/*
 *    Stop running animation
 *
 *    @param zCModel     			zCModelPtr
 *    @param AniActivePtr    		active animation pointer
 */
func void zCModel_StopAni_ByModelAniActivePtr (var int modelPtr, var int modelAniActivePtr) {
	//0x00560EE0 public: void __thiscall zCModel::StopAni(class zCModelAniActive *)
	const int zCModel__StopAni_G1 = 5639904;

	//0x0057ACB0 public: void __thiscall zCModel::StopAni(class zCModelAniActive *)
	const int zCModel__StopAni_G2 = 5745840;

	// check
	if (!modelPtr) { return; };
	if (!modelAniActivePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (modelAniActivePtr));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__StopAni_G1, zCModel__StopAni_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void zCModel_StopAni_ByModelAniPtr (var int modelPtr, var int modelAniPtr) {
	//0x00560E90 public: void __thiscall zCModel::StopAni(class zCModelAni *)
	const int zCModel__StopAni_G1 = 5639824;

	//0x0057AC60 public: void __thiscall zCModel::StopAni(class zCModelAni *)
	const int zCModel__StopAni_G2 = 5745760;

	// check
	if (!modelPtr) { return; };
	if (!modelAniPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (modelAniPtr));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__StopAni_G1, zCModel__StopAni_G2));
		call = CALL_End();
	};
};

// I don't know, what this does - probably plays combined anis? (in .MDS -> "0.2 0.3" ???)
// Function renamed from zCModel_DoCombineAni to zCModelAniActive_DoCombineAni --> to match engine name
func void zCModelAniActive_DoCombineAni(var int modelAniActivePtr, var int modelPtr, var int aniID1, var int aniID2) {
	//0x00565D30 public: void __thiscall zCModelAniActive::DoCombineAni(class zCModel *,int,int)
	const int zCModelAniActive__DoCombineAni_G1 = 5659952;

	//0x0057FDB0 public: void __thiscall zCModelAniActive::DoCombineAni(class zCModel *,int,int)
	const int zCModelAniActive__DoCombineAni_G2 = 5766576;

	// check
	if (!modelAniActivePtr) { return; };
	if (!modelPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (aniID2));
		CALL_IntParam (_@ (aniID1));
		CALL_PtrParam (_@ (modelPtr));
		CALL__thiscall (_@ (modelAniActivePtr), MEMINT_SwitchG1G2 (zCModelAniActive__DoCombineAni_G1, zCModelAniActive__DoCombineAni_G2));
		call = CALL_End();
	};
};

func int oCAniCtrl_Human_IsInCombo (var int aniCtrlPtr) {
	//0x00628350 public: int __thiscall oCAniCtrl_Human::IsInCombo(void)
	const int oCAniCtrl_Human__IsInCombo_G1 = 6456144;

	//0x006B1430 public: int __thiscall oCAniCtrl_Human::IsInCombo(void)
	const int oCAniCtrl_Human__IsInCombo_G2 = 7017520;

	if (!aniCtrlPtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__IsInCombo_G1, oCAniCtrl_Human__IsInCombo_G2));
		call = CALL_End ();
	};

	return + retVal;
};

func void oCAniCtrl_Human_SetLookAtTarget (var int aniCtrlPtr, var int targetVob) {
	//0x0062CE10 public: void __thiscall oCAniCtrl_Human::SetLookAtTarget(class zCVob *)
	const int oCAniCtrl_Human__SetLookAtTarget_G1 = 6475280;

	//0x006B6490 public: void __thiscall oCAniCtrl_Human::SetLookAtTarget(class zCVob *)
	const int oCAniCtrl_Human__SetLookAtTarget_G2 = 7038096;

	//Safety check
	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (targetVob));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__SetLookAtTarget_G1, oCAniCtrl_Human__SetLookAtTarget_G2));
		call = CALL_End ();
	};
};

func void oCAniCtrl_Human_StopLookAtTarget (var int aniCtrlPtr) {
	//0x0062CF70 public: void __thiscall oCAniCtrl_Human::StopLookAtTarget(void)
	const int oCAniCtrl_Human__StopLookAtTarget_G1 = 6475632;

	//0x006B6640 public: void __thiscall oCAniCtrl_Human::StopLookAtTarget(void)
	const int oCAniCtrl_Human__StopLookAtTarget_G2 = 7038528;

	//Safety check
	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__StopLookAtTarget_G1, oCAniCtrl_Human__StopLookAtTarget_G2));
		call = CALL_End ();
	};
};

/*
 *	oCAniCtrl_Human_InterpolateCombineAni
 */
func int oCAniCtrl_Human_InterpolateCombineAni(var int aniCtrlPtr, var int fX, var int fY, var int aniID) {
	//0x0062CB50 public: int __thiscall oCAniCtrl_Human::InterpolateCombineAni(float,float,int)
	const int oCAniCtrl_Human__InterpolateCombineAni_G1 = 6474576;

	//0x006B6170 public: int __thiscall oCAniCtrl_Human::InterpolateCombineAni(float,float,int)
	const int oCAniCtrl_Human__InterpolateCombineAni_G2 = 7037296;

	if (!aniCtrlPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL_IntParam ( _@ (aniID));
		CALL_FloatParam ( _@ (fY));
		CALL_FloatParam ( _@ (fX));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__InterpolateCombineAni_G1, oCAniCtrl_Human__InterpolateCombineAni_G2));
		call = CALL_End();
	};

	return +retVal;
};

func void oCAniCtrl_Human_StopCombineAni (var int aniCtrlPtr, var int aniID) {
	//0x0062D2E0 public: void __thiscall oCAniCtrl_Human::StopCombineAni(int)
	const int oCAniCtrl_Human__StopCombineAni_G1 = 6476512;

	//0x006B6A80 public: void __thiscall oCAniCtrl_Human::StopCombineAni(int)
	const int oCAniCtrl_Human__StopCombineAni_G2 = 7039616;

	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam ( _@ (aniID));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__StopCombineAni_G1, oCAniCtrl_Human__StopCombineAni_G2));
		call = CALL_End();
	};
};

//----------------------------------------------------------------------------------------------------------------------------------
//  oCAniCtrl functions - they might have some use, mainly -> oCAniCtrl_Human_SetNextAni <-
//  but I haven't found a real use for them yet.
// 	You can string 2 anis together with this (They play one afther the other, but you cannot string more than 2)

// Function renamed from oCAniCtrl__StartAni to oCAniCtrl_Human_StartAni
// Input has to be now aniCtrlPtr instead of NPC instance
func int oCAniCtrl_Human_StartAni (var int aniCtrlPtr, var int aniID1, var int aniID2) {
	//0x0061B7A0 public: int __thiscall oCAniCtrl_Human::StartAni(int,int)
	const int oCAniCtrl_Human__StartAni_G1 = 6404000;

	//0x006A3DC0 public: int __thiscall oCAniCtrl_Human::StartAni(int,int)
	const int oCAniCtrl_Human__StartAni_G2 = 6962624;

	if (!aniCtrlPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (aniID2));
		CALL_IntParam ( _@ (aniID1));
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__StartAni_G1, oCAniCtrl_Human__StartAni_G2));
		call = CALL_End();
	};

	return + retVal;
};

//sets next animation (bit pointless, you can call oCAniCtrl_Human_StartAni and provide 2 IDs, and they get played after one another)

// Input has to be now aniCtrlPtr instead of NPC instance
func void oCAniCtrl_Human_SetNextAni (var int aniCtrlPtr, var int aniID1, var int aniID2) {
	//0x0061B980 public: void __thiscall oCAniCtrl_Human::SetNextAni(int,int)
	const int oCAniCtrl_Human__SetNextAni_G1 = 6404480;

	//0x006A3FA0 public: void __thiscall oCAniCtrl_Human::SetNextAni(int,int)
	const int oCAniCtrl_Human__SetNextAni_G2 = 6963104;

	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (aniID2));
		CALL_IntParam (_@ (aniID1));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__SetNextAni_G1, oCAniCtrl_Human__SetNextAni_G2));
		call = CALL_End();
	};
};

// I don't really know what this initializes

// Input has to be now aniCtrlPtr instead of NPC instance
func void oCAniCtrl_Human_InitAnimations (var int aniCtrlPtr) {
	//0x0061B9F0 public: void __thiscall oCAniCtrl_Human::InitAnimations(void)
	const int oCAniCtrl_Human__InitAnimations_G1 = 6404592;

	//0x006A4010 public: void __thiscall oCAniCtrl_Human::InitAnimations(void)
	const int oCAniCtrl_Human__InitAnimations_G2 = 6963216;

	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__InitAnimations_G1, oCAniCtrl_Human__InitAnimations_G2));
		call = CALL_End();
	};
};

// sets the walk mode

// Function renamed from oCAniCtrl__SetWalkMode to oCAniCtrl_Human_SetWalkMode to match engine function name
func void oCAniCtrl_Human_SetWalkMode (var int aniCtrlPtr, var int walkMode) {
	//0x006211E0 public: void __thiscall oCAniCtrl_Human::SetWalkMode(int)
	const int oCAniCtrl_Human__SetWalkMode_G1 = 6427104;

	//0x006A9820 public: void __thiscall oCAniCtrl_Human::SetWalkMode(int)
	const int oCAniCtrl_Human__SetWalkMode_G2 = 6985760;

	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (walkMode));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__SetWalkMode_G1, oCAniCtrl_Human__SetWalkMode_G2));
		call = CALL_End();
	};
};

// Start the stand ani (the default npc animation)

// Function renamed from oCAniCtrl__StartStandAni to oCAniCtrl_Human_StartStandAni to match engine function name
func void oCAniCtrl_Human_StartStandAni (var int aniCtrlPtr) {
	//0x0061CA40 public: virtual void __thiscall oCAniCtrl_Human::StartStandAni(void)
	const int oCAniCtrl_Human__StartStandAni_G1 = 6408768;

	//0x006A5060 public: virtual void __thiscall oCAniCtrl_Human::StartStandAni(void)
	const int oCAniCtrl_Human__StartStandAni_G2 = 6967392;

	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2(oCAniCtrl_Human__StartStandAni_G1, oCAniCtrl_Human__StartStandAni_G2));
		call = CALL_End();
	};
};

// I don't really know what this initializes + crashes the game. Not useful (for now)

// Function renamed from oCAniCtrl__Init to oCAniCtrl_Human_Init to match engine function name
func void oCAniCtrl_Human_Init (var int aniCtrlPtr, var int npcPtr) {
	//0x0061B740 public: virtual void __thiscall oCAniCtrl_Human::Init(class oCNpc *)
	const int oCAniCtrl_Human__Init_G1 = 6403904;

	//0x006A3D60 public: virtual void __thiscall oCAniCtrl_Human::Init(class oCNpc *)
	const int oCAniCtrl_Human__Init_G2 = 6962528;

	if (!aniCtrlPtr) { return; };
	if (!Hlp_Is_oCNpc (npcPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2(oCAniCtrl_Human__Init_G1, oCAniCtrl_Human__Init_G2));
		call = CALL_End();
	};
};

/*
 *	zCModel_AdvanceAnis
 */
func void zCModel_AdvanceAnis (var int modelPtr) {
	//0x00562CD0 public: void __thiscall zCModel::AdvanceAnis(void)
	const int oCNPC__AdvanceAnis_G1 = 5647568;

	//0x0057CA90 public: void __thiscall zCModel::AdvanceAnis(void)
	const int oCNPC__AdvanceAnis_G2 = 5753488;

	//Safety check
	if (!modelPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (oCNPC__AdvanceAnis_G1, oCNPC__AdvanceAnis_G2));
		call = CALL_End();
	};
};

/*
 *	zCModel_DoAniEvents
 */
func void zCModel_DoAniEvents (var int modelPtr, var int modelAniActivePtr) {
	//0x00561AF0 private: void __thiscall zCModel::DoAniEvents(class zCModelAniActive *)
	const int zCModel__DoAniEvents_G1 = 5642992;

	//0x0057B890 private: void __thiscall zCModel::DoAniEvents(class zCModelAniActive *)
	const int zCModel__DoAniEvents_G2 = 5748880;

	// Safety checks
	if (!modelAniActivePtr) { return; };
	if (!modelPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (modelAniActivePtr));
		CALL__thiscall (_@ (modelPtr), MEMINT_SwitchG1G2 (zCModel__DoAniEvents_G1, zCModel__DoAniEvents_G2));
		call = CALL_End();
	};
};

////////////////////////////////
// Useful "wrapper" functions //
////////////////////////////////

/*
 * Plays animation with offset
 *
 *    @param slfInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 *    @param progressF          animation progress (float) e.g. divf (mkf(12), mkf(100)); // = 0.12 12%
 *	  @param aniDir      		direction - "AniDir_Forward" or "AniDir_Reverse"
 */
func string NPC_StartAniWithOffset(var int slfInstance, var string aniName, var int progressF, var int aniDir) {
	// getting zCModel
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return STR_EMPTY; };

	// getting animation ID
	var int aniID; aniID = zCModel_GetAniIDFromAniName(modelPtr, aniName);
	if (aniID == -1) { return STR_EMPTY; };

	// start animation to make it AniActive
	zCModel_StartAni_ByAniID (modelPtr, aniID, STARTANI_FORCE);

	// get aniActivePtr of our, now running, animation
	var int aniActivePtr; aniActivePtr = zCModel_GetActiveAni_ByAniID(modelPtr, aniID);

	// set animation direction
	zCModelAniActive_SetDirection (aniActivePtr, aniDir);

	// change ani progress to specified value
	zCModelAniActive_SetProgressPercent (aniActivePtr, progressF);

	// advance anis
	zCModel_AdvanceAnis (modelPtr);

	// This section returns string -> message (for console or zSpy output)
	var string mes;
	mes = "Playing ani: ";
	mes = ConcatStrings (mes, aniName);
	mes = ConcatStrings (mes, " with progress: ");
	mes = ConcatStrings (mes, toStringf( progressF ) );
	if (aniDir) { mes = ConcatStrings (mes, " and direction: R"); };
	if (!aniDir) { mes = ConcatStrings (mes, " and direction: F"); };
	//MEM_Info(mes); // uncomment for zSpy input
	return mes;
};

/*
 * Plays animation - starts on specified frame
 *
 *    @param slfInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 *    @param aniFrame           animation frame (float)
 *	  @param aniDir      		direction - "dirForward" or "dirReverse"
 */
func string NPC_StartAniWithFrameOffset(var int slfInstance, var string aniName, var int aniFrame, var int aniDir) {
	// getting zCModel
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return STR_EMPTY; };

	// getting animation ID
	var int aniID; aniID = zCModel_GetAniIDFromAniName(modelPtr, aniName);
	if (aniID == -1) { return STR_EMPTY; };

	// start animation to make it AniActive
	zCModel_StartAni_ByAniID (modelPtr, aniID, STARTANI_FORCE);

	// get aniActivePtr of our, now running, animation
	var int aniActivePtr; aniActivePtr = zCModel_GetActiveAni_ByAniID(modelPtr, aniID);

	// set animation direction
	zCModelAniActive_SetDirection(aniActivePtr, aniDir);

	// change ani frame to specified value
	zCModelAniActive_SetActFrame (aniActivePtr, aniFrame);

	// advance anis
	zCModel_AdvanceAnis (modelPtr);

	// change ani frame to specified value
	zCModelAniActive_SetActFrame (aniActivePtr, aniFrame);

	// This section returns string -> message (for console or zSpy output)
	var string mes;
	mes = "Playing ani: ";
	mes = ConcatStrings (mes, aniName);
	mes = ConcatStrings (mes, " starting on frame: ");
	mes = ConcatStrings (mes, toStringf( aniFrame ) );
	if (aniDir) { mes = ConcatStrings (mes, " and direction: R"); };
	if (!aniDir) { mes = ConcatStrings (mes, " and direction: F"); };
	//MEM_Info(mes); // uncomment for zSpy input
	return mes;
};

/*
 *	NPC_AdvanceAnis
 */
func void NPC_AdvanceAnis (var int slfInstance) {
	var int modelPtr; modelPtr = oCNpc_GetModel (slfInstance);
	zCModel_AdvanceAnis (modelPtr);
};

//TODO: Add checks
// |
// |
// V

/*
 * Is animation playing?
 *
 *    @param slfInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func int NPC_IsAniActive_ByAniName (var int slfInstance, var string aniName) {
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	return +zCModel_IsAniActive_ByAniName (modelPtr, aniName);
};

func int NPC_IsAniActive_ByID (var int slfInstance, var int aniID) {
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	return +zCModel_IsAniActive_ByAniID (modelPtr, aniID);
};

/*
 * Get animation progress
 *
 *    @param slfInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func int NPC_GetProgressPercent (var int slfInstance, var string aniName) {
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return FLOATNULL; };
	return +zCModel_GetProgressPercent_ByAniName (modelPtr, aniName);
};

/*
 * Stops animation (if it is playing)
 *
 *    @param slfInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func void NPC_StopAnimation_ByAniName (var int slfInstance, var string aniName){
	var int modelPtr; modelPtr = oCNpc_GetModel (slfInstance);
	var int aniID; aniID = zCModel_GetAniIdFromAniName (modelPtr, aniName);
	var int modelAniActivePtr; modelAniActivePtr = zCModel_GetActiveAni_ByAniID (modelPtr, aniID);
	zCModel_StopAni_ByModelAniActivePtr (modelPtr, modelAniActivePtr);
};

/*
 * Starts animation
 *
 *    @param slfInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func void NPC_StartAnimation_ByAniName (var int slfInstance, var string aniName){
	var int modelPtr; modelPtr = oCNpc_GetModel (slfInstance);
	zCModel_StartAnimation (modelPtr, aniName);
};

/*
 *	Author: OrcWarrior
 *	Original post: https://github.com/orcwarrior/Czas_Zaplaty/blob/master/Content/AI/AI_Intern/Sprint_Func.d
 */
func string oCAniCtrl_GetCurrentAniName (var int oCAniCtrl_Ptr) {
	if (oCAniCtrl_Ptr) {
		var int ptr;
		ptr = MEM_ReadInt (oCAniCtrl_Ptr + 104);			//zCModel		oCAniCtrl_Human.model
		if (ptr) {
			ptr = MEM_ReadInt (ptr + 56);				//zCModelAniActive*	zCModel.aniChannels[zMDL_MAX_ANIS_PARALLEL] //zMDL_MAX_ANIS_PARALLEL = 6
			if (ptr) {
				ptr = MEM_ReadInt (ptr);			//zCModelAni* 		zCModelAniActive.protoAni
				if (ptr) {
					return MEM_ReadString (ptr + 36);	//zSTRING		zCModelAni.aniName
				};
			};
		};
	};

	return "ERROR";
};

func string NPC_GetAniName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return "ERROR"; };
	var string aniName; aniName = oCAniCtrl_GetCurrentAniName (slf.AniCtrl);
	return aniName;
};

//Name changed from NPC_StopAni to NPC_StopAni_ByAniName (NPC_StopAni is G2A default function)
func void NPC_StopAni_ByAniName (var int slfInstance, var string aniName) {
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);

	var int aniID; aniID = zCModel_GetAniIdFromAniName (modelPtr, aniName);
	var int modelAniPtr; modelAniPtr = zCModel_GetAniFromAniID (modelPtr, aniID);

	zCModel_StopAni_ByModelAniPtr (modelPtr, modelAniPtr);
};

//Wrapper function to get current ani progress
func int NPC_GetAniProgress (var int slfInstance) {
	var int modelPtr; modelPtr = oCNpc_GetModel (slfInstance);
	var string aniName; aniName = NPC_GetAniName (slfInstance);
	var int aniID; aniID = zCModel_GetAniIDFromAniName (modelPtr, aniName);

	if (aniID != -1) {
		return +zCModel_GetProgressPercent_ByAniName (modelPtr, aniName);
	};

	return FLOATNULL;
};

func void Npc_StartAni (var int slfInstance, var string aniName) {
	// getting zCModel
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return; };

	// getting animation ID
	var int aniID; aniID = zCModel_GetAniIDFromAniName(modelPtr, aniName);
	if (aniID == -1) { return; };

	// getting animation ptr
	//var int aniPtr; aniPtr = zCModel_GetAniFromAniID(modelPtr, aniID);

	// start animation to make it AniActive
	zCModel_StartAni_ByAniID (modelPtr, aniID, STARTANI_FORCE);
};

func void Npc_StartAnis (var int slfInstance, var string aniName1, var string aniName2) {
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return; };

	var int aniID1; aniID1 = zCModel_GetAniIDFromAniName(modelPtr, aniName1);
	var int aniID2; aniID2 = zCModel_GetAniIDFromAniName(modelPtr, aniName2);

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	oCAniCtrl_Human_StartAni (slf.aniCtrl, aniID1, aniID2);
};

func int Npc_GetAniIDFromAniName (var int slfInstance, var string aniName) {
	// getting zCModel
	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	return + zCModel_GetAniIDFromAniName(modelPtr, aniName);
};
