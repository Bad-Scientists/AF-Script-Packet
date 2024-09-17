/*
 *	Create
 *	- will 'create' specified amount of items either in inventory of NPC in players focus or in players inventory if there is no NPC in focus
 */

func string CC_Create (var string param) {
	param = STR_TrimChar (param, CHR_SPACE);
	param = STR_Upper (param);

	var string msg;

	var oCNpc her; her = Hlp_GetNpc (hero);
	var oCNpc npc; npc = Hlp_GetNpc (hero);

	if (Hlp_Is_oCNpc (her.focus_vob)) {
		npc = _^ (her.focus_vob);
	};

	var string instanceName; instanceName = STR_EMPTY;
	var string amount; amount = "1";

	var int count; count = STR_SplitCount (param, STR_SPACE);
	if (count > 0) {
		instanceName = STR_Split (param, STR_SPACE, 0);
		instanceName = STR_TrimChar (instanceName, CHR_SPACE);
	};

	if (count > 1) {
		amount = STR_Split (param, STR_SPACE, 1);
		amount = STR_TrimChar (amount, CHR_SPACE);

		if (!STR_IsNumeric (amount)) {
			amount = "1";
		};
	};

	var int qty; qty = STR_ToInt (amount);
	if (qty < 1) { qty = 1; };

	if (Hlp_StrCmp(instanceName, "USEWITHITEM")) {
		if (!Hlp_Is_oCMobInter(her.focus_vob)) {
			return "No oCMobInter object in focus.";
		};

		var oCMobInter mobInter; mobInter = _^(her.focus_vob);

		var int itemInstanceID;

		if (!STR_Len(mobInter.useWithItem)) {
			return "UseWithItem is blank.";
		};

		itemInstanceID = MEM_GetSymbolIndex(mobInter.useWithItem);

		if (itemInstanceID == -1) {
			msg = ConcatStrings("No valid item instance found for useWithItem: '", mobInter.useWithItem);
			msg = ConcatStrings(msg, "'");
			return msg;
		};

		CreateInvItems(hero, itemInstanceID, qty);

		msg = mobInter.useWithItem;

		msg = ConcatStrings ("x ", msg);
		msg = ConcatStrings (IntToString (qty), msg);
		msg = ConcatStrings (msg, " created in my inventory.");

		return msg;
	};

	msg = instanceName;

	var int symbID; symbID = MEM_GetSymbolIndex (instanceName);
	if (symbID > 0) && (symbID < currSymbolTableLength) {
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
	CC_RegisterMulti (CC_Create, "create useWithItem", "Create items required for interaction with oCMobInter in focus.");
};
