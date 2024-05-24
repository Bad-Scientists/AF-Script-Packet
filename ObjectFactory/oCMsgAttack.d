/*
 *	Create object
 */
func int oCMsgAttack_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCMsgAttack");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCMsgAttack_Create (var int subType, var int targetVob, var int startFrameF, var int ani, var int combo) {
	var int ptr; ptr = oCMsgAttack_New ();

	if (!ptr) { return 0; };

	/*
	//0x006BFF90 public: __thiscall oCMsgAttack::oCMsgAttack(enum oCMsgAttack::TAttackSubType,class zCVob *,float)
	const int oCMsgAttack__oCMsgAttack_G1 = 7077776;

	//0x00767130 public: __thiscall oCMsgAttack::oCMsgAttack(enum oCMsgAttack::TAttackSubType,class zCVob *,float)
	const int oCMsgAttack__oCMsgAttack_G2 = 7762224;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_FloatParam (_@ (startFrameF));
		CALL_IntParam (_@ (targetVob));
		CALL_IntParam (_@ (subType));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgAttack__oCMsgAttack_G1, oCMsgAttack__oCMsgAttack_G2));
		call = CALL_End();
	};
	*/

	//0x006BFEC0 public: __thiscall oCMsgAttack::oCMsgAttack(enum oCMsgAttack::TAttackSubType,int,int)
	const int oCMsgAttack__oCMsgAttack2_G1 = 7077568;

	//0x00767060 public: __thiscall oCMsgAttack::oCMsgAttack(enum oCMsgAttack::TAttackSubType,int,int)
	const int oCMsgAttack__oCMsgAttack2_G2 = 7762016;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (combo));
		CALL_IntParam (_@ (ani));
		CALL_IntParam (_@ (subType));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgAttack__oCMsgAttack2_G1, oCMsgAttack__oCMsgAttack2_G2));
		call = CALL_End();
	};

	//Setup additional parameters
	var oCMsgAttack msg; msg = _^ (ptr);

	msg.target = targetVob;
	msg.startFrame = startFrameF;

	return ptr;
};
