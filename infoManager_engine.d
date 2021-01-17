/*
 *	Function will return specific instance of dialog option (includes C_Info.important dialogs, which are not listed in Dialog choice box)
 *	Be careful - this can't be used with dialog choices (Info_AddChoice ...)
 */
func int oCInfoManager_GetInfo (var int slfInstance, var int othInstance, var int index) {
	//00664E50  .text     Debug data           ?GetInfo@oCInfoManager@@QAEPAVoCInfo@@PAVoCNPC@@0H@Z
	const int oCInfoManager__GetInfo_G1 = 6704720;

	//0x00702D60 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNPC *,class oCNPC *,int)
	const int oCInfoManager__GetInfo_G2 = 7351648;
	
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var oCNPC oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);
	var int othPtr; othPtr = _@ (oth);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (index));
		CALL_PtrParam (_@ (slfPtr));
		CALL_PtrParam (_@ (othPtr));
		CALL__thiscall (_@ (MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfo_G1, oCInfoManager__GetInfo_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsPtr();
};

/*
 *	Function will return specific instance of dialog option (does not include C_Info.important dialogs. Will return only dialog which is listed Dialog choice box)
 *	Be careful - this can't be used with dialog choices (Info_AddChoice ...)
 */
func int oCInfoManager_GetInfoUnimportant (var int slfInstance, var int othInstance, var int index) {
	//00665120  .text     Debug data           ?GetInfoUnimportant@oCInfoManager@@QAEPAVoCInfo@@PAVoCNPC@@0H@Z
	const int oCInfoManager__GetInfoUnimportant_G1 = 6705440;

	//0x00703030 public: class oCInfo * __thiscall oCInfoManager::GetInfoUnimportant(class oCNPC *,class oCNPC *,int)
	const int oCInfoManager__GetInfoUnimportant_G2 = 7352368;
	
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var oCNPC oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return 0; };
	
	var int slfPtr; slfPtr = _@ (slf);
	var int othPtr; othPtr = _@ (oth);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (index));
		CALL_PtrParam (_@ (slfPtr));
		CALL_PtrParam (_@ (othPtr));
		CALL__thiscall (_@ (MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfoUnimportant_G1, oCInfoManager__GetInfoUnimportant_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsPtr();
};

/*
 *	Function returns number of dialog instances which are available between slfInstance & othInstance
 */
func int oCInfoManager_GetInfoCount (var int slfInstance, var int othInstance) {
	//00664A30  .text     Debug data           ?GetInfoCount@oCInfoManager@@QAEHPAVoCNPC@@0@Z
	const int oCInfoManager__GetInfoCount_G1 = 6703664;

	//0x00702940 public: int __thiscall oCInfoManager::GetInfoCount(class oCNPC *,class oCNPC *)
	const int oCInfoManager__GetInfoCount_G2 = 7350592;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var oCNPC oth; oth = Hlp_GetNPC (othInstance);
	if (!Hlp_IsValidNPC (oth)) { return 0; };
	
	var int slfPtr; slfPtr = _@ (slf);
	var int othPtr; othPtr = _@ (oth);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL_PtrParam (_@ (othPtr));
		CALL__thiscall (_@ (MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfoCount_G1, oCInfoManager__GetInfoCount_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt();
};

/*
 *	Toggles debug informations for dialogs
 */
func void oCInformationManager_ToggleStatus () {
	//0072B360  .text     Debug data           ?ToggleStatus@oCInformationManager@@QAIXXZ
	const int oCInformationManager__ToggleStatus_G1 = 7517024;

	//0x0065FF20 public: void __fastcall oCInformationManager::ToggleStatus(void)
	const int oCInformationManager__ToggleStatus_G2 = 6684448;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__ToggleStatus_G1, oCInformationManager__ToggleStatus_G2));
		call = CALL_End();
	};
};

//??
func void oCInformationManager_PrintStatus () {
	//0072B3B0  .text     Debug data           ?PrintStatus@oCInformationManager@@IAIXXZ
	const int oCInformationManager__PrintStatus_G1 = 7517104;

	//0x0065FF70 protected: void __fastcall oCInformationManager::PrintStatus(void)
	const int oCInformationManager__PrintStatus_G2 = 6684528;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__PrintStatus_G1, oCInformationManager__PrintStatus_G2));
		call = CALL_End();
	};
};

/*
 *	Triggers process infos process ?
 */
func void oCInformationManager_Update () {
	//0072BE90  .text     Debug data           ?Update@oCInformationManager@@QAIXXZ
	const int oCInformationManager__Update_G1 = 7519888;

	//0x00660BB0 public: void __fastcall oCInformationManager::Update(void)
	const int oCInformationManager__Update_G2 = 6687664;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__Update_G1, oCInformationManager__Update_G2));
		call = CALL_End();
	};
};

/*
 *	Starts dialog camera
 */
