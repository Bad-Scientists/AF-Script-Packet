func void oCMobInter_SendStateChange (var int mobPtr, var int fromState, var int toState) {
	//0x0067D8C0 protected: void __thiscall oCMobInter::SendStateChange(int,int)
	const int oCMobInter__SendStateChange_G1 = 6805696;

	//0x0071ED90 public: void __thiscall oCMobInter::SendStateChange(int,int)
	const int oCMobInter__SendStateChange_G2 = 7466384;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (toState));
		CALL_IntParam (_@ (fromState));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SendStateChange_G1, oCMobInter__SendStateChange_G2));
		call = CALL_End();
	};
};

func string oCMobInter_GetScemeName (var int mobPtr) {
	//0x00684CA0 public: virtual class zSTRING __thiscall oCMobDoor::GetScemeName(void)
	const int oCMobDoor__GetScemeName_G1 = 6835360;

	//0x00726D60 public: virtual class zSTRING __thiscall oCMobDoor::GetScemeName(void)
	const int oCMobDoor__GetScemeName_G2 = 7499104;

	//Only G2A ... G1 does not have this function
	//0x007232A0 public: virtual class zSTRING __thiscall oCMobBed::GetScemeName(void)
	const int oCMobBed__GetScemeName_G2 = 7484064;

	//0x0067C970 public: virtual class zSTRING __thiscall oCMobInter::GetScemeName(void)
	const int oCMobInter__GetScemeName_G1 = 6801776;

	//0x0071DBE0 public: virtual class zSTRING __thiscall oCMobInter::GetScemeName(void)
	const int oCMobInter__GetScemeName_G2 = 7461856;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return STR_EMPTY; };

	CALL_RetValIszString();

	if (Hlp_Is_oCMobDoor (mobPtr)) {
		CALL__thiscall (mobPtr, MEMINT_SwitchG1G2 (oCMobDoor__GetScemeName_G1, oCMobDoor__GetScemeName_G2));
	} else
	if (Hlp_Is_oCMobBed (mobPtr) && (MEMINT_SwitchG1G2 (0, 1))) {
		CALL__thiscall (mobPtr, oCMobBed__GetScemeName_G2);
	} else {
		CALL__thiscall (mobPtr, MEMINT_SwitchG1G2 (oCMobInter__GetScemeName_G1, oCMobInter__GetScemeName_G2));
	};

	return CALL_RetValAszstring ();
};

func void oCMobInter_ScanIdealPositions (var int mobPtr) {
	//0x0067C9C0 protected: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G1 = 6801856;

	//0x0071DC30 public: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G2 = 7461936;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__ScanIdealPositions_G1, oCMobInter__ScanIdealPositions_G2));
		call = CALL_End();
	};
};

func int oCMobInter_SearchFreePosition (var int mobPtr, var int slfInstance, var int rangeF) {
	//0x0067CD60 protected: virtual struct TMobOptPos * __thiscall oCMobInter::SearchFreePosition(class oCNpc *)
	const int oCMobInter__SearchFreePosition_G1 = 6802784;

	//0x0071DFC0 public: virtual struct TMobOptPos * __thiscall oCMobInter::SearchFreePosition(class oCNpc *,float)
	const int oCMobInter__SearchFreePosition_G2 = 7462848;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		//G2A has 1 extra parameter - I assume range
		if (MEMINT_SwitchG1G2 (0, 1)) {
			CALL_PtrParam (_@ (rangeF));
		};

		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SearchFreePosition_G1, oCMobInter__SearchFreePosition_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func int oCMobInter_GetFreePosition (var int mobPtr, var int slfInstance, var int posPtr) {
	//0x0067CD00 public: int __thiscall oCMobInter::GetFreePosition(class oCNpc *,class zVEC3 &)
	const int oCMobInter__GetFreePosition_G1 = 6802688;

	//0x0071DF50 public: int __thiscall oCMobInter::GetFreePosition(class oCNpc *,class zVEC3 &)
	const int oCMobInter__GetFreePosition_G2 = 7462736;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (posPtr));
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__GetFreePosition_G1, oCMobInter__GetFreePosition_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func void oCMobInter_SetIdealPosition (var int mobPtr, var int slfInstance) {
	//0x0067CEF0 protected: void __thiscall oCMobInter::SetIdealPosition(class oCNpc *)
	const int oCMobInter__SetIdealPosition_G1 = 6803184;

	//0x0071E240 public: void __thiscall oCMobInter::SetIdealPosition(class oCNpc *)
	const int oCMobInter__SetIdealPosition_G2 = 7463488;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SetIdealPosition_G1, oCMobInter__SetIdealPosition_G2));
		call = CALL_End();
	};
};

