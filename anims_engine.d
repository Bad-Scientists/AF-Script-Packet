/*
 *	These are some useful engine ANIMATION functions
 *	by Milgos, Fawkes and Auronen
 */

func int oCNPC_GetModel (var int npcInstance) {
	//0x00695300 public: class zCModel * __thiscall oCNpc::GetModel(void)
	const int oCNPC__GetModel_G1 = 6902528;

	//0x00738720 public: class zCModel * __thiscall oCNpc::GetModel(void)
	const int oCNPC__GetModel_G2 = 7571232;

	//check if npc is valid
	var oCNPC slf; slf = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	CALL__thiscall (_@ (slf), MEMINT_SwitchG1G2 (oCNPC__GetModel_G1, oCNPC__GetModel_G2));
	return CALL_RetValAsPtr();
};

/*
 * 	  Returns aniId based on animation name
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */
func int zCModel_GetAniIdFromAniName(var int zCModel, var string aniName) {
	//0x0047EC50 public: int __thiscall zCModel::GetAniIDFromAniName(class zSTRING const &)const
	const int zCModel__GetAniIdFromAniName_G1 = 4713552;

	//0x00612070 public: int __thiscall zCModel::GetAniIDFromAniName(class zSTRING const &)const
	const int zCModel__GetAniIdFromAniName_G2 = 6365296;

	// check
	if (!zCModel) { return 0; };

	CALL_zstringPtrParam (Str_Upper (aniName));
	CALL__thiscall (zCModel, MEMINT_SwitchG1G2 (zCModel__GetAniIdFromAniName_G1, zCModel__GetAniIdFromAniName_G2));

	return CALL_RetValAsInt();
};

/*
 *    Returns aniPtr based on animation ID
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniId         		animation ID
 */
func int zCModel_GetAniFromAniID(var int zCModel, var int aniId) { //zCModelAni *
	//0x0046D1E0 public: class zCModelAni * __thiscall zCModel::GetAniFromAniID(int)const
	const int zCModel__GetAniFromAniID_G1 = 4641248;

	//0x00472F50 public: class zCModelAni * __thiscall zCModel::GetAniFromAniID(int)const
	const int zCModel__GetAniFromAniID_G2 = 4665168;

	// checks
	if (!zCModel) { return 0; };
	if (aniId == -1) { return 0; };

	CALL_IntParam (aniId);
	CALL__thiscall (zCModel, MEMINT_SwitchG1G2 (zCModel__GetAniFromAniID_G1, zCModel__GetAniFromAniID_G2));

	return CALL_RetValAsPtr();
};

/*
 *    Plays animation using animation name
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniName         	animation name
 *	  @param param2				I have no idea, what it does
 */

func void zCModel_StartAni (var int zCModel, var string aniName) {
	//0x0055CE40 public: virtual void __thiscall zCModel::StartAnimation(class zSTRING const &)
	const int zCModel__StartAni_G1 = 5623360;

	//0x005765E0 public: virtual void __thiscall zCModel::StartAnimation(class zSTRING const &)
	const int zCModel__StartAni_G2 = 5727712;

	if (!zCModel) { return; };

	CALL_zStringPtrParam (STR_Upper (aniName));
	CALL__thiscall (zCModel, MEMINT_SwitchG1G2 (zCModel__StartAni_G1, zCModel__StartAni_G2));
};

/*
 *    Plays animation using animation pointer
 *
 *    @param zCModel        	zCModelPtr
 *    @param aniId         		animation ID
 *	  @param param2				I have no idea, what it does
 */
func void zCModel_StartAniByAniID (var int zCModel, var int aniId, var int param2) {
	//0x005612A0 public: void __thiscall zCModel::StartAni(int,int)
	const int zCModel__StartAniByAniID_G1 = 5640864;

	//0x0057B070 public: void __thiscall zCModel::StartAni(int,int)
	const int zCModel__StartAniByAniID_G2 = 5746800;

	//checks
	if (!zCModel) { return; };
	if (aniId == -1) { return; };

	CALL_IntParam(param2);
	CALL_IntParam(aniId);
	CALL__thiscall(zCModel, MEMINT_SwitchG1G2 (zCModel__StartAniByAniID_G1, zCModel__StartAniByAniID_G2));
};

