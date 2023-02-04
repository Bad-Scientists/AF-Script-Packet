/*
 *	Create object
 */
func int oCMsgMovement_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCMsgMovement");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCMsgMovement_Create (var int subType, var string targetName, var int targetVob, var int posPtr, var int angleF, var int targetMode) {
	var int ptr; ptr = oCMsgMovement_New ();

	if (!ptr) { return 0; };

	//0x006BE4B0 public: __thiscall oCMsgMovement::oCMsgMovement(void)
	const int oCMsgMovement__oCMsgMovement_G1 = 7070896;

	//0x00765650 public: __thiscall oCMsgMovement::oCMsgMovement(void)
	const int oCMsgMovement__oCMsgMovement_G2 = 7755344;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgMovement__oCMsgMovement_G1, oCMsgMovement__oCMsgMovement_G2));
		call = CALL_End();
	};

	//Setup additional parameters
	var oCMsgMovement msg;
	msg = _^ (ptr);

	msg.subType = subType;

	//EV_GOTOFP, EV_GOROUTE, EV_BEAMTO
	msg.targetName = targetName;

	//EV_GOTOVOB, EV_TURNTOVOB, EV_TURNAWAY, EV_WHIRLAROUND
	msg.targetVob = targetVob;

	//We don't really need targetVobName, do we?
	msg.targetVobName = targetName;

	//EV_GOTOPOS, EV_TURNTOPOS, EV_JUMP
	//Get target pos of vobPointer
	if (targetVob) {
		//TODO: will this work ?
		//func int zCVob_GetPositionWorld (var int vobPtr) {

			//0x0051B3C0 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
			const int zCVob__GetPositionWorld_G1 = 5354432;

			//0x0052DC90 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
			const int zCVob__GetPositionWorld_G2 = 5430416;

			//if (!vobPtr) { return 0; };

			CALL_RetValIsStruct (12);
			CALL__thiscall (targetVob, MEMINT_SwitchG1G2 (zCVob__GetPositionWorld_G1, zCVob__GetPositionWorld_G2));
			var int vobPosPtr; vobPosPtr = CALL_RetValAsPtr ();

			MEM_CopyBytes (vobPosPtr, _@ (msg.targetPos), 12);
			MEM_Free (vobPosPtr);
		//};
	};

	if (posPtr) {
		MEM_CopyBytes (posPtr, _@ (msg.targetPos), 12);
	};

	if (subType == EV_TURN) {
		msg.angle = angleF;
	};

	//EV_SETWALKMODE
	if (subType == EV_SETWALKMODE) {
		msg.targetMode = targetMode;
	};

	return ptr;
};
