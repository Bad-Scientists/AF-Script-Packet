/*
 *	Function will return specific instance of dialog option (includes C_Info.important dialogs, which are not listed in Dialog choice box)
 *	Be careful - this can't be used with dialog choices (Info_AddChoice ...)
 */
func int oCInfoManager_GetInfo_ByPtr (var int slfPtr, var int othPtr, var int index) {
	//0x00664E50 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNpc *,class oCNpc *,int)
	const int oCInfoManager__GetInfo_G1 = 6704720;

	//0x00702D60 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNPC *,class oCNPC *,int)
	const int oCInfoManager__GetInfo_G2 = 7351648;

	if (!MEM_Game.infoman) { return 0; };
	if (!Hlp_Is_oCNpc(slfPtr)) { return 0; };
	if (!Hlp_Is_oCNpc(othPtr)) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(index));
		CALL_PtrParam(_@(slfPtr));
		CALL_PtrParam(_@(othPtr));
		CALL__thiscall(_@(MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfo_G1, oCInfoManager__GetInfo_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int oCInfoManager_GetInfo (var int slfinstance, var int othinstance, var int index) {
	//0x00664E50 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNpc *,class oCNpc *,int)
	const int oCInfoManager__GetInfo_G1 = 6704720;

	//0x00702D60 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNPC *,class oCNPC *,int)
	const int oCInfoManager__GetInfo_G2 = 7351648;

	if (!MEM_Game.infoman) { return 0; };
	var oCNPC slf; slf = Hlp_GetNpc(slfinstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };
	var oCNPC oth; oth = Hlp_GetNpc(othinstance);
	if (!Hlp_IsValidNpc(oth)) { return 0; };

	var int slfPtr; slfPtr = _@(slf);
	var int othPtr; othPtr = _@(oth);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(index));
		CALL_PtrParam(_@(slfPtr));
		CALL_PtrParam(_@(othPtr));
		CALL__thiscall(_@(MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfo_G1, oCInfoManager__GetInfo_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Function will return specific instance of dialog option (does not include C_Info.important dialogs. Will return only dialog which is listed Dialog choice box)
 *	Be careful - this can't be used with dialog choices (Info_AddChoice ...)
 */
func int oCInfoManager_GetInfoUnimportant_ByPtr (var int slfPtr, var int othPtr, var int index) {
	//0x00665120 public: class oCInfo * __thiscall oCInfoManager::GetInfoUnimportant(class oCNpc *,class oCNpc *,int)
	const int oCInfoManager__GetInfoUnimportant_G1 = 6705440;

	//0x00703030 public: class oCInfo * __thiscall oCInfoManager::GetInfoUnimportant(class oCNPC *,class oCNPC *,int)
	const int oCInfoManager__GetInfoUnimportant_G2 = 7352368;

	if (!MEM_Game.infoman) { return 0; };
	if (!Hlp_Is_oCNpc(slfPtr)) { return 0; };
	if (!Hlp_Is_oCNpc(othPtr)) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(index));
		CALL_PtrParam(_@(slfPtr));
		CALL_PtrParam(_@(othPtr));
		CALL__thiscall(_@(MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfoUnimportant_G1, oCInfoManager__GetInfoUnimportant_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int oCInfoManager_GetInfoUnimportant (var int slfinstance, var int othinstance, var int index) {
	//0x00665120 public: class oCInfo * __thiscall oCInfoManager::GetInfoUnimportant(class oCNpc *,class oCNpc *,int)
	const int oCInfoManager__GetInfoUnimportant_G1 = 6705440;

	//0x00703030 public: class oCInfo * __thiscall oCInfoManager::GetInfoUnimportant(class oCNPC *,class oCNPC *,int)
	const int oCInfoManager__GetInfoUnimportant_G2 = 7352368;

	if (!MEM_Game.infoman) { return 0; };
	var oCNPC slf; slf = Hlp_GetNpc(slfinstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };
	var oCNPC oth; oth = Hlp_GetNpc(othinstance);
	if (!Hlp_IsValidNpc(oth)) { return 0; };

	var int slfPtr; slfPtr = _@(slf);
	var int othPtr; othPtr = _@(oth);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(index));
		CALL_PtrParam(_@(slfPtr));
		CALL_PtrParam(_@(othPtr));
		CALL__thiscall(_@(MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfoUnimportant_G1, oCInfoManager__GetInfoUnimportant_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Function returns number of dialog instances which are available between slfinstance & othinstance
 */
func int oCInfoManager_GetInfoCount (var int slfinstance, var int othinstance) {
	//0x00664A30 public: int __thiscall oCInfoManager::GetInfoCount(class oCNpc *,class oCNpc *)
	const int oCInfoManager__GetInfoCount_G1 = 6703664;

	//0x00702940 public: int __thiscall oCInfoManager::GetInfoCount(class oCNPC *,class oCNPC *)
	const int oCInfoManager__GetInfoCount_G2 = 7350592;

	if (!MEM_Game.infoman) { return 0; };
	var oCNPC slf; slf = Hlp_GetNpc(slfinstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };
	var oCNPC oth; oth = Hlp_GetNpc(othinstance);
	if (!Hlp_IsValidNpc(oth)) { return 0; };

	var int slfPtr; slfPtr = _@(slf);
	var int othPtr; othPtr = _@(oth);

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_PtrParam(_@(slfPtr));
		CALL_PtrParam(_@(othPtr));
		CALL__thiscall(_@(MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInfoCount_G1, oCInfoManager__GetInfoCount_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Toggles debug informations for dialogs
 */
func void oCInformationManager_ToggleStatus () {
	//0x0072B360 public: void __fastcall oCInformationManager::ToggleStatus(void)
	const int oCInformationManager__ToggleStatus_G1 = 7517024;

	//0x0065FF20 public: void __fastcall oCInformationManager::ToggleStatus(void)
	const int oCInformationManager__ToggleStatus_G2 = 6684448;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__ToggleStatus_G1, oCInformationManager__ToggleStatus_G2));
		call = CALL_End();
	};
};

//??
func void oCInformationManager_PrintStatus () {
	//0x0072B3B0 protected: void __fastcall oCInformationManager::PrintStatus(void)
	const int oCInformationManager__PrintStatus_G1 = 7517104;

	//0x0065FF70 protected: void __fastcall oCInformationManager::PrintStatus(void)
	const int oCInformationManager__PrintStatus_G2 = 6684528;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__PrintStatus_G1, oCInformationManager__PrintStatus_G2));
		call = CALL_End();
	};
};

/*
 *	Triggers process infos process ?
 */
func void oCInformationManager_Update () {
	//0x0072BE90 public: void __fastcall oCInformationManager::Update(void)
	const int oCInformationManager__Update_G1 = 7519888;

	//0x00660BB0 public: void __fastcall oCInformationManager::Update(void)
	const int oCInformationManager__Update_G2 = 6687664;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__Update_G1, oCInformationManager__Update_G2));
		call = CALL_End();
	};
};

/*
 *	Starts dialog camera
 */
func void oCInformationManager_CameraStart () {
	//0x0072C690 protected: void __fastcall oCInformationManager::CameraStart(void)
	const int oCInformationManager__CameraStart_G1 = 7521936;

	//0x006613A0 protected: void __fastcall oCInformationManager::CameraStart(void)
	const int oCInformationManager__CameraStart_G2 = 6689696;

	//Crashes if info manager is not available!
	if (MEM_InformationMan.IsDone) { return; };

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__CameraStart_G1, oCInformationManager__CameraStart_G2));
		call = CALL_End();
	};
};