/*
 *    Returns AniActivePtr using animation pointer
 *
 *    @param zCModel		    zCModelPtr
 *    @param zCModelAniPtr      animation pointer
 */
func int zCModel_GetActiveAni (var int zCModel, var int zCModelAniPtr) { //zCModelAniActive *
	//0x00560DD0 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(class zCModelAni *)const
	const int zCModel_GetActiveAni_G1 = 5639632;

	//0x0057ABA0 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(class zCModelAni *)const
	const int zCModel_GetActiveAni_G2 = 5745568;

	// checks
	if (!zCModel) { return 0; };
	if (!zCModelAniPtr) { return 0; };

	CALL_PtrParam (zCModelAniPtr);
	CALL__thiscall (zCModel, MEMINT_SwitchG1G2 (zCModel_GetActiveAni_G1, zCModel_GetActiveAni_G2));

	return CALL_RetValAsPtr();
};

/*
 *    Returns AniActivePtr using animation id
 *
 *    @param zCModel		    zCModelPtr
 *    @param aniId      		animation id
 */
func int zCModel_GetActiveAniPtrByAniID (var int zCModel, var int aniId) { //zCModelAniActive *
	//0x00560D90 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(int)const
	const int zCModel_GetActiveAniPtrByAniID_G1 = 5639568;

	//0x0057AB60 public: class zCModelAniActive * __thiscall zCModel::GetActiveAni(int)const
	const int zCModel_GetActiveAniPtrByAniID_G2 = 5745504;

	// checks
	if (!zCModel) { return 0; };
	if (aniId == -1) { return 0; };

	CALL_IntParam (aniId);
	CALL__thiscall (zCModel, MEMINT_SwitchG1G2 (zCModel_GetActiveAniPtrByAniID_G1, zCModel_GetActiveAniPtrByAniID_G2));

	return CALL_RetValAsPtr();
};

/*
 *    Sets progress percentage for active animation
 *
 *    @param zCModelAniActivePtr        active animation pointer
 *    @param progress      				progress (0.0 to 1.0)
 */
func void zCModelAniActive_SetProgressPercent (var int zCModelAniActivePtr, var int progress) {
	//0x0055D510 public: void __thiscall zCModelAniActive::SetProgressPercent(float)
	const int zCModelAniActive__SetProgressPercent_G1 = 5625104;

	//0x00576CA0 public: void __thiscall zCModelAniActive::SetProgressPercent(float)
	const int zCModelAniActive__SetProgressPercent_G2 = 5729440;

	//checks
	if (!zCModelAniActivePtr) { return; };

	CALL_FloatParam (progress);
	CALL__thiscall (zCModelAniActivePtr, MEMINT_SwitchG1G2 (zCModelAniActive__SetProgressPercent_G1, zCModelAniActive__SetProgressPercent_G2));
};

/*
 *    Sets active animation to a specified frame
 *
 *    @param zCModelAniActivePtr        active animation pointer
 *    @param frame      				frame number (float)
 */
func void zCModelAniActive_SetActFrame (var int zCModelAniActivePtr, var int frame) {
	//0x0055D560 public: void __thiscall zCModelAniActive::SetActFrame(float)
	const int zCModelAniActive__SetActFrame_G1 = 5625184;

	//0x00576CF0 public: void __thiscall zCModelAniActive::SetActFrame(float)
	const int zCModelAniActive__SetActFrame_G2 = 5729520;

	//checks
	if (!zCModelAniActivePtr) { return; };

	CALL_FloatParam (frame);
	CALL__thiscall (zCModelAniActivePtr, MEMINT_SwitchG1G2 (zCModelAniActive__SetActFrame_G1, zCModelAniActive__SetActFrame_G2));
};

