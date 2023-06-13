/*
 *	Create object
 */
func int oCMsgState_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCMsgState");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCMsgState_Create (var int subType, var int funcID, var int endOldState, var string wp) {
	var int ptr; ptr = oCMsgState_New ();

	if (!ptr) { return 0; };

	//0x006C0D60 public: __thiscall oCMsgState::oCMsgState(enum oCMsgState::TStateSubType,float)
	//0x00767F00 public: __thiscall oCMsgState::oCMsgState(enum oCMsgState::TStateSubType,float)

/*
	//0x006C0E40 public: __thiscall oCMsgState::oCMsgState(enum oCMsgState::TStateSubType,int)
	const int oCMsgState__oCMsgState_G1 = 7081536;

	//0x00767FE0 public: __thiscall oCMsgState::oCMsgState(enum oCMsgState::TStateSubType,int)
	const int oCMsgState__oCMsgState_G2 = 7765984;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (funcID));
		CALL_IntParam (_@ (subType));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgState__oCMsgState_G1, oCMsgState__oCMsgState_G2));
		call = CALL_End();
	};

*/
	//0x006C0F20 public: __thiscall oCMsgState::oCMsgState(enum oCMsgState::TStateSubType,int,int,class zSTRING const &)
	const int oCMsgState__oCMsgState_G1 = 7081760;

	//0x007680C0 public: __thiscall oCMsgState::oCMsgState(enum oCMsgState::TStateSubType,int,int,class zSTRING const &)
	const int oCMsgState__oCMsgState_G2 = 7766208;

	CALL_zStringPtrParam (wp);
	CALL_IntParam (endOldState);
	CALL_IntParam (funcID);
	CALL_IntParam (subType);
	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (oCMsgState__oCMsgState_G1, oCMsgState__oCMsgState_G2));

	return ptr;
};
