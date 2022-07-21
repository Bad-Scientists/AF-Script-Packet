/*
 *	Create object
 */
func int oCAICamera_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCAICamera");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCAICamera_Create () {
	var int ptr; ptr = oCAICamera_New ();

	if (!ptr) { return 0; };

	//0x00616500 public: __thiscall oCAICamera::oCAICamera(void)
	const int oCAICamera__oCAICamera_G1 = 6382848;

	//0x0069DD00 public: __thiscall oCAICamera::oCAICamera(void)
	const int oCAICamera__oCAICamera_G2 = 6937856;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCAICamera__oCAICamera_G1, oCAICamera__oCAICamera_G2));
		call = CALL_End();
	};

	return ptr;
};