/*
 *	  Sets direction for active animation
 *
 *    @param zCModelAniActivePtr        active animation pointer
 *    @param direction      			direction - "AniDir_Forward" or "AniDir_Reverse"
 */
func void zCModelAniActive_SetDirection (var int zCModelAniActivePtr, var int direction) {
	//0x0055D480 public: void __thiscall zCModelAniActive::SetDirection(enum zTMdl_AniDir)
	const int zCModelAniActive__SetDirection_G1 = 5624960;

	//0x00576C10 public: void __thiscall zCModelAniActive::SetDirection(enum zTMdl_AniDir)
	const int zCModelAniActive__SetDirection_G2 = 5729296;

	//checks
	if (!zCModelAniActivePtr) { return; };

	CALL_IntParam (direction);
	CALL__thiscall (zCModelAniActivePtr, MEMINT_SwitchG1G2 (zCModelAniActive__SetDirection_G1, zCModelAniActive__SetDirection_G2));
};

/*
 *    Get the progress of active animation (zCModelAniActive)
 *
 *    @param zCModel     zCModelptr
 *	  @param aniName	 animation name
 */
func int zCModelAniActive_GetProgressPercent (var int zCModelAniActivePtr) { // float
	//0x0055D4D0 public: float __thiscall zCModelAniActive::GetProgressPercent(void)const
	const int zCModelAniActive__GetProgressPercent_G1 = 5625040;

	//0x00576C60 public: float __thiscall zCModelAniActive::GetProgressPercent(void)const
	const int zCModelAniActive__GetProgressPercent_G2 = 5729376;

	if (!zCModelAniActivePtr) { return 0; };

	CALL__thiscall (zCModelAniActivePtr, MEMINT_SwitchG1G2 (zCModelAniActive__GetProgressPercent_G1, zCModelAniActive__GetProgressPercent_G2));
	return CALL_RetValAsFloat();
};

/*
 *    Get the progress of active animation (zCModel)
 *
 *    @param zCModel     zCModelptr
 *	  @param aniName	 animation name
 */
func int zCModel_GetProgressPercent (var int model, var string aniName) {
	//0x00565210 public: float __thiscall zCModel::GetProgressPercent(class zSTRING const &)const
	const int zCModel__GetProgressPercent_G1 = 5657104;

	//0x0057F290 public: float __thiscall zCModel::GetProgressPercent(class zSTRING const &)const
	const int zCModel__GetProgressPercent_G2 = 5763728;

	if (!model) { return FLOATNULL; };

	CALL_RetValIsFloat (); // method returns float
	CALL_zStringPtrParam (Str_Upper (aniName));
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__GetProgressPercent_G1, zCModel__GetProgressPercent_G2));

	return CALL_RetValAsFloat ();
};

/*
 *    Get the progress of active animation (zCModel)
 *
 *    @param zCModel     zCModelptr
 *	  @param aniId	 	animation ID
 */
func int zCModel_GetProgressPercentId(var int zCModel, var int aniId) {
	//0x005652C0 public: float __thiscall zCModel::GetProgressPercent(int)const
	const int zCModel__GetProgressPercentId_G1 = 5657280;

	//0x0057F340 public: float __thiscall zCModel::GetProgressPercent(int)const
	const int zCModel__GetProgressPercentId_G2 = 5763904;

	//check
	if (!zCModel) { return 0; };

	CALL_IntParam (aniId);
	CALL__thiscall (zCModel, MEMINT_SwitchG1G2 (zCModel__GetProgressPercentId_G1, zCModel__GetProgressPercentId_G2));

	return CALL_RetValAsFloat ();
};

/*
 *    Is animation running
 *
 *    @param model	     model
 *    @param zCModelAniPtr   animation pointer
 */
