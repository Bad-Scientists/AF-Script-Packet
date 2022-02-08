/*
 *	Create object
 */
func int oCMsgManipulate_New () {
	var int ptr; ptr = CreateNewInstanceByString ("oCMsgManipulate");
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCMsgManipulate_Create (var int subType, var string scemeName, var int targetVob, var int targetState, var string itemName, var string slotName) {
	var int ptr; ptr = oCMsgManipulate_New ();

	if (!ptr) { return 0; };

	//0x006C16D0 public: __thiscall oCMsgManipulate::oCMsgManipulate(enum oCMsgManipulate::TManipulateSubType)
	const int oCMsgManipulate__oCMsgManipulate_G1 = 7083728;

	//0x00768870 public: __thiscall oCMsgManipulate::oCMsgManipulate(enum oCMsgManipulate::TManipulateSubType)
	const int oCMsgManipulate__oCMsgManipulate_G2 = 7768176;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (subType));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (oCMsgManipulate__oCMsgManipulate_G1, oCMsgManipulate__oCMsgManipulate_G2));
		call = CALL_End();
	};

	//Setup additional parameters
	var oCMsgManipulate msg;
	msg = _^ (ptr);

	msg.name = scemeName;
	msg.targetVob = targetVob;
	msg.targetState = targetState;

	//TODO: Seems like npcSlot also has to be set to targetState in G1, what about G2A? Will this cause any issues?
	msg.npcSlot = targetState;

	//Seems like itemName is also stored in .name property - let's update it only for certain subTypes
	//TODO: will this work ?

	if (subType == EV_USEITEM)
	|| (subType == EV_INSERTINTERACTITEM)
	|| (subType == EV_REMOVEINTERACTITEM)
	|| (subType == EV_CREATEINTERACTITEM)
	|| (subType == EV_DESTROYINTERACTITEM)
	|| (subType == EV_PLACEINTERACTITEM)
	|| (subType == EV_EXCHANGEINTERACTITEM) {
		msg.name = itemName;
		msg.slot = slotName;
	};

	//
	if (subType == EV_USEMOB) {
		msg.name = itemName;
	};

	return ptr;
};