/*
 *	Stops dialog camera
 */
func void oCInformationManager_CameraStop () {
	//0x0072C810 protected: void __fastcall oCInformationManager::CameraStop(void)
	const int oCInformationManager__CameraStop_G1 = 7522320;

	//0x00661520 protected: void __fastcall oCInformationManager::CameraStop(void)
	const int oCInformationManager__CameraStop_G2 = 6690080;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__CameraStop_G1, oCInformationManager__CameraStop_G2));
		call = CALL_End();
	};
};

//?
func void oCInformationManager_CameraRefresh () {
	//0x0072C880 protected: void __fastcall oCInformationManager::CameraRefresh(void)
	const int oCInformationManager__CameraRefresh_G1 = 7522432;

	//0x00661590 protected: void __fastcall oCInformationManager::CameraRefresh(void)
	const int oCInformationManager__CameraRefresh_G2 = 6690192;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__CameraRefresh_G1, oCInformationManager__CameraRefresh_G2));
		call = CALL_End();
	};
};

/*
 *	Exits Information manager
 */
func void oCInformationManager_Exit () {
	//0x0072C530 public: void __fastcall oCInformationManager::Exit(void)
	const int oCInformationManager__Exit_G1 = 7521584;

	//0x00661240 public: void __fastcall oCInformationManager::Exit(void)
	const int oCInformationManager__Exit_G2 = 6689344;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__Exit_G1, oCInformationManager__Exit_G2));
		call = CALL_End();
	};
};