func int zCModel_IsAniActive(var int model, var int zCModelAniPtr) { //BOOL
	//0x0046D220 public: int __thiscall zCModel::IsAniActive(class zCModelAni *)
	const int zCModel__IsAniActive_G1 = 4641312;

	//0x00472F90 public: int __thiscall zCModel::IsAniActive(class zCModelAni *)
	const int zCModel__IsAniActive_G2 = 4665232;

	//check
	if (!model) { return 0; };
	if (!zCModelAniPtr) { return 0; };

	CALL_PtrParam (zCModelAniPtr);
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__IsAniActive_G1, zCModel__IsAniActive_G2));

	return CALL_RetValAsInt();
};

/*
 *    Stop running animation
 *
 *    @param zCModel     			zCModelPtr
 *    @param aniName    			animation name
 */
func void zCModel_StopAnimation (var int model, var string aniName) {
	//0x0055CE50 public: virtual void __thiscall zCModel::StopAnimation(class zSTRING const &)
	const int zCModel__StopAnimation_G1 = 5623376;

	//0x005765F0 public: virtual void __thiscall zCModel::StopAnimation(class zSTRING const &)
	const int zCModel__StopAnimation_G2 = 5727728;

	// check
	if (!model) { return; };

	CALL_zStringPtrParam (STR_Upper (aniName));
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__StopAnimation_G1, zCModel__StopAnimation_G2));
};

/*
 *    Stop running animation
 *
 *    @param zCModel     			zCModelPtr
 *    @param AniActivePtr    		active animation pointer
 */
func void zCModel_StopAni_zCModelAniActive (var int model, var int AniActivePtr) {
	//0x00560EE0 public: void __thiscall zCModel::StopAni(class zCModelAniActive *)
	const int zCModel__StopAni_G1 = 5639904;

	//0x0057ACB0 public: void __thiscall zCModel::StopAni(class zCModelAniActive *)
	const int zCModel__StopAni_G2 = 5745840;

	// check
	if (!model) { return; };

	CALL_IntParam (AniActivePtr);
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__StopAni_G1, zCModel__StopAni_G2));
};

//modelAni == aniID
func void zCModel_StopAni_zCModelAni (var int model, var int modelAni) {
	//0x00560E90 public: void __thiscall zCModel::StopAni(class zCModelAni *)
	const int zCModel__StopAni_G1 = 5639824;

	//0x0057AC60 public: void __thiscall zCModel::StopAni(class zCModelAni *)
	const int zCModel__StopAni_G2 = 5745760;

	// check
	if (!model) { return; };

	if (modelAni == -1) { return; };

	CALL_IntParam (modelAni);
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__StopAni_G1, zCModel__StopAni_G2));
};

// I don't know, what this does - probably plays combined anis? (in .MDS -> "0.2 0.3" ???)
func void zCModel_DoCombineAni(var int model, var int zCModelAniActivePtr, var int aniId1, var int aniId2) {
	//0x00565D30 public: void __thiscall zCModelAniActive::DoCombineAni(class zCModel *,int,int)
	const int zCModel__DoCombineAni_G1 = 5659952;

	//0x0057FDB0 public: void __thiscall zCModelAniActive::DoCombineAni(class zCModel *,int,int)
	const int zCModel__DoCombineAni_G2 = 5766576;

	// check
	if (!model) { return; };

	CALL_IntParam (aniId2);
	CALL_IntParam (aniId1);
	CALL_PtrParam (model);
	CALL__thiscall (zCModelAniActivePtr, MEMINT_SwitchG1G2 (zCModel__DoCombineAni_G1, zCModel__DoCombineAni_G2));
};