func void oCMobInter_SetHeading (var int mobPtr, var int slfInstance) {
	//0x0067CEA0 protected: void __thiscall oCMobInter::SetHeading(class oCNpc *)
	const int oCMobInter__SetHeading_G1 = 6803104;

	//0x0071E1F0 public: void __thiscall oCMobInter::SetHeading(class oCNpc *)
	const int oCMobInter__SetHeading_G2 = 7463408;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__SetHeading_G1, oCMobInter__SetHeading_G2));
		call = CALL_End();
	};
};

func int oCMobInter_IsAvailable (var int mobPtr, var int slfInstance) {
	//0x0067F570 public: int __thiscall oCMobInter::IsAvailable(class oCNpc *)
	const int oCMobInter__IsAvailable_G1 = 6813040;

	//0x00720EC0 public: int __thiscall oCMobInter::IsAvailable(class oCNpc *)
	const int oCMobInter__IsAvailable_G2 = 7474880;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__IsAvailable_G1, oCMobInter__IsAvailable_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func void oCMobInter_MarkAsUsed (var int mobPtr, var int timeDeltaF, var int vobPtr) {
	//0x0067F5D0 public: void __thiscall oCMobInter::MarkAsUsed(float,class zCVob *)
	const int oCMobInter__MarkAsUsed_G1 = 6813136;

	//0x00720F20 public: void __thiscall oCMobInter::MarkAsUsed(float,class zCVob *)
	const int oCMobInter__MarkAsUsed_G2 = 7474976;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vobPtr));
		CALL_FloatParam (_@ (timeDeltaF));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__MarkAsUsed_G1, oCMobInter__MarkAsUsed_G2));
		call = CALL_End();
	};
};

func int oCMobInter_GetFreeTrafo_ByNodeName (var int mobPtr, var string nodeName, var int trafoPtr) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return FALSE; };

	oCMobInter_ScanIdealPositions (mobPtr);

	var oCMobInter mob; mob = _^ (mobPtr);

	var int ptr;
	var zCList list;
	ptr = mob.optimalPosList_next;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			var TMobOptPos mobOptPos;
			mobOptPos = _^ (ptr);

			//ZS_POS0_FRONT, ZS_POS0_BACK
			if (STR_EndsWith (mobOptPos.nodeName, nodeName)) {
				MEM_CopyBytes (_@ (mobOptPos.trafo), trafoPtr, 64);
				return TRUE;
			};
		};

		ptr = list.next;
	end;

	return FALSE;
};

func void oCMobInter_SetInteractWith (var int mobPtr, var int npcPtr) {
	if (!Hlp_Is_oCMobInter (mobPtr)) { return; };

	oCMobInter_ScanIdealPositions (mobPtr);

	var oCMobInter mob; mob = _^ (mobPtr);

	var int ptr;
	var zCList list;
	ptr = mob.optimalPosList_next;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			var TMobOptPos mobOptPos;
			mobOptPos = _^ (ptr);

			//if (STR_StartsWith (mobOptPos.nodeName, "ZS_POS")) {
				mobOptPos.npc = npcPtr;
				//return;
			//};
		};

		ptr = list.next;
	end;
};

/*

	const int oCMobInter__IsInteractingWith_G1 = 6814832;
	CALL_PtrParam (_@ (hero));
	CALL__thiscall (spell.spellTarget, oCMobInter__IsInteractingWith_G1);
	var int retVal; retVal = CALL_RetValAsInt ();
*/

func int oCMobInter_IsInteractingWith (var int mobPtr, var int slfInstance) {
	//0x0067FC70 public: virtual int __thiscall oCMobInter::IsInteractingWith(class oCNpc *)
	const int oCMobInter__IsInteractingWith_G1 = 6814832;

	//0x00721550 public: virtual int __thiscall oCMobInter::IsInteractingWith(class oCNpc *)
	const int oCMobInter__IsInteractingWith_G2 = 7476560;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__IsInteractingWith_G1, oCMobInter__IsInteractingWith_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMobInter_CanInteractWith (var int mobPtr, var int slfInstance) {
	//0x0067F5F0 public: virtual int __thiscall oCMobInter::CanInteractWith(class oCNpc *)
	const int oCMobInter__CanInteractWith_G1 = 6813168;

	//0x00720F40 public: virtual int __thiscall oCMobInter::CanInteractWith(class oCNpc *)
	const int oCMobInter__CanInteractWith_G2 = 7475008;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (slfPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__CanInteractWith_G1, oCMobInter__CanInteractWith_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};