func void oCInformationManager_OnTermination () {
	//0x0072E430 protected: void __fastcall oCInformationManager::OnTermination(void)
	const int oCInformationManager__OnTermination_G1 = 7529520;

	//0x006631A0 protected: void __fastcall oCInformationManager::OnTermination(void)
	const int oCInformationManager__OnTermination_G2 = 6697376;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEMINT_oCInformationManager_Address), _@(null), MEMINT_SwitchG1G2(oCInformationManager__OnTermination_G1, oCInformationManager__OnTermination_G2));
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
	//0x007594A0 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
	const int zCViewDialogChoice__HighlightSelected_G1 = 7705760;

	//0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
	const int zCViewDialogChoice__HighlightSelected_G2 = 6878752;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(null), MEMINT_SwitchG1G2(zCViewDialogChoice__HighlightSelected_G1, zCViewDialogChoice__HighlightSelected_G2));
		call = CALL_End();
	};
};

func void zCViewDialogChoice_ShowSelected () {
	//0x00759000 protected: void __fastcall zCViewDialogChoice::ShowSelected(void)
	const int zCViewDialogChoice__ShowSelected_G1 = 7704576;

	//0x0068F180 protected: void __fastcall zCViewDialogChoice::ShowSelected(void)
	const int zCViewDialogChoice__ShowSelected_G2 = 6877568;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(null), MEMINT_SwitchG1G2(zCViewDialogChoice__ShowSelected_G1, zCViewDialogChoice__ShowSelected_G2));
		call = CALL_End();
	};
};

//?
func void zCViewDialogChoice_BlitText () {
	//0x00758E70 protected: virtual void __fastcall zCViewDialogChoice::BlitText(void)
	const int zCViewDialogChoice__BlitText_G1 = 7704176;

	//0x0068EFE0 protected: virtual void __fastcall zCViewDialogChoice::BlitText(void)
	const int zCViewDialogChoice__BlitText_G2 = 6877152;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(null), MEMINT_SwitchG1G2(zCViewDialogChoice__BlitText_G1, zCViewDialogChoice__BlitText_G2));
		call = CALL_End();
	};
};

/*
 *	Selects dialog choice - index starts at 0
 */
func void zCViewDialogChoice_Select (var int index) {
	//0x007592C0 protected: void __fastcall zCViewDialogChoice::Select(int)
	const int zCViewDialogChoice__Select_G1 = 7705280;

	//0x0068F440 protected: void __fastcall zCViewDialogChoice::Select(int)
	const int zCViewDialogChoice__Select_G2 = 6878272;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(index), MEMINT_SwitchG1G2(zCViewDialogChoice__Select_G1, zCViewDialogChoice__Select_G2));
		call = CALL_End();
	};
};