//----------------------------------------------------------------------------------------------------------------------------------
//  oCAniCtrl functions - they might have some use, mainly -> oCAniCtrl_Human_SetNextAni <-
//  but I haven't found a real use for them yet.
// 	You can string 2 anis together with this (They play one afther the other, but you cannot string more than 2)
func int oCAniCtrl__StartAni (var int slfInstance, var int aniId1, var int aniId2) {
	//0x0061B7A0 public: int __thiscall oCAniCtrl_Human::StartAni(int,int)
	const int oCAniCtrl__StartAni_G1 = 6404000;

	//0x006A3DC0 public: int __thiscall oCAniCtrl_Human::StartAni(int,int)
	const int oCAniCtrl__StartAni_G2 = 6962624;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNpc (slf)) { return -1; };
	if (!slf.anictrl) { return -1; };

	CALL_IntParam(aniId2);
	CALL_IntParam(aniId1);
	CALL__thiscall(slf.anictrl, MEMINT_SwitchG1G2(oCAniCtrl__StartAni_G1,oCAniCtrl__StartAni_G2));

	return CALL_RetValAsInt();
};

//sets next animation (bit pointless, you can call oCAniCtrl__StartAni and provide 2 IDs, and they get played after one another)
func void oCAniCtrl_Human_SetNextAni (var int slfInstance, var int aniId1, var int aniId2) {
	//0x0061B980 public: void __thiscall oCAniCtrl_Human::SetNextAni(int,int)
	const int oCAniCtrl_Human__SetNextAni_G1 = 6404480;

	//0x006A3FA0 public: void __thiscall oCAniCtrl_Human::SetNextAni(int,int)
	const int oCAniCtrl_Human__SetNextAni_G2 = 6963104;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNpc (slf)) { return; };
	if (!slf.anictrl) { return; };

	CALL_IntParam (aniId2);
	CALL_IntParam (aniId1);
	CALL__thiscall(slf.anictrl, MEMINT_SwitchG1G2 (oCAniCtrl_Human__SetNextAni_G1, oCAniCtrl_Human__SetNextAni_G2));
};

// I don't really know what this initializes
func void oCAniCtrl_Human_InitAnimations (var int slfInstance) {
	//0x0061B9F0 public: void __thiscall oCAniCtrl_Human::InitAnimations(void)
	const int oCAniCtrl_Human__InitAnimations_G1 = 6404592;

	//0x006A4010 public: void __thiscall oCAniCtrl_Human::InitAnimations(void)
	const int oCAniCtrl_Human__InitAnimations_G2 = 6963216;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNpc (slf)) { return; };
	if (!slf.anictrl) { return; };

	CALL__thiscall(slf.anictrl, MEMINT_SwitchG1G2 (oCAniCtrl_Human__InitAnimations_G1, oCAniCtrl_Human__InitAnimations_G2));
};

// sets the walk mode
func void oCAniCtrl__SetWalkMode (var int aniCtrl, var int walkMode) {
	//0x006211E0 public: void __thiscall oCAniCtrl_Human::SetWalkMode(int)
	const int oCAniCtrl_Human__SetWalkMode_G1 = 6427104;

	//0x006A9820 public: void __thiscall oCAniCtrl_Human::SetWalkMode(int)
	const int oCAniCtrl_Human__SetWalkMode_G2 = 6985760;

	if (!aniCtrl) { return; };

	CALL_IntParam (walkMode);
	CALL__thiscall (aniCtrl, MEMINT_SwitchG1G2(oCAniCtrl_Human__SetWalkMode_G1, oCAniCtrl_Human__SetWalkMode_G2));
};

// Start the stand ani (the default npc animation)
func void oCAniCtrl__StartStandAni (var int aniCtrl) {
	//0x0061CA40 public: virtual void __thiscall oCAniCtrl_Human::StartStandAni(void)
	const int oCAniCtrl_Human__StartStandAni_G1 = 6408768;

	//0x006A5060 public: virtual void __thiscall oCAniCtrl_Human::StartStandAni(void)
	const int oCAniCtrl_Human__StartStandAni_G2 = 6967392;

	if (!aniCtrl) { return; };

	CALL__thiscall (aniCtrl, MEMINT_SwitchG1G2(oCAniCtrl_Human__StartStandAni_G1, oCAniCtrl_Human__StartStandAni_G2));
};

