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

