/*
 *	Selects previous dialog choice
 */
func void zCViewDialogChoice_SelectPrevious () {
	//0x007590A0 protected: void __fastcall zCViewDialogChoice::SelectPrevious(void)
	const int zCViewDialogChoice__SelectPrevious_G1		= 7704736;
	//0x0068F220 protected: void __fastcall zCViewDialogChoice::SelectPrevious(void)
	const int zCViewDialogChoice__SelectPrevious_G2		= 6877728;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(null), MEMINT_SwitchG1G2(zCViewDialogChoice__SelectPrevious_G1, zCViewDialogChoice__SelectPrevious_G2));
		call = CALL_End();
	};
};

/*
 *	Selects next dialog choice
 */
func void zCViewDialogChoice_SelectNext () {
	//0x007591B0 protected: void __fastcall zCViewDialogChoice::SelectNext(void)
	const int zCViewDialogChoice__SelectNext_G1 = 7705008;
	//0x0068F330 protected: void __fastcall zCViewDialogChoice::SelectNext(void)
	const int zCViewDialogChoice__SelectNext_G2 = 6878000;

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(null), MEMINT_SwitchG1G2(zCViewDialogChoice__SelectNext_G1, zCViewDialogChoice__SelectNext_G2));
		call = CALL_End();
	};
};

//???
func void zCViewDialogChoice_RemoveChoice (var int index) {
	//0x00759800 public: void __fastcall zCViewDialogChoice::RemoveChoice(int)
	const int zCViewDialogChoice__RemoveChoice_G1 = 7706624;

	//0x0068F9B0 public: void __fastcall zCViewDialogChoice::RemoveChoice(int)
	const int zCViewDialogChoice__RemoveChoice_G2 = 6879664;

	if (!MEM_InformationMan.DlgChoice) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(MEM_InformationMan.DlgChoice), _@(index), MEMINT_SwitchG1G2(zCViewDialogChoice__RemoveChoice_G1, zCViewDialogChoice__RemoveChoice_G2));
		call = CALL_End();
	};
};

//0x00665B70 public: void __thiscall oCInfo::RemoveChoice(class zSTRING)

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


00759810  .text     Debug data           ?RemoveAllChoices@zCViewDialogChoice@@QAIXXZ
0x0068F9C0 public: void __fastcall zCViewDialogChoice::RemoveAllChoices(void)
*/

/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC
 */
func int NPC_GetInfoInstanceCount (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC(slfInstance);
	if (!Hlp_IsValidNPC(slf)) { return 0; };
	var int instID; instID = Hlp_GetInstanceID(slf);

	var int count; count = 0;

	var oCInfo info;
	var zCListSort ls;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while(infoPtr);
		ls = _^(infoPtr);

		if (ls.data) {
			info = _^(ls.data);

			if (info.npc == instID) {
				count += 1;
			};
		};

		infoPtr = ls.next;
	end;

	return + count;
};

/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC and were not yet told
 */
func int NPC_GetInfoInstanceUntoldCount (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };
	var int instID; instID = Hlp_GetInstanceID(slf);

	var int count; count = 0;

	var oCInfo info;
	var zCListSort ls;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		ls = _^(infoPtr);
		if (ls.data) {
			info = _^(ls.data);

			if (info.npc == instID) {
				if (info.told == 0) {
					count += 1;
				};
			};
		};

		infoPtr = ls.next;
	end;

	return count;
};

//	Commented out - seems like this cannot be used when NPC is inserted into the world - causes crashes