// I don't really know what this initializes + crashes the game. Not useful (for now)
func void oCAniCtrl__Init (var int aniCtrl, var int npcPtr) {
	//0x0061B740 public: virtual void __thiscall oCAniCtrl_Human::Init(class oCNpc *)
	const int oCAniCtrl_Human__Init_G1 = 6403904;

	//0x006A3D60 public: virtual void __thiscall oCAniCtrl_Human::Init(class oCNpc *)
	const int oCAniCtrl_Human__Init_G2 = 6962528;

	if (!aniCtrl) { return; };
	if (!(Hlp_Is_oCNpc (npcPtr))) { return; };

	CALL_PtrParam (npcPtr);
	CALL__thiscall (aniCtrl, MEMINT_SwitchG1G2(oCAniCtrl_Human__Init_G1, oCAniCtrl_Human__Init_G2));
};

////////////////////////////////
// Usuful "wrapper" functions //
////////////////////////////////

/*
 * Plays animation with offset
 *
 *    @param npcInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 *    @param aniProgress        animation progress (float) e.g. divf (mkf(12), mkf(100)); // = 0.12 12%
 *	  @param aniDir      		direction - "AniDir_Forward" or "AniDir_Reverse"
 */
func string NPC_StartAniWithOffset(var int npcInstance, var string aniName, var int aniProgress, var int aniDir) {
	// getting zCModel
	var int model; model = oCNPC_GetModel (npcInstance);

	// checks
	if (!model) { return ""; };

	// getting animation ID
	var int aniId; aniId = zCModel_GetAniIDFromAniName(model, aniName);

	// checks
	if (aniId == -1) { return ""; };

	// getting animation ptr
	var int aniPtr; aniPtr = zCModel_GetAniFromAniID(model, aniId);

	// start animation to make it AniActive
	zCModel_StartAniByAniID(model, aniId, 1);

	// get aniActivePtr of our, now running, animation
	var int aniActivePtr; aniActivePtr = zCModel_GetActiveAniPtrByAniID(model, aniId);

	// set animation direction
	zCModelAniActive_SetDirection(aniActivePtr, aniDir);

	// change ani progress to specified value
	zCModelAniActive_SetProgressPercent (aniActivePtr, aniProgress);

	// This section returns string -> message (for console or zSpy output)
	var string mes;
	mes = "Playing ani: ";
	mes = ConcatStrings (mes, aniName);
	mes = ConcatStrings (mes, " with progress: ");
	mes = ConcatStrings (mes, toStringf( aniProgress ) );
	if (aniDir) { mes = ConcatStrings (mes, " and direction: R"); };
	if (!aniDir) { mes = ConcatStrings (mes, " and direction: F"); };
	//MEM_Info(mes); // uncomment for zSpy input
	return mes;
};

/*
 * Plays animation - starts on specified frame
 *
 *    @param npcInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 *    @param aniFrame           animation frame (float)
 *	  @param aniDir      		direction - "dirForward" or "dirReverse"
 */
