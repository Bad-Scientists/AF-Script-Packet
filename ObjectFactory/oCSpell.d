/*
 *	Create object
 */
func int oCSpell_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCSpell");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCSpell_Create (var int spellID) {
	var int ptr; ptr = oCSpell_New ();

	if (!ptr) { return 0; };

	//0x0047B9F0 public: __thiscall oCSpell::oCSpell(int)
	const int oCSpell__oCSpell_G1 = 4700656;

	//0x00483DD0 public: __thiscall oCSpell::oCSpell(int)
	const int oCSpell__oCSpell_G2 = 4734416;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (spellID));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCSpell__oCSpell_G1, oCSpell__oCSpell_G2));
		call = CALL_End();
	};

	return ptr;
};