/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC and have trade attribute == TRUE
 */
 /*
var int InfoMan_TotalCount;
var int InfoMan_NpcInstanceID;

func void NPC_InfoMan_GetTradeCount_Sub (var int node) {
	var zCListSort list; list = _^(node);
	if (list.data) {
		var oCInfo info;
		info = _^(list.data);

		if ((info.npc == InfoMan_NpcInstanceID) && (info.trade)) {
			var int i; i;
			InfoMan_TotalCount += 1;
		};
	};
};

func int NPC_GetInfoInstanceTradeCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };

	if (!MEM_InfoMan.infoList_next) { return 0; };

	InfoMan_TotalCount = 0;
	InfoMan_NpcInstanceID = Hlp_GetInstanceID(slf);

	List_ForFS (MEM_InfoMan.infoList_next, NPC_InfoMan_GetTradeCount_Sub);

	return +InfoMan_TotalCount;
};

func int NPC_GetInfoInstanceTradeCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };

	if (!MEM_InfoMan.infoList_next) { return 0; };

	var int count; count = 0;
	var int instID; instID = Hlp_GetInstanceID(slf);

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	var int p;

	p = MEM_StackPos.position;

	var zCListSort list; list = _^(infoPtr);

	if (list.data) {

		var oCInfo info;
		info = _^(list.data);

		if ((info.npc == instID) && (info.trade)) {
			//No idea why ... but here I have to use var int i; i; otherwise Gothic crashes
			var int i; i;
			count += 1;
		};

		infoPtr = list.next;
	};

	if (infoPtr) {
		MEM_StackPos.position = p;
	};

	return +count;
};

func int NPC_IsTrader (var int slfInstance) {
	MEM_InitAll ();

	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return 0; };

	if (!MEM_InfoMan.infoList_next) { return 0; };

	var int instID; instID = Hlp_GetInstanceID(slf);

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		var zCListSort list; list = _^(infoPtr);

		if (list.data) {
			var oCInfo info;
			info = _^(list.data);

			if ((info.npc == instID) && (info.trade)) {
				//No idea why ... but here I have to use var int i; i; otherwise Gothic crashes
				var int i; i;
				return TRUE;
			};
		};

		infoPtr = list.next;
	end;

	return FALSE;
};
*/

func int InfoManager_GetSelectedInfo () {
	if (InfoManager_HasFinished()) { return 0; };
	var int dlgChoice; dlgChoice = MEM_InformationMan.dlgChoice;
	if (!dlgChoice) { return 0; };
	var zCViewDialogChoice dlg; dlg = _^(dlgChoice);
	var zCArray arr; arr = _^(dlgChoice + 172);
	if (!arr.array) { return 0; };

	if (MEM_InformationMan.mode == INFO_MGR_MODE_INFO) {
		return + oCInfoManager_GetInfoUnimportant_ByPtr(MEM_InformationMan.npc, MEM_InformationMan.player, dlg.ChoiceSelected);
	} else
	//Choices - have to be extracted from oCInfo.listChoices_next
	//MEM_InformationMan.Info is oCInfo pointer
	if (MEM_InformationMan.mode == INFO_MGR_MODE_CHOICE) {
		return + MEM_InformationMan.Info;
	};

	return 0;
};

func int InfoManager_GetSelectedInfoChoice () {
	if (InfoManager_HasFinished()) { return 0; };
	var int dlgChoice; dlgChoice = MEM_InformationMan.dlgChoice;
	if (!dlgChoice) { return 0; };
	var zCViewDialogChoice dlg; dlg = _^(dlgChoice);
	var zCArray arr; arr = _^(dlgChoice + 172);
	if (!arr.array) { return 0; };

	var oCInfo info;
	var zCList l;
	var int list;
	var int i; i = 0;

	//Choices - have to be extracted from oCInfo.listChoices_next
	//MEM_InformationMan.Info is oCInfo pointer
	if (MEM_InformationMan.mode == INFO_MGR_MODE_CHOICE) {
		if (MEM_InformationMan.Info) {
			info = _^(MEM_InformationMan.info);
			list = info.listChoices_next;
			while (list);
				l = _^(list);

				if (l.data) {
					if (i == dlg.choiceSelected) {
						return l.data;
					};
				};

				list = l.next;
				i += 1;
			end;
		};
	};

	return 0;
};