func string NPC_StartAniWithFrameOffset(var int npcInstance, var string aniName, var int aniFrame, var int aniDir) {
	// getting zCModel
	var int model; model = oCNPC_GetModel (npcInstance);

	// checks
	if (!model) { return ""; };

	// getting animation ID
	var int aniId;
	aniId = zCModel_GetAniIDFromAniName(model, aniName);

	// checks
	if (aniId == -1) { return ""; };

	// getting animation ptr
	var int aniPtr; aniPtr = zCModel_GetAniFromAniID(model, aniId);

	// start animation to make it AniActive
	zCModel_StartAniByAniID(model, aniId, 1);

	// get aniActivePtr of our, now running, animation
	var int aniActivePtr; aniActivePtr = zCModel_GetActiveAniPtrByAniID(model, aniId);

	// set animation direction
	zCModelAniActive_SetDirection(aniActivePtr, aniDir);

	// change ani frame to specified value
	zCModelAniActive_SetActFrame(aniActivePtr, aniFrame);

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

//TODO: Add checks
// |
// |
// V

/*
 * Is animation playing?
 *
 *    @param npcInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func int NPC_IsAniActive(var int npcInstance, var string aniName) {
	// getting zCModel
	var int model; model = oCNPC_GetModel (npcInstance);

	// checks
	if (!model) { return -1; };

	var int aniId; aniId = zCModel_GetAniIdFromAniName(model, aniName);

	var int aniPtr; aniPtr = zCModel_GetAniFromAniID(model, aniId);

	return zCModel_IsAniActive (model, aniPtr);
};

/*
 * Get animation progress
 *
 *    @param npcInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func int NPC_GetProgressPercent(var int npcInstance, var string aniName) {
	// getting zCModel
	var int model; model = oCNPC_GetModel (npcInstance);

	// checks
	if (!model) { return FLOATNULL; };

	return zCModel_GetProgressPercent (model, aniName);
};

/*
 * Stops animation (if it is playing)
 *
 *    @param npcInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func void NPC_StopAnimation(var int npcInstance, var string aniName){
	var int model; model = oCNpc_GetModel (npcInstance);

	var int aniId; aniId = zCModel_GetAniIdFromAniName(model, aniName);

	var int aniPtr; aniPtr = zCModel_GetAniFromAniID(model, aniId);

	var int aniActivePtr; aniActivePtr = zCModel_GetActiveAniPtrByAniID(model, aniId);

	zCModel_StopAni_zCModelAniActive (model, aniActivePtr);
};

/*
 * Starts animation
 *
 *    @param npcInstance        npc
 *    @param aniName            animation name (string)    e.g. "t_DIALOGGESTURE_12"
 */

func void NPC_StartAni (var int npcInstance, var string aniName){
	var int model; model = oCNpc_GetModel (npcInstance);
	zCModel_StartAni (model, aniName);
};

/*
 *	Author: OrcWarrior
 *	Original post: https://github.com/orcwarrior/Czas_Zaplaty/blob/master/Content/AI/AI_Intern/Sprint_Func.d
 */
func string oCAniCtrl__GetCurrentAniName (var int oCAniCtrl_Ptr)
{
	if (oCAniCtrl_Ptr) {

		var int ptr;
		ptr = MEM_ReadInt (oCAniCtrl_Ptr + 104);			//zCModel 	oCAniCtrl_Human._zCAIPlayer_model

		if (ptr)
		{
			ptr = MEM_ReadInt (ptr + 56);				//*ActiveAniLayer1
			if (ptr)
			{
				ptr = MEM_ReadInt (ptr);			//*oCAni
				if (ptr)
				{
					return MEM_ReadString (ptr + 36);	// This will read active ani name(?)
				};	//aniname(zstring)
			};
		};
	};

	return "ERROR";
};

func string NPC_GetAniName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return "ERROR"; };
	var string aniName; aniName = oCAniCtrl__GetCurrentAniName (slf.AniCtrl);
	return aniName;
};

//Name changed from NPC_StopAni to NPC_StopAniByAniName (NPC_StopAni is G2A default function)
func void NPC_StopAniByAniName (var int slfInstance, var string aniName) {
	var int model; model = oCNPC_GetModel (slfInstance);
	var int aniID; aniID = zCModel_GetAniIDFromAniName (model, aniName);

	zCModel_StopAni_zCModelAni (model, aniID);
};

//Wrapper function to get current ani progress
func int NPC_GetAniProgress (var int slfInstance) {
	var int model; model = oCNpc_GetModel (slfInstance);
	var string aniName; aniName = NPC_GetAniName (slfInstance);
	var int aniID; aniID = zCModel_GetAniIDFromAniName (model, aniName);

	if (aniID != -1) {
		return zCModel_GetProgressPercent (model, aniName);
	};

	return FLOATNULL;
};
