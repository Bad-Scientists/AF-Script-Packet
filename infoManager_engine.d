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
FUNC VOID zCViewDialogChoice_HighlightSelected ()
{
	const int zCViewDialogChoice__HighlightSelected = 7705760;

//	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall (_@ (MEM_InformationMan.DlgChoice), _@ (null), zCViewDialogChoice__HighlightSelected);
		call = CALL_End();
	};
};


func void oCInformationManager__ToggleStatus ()
{
	// 0072B360  .text     Debug data           ?ToggleStatus@oCInformationManager@@QAIXXZ
	const int oCInformationManager__ToggleStatus_G1 = 7517024;
	// 0x0065FF20 public: void __fastcall oCInformationManager::ToggleStatus(void)
	const int oCInformationManager__ToggleStatus_G2 = 6684448;

	var int im;
	im = MEM_InstToPtr(MEM_InformationMan);

	const int null = 0;

	const int call = 0;
	
	if (CALL_Begin(call)) {

        CALL__fastcall(im, _@(null), MEMINT_SwitchG1G2(oCInformationManager__ToggleStatus_G1,
                                                       oCInformationManager__ToggleStatus_G2));
        call = CALL_End();
    };

};

/*
0x00621B80 public: int __fastcall zCWorld::TraceRayNearestHit(class zVEC3 const &,class zVEC3 const &,class zCArray<class zCVob *> const *,int)

const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(flags));
        CALL_PtrParam(_@(ignoreList));
        CALL_PtrParam(_@(dirPtr));

        CALL__fastcall(_@(worldPtr), _@(posPtr), MEMINT_SwitchG1G2(zCWorld__TraceRayNearestHit_G1,
                                                                   zCWorld__TraceRayNearestHit_G2));
        call = CALL_End();
    };
*/

//00757460  .text     Debug data           ?AddText@zCViewPrint@@IAIXPAVzCViewText2@@@Z
//const int zCViewPrint__AddText
//0x00694070 protected: void __fastcall zCViewPrint::AddText(class zCViewText2 *)

/*
00664E50  .text     Debug data           ?GetInfo@oCInfoManager@@QAEPAVoCInfo@@PAVoCNPC@@0H@Z
00664FB0  .text     Debug data           ?GetInfoImportant@oCInfoManager@@QAEPAVoCInfo@@PAVoCNPC@@0H@Z
00665120  .text     Debug data           ?GetInfoUnimportant@oCInfoManager@@QAEPAVoCInfo@@PAVoCNPC@@0H@Z

0x00702D60 public: class oCInfo * __thiscall oCInfoManager::GetInfo(class oCNPC *,class oCNPC *,int)
0x00702EC0 public: class oCInfo * __thiscall oCInfoManager::GetInfoImportant(class oCNPC *,class oCNPC *,int)
0x00703030 public: class oCInfo * __thiscall oCInfoManager::GetInfoUnimportant(class oCNPC *,class oCNPC *,int)
*/