func void InfoManager_SetInfoChoiceText (var int index, var string text) {
	if (InfoManager_HasFinished()) { return; };
	var int dlgChoice; dlgChoice = MEM_InformationMan.dlgChoice;
	if (!dlgChoice) { return; };
	var zCArray arr; arr = _^(dlgChoice + 172);
	if (!arr.array) { return; };

	var oCInfo info;
	var int i; i = 0;
	var int list;
	var zCList l;
	var oCInfoChoice infoChoice;

	//Choices - have to be extracted from oCInfo.listChoices_next
	//MEM_InformationMan.info is oCInfo pointer
	if (MEM_InformationMan.mode == INFO_MGR_MODE_CHOICE) {
		if (MEM_InformationMan.info) {
			info = _^(MEM_InformationMan.info);
			list = info.listChoices_next;
			while (list);
				l = _^(list);

				if (l.data) {
					if (i == index) {
						infoChoice = _^(l.data);
						infoChoice.text = text;
						return;
					};
				};

				list = l.next;
				i += 1;
			end;
		};
	};
};

func int InfoManager_IsInChoiceMode () {
	if (InfoManager_HasFinished()) { return FALSE; };

	if (MEM_InformationMan.mode == INFO_MGR_MODE_CHOICE) {
		return TRUE;
	};

	return FALSE;
};

func int InfoManager_GetSelectedChoiceIndex () {
	if (InfoManager_HasFinished()) { return -1; };

	var int dlgChoice; dlgChoice = MEM_InformationMan.dlgChoice;
	if (!dlgChoice) { return -1; };

	var zCViewDialogChoice dlg; dlg = _^(dlgChoice);
	return dlg.ChoiceSelected;
};

func string InfoManager_GetChoiceDescription (var int index) {
	if (InfoManager_HasFinished()) { return STR_EMPTY; };
	var int dlgChoice; dlgChoice = MEM_InformationMan.dlgChoice;
	if (!dlgChoice) { return STR_EMPTY; };
	var zCArray arr; arr = _^(dlgChoice + 172);
	if (!arr.array) { return STR_EMPTY; };
	if ((index < 0) || (index >= arr.numInArray)) { return STR_EMPTY; };

	var int infoPtr;
	var int list;

	var zCList l;
	var oCInfo info;
	var oCInfoChoice infoChoice;

	var int i; i = 0;

	if (MEM_InformationMan.mode == INFO_MGR_MODE_INFO)
	{
		infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr(MEM_InformationMan.npc, MEM_InformationMan.player, index);

		if (infoPtr) {
			info = _^(infoPtr);
			return info.description;
		};
	} else
	//Choices - have to be extracted from oCInfo.listChoices_next
	//MEM_InformationMan.info is oCInfo pointer
	if (MEM_InformationMan.mode == INFO_MGR_MODE_CHOICE) {
		infoPtr = MEM_InformationMan.info;

		if (infoPtr) {
			info = _^(infoPtr);

			list = info.listChoices_next;

			while (list);
				l = _^(list);
				if (l.data) {
					//if our dialog option is dialog choice - put text to dlgDescription
					if (i == index) {
						infoChoice = _^(l.data);
						return infoChoice.text;
					};
				};

				list = l.next;
				i += 1;
			end;
		};
	};

	return STR_EMPTY;
};

/*
 *	Npc_KnowsInfoByString
 *	 - function checks out if oCInfo.told property != 0
 *	 - I will be using this one to avoid compilation issues (function will allow me to compile incomplete/interconnected dialogues)
 *	 - but it might be actually quite useful - as it also works with .permanent dialogues, unlike vanilla Npc_KnowsInfo!
 *	 - NPC parameter is pointless ... it's always 'hero', using it just for sake of consistency with Npc_KnowsInfo
 *
 *	Altered version of setInfoToTold function, originally created by Cryp18Struct
 *	Original function: https://forum.worldofplayers.de/forum/threads/1529361-Dialog-Instance-auf-TRUE-setzten?p=25955510&viewfull=1#post25955510
 */
