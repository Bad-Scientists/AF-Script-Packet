/*
 *	Create object
 */
func int oCMsgWeapon_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCMsgWeapon");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCMsgWeapon_Create (var int subType, var int targetMode, var int useFist) {
	var int ptr; ptr = oCMsgWeapon_New ();

	if (!ptr) { return 0; };

	//0x006BF630 public: __thiscall oCMsgWeapon::oCMsgWeapon(enum oCMsgWeapon::TWeaponSubType,int,int)
	const int oCMsgWeapon__oCMsgWeapon_G1 = 7075376;

	//0x007667D0 public: __thiscall oCMsgWeapon::oCMsgWeapon(enum oCMsgWeapon::TWeaponSubType,int,int)
	const int oCMsgWeapon__oCMsgWeapon_G2 = 7759824;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (useFist));
		CALL_IntParam (_@ (targetMode));
		CALL_IntParam (_@ (subType));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgWeapon__oCMsgWeapon_G1, oCMsgWeapon__oCMsgWeapon_G2));
		call = CALL_End();
	};

	return ptr;
};
