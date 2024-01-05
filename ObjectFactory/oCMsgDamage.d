//0x006BDE70 protected: __thiscall oCMsgDamage::oCMsgDamage(void)
//0x006BDF70 protected: __thiscall oCMsgDamage::oCMsgDamage(enum oCMsgDamage::TDamageSubType)

//0x00765010 protected: __thiscall oCMsgDamage::oCMsgDamage(void)
//0x00765110 protected: __thiscall oCMsgDamage::oCMsgDamage(enum oCMsgDamage::TDamageSubType)

/*
 *	Create object
 */
func int oCMsgDamage_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCMsgDamage");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCMsgDamage_Create (var int subType, var int ddPtr) {
	var int ptr; ptr = oCMsgDamage_New ();

	if (!ptr) { return 0; };

	//0x006BE040 public: __thiscall oCMsgDamage::oCMsgDamage(enum oCMsgDamage::TDamageSubType,struct oCNpc::oSDamageDescriptor const &)
	const int oCMsgDamage__oCMsgDamage_G1 = 7069760;

	//0x007651E0 public: __thiscall oCMsgDamage::oCMsgDamage(enum oCMsgDamage::TDamageSubType,struct oCNpc::oSDamageDescriptor const &)
	const int oCMsgDamage__oCMsgDamage_G2 = 7754208;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (ddPtr));
		CALL_IntParam (_@ (subType));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgDamage__oCMsgDamage_G1, oCMsgDamage__oCMsgDamage_G2));
		call = CALL_End();
	};

	return ptr;
};