func int Npc_KnowsInfoByString (var int slfInstance, var string instanceName) {
	// Find instance symbol by instance name
	var int symbID; symbID = MEM_GetSymbolIndex(instanceName);
	if (symbID < 0) || (symbID >= currSymbolTableLength) {
		MEM_Info(ConcatStrings("Npc_KnowsInfoByString: symbol not found ", instanceName));
		return 0;
	};

	var int ptr; ptr = MEM_GetSymbolByIndex(symbID);
	if (!ptr) { return 0; };
	var zCPar_Symbol symb; symb = _^(ptr);

	// Verify that it is an instance
	if ((symb.bitfield & zCPar_Symbol_bitfield_type) != zPAR_TYPE_INSTANCE)
	|| (!symb.offset) {
		MEM_Info(ConcatStrings("Npc_KnowsInfoByString: symbol is not an instance ", instanceName));
		return 0;
	};

	// Verify that it is a oCInfo instance

	//0x007DCD8C const oCInfo::`vftable'
	const int oCInfo___vftable_G1 = 8244620;

	//0x0083C44C const oCInfo::`vftable'
	const int oCInfo___vftable_G2 = 8635468;

	if (MEM_ReadInt(symb.offset - oCInfo_C_INFO_Offset) != MEMINT_SwitchG1G2(oCInfo___vftable_G1, oCInfo___vftable_G2)) {
		MEM_Info(ConcatStrings("Npc_KnowsInfoByString: symbol is not an oCInfo instance: ", instanceName));
		return 0;
	};

	var oCInfo info; info = _^(symb.offset - oCInfo_C_INFO_Offset);
	return info.told;
};

