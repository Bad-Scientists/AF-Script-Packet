/*
 *	Create
 *	- will 'create' specified amount of items either in inventory of NPC in players focus or in players inventory if there is no NPC in focus
 */

 func string CC_Create (var string param) {
	param = STR_Trim (param, " ");
	param = STR_Upper (param);

	var string msg;

	var oCNpc her; her = Hlp_GetNpc (hero);
	var oCNpc npc; npc = Hlp_GetNpc (hero);

	if (Hlp_Is_oCNpc (her.focus_vob)) {
		npc = _^ (her.focus_vob);
	};

	var string instanceName; instanceName = "";
	var string amount; amount = "1";

	var int count; count = STR_SplitCount (param, " ");
	if (count > 0) {
		instanceName = STR_Split (param, " ", 0);
		instanceName = STR_Trim (instanceName, " ");
	};

	if (count > 1) {
		amount = STR_Split (param, " ", 1);
		amount = STR_Trim (amount, " ");

		if (!STR_IsNumeric (amount)) {
			amount = "1";
		};
	};

	msg = instanceName;

	var int symbID; symbID = MEM_GetSymbolIndex (instanceName);
	if (symbID > 0) && (symbID < currSymbolTableLength) {
		var int qty; qty = STR_ToInt (amount);
		if (qty < 1) { qty = 1; };

		CreateInvItems (npc, symbID, qty);

		msg = ConcatStrings ("x ", msg);
		msg = ConcatStrings (IntToString (qty), msg);
		msg = ConcatStrings (msg, " created in ");
		if (Npc_IsPlayer (npc)) {
			msg = ConcatStrings (msg, "my inventory.");
		} else {
			msg = ConcatStrings (msg, npc.Name);
			msg = ConcatStrings (msg, "'s inventory.");
		};
	} else {
		msg = ConcatStrings ("Item ", msg);
		msg = ConcatStrings (msg, " does not exist.");
	};

	return msg;
};

func void CC_Create_Init () {
	CC_Register (CC_Create, "create", "Create items for player/Npc in focus.");
};