func void oCInformationManager_CameraStart () {
	//0072C690  .text     Debug data           ?CameraStart@oCInformationManager@@IAIXXZ
	const int oCInformationManager__CameraStart_G1 = 7521936;

	//0x006613A0 protected: void __fastcall oCInformationManager::CameraStart(void)
	const int oCInformationManager__CameraStart_G2 = 6689696;

	//Crashes if info manager is not available!
	if (MEM_InformationMan.IsDone) { return; };

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__CameraStart_G1, oCInformationManager__CameraStart_G2));
		call = CALL_End();
	};
};

/*
 *	Stops dialog camera
 */
func void oCInformationManager_CameraStop () {
	//0072C810  .text     Debug data           ?CameraStop@oCInformationManager@@IAIXXZ
	const int oCInformationManager__CameraStop_G1 = 7522320;

	//0x00661520 protected: void __fastcall oCInformationManager::CameraStop(void)
	const int oCInformationManager__CameraStop_G2 = 6690080;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__CameraStop_G1, oCInformationManager__CameraStop_G2));
		call = CALL_End();
	};
};

//?
func void oCInformationManager_CameraRefresh () {
	//0072C880  .text     Debug data           ?CameraRefresh@oCInformationManager@@IAIXXZ
	const int oCInformationManager__CameraRefresh_G1 = 7522432;

	//0x00661590 protected: void __fastcall oCInformationManager::CameraRefresh(void)
	const int oCInformationManager__CameraRefresh_G2 = 6690192;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__CameraRefresh_G1, oCInformationManager__CameraRefresh_G2));
		call = CALL_End();
	};
};

/*
 *	Exits Information manager
 */
func void oCInformationManager_Exit () {
	//0072C530  .text     Debug data           ?Exit@oCInformationManager@@QAIXXZ
	const int oCInformationManager__Exit_G1 = 7521584;

	//0x00661240 public: void __fastcall oCInformationManager::Exit(void)
	const int oCInformationManager__Exit_G2 = 6689344;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEMINT_oCInformationManager_Address), _@ (null), MEMINT_SwitchG1G2 (oCInformationManager__Exit_G1, oCInformationManager__Exit_G2));
		call = CALL_End();
	};
};

/*
0072ABD0  .text     Debug data           ?GetInformationManager@oCInformationManager@@SAAAV1@XZ

0x0065F790 public: static class oCInformationManager & __cdecl oCInformationManager::GetInformationManager(void)

0072BCC0  .text     Debug data           ?HasFinished@oCInformationManager@@QAIHXZ

0x006609D0 public: int __fastcall oCInformationManager::HasFinished(void)

0072BCD0  .text     Debug data           ?WaitingForEnd@oCInformationManager@@QAIHXZ

0x006609E0 public: int __fastcall oCInformationManager::WaitingForEnd(void)


0x00688FD0 public: virtual int __fastcall zCViewDialog::IsActive(void)
0x00688FE0 public: virtual int __fastcall zCViewDialog::HasFinished(void)

0x006895B0 public: virtual void __fastcall zCViewDialog::Activate(int)
0x006895C0 public: virtual void __fastcall zCViewDialog::StartSelection(void)
0x006895D0 public: virtual void __fastcall zCViewDialog::StopSelection(void)

0x0068B020 public: virtual short __thiscall oCViewDialogTrade::GetTransferCount(void)

*/

//?
func void zCViewDialogChoice_HighlightSelected () {
	//007594A0  .text     Debug data           ?HighlightSelected@zCViewDialogChoice@@IAIXXZ
	const int zCViewDialogChoice__HighlightSelected_G1 = 7705760;

	//0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
	const int zCViewDialogChoice__HighlightSelected_G2 = 6878752;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEM_InformationMan.DlgChoice), _@ (null), MEMINT_SwitchG1G2 (zCViewDialogChoice__HighlightSelected_G1, zCViewDialogChoice__HighlightSelected_G2));
		call = CALL_End();
	};
};

//?
func void zCViewDialogChoice_BlitText () {
	//00758E70  .text     Debug data           ?BlitText@zCViewDialogChoice@@MAIXXZ
	const int zCViewDialogChoice__BlitText_G1 = 7704176;

	//0x0068EFE0 protected: virtual void __fastcall zCViewDialogChoice::BlitText(void)
	const int zCViewDialogChoice__BlitText_G2 = 6877152;
	
	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEM_InformationMan.DlgChoice), _@ (null), MEMINT_SwitchG1G2 (zCViewDialogChoice__BlitText_G1, zCViewDialogChoice__BlitText_G2));
		call = CALL_End();
	};
};

/*
 *	Selects dialog choice - index starts at 0
 */
func void zCViewDialogChoice_Select (var int index) {
	//007592C0  .text     Debug data           ?Select@zCViewDialogChoice@@IAIXH@Z
	const int zCViewDialogChoice__Select_G1 = 7705280;

	//0x0068F440 protected: void __fastcall zCViewDialogChoice::Select(int)
	const int zCViewDialogChoice__Select_G2 = 6878272;
	
	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEM_InformationMan.DlgChoice), _@ (index), MEMINT_SwitchG1G2 (zCViewDialogChoice__Select_G1, zCViewDialogChoice__Select_G2));
		call = CALL_End();
	};
};

/*
 *	Selects previous dialog choice
 */
