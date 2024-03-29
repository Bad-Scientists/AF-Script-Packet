/*
 *	Author: szapp (mud-freak)
 *	I was not able to find original post though.
 */
func void RemoveoCVobSafe (var int vobPtr, var int purgeChildren) {
	if (!vobPtr) { return; };

	var int worldPtr; worldPtr = _@ (MEM_World);

	if (purgeChildren) {
		var int vobTreePtr; vobTreePtr = MEM_ReadInt (vobPtr+36);

		//0x005F55F0 public: virtual int __thiscall zCWorld::DisposeVobs(class zCTree<class zCVob> *)
		const int zCWorld__DisposeVobs_G1 = 6247920;

		//0x00623960 public: virtual int __thiscall zCWorld::DisposeVobs(class zCTree<class zCVob> *)
		const int zCWorld__DisposeVobs_G2 = 6437216;

		const int call = 0;
		if (CALL_Begin(call)) {
			CALL_PtrParam (_@(vobTreePtr));
			CALL__thiscall (_@(worldPtr), MEMINT_SwitchG1G2 (zCWorld__DisposeVobs_G1, zCWorld__DisposeVobs_G2));
			call = CALL_End();
		};
		return;
	};

	//0x006D6EF0 public: virtual void __thiscall oCWorld::RemoveVob(class zCVob *)
	const int oCWorld__RemoveVob_G1 = 7171824;

	//0x007800C0 public: virtual void __thiscall oCWorld::RemoveVob(class zCVob *)
	const int oCWorld__RemoveVob_G2 = 7864512;

	const int call2 = 0;
	if (CALL_Begin(call2)) {
		CALL_PtrParam (_@(vobPtr));
		CALL__thiscall (_@(worldPtr), MEMINT_SwitchG1G2 (oCWorld__RemoveVob_G1, oCWorld__RemoveVob_G2));
		call2 = CALL_End();
	};
};