func int oCInfoManager_GetInformation (var int diaInstance) {
	//0x00664A00 public: class oCInfo * __thiscall oCInfoManager::GetInformation(int)
	const int oCInfoManager__GetInformation_G1 = 6703616;

	//0x00702910 public: class oCInfo * __thiscall oCInfoManager::GetInformation(int)
	const int oCInfoManager__GetInformation_G2 = 7350544;

	if (!MEM_Game.infoman) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(diaInstance));
		CALL__thiscall(_@(MEM_Game.infoman), MEMINT_SwitchG1G2(oCInfoManager__GetInformation_G1, oCInfoManager__GetInformation_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func void oCInfo_AddChoice (var int infoPtr, var string s, var int funcID) {
	//0x00665A50 public: void __thiscall oCInfo::AddChoice(class zSTRING,int)
	const int oCInfo__AddChoice_G1 = 6707792;

	//0x00703B20 public: void __thiscall oCInfo::AddChoice(class zSTRING,int)
	const int oCInfo__AddChoice_G2 = 7355168;

	if (!infoPtr) { return; };

	/*
	Sooo ... I have no idea how to call engine function here :)

	//This was crashing!
	//CALL_zstringPtrParam cannot be used in recyclable call
	//CALL_IntParam(funcID);
	//CALL_zstringPtrParam (text);

	//This was not crashing ... however it didn't work properly (sometimes I received completely random texts ?)
	//CALL_IntParam(funcID);
	//CALL_StructParam (_@s (text), 5);
	//CALL__thiscall(infoPtr, MEMINT_SwitchG1G2(oCInfo__AddChoice_G1, oCInfo__AddChoice_G2));
	*/

	//--> Therefore using my own method - I will create oCInfoChoice object and will add it to listChoices
	var oCInfo info; info = _^(infoPtr);
	var int infoChoicePtr; infoChoicePtr = oCInfoChoice_Create(s, funcID);

	//Create list - if it was not yet created
	if (!info.listChoices_next) {
		info.listChoices_next = List_Create(infoChoicePtr);
		return;
	};

	//Otherwise add to the front
	List_AddFront(info.listChoices_next, infoChoicePtr);
};

func void Info_AddChoiceByID (var int diaInstance, var string s, var int funcID) {
	var int infoPtr; infoPtr = oCInfoManager_GetInformation(diaInstance);
	oCInfo_AddChoice(infoPtr, s, funcID);
};

/*
 *	InfoManager_IsChoiceModeActive
 *	 - wrapper function useful for spinners and cached string reset - only for super users :)
 */
func int InfoManager_IsChoiceModeActive () {
	if (InfoManager_IsInChoiceMode()) {
		if (!Hlp_StrCmp(MEM_InformationMan.LastMethod, "OnChoiceBegin")) {
			return TRUE;
		};
	};

	return FALSE;
};

/*
 *	Info_AssignNpc
 *	 - assigns npc to info instance
 */
func void Info_AssignNpc (var int infoInstance, var int npcInstanceID) {
	var int ptr; ptr = oCInfoManager_GetInformation(infoInstance);
	if (!ptr) { return; };

	var oCInfo info; info = _^(ptr);
	info.npc = npcInstanceID;
};

/*
 *	Info_InjectChoices
 *	 - allows me to inject choices into dialogues
 *	 - this feature allows better quest modularity
 */
func void Info_InjectChoices (var int infoInstance) {
	var int ptr; ptr = oCInfoManager_GetInformation(infoInstance);
	if (!ptr) { return; };

	//Override current dialogue instance pointer
	MEM_InformationMan.info = ptr;

	var string injectName; injectName = GetSymbolName(infoInstance);
	injectName = ConcatStrings("IC_", injectName);
	injectName = STR_Upper(injectName);

	var string msg;
	msg = "Info_InjectChoices - searching for dialogues starting with: ";
	msg = ConcatStrings(msg, injectName);
	MEM_Info(msg);

	var int injected; injected = FALSE;

	var oCInfo info;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^(infoPtr);

		if (list.data) {
			info = _^(list.data);
			//if (info.npc == info.npc) {
				if (STR_StartsWith(STR_Upper(info.name), injectName)) {
					MEM_CallByID(info.information);

					injected = TRUE;
					msg = ConcatStrings(" - found ", info.name);
					MEM_Info(msg);
				};
			//};
		};

		infoPtr = list.next;
	end;

	if (!injected) {
		MEM_Info(" - no dialogue choices that could be injected found ...");
	};
};

/*
 *	Info_Injectable_GetChoiceCondition
 *	 - allows me to check if underlying injectable choices will be injected
 *	 - this feature allows better quest modularity
 */
func int Info_Injectable_GetChoiceCondition (var int infoInstance) {
	var int ptr; ptr = oCInfoManager_GetInformation(infoInstance);
	if (!ptr) { return FALSE; };

	var string injectName; injectName = GetSymbolName(infoInstance);
	injectName = ConcatStrings("IC_", injectName);
	injectName = STR_Upper(injectName);

	var string msg;
	msg = "Info_Injectable_GetChoiceCondition - searching for dialogues starting with: ";
	msg = ConcatStrings(msg, injectName);
	MEM_Info(msg);

	var int retVal; retVal = 0;
	var int isNonZero; isNonZero = FALSE;

	var oCInfo info;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^(infoPtr);

		if (list.data) {
			info = _^(list.data);

			//if (info.npc == info.npc) {
				if (STR_StartsWith(STR_Upper(info.name), injectName)) {
					MEM_CallByID(info.conditions);
					retVal = MEM_PopIntResult();

					if (retVal) {
						isNonZero = TRUE;
					};

					msg = ConcatStrings(" - found ", info.name);
					MEM_Info(msg);
				};
			//};
		};

		infoPtr = list.next;
	end;

	if (!isNonZero) {
		MEM_Info(" - no dialogue choices conditions that would return non-zero value found ...");
	};

	return + isNonZero;
};