func void zCViewDialogChoice_SelectPrevious () {
	//007590A0  .text     Debug data           ?SelectPrevious@zCViewDialogChoice@@IAIXXZ
	const int zCViewDialogChoice__SelectPrevious_G1		= 7704736;
	//0x0068F220 protected: void __fastcall zCViewDialogChoice::SelectPrevious(void)
	const int zCViewDialogChoice__SelectPrevious_G2		= 6877728;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEM_InformationMan.DlgChoice), _@ (null), MEMINT_SwitchG1G2 (zCViewDialogChoice__SelectPrevious_G1, zCViewDialogChoice__SelectPrevious_G2));
		call = CALL_End();
	};
};

/*
 *	Selects next dialog choice
 */
func void zCViewDialogChoice_SelectNext () {
	//007591B0  .text     Debug data           ?SelectNext@zCViewDialogChoice@@IAIXXZ
	const int zCViewDialogChoice__SelectNext_G1 = 7705008;
	//0x0068F330 protected: void __fastcall zCViewDialogChoice::SelectNext(void)
	const int zCViewDialogChoice__SelectNext_G2 = 6878000;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEM_InformationMan.DlgChoice), _@ (null), MEMINT_SwitchG1G2 (zCViewDialogChoice__SelectNext_G1, zCViewDialogChoice__SelectNext_G2));
		call = CALL_End();
	};
};

/*
00758E00  .text     Debug data           ?StartSelection@zCViewDialogChoice@@UAIXXZ
0x0068EF70 public: virtual void __fastcall zCViewDialogChoice::StartSelection(void)

00758E40  .text     Debug data           ?StopSelection@zCViewDialogChoice@@UAIXXZ
0x0068EFB0 public: virtual void __fastcall zCViewDialogChoice::StopSelection(void)

00758E70  .text     Debug data           ?BlitText@zCViewDialogChoice@@MAIXXZ
0x0068EFE0 protected: virtual void __fastcall zCViewDialogChoice::BlitText(void)

00758ED0  .text     Debug data           ?ScrollUp@zCViewDialogChoice@@IAIXXZ
0x0068F050 protected: void __fastcall zCViewDialogChoice::ScrollUp(void)

00758F10  .text     Debug data           ?ScrollDown@zCViewDialogChoice@@IAIXXZ
0x0068F090 protected: void __fastcall zCViewDialogChoice::ScrollDown(void)

00758F50  .text     Debug data           ?IsSelectedOutsideAbove@zCViewDialogChoice@@IAIHXZ
0x0068F0D0 protected: int __fastcall zCViewDialogChoice::IsSelectedOutsideAbove(void)

00758F70  .text     Debug data           ?IsSelectedOutsideBelow@zCViewDialogChoice@@IAIHXZ
0x0068F0F0 protected: int __fastcall zCViewDialogChoice::IsSelectedOutsideBelow(void)

00759000  .text     Debug data           ?ShowSelected@zCViewDialogChoice@@IAIXXZ
0x0068F180 protected: void __fastcall zCViewDialogChoice::ShowSelected(void)

007590A0  .text     Debug data           ?SelectPrevious@zCViewDialogChoice@@IAIXXZ
0x0068F220 protected: void __fastcall zCViewDialogChoice::SelectPrevious(void)

007591B0  .text     Debug data           ?SelectNext@zCViewDialogChoice@@IAIXXZ
0x0068F330 protected: void __fastcall zCViewDialogChoice::SelectNext(void)

007592C0  .text     Debug data           ?Select@zCViewDialogChoice@@IAIXH@Z
0x0068F440 protected: void __fastcall zCViewDialogChoice::Select(int)

007593C0  .text     Debug data           ?GetSelection@zCViewDialogChoice@@IAIPAVzCViewText2@@XZ
0x0068F540 protected: class zCViewText2 * __fastcall zCViewDialogChoice::GetSelection(void)

007593D0  .text     Debug data           ?GetSelectedText@zCViewDialogChoice@@QAI?AVzSTRING@@XZ
0x0068F550 public: class zSTRING __fastcall zCViewDialogChoice::GetSelectedText(void)

007594A0  .text     Debug data           ?HighlightSelected@zCViewDialogChoice@@IAIXXZ
0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)

00759590  .text     Debug data           ?AddChoice@zCViewDialogChoice@@QAIXAAVzSTRING@@H@Z
0x0068F710 public: void __fastcall zCViewDialogChoice::AddChoice(class zSTRING &,int)

007597F0  .text     Debug data           ?RemoveChoice@zCViewDialogChoice@@QAIXAAVzSTRING@@@Z
0x0068F9A0 public: void __fastcall zCViewDialogChoice::RemoveChoice(class zSTRING &)

00759800  .text     Debug data           ?RemoveChoice@zCViewDialogChoice@@QAIXH@Z
0x0068F9B0 public: void __fastcall zCViewDialogChoice::RemoveChoice(int)

00759810  .text     Debug data           ?RemoveAllChoices@zCViewDialogChoice@@QAIXXZ
0x0068F9C0 public: void __fastcall zCViewDialogChoice::RemoveAllChoices(void)
*/

