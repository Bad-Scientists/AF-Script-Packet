//Author: mud-freak
func void oCNpc_SetFocusVob (var int slfInstance, var int focusPtr) {
	//0068FF70  .text     Debug data           ?SetFocusVob@oCNpc@@QAEXPAVzCVob@@@Z
	const int oCNpc__SetFocusVob_G1 = 6881136;

	//0x00732B60 public: void __thiscall oCNpc::SetFocusVob(class zCVob *)
	const int oCNpc__SetFocusVob_G2 = 7547744;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPc (slf)) { return; };
	
	var int slfPtr; slfPtr = _@ (slf);

	// Update the focus vob (properly, mind the reference counter)
	if (focusPtr != slf.focus_vob) {
		const int call = 0;

		if (CALL_Begin(call)) {
			CALL_PtrParam(_@(focusPtr)); 
			CALL__thiscall(_@(slfPtr), MEMINT_SwitchG1G2 (oCNpc__SetFocusVob_G1, oCNpc__SetFocusVob_G2));
			call = CALL_End();
		};
	};
};